From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 26 Nov 2014 18:03:55 +0100
Subject: [RFC PATCH 1/5] KVM: redesing kvm_io_bus_ API to pass VCPU
 structure to the callbacks.
In-Reply-To: <20141124212643.10605.72905.stgit@i3820>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212643.10605.72905.stgit@i3820>
Message-ID: <547607FB.5020101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolay,

typo in the title,

On 11/24/2014 10:26 PM, Nikolay Nikolaev wrote:
> This is needed in e.g. ARM vGIC emulation, where the MMIO handling
> depends on the VCPU that does the access.
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> ---
>  arch/ia64/kvm/kvm-ia64.c   |    4 ++--
>  arch/powerpc/kvm/powerpc.c |    4 ++--
>  arch/s390/kvm/diag.c       |    2 +-
>  arch/x86/kvm/vmx.c         |    2 +-
>  arch/x86/kvm/x86.c         |   11 ++++++-----
>  include/linux/kvm_host.h   |   10 +++++-----
>  virt/kvm/coalesced_mmio.c  |    5 +++--
>  virt/kvm/eventfd.c         |    4 ++--
>  virt/kvm/iodev.h           |   23 +++++++++++++++--------
>  virt/kvm/kvm_main.c        |   32 ++++++++++++++++----------------
>  10 files changed, 53 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
> index ec6b9ac..16f1d26 100644
> --- a/arch/ia64/kvm/kvm-ia64.c
> +++ b/arch/ia64/kvm/kvm-ia64.c
> @@ -246,10 +246,10 @@ static int handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	return 0;
>  mmio:
>  	if (p->dir)
> -		r = kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, p->addr,
> +		r = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, p->addr,
>  				    p->size, &p->data);
>  	else
> -		r = kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, p->addr,
> +		r = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, p->addr,
>  				     p->size, &p->data);
>  	if (r)
>  		printk(KERN_ERR"kvm: No iodevice found! addr:%lx\n", p->addr);
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index c1f8f53..5ac065b 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -814,7 +814,7 @@ int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  
>  	idx = srcu_read_lock(&vcpu->kvm->srcu);
>  
> -	ret = kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, run->mmio.phys_addr,
> +	ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, run->mmio.phys_addr,
>  			      bytes, &run->mmio.data);
>  
>  	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> @@ -887,7 +887,7 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  
>  	idx = srcu_read_lock(&vcpu->kvm->srcu);
>  
> -	ret = kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, run->mmio.phys_addr,
> +	ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, run->mmio.phys_addr,
>  			       bytes, &run->mmio.data);
>  
>  	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 9254aff..329ec75 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -213,7 +213,7 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
>  	 * - gpr 3 contains the virtqueue index (passed as datamatch)
>  	 * - gpr 4 contains the index on the bus (optionally)
>  	 */
> -	ret = kvm_io_bus_write_cookie(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
> +	ret = kvm_io_bus_write_cookie(vcpu, KVM_VIRTIO_CCW_NOTIFY_BUS,
>  				      vcpu->run->s.regs.gprs[2] & 0xffffffff,
>  				      8, &vcpu->run->s.regs.gprs[3],
>  				      vcpu->run->s.regs.gprs[4]);
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 3e556c6..e6d9f01 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -5620,7 +5620,7 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
>  	gpa_t gpa;
>  
>  	gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> -	if (!kvm_io_bus_write(vcpu->kvm, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
> +	if (!kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
>  		skip_emulated_instruction(vcpu);
>  		return 1;
>  	}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0033df3..bbf9375 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4053,7 +4053,7 @@ static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
>  		n = min(len, 8);
>  		if (!(vcpu->arch.apic &&
>  		      !kvm_iodevice_write(&vcpu->arch.apic->dev, addr, n, v))
vcpu param should be added above too.

Eric
> -		    && kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
> +		    && kvm_io_bus_write(vcpu, KVM_MMIO_BUS, addr, n, v))
>  			break;
>  		handled += n;
>  		addr += n;
> @@ -4072,8 +4072,9 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
>  	do {
>  		n = min(len, 8);
>  		if (!(vcpu->arch.apic &&
> -		      !kvm_iodevice_read(&vcpu->arch.apic->dev, addr, n, v))
> -		    && kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
> +		      !kvm_iodevice_read(vcpu, &vcpu->arch.apic->dev,
> +					 addr, n, v))
> +		    && kvm_io_bus_read(vcpu, KVM_MMIO_BUS, addr, n, v))
>  			break;
>  		trace_kvm_mmio(KVM_TRACE_MMIO_READ, n, addr, *(u64 *)v);
>  		handled += n;
> @@ -4565,10 +4566,10 @@ static int kernel_pio(struct kvm_vcpu *vcpu, void *pd)
>  	int r;
>  
>  	if (vcpu->arch.pio.in)
> -		r = kvm_io_bus_read(vcpu->kvm, KVM_PIO_BUS, vcpu->arch.pio.port,
> +		r = kvm_io_bus_read(vcpu, KVM_PIO_BUS, vcpu->arch.pio.port,
>  				    vcpu->arch.pio.size, pd);
>  	else
> -		r = kvm_io_bus_write(vcpu->kvm, KVM_PIO_BUS,
> +		r = kvm_io_bus_write(vcpu, KVM_PIO_BUS,
>  				     vcpu->arch.pio.port, vcpu->arch.pio.size,
>  				     pd);
>  	return r;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4a7798e..1d26571 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -168,12 +168,12 @@ enum kvm_bus {
>  	KVM_NR_BUSES
>  };
>  
> -int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
>  		     int len, const void *val);
> -int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> -			    int len, const void *val, long cookie);
> -int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr, int len,
> -		    void *val);
> +int kvm_io_bus_write_cookie(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx,
> +			    gpa_t addr, int len, const void *val, long cookie);
> +int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
> +		    int len, void *val);
>  int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  			    int len, struct kvm_io_device *dev);
>  int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 00d8642..c831a40 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -60,8 +60,9 @@ static int coalesced_mmio_has_room(struct kvm_coalesced_mmio_dev *dev)
>  	return 1;
>  }
>  
> -static int coalesced_mmio_write(struct kvm_io_device *this,
> -				gpa_t addr, int len, const void *val)
> +static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
> +				struct kvm_io_device *this, gpa_t addr,
> +				int len, const void *val)
>  {
>  	struct kvm_coalesced_mmio_dev *dev = to_mmio(this);
>  	struct kvm_coalesced_mmio_ring *ring = dev->kvm->coalesced_mmio_ring;
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index b0fb390..7202039 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -719,8 +719,8 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
>  
>  /* MMIO/PIO writes trigger an event if the addr/val match */
>  static int
> -ioeventfd_write(struct kvm_io_device *this, gpa_t addr, int len,
> -		const void *val)
> +ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this, gpa_t addr,
> +		int len, const void *val)
>  {
>  	struct _ioeventfd *p = to_ioeventfd(this);
>  
> diff --git a/virt/kvm/iodev.h b/virt/kvm/iodev.h
> index 12fd3ca..7dd88cb 100644
> --- a/virt/kvm/iodev.h
> +++ b/virt/kvm/iodev.h
> @@ -20,6 +20,7 @@
>  #include <asm/errno.h>
>  
>  struct kvm_io_device;
> +struct kvm_vcpu;
>  
>  /**
>   * kvm_io_device_ops are called under kvm slots_lock.
> @@ -27,11 +28,13 @@ struct kvm_io_device;
>   * or non-zero to have it passed to the next device.
>   **/
>  struct kvm_io_device_ops {
> -	int (*read)(struct kvm_io_device *this,
> +	int (*read)(struct kvm_vcpu *vcpu,
> +			struct kvm_io_device *this,
>  		    gpa_t addr,
>  		    int len,
>  		    void *val);
> -	int (*write)(struct kvm_io_device *this,
> +	int (*write)(struct kvm_vcpu *vcpu,
> +			 struct kvm_io_device *this,
>  		     gpa_t addr,
>  		     int len,
>  		     const void *val);
> @@ -49,16 +52,20 @@ static inline void kvm_iodevice_init(struct kvm_io_device *dev,
>  	dev->ops = ops;
>  }
>  
> -static inline int kvm_iodevice_read(struct kvm_io_device *dev,
> -				    gpa_t addr, int l, void *v)
> +static inline int kvm_iodevice_read(struct kvm_vcpu *vcpu,
> +				    struct kvm_io_device *dev, gpa_t addr,
> +				    int l, void *v)
>  {
> -	return dev->ops->read ? dev->ops->read(dev, addr, l, v) : -EOPNOTSUPP;
> +	return dev->ops->read ? dev->ops->read(vcpu, dev, addr, l, v)
> +				: -EOPNOTSUPP;
>  }
>  
> -static inline int kvm_iodevice_write(struct kvm_io_device *dev,
> -				     gpa_t addr, int l, const void *v)
> +static inline int kvm_iodevice_write(struct kvm_vcpu *vcpu,
> +				     struct kvm_io_device *dev, gpa_t addr,
> +				     int l, const void *v)
>  {
> -	return dev->ops->write ? dev->ops->write(dev, addr, l, v) : -EOPNOTSUPP;
> +	return dev->ops->write ? dev->ops->write(vcpu, dev, addr, l, v)
> +				 : -EOPNOTSUPP;
>  }
>  
>  static inline void kvm_iodevice_destructor(struct kvm_io_device *dev)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 25ffac9..e93fb53 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2924,7 +2924,7 @@ static int kvm_io_bus_get_first_dev(struct kvm_io_bus *bus,
>  	return off;
>  }
>  
> -static int __kvm_io_bus_write(struct kvm_io_bus *bus,
> +static int __kvm_io_bus_write(struct kvm_vcpu *vcpu, struct kvm_io_bus *bus,
>  			      struct kvm_io_range *range, const void *val)
>  {
>  	int idx;
> @@ -2935,7 +2935,7 @@ static int __kvm_io_bus_write(struct kvm_io_bus *bus,
>  
>  	while (idx < bus->dev_count &&
>  		kvm_io_bus_cmp(range, &bus->range[idx]) == 0) {
> -		if (!kvm_iodevice_write(bus->range[idx].dev, range->addr,
> +		if (!kvm_iodevice_write(vcpu, bus->range[idx].dev, range->addr,
>  					range->len, val))
>  			return idx;
>  		idx++;
> @@ -2945,7 +2945,7 @@ static int __kvm_io_bus_write(struct kvm_io_bus *bus,
>  }
>  
>  /* kvm_io_bus_write - called under kvm->slots_lock */
> -int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
>  		     int len, const void *val)
>  {
>  	struct kvm_io_bus *bus;
> @@ -2957,14 +2957,14 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		.len = len,
>  	};
>  
> -	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> -	r = __kvm_io_bus_write(bus, &range, val);
> +	bus = srcu_dereference(vcpu->kvm->buses[bus_idx], &kvm->srcu);
> +	r = __kvm_io_bus_write(vcpu, bus, &range, val);
>  	return r < 0 ? r : 0;
>  }
>  
>  /* kvm_io_bus_write_cookie - called under kvm->slots_lock */
> -int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> -			    int len, const void *val, long cookie)
> +int kvm_io_bus_write_cookie(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx,
> +			    gpa_t addr, int len, const void *val, long cookie)
>  {
>  	struct kvm_io_bus *bus;
>  	struct kvm_io_range range;
> @@ -2974,12 +2974,12 @@ int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		.len = len,
>  	};
>  
> -	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> +	bus = srcu_dereference(vcpu->kvm->buses[bus_idx], &kvm->srcu);
>  
>  	/* First try the device referenced by cookie. */
>  	if ((cookie >= 0) && (cookie < bus->dev_count) &&
>  	    (kvm_io_bus_cmp(&range, &bus->range[cookie]) == 0))
> -		if (!kvm_iodevice_write(bus->range[cookie].dev, addr, len,
> +		if (!kvm_iodevice_write(vcpu, bus->range[cookie].dev, addr, len,
>  					val))
>  			return cookie;
>  
> @@ -2987,11 +2987,11 @@ int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  	 * cookie contained garbage; fall back to search and return the
>  	 * correct cookie value.
>  	 */
> -	return __kvm_io_bus_write(bus, &range, val);
> +	return __kvm_io_bus_write(vcpu, bus, &range, val);
>  }
>  
> -static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
> -			     void *val)
> +static int __kvm_io_bus_read(struct kvm_vcpu *vcpu, struct kvm_io_bus *bus,
> +			     struct kvm_io_range *range, void *val)
>  {
>  	int idx;
>  
> @@ -3001,7 +3001,7 @@ static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
>  
>  	while (idx < bus->dev_count &&
>  		kvm_io_bus_cmp(range, &bus->range[idx]) == 0) {
> -		if (!kvm_iodevice_read(bus->range[idx].dev, range->addr,
> +		if (!kvm_iodevice_read(vcpu, bus->range[idx].dev, range->addr,
>  				       range->len, val))
>  			return idx;
>  		idx++;
> @@ -3012,7 +3012,7 @@ static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
>  EXPORT_SYMBOL_GPL(kvm_io_bus_write);
>  
>  /* kvm_io_bus_read - called under kvm->slots_lock */
> -int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
>  		    int len, void *val)
>  {
>  	struct kvm_io_bus *bus;
> @@ -3024,8 +3024,8 @@ int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		.len = len,
>  	};
>  
> -	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> -	r = __kvm_io_bus_read(bus, &range, val);
> +	bus = srcu_dereference(vcpu->kvm->buses[bus_idx], &kvm->srcu);
> +	r = __kvm_io_bus_read(vcpu, bus, &range, val);
>  	return r < 0 ? r : 0;
>  }
>  
> 
