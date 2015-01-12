From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 12 Jan 2015 18:10:07 +0100
Subject: [PATCH v2 1/5] KVM: Redesign kvm_io_bus_ API to pass VCPU
 structure to the callbacks.
In-Reply-To: <20141207093742.17563.62534.stgit@i3820>
References: <20141207093641.17563.84226.stgit@i3820>
 <20141207093742.17563.62534.stgit@i3820>
Message-ID: <54B3FFEF.4010406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolay,

On 12/07/2014 10:37 AM, Nikolay Nikolaev wrote:
> This is needed in e.g. ARM vGIC emulation, where the MMIO handling
> depends on the VCPU that does the access.
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> ---
>  arch/ia64/kvm/kvm-ia64.c   |    4 ++--
>  arch/powerpc/kvm/mpic.c    |   10 ++++++----
>  arch/powerpc/kvm/powerpc.c |    4 ++--
>  arch/s390/kvm/diag.c       |    2 +-
>  arch/x86/kvm/i8254.c       |   14 +++++++++-----
>  arch/x86/kvm/i8259.c       |   12 ++++++------
>  arch/x86/kvm/lapic.c       |    4 ++--
>  arch/x86/kvm/vmx.c         |    2 +-
>  arch/x86/kvm/x86.c         |   13 +++++++------
>  include/linux/kvm_host.h   |   10 +++++-----
>  virt/kvm/coalesced_mmio.c  |    5 +++--
>  virt/kvm/eventfd.c         |    4 ++--
>  virt/kvm/ioapic.c          |    8 ++++----
>  virt/kvm/iodev.h           |   23 +++++++++++++++--------
>  virt/kvm/kvm_main.c        |   32 ++++++++++++++++----------------
>  15 files changed, 81 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
> index dbe46f4..287df8d 100644
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
> diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
> index 39b3a8f..8542f07 100644
> --- a/arch/powerpc/kvm/mpic.c
> +++ b/arch/powerpc/kvm/mpic.c
> @@ -1374,8 +1374,9 @@ static int kvm_mpic_write_internal(struct openpic *opp, gpa_t addr, u32 val)
>  	return -ENXIO;
>  }
>  
> -static int kvm_mpic_read(struct kvm_io_device *this, gpa_t addr,
> -			 int len, void *ptr)
> +static int kvm_mpic_read(struct kvm_vcpu *vcpu,
> +			 struct kvm_io_device *this,
> +			 gpa_t addr, int len, void *ptr)
>  {
>  	struct openpic *opp = container_of(this, struct openpic, mmio);
>  	int ret;
> @@ -1415,8 +1416,9 @@ static int kvm_mpic_read(struct kvm_io_device *this, gpa_t addr,
>  	return ret;
>  }
>  
> -static int kvm_mpic_write(struct kvm_io_device *this, gpa_t addr,
> -			  int len, const void *ptr)
> +static int kvm_mpic_write(struct kvm_vcpu *vcpu,
> +			  struct kvm_io_device *this,
> +			  gpa_t addr, int len, const void *ptr)
>  {
>  	struct openpic *opp = container_of(this, struct openpic, mmio);
>  	int ret;
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
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index 298781d..4dce6f8 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -443,7 +443,8 @@ static inline int pit_in_range(gpa_t addr)
>  		(addr < KVM_PIT_BASE_ADDRESS + KVM_PIT_MEM_LENGTH));
>  }
>  
> -static int pit_ioport_write(struct kvm_io_device *this,
> +static int pit_ioport_write(struct kvm_vcpu *vcpu,
> +				struct kvm_io_device *this,
>  			    gpa_t addr, int len, const void *data)
>  {
>  	struct kvm_pit *pit = dev_to_pit(this);
> @@ -519,7 +520,8 @@ static int pit_ioport_write(struct kvm_io_device *this,
>  	return 0;
>  }
>  
> -static int pit_ioport_read(struct kvm_io_device *this,
> +static int pit_ioport_read(struct kvm_vcpu *vcpu,
> +			   struct kvm_io_device *this,
>  			   gpa_t addr, int len, void *data)
>  {
>  	struct kvm_pit *pit = dev_to_pit(this);
> @@ -589,7 +591,8 @@ static int pit_ioport_read(struct kvm_io_device *this,
>  	return 0;
>  }
>  
> -static int speaker_ioport_write(struct kvm_io_device *this,
> +static int speaker_ioport_write(struct kvm_vcpu *vcpu,
> +				struct kvm_io_device *this,
>  				gpa_t addr, int len, const void *data)
>  {
>  	struct kvm_pit *pit = speaker_to_pit(this);
> @@ -606,8 +609,9 @@ static int speaker_ioport_write(struct kvm_io_device *this,
>  	return 0;
>  }
>  
> -static int speaker_ioport_read(struct kvm_io_device *this,
> -			       gpa_t addr, int len, void *data)
> +static int speaker_ioport_read(struct kvm_vcpu *vcpu,
> +				   struct kvm_io_device *this,
> +				   gpa_t addr, int len, void *data)
>  {
>  	struct kvm_pit *pit = speaker_to_pit(this);
>  	struct kvm_kpit_state *pit_state = &pit->pit_state;
> diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
> index cc31f7c..8ff4eaa 100644
> --- a/arch/x86/kvm/i8259.c
> +++ b/arch/x86/kvm/i8259.c
> @@ -528,42 +528,42 @@ static int picdev_read(struct kvm_pic *s,
>  	return 0;
>  }
>  
> -static int picdev_master_write(struct kvm_io_device *dev,
> +static int picdev_master_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  			       gpa_t addr, int len, const void *val)
>  {
>  	return picdev_write(container_of(dev, struct kvm_pic, dev_master),
>  			    addr, len, val);
>  }
>  
> -static int picdev_master_read(struct kvm_io_device *dev,
> +static int picdev_master_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  			      gpa_t addr, int len, void *val)
>  {
>  	return picdev_read(container_of(dev, struct kvm_pic, dev_master),
>  			    addr, len, val);
>  }
>  
> -static int picdev_slave_write(struct kvm_io_device *dev,
> +static int picdev_slave_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  			      gpa_t addr, int len, const void *val)
>  {
>  	return picdev_write(container_of(dev, struct kvm_pic, dev_slave),
>  			    addr, len, val);
>  }
>  
> -static int picdev_slave_read(struct kvm_io_device *dev,
> +static int picdev_slave_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  			     gpa_t addr, int len, void *val)
>  {
>  	return picdev_read(container_of(dev, struct kvm_pic, dev_slave),
>  			    addr, len, val);
>  }
>  
> -static int picdev_eclr_write(struct kvm_io_device *dev,
> +static int picdev_eclr_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  			     gpa_t addr, int len, const void *val)
>  {
>  	return picdev_write(container_of(dev, struct kvm_pic, dev_eclr),
>  			    addr, len, val);
>  }
>  
> -static int picdev_eclr_read(struct kvm_io_device *dev,
> +static int picdev_eclr_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  			    gpa_t addr, int len, void *val)
>  {
>  	return picdev_read(container_of(dev, struct kvm_pic, dev_eclr),
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index b8345dd..c071c36 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1007,7 +1007,7 @@ static int apic_mmio_in_range(struct kvm_lapic *apic, gpa_t addr)
>  	    addr < apic->base_address + LAPIC_MMIO_LENGTH;
>  }
>  
> -static int apic_mmio_read(struct kvm_io_device *this,
> +static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>  			   gpa_t address, int len, void *data)
>  {
>  	struct kvm_lapic *apic = to_lapic(this);
> @@ -1253,7 +1253,7 @@ static int apic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>  	return ret;
>  }
>  
> -static int apic_mmio_write(struct kvm_io_device *this,
> +static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>  			    gpa_t address, int len, const void *data)
>  {
>  	struct kvm_lapic *apic = to_lapic(this);
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
> index 0033df3..e0462db 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4052,8 +4052,8 @@ static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
>  	do {
>  		n = min(len, 8);
>  		if (!(vcpu->arch.apic &&
> -		      !kvm_iodevice_write(&vcpu->arch.apic->dev, addr, n, v))
> -		    && kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
> +		      !kvm_iodevice_write(vcpu, &vcpu->arch.apic->dev, addr, n, v))
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
> index b1aa88d..f0d1ce7 100644
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
> diff --git a/virt/kvm/ioapic.c b/virt/kvm/ioapic.c
> index 0ba4057..a032909 100644
> --- a/virt/kvm/ioapic.c
> +++ b/virt/kvm/ioapic.c
> @@ -505,8 +505,8 @@ static inline int ioapic_in_range(struct kvm_ioapic *ioapic, gpa_t addr)
>  		 (addr < ioapic->base_address + IOAPIC_MEM_LENGTH)));
>  }
>  
> -static int ioapic_mmio_read(struct kvm_io_device *this, gpa_t addr, int len,
> -			    void *val)
> +static int ioapic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> +				gpa_t addr, int len, void *val)
>  {
>  	struct kvm_ioapic *ioapic = to_ioapic(this);
>  	u32 result;
> @@ -548,8 +548,8 @@ static int ioapic_mmio_read(struct kvm_io_device *this, gpa_t addr, int len,
>  	return 0;
>  }
>  
> -static int ioapic_mmio_write(struct kvm_io_device *this, gpa_t addr, int len,
> -			     const void *val)
> +static int ioapic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> +				 gpa_t addr, int len, const void *val)
>  {
>  	struct kvm_ioapic *ioapic = to_ioapic(this);
>  	u32 data;
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
strange alignment
>  		    gpa_t addr,
>  		    int len,
>  		    void *val);
> -	int (*write)(struct kvm_io_device *this,
> +	int (*write)(struct kvm_vcpu *vcpu,
> +			 struct kvm_io_device *this,
same

Besides this minor thing, looks ok to me.

Best Regards

Eric
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
> index 3cee7b1..16e5152 100644
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
