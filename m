From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 27 Nov 2014 11:51:37 +0100
Subject: [RFC PATCH 3/5] KVM: ARM VGIC add kvm_io_bus_ frontend
In-Reply-To: <20141124212658.10605.16215.stgit@i3820>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212658.10605.16215.stgit@i3820>
Message-ID: <54770239.4070408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 10:26 PM, Nikolay Nikolaev wrote:
> In io_mem_abort remove the call to vgic_handle_mmio. The target is to have
> a single MMIO handling path - that is through the kvm_io_bus_ API.
> 
> Register a kvm_io_device in kvm_vgic_init on the whole vGIC MMIO region.
> Both read and write calls are redirected to vgic_io_dev_access where
> kvm_exit_mmio is composed to pass it to vm_ops.handle_mmio.
> 
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> ---
>  arch/arm/kvm/mmio.c    |    3 --
>  include/kvm/arm_vgic.h |    3 +-
>  virt/kvm/arm/vgic.c    |   88 ++++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 74 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 81230da..1c44a2b 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -227,9 +227,6 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	if (mmio.is_write)
>  		mmio_write_buf(mmio.data, mmio.len, data);
>  
> -	if (vgic_handle_mmio(vcpu, run, &mmio))
> -		return 1;
> -
>  	if (handle_kernel_mmio(vcpu, run, &mmio))
>  		return 1;
>  
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index e452ef7..d9b7d2a 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -233,6 +233,7 @@ struct vgic_dist {
>  	unsigned long		*irq_pending_on_cpu;
>  
>  	struct vgic_vm_ops	vm_ops;
> +	struct kvm_io_device	*io_dev;
>  #endif
>  };
>  
> @@ -307,8 +308,6 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>  			bool level);
>  void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -		      struct kvm_exit_mmio *mmio);
>  
>  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
>  #define vgic_initialized(k)	((k)->arch.vgic.ready)
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 1213da5..3da1115 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -31,6 +31,9 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/kvm.h>
> +
> +#include "iodev.h"
>  
>  /*
>   * How the whole thing works (courtesy of Christoffer Dall):
> @@ -775,28 +778,81 @@ bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	return true;
>  }
>  
> -/**
> - * vgic_handle_mmio - handle an in-kernel MMIO access for the GIC emulation
> - * @vcpu:      pointer to the vcpu performing the access
> - * @run:       pointer to the kvm_run structure
> - * @mmio:      pointer to the data describing the access
> - *
> - * returns true if the MMIO access has been performed in kernel space,
> - * and false if it needs to be emulated in user space.
> - * Calls the actual handling routine for the selected VGIC model.
> - */
> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -		      struct kvm_exit_mmio *mmio)
may be worth to restore some comments
> +static int vgic_io_dev_access(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> +			    gpa_t addr, int len, void *val, bool is_write)
>  {
> -	if (!irqchip_in_kernel(vcpu->kvm))
> -		return false;
> +	struct kvm_exit_mmio mmio;
> +	bool ret;
> +
> +	mmio = (struct kvm_exit_mmio) {
> +		.phys_addr = addr,
> +		.len = len,
> +		.is_write = is_write,
> +	};
> +
> +	if (is_write)
> +		memcpy(mmio.data, val, len);
>  
>  	/*
>  	 * This will currently call either vgic_v2_handle_mmio() or
>  	 * vgic_v3_handle_mmio(), which in turn will call
>  	 * vgic_handle_mmio_range() defined above.
>  	 */
> -	return vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, run, mmio);
> +	ret = vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, vcpu->run, &mmio);
> +
> +	if (!is_write)
> +		memcpy(val, mmio.data, len);
> +
> +	return ret ? 0 : 1;
> +}
> +
> +static int vgic_io_dev_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> +			  gpa_t addr, int len, void *val)
> +{
> +	return vgic_io_dev_access(vcpu, this, addr, len, val, false);
> +}
> +
> +static int vgic_io_dev_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> +			   gpa_t addr, int len, const void *val)
> +{
> +	return vgic_io_dev_access(vcpu, this, addr, len, (void *)val, true);
> +}
> +
> +static const struct kvm_io_device_ops vgic_io_dev_ops = {
> +	.read       = vgic_io_dev_read,
> +	.write      = vgic_io_dev_write,
> +};
> +
> +static int vgic_register_kvm_io_dev(struct kvm *kvm)
> +{
> +	struct kvm_io_device *dev;
> +	int ret;
> +
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +	unsigned long base = dist->vgic_dist_base;
Nikolay,

are you sure dist->vgic_dist_base was set by the guest?
in vgic_init/vm_ops.vgic_init (vgic_v2_init) it is tested so I think you
should test it here too.
> +
> +	dev = kzalloc(sizeof(struct kvm_io_device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	kvm_iodevice_init(dev, &vgic_io_dev_ops);
> +
> +	mutex_lock(&kvm->slots_lock);
> +
> +	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS,
> +			base, KVM_VGIC_V2_DIST_SIZE, dev);
> +	if (ret < 0)
> +		goto out_free_dev;
> +	mutex_unlock(&kvm->slots_lock);
> +
> +	kvm->arch.vgic.io_dev = dev;
> +
> +	return 0;
> +
> +out_free_dev:
> +	mutex_unlock(&kvm->slots_lock);
> +	kfree(dev);
> +	return ret;
>  }
>  
>  static int vgic_nr_shared_irqs(struct vgic_dist *dist)
> @@ -1545,6 +1601,8 @@ int kvm_vgic_init(struct kvm *kvm)
>  
>  	mutex_lock(&kvm->lock);
>  
> +	vgic_register_kvm_io_dev(kvm);

I think you should move this after below test.

Eric
> +
>  	if (vgic_initialized(kvm))
>  		goto out;
>  
> 
