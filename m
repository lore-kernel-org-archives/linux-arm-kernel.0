From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Sep 2012 16:55:05 +0100
Subject: [PATCH 09/15] KVM: ARM: Inject IRQs and FIQs from userspace
In-Reply-To: <20120915153527.21241.61813.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153527.21241.61813.stgit@ubuntu>
Message-ID: <20120925155505.GD28728@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:35:27PM +0100, Christoffer Dall wrote:
> diff --git a/arch/arm/include/asm/kvm.h b/arch/arm/include/asm/kvm.h
> index a13b582..131e632 100644
> --- a/arch/arm/include/asm/kvm.h
> +++ b/arch/arm/include/asm/kvm.h
> @@ -22,6 +22,7 @@
>  #include <asm/types.h>
>  
>  #define __KVM_HAVE_GUEST_DEBUG
> +#define __KVM_HAVE_IRQ_LINE
>  
>  #define KVM_REG_SIZE(id)						\
>  	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
> @@ -85,4 +86,24 @@ struct kvm_reg_list {
>  #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
>  #define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
>  
> +/* KVM_IRQ_LINE irq field index values */
> +#define KVM_ARM_IRQ_TYPE_SHIFT		24
> +#define KVM_ARM_IRQ_TYPE_MASK		0xff
> +#define KVM_ARM_IRQ_VCPU_SHIFT		16
> +#define KVM_ARM_IRQ_VCPU_MASK		0xff
> +#define KVM_ARM_IRQ_NUM_SHIFT		0
> +#define KVM_ARM_IRQ_NUM_MASK		0xffff
> +
> +/* irq_type field */
> +#define KVM_ARM_IRQ_TYPE_CPU		0
> +#define KVM_ARM_IRQ_TYPE_SPI		1
> +#define KVM_ARM_IRQ_TYPE_PPI		2
> +
> +/* out-of-kernel GIC cpu interrupt injection irq_number field */
> +#define KVM_ARM_IRQ_CPU_IRQ		0
> +#define KVM_ARM_IRQ_CPU_FIQ		1
> +
> +/* Highest supported SPI, from VGIC_NR_IRQS */
> +#define KVM_ARM_IRQ_GIC_MAX		127

This define, and those referring to PPIs and SPIs sound highly GIC-specific.
Is that really appropriate for kvm.h? Do you mandate a single GIC as the
only interrupt controller?

> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
> index 6e46541..0f641c1 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -74,6 +74,7 @@
>  #define HCR_GUEST_MASK (HCR_TSC | HCR_TSW | HCR_TWI | HCR_VM | HCR_BSU_IS | \
>  			HCR_FB | HCR_TAC | HCR_AMO | HCR_IMO | HCR_FMO | \
>  			HCR_SWIO | HCR_TIDCP)
> +#define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
>  
>  /* Hyp System Control Register (HSCTLR) bits */
>  #define HSCTLR_TE	(1 << 30)
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index b97ebd0..8a87fc7 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -24,6 +24,7 @@
>  #include <linux/fs.h>
>  #include <linux/mman.h>
>  #include <linux/sched.h>
> +#include <linux/kvm.h>
>  #include <trace/events/kvm.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -271,6 +272,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>  
>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
> +	vcpu->cpu = cpu;
>  }
>  
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> @@ -311,6 +313,74 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	return -EINVAL;
>  }
>  
> +static int vcpu_interrupt_line(struct kvm_vcpu *vcpu, int number, bool level)
> +{
> +	int bit_index;
> +	bool set;
> +	unsigned long *ptr;
> +
> +	if (number == KVM_ARM_IRQ_CPU_IRQ)
> +		bit_index = ffs(HCR_VI) - 1;
> +	else /* KVM_ARM_IRQ_CPU_FIQ */
> +		bit_index = ffs(HCR_VF) - 1;

__ffs

Will
