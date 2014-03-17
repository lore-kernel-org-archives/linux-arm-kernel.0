From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 16 Mar 2014 20:40:13 -0700
Subject: [PATCH v4 02/10] ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
In-Reply-To: <1391686302-19451-3-git-send-email-anup.patel@linaro.org>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-3-git-send-email-anup.patel@linaro.org>
Message-ID: <20140317034013.GC20648@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 05:01:34PM +0530, Anup Patel wrote:
> Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
> VCPUs. This patch extends current in-kernel PSCI emulation to provide
> PSCI v0.2 interface to VCPUs.
> 
> By default, ARM/ARM64 KVM will always provide PSCI v0.1 interface for
> keeping the ABI backward-compatible.
> 
> To select PSCI v0.2 interface for VCPUs, the user space (i.e. QEMU or
> KVMTOOL) will have to set KVM_ARM_VCPU_PSCI_0_2 feature when doing VCPU
> init using KVM_ARM_VCPU_INIT ioctl.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/include/asm/kvm_host.h   |    2 +-
>  arch/arm/include/asm/kvm_psci.h   |    4 ++
>  arch/arm/include/uapi/asm/kvm.h   |   35 ++++++++++++++-
>  arch/arm/kvm/arm.c                |    1 +
>  arch/arm/kvm/psci.c               |   85 +++++++++++++++++++++++++++++++------
>  arch/arm64/include/asm/kvm_host.h |    2 +-
>  arch/arm64/include/asm/kvm_psci.h |    4 ++
>  arch/arm64/include/uapi/asm/kvm.h |   35 ++++++++++++++-
>  8 files changed, 152 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 09af149..193ceaf 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -36,7 +36,7 @@
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>  #define KVM_HAVE_ONE_REG
>  
> -#define KVM_VCPU_MAX_FEATURES 1
> +#define KVM_VCPU_MAX_FEATURES 2
>  
>  #include <kvm/arm_vgic.h>
>  
> diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
> index 9a83d98..4c0e3e1 100644
> --- a/arch/arm/include/asm/kvm_psci.h
> +++ b/arch/arm/include/asm/kvm_psci.h
> @@ -18,6 +18,10 @@
>  #ifndef __ARM_KVM_PSCI_H__
>  #define __ARM_KVM_PSCI_H__
>  
> +#define KVM_ARM_PSCI_0_1	1
> +#define KVM_ARM_PSCI_0_2	2
> +
> +int kvm_psci_version(struct kvm_vcpu *vcpu);
>  bool kvm_psci_call(struct kvm_vcpu *vcpu);
>  
>  #endif /* __ARM_KVM_PSCI_H__ */
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index ef0c878..9c922d9 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -83,6 +83,7 @@ struct kvm_regs {
>  #define KVM_VGIC_V2_CPU_SIZE		0x2000
>  
>  #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
> +#define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
>  
>  struct kvm_vcpu_init {
>  	__u32 target;
> @@ -192,7 +193,7 @@ struct kvm_arch_memory_slot {
>  /* Highest supported SPI, from VGIC_NR_IRQS */
>  #define KVM_ARM_IRQ_GIC_MAX		127
>  
> -/* PSCI interface */
> +/* PSCI v0.1 interface */
>  #define KVM_PSCI_FN_BASE		0x95c1ba5e
>  #define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
>  
> @@ -201,9 +202,41 @@ struct kvm_arch_memory_slot {
>  #define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
>  #define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
>  
> +/* PSCI v0.2 interface */
> +#define KVM_PSCI_0_2_FN_BASE		0x84000000
> +#define KVM_PSCI_0_2_FN(n)		(KVM_PSCI_0_2_FN_BASE + (n))
> +#define KVM_PSCI_0_2_FN64_BASE		0xC4000000
> +#define KVM_PSCI_0_2_FN64(n)		(KVM_PSCI_0_2_FN64_BASE + (n))
> +
> +#define KVM_PSCI_0_2_FN_PSCI_VERSION	KVM_PSCI_0_2_FN(0)
> +#define KVM_PSCI_0_2_FN_CPU_SUSPEND	KVM_PSCI_0_2_FN(1)
> +#define KVM_PSCI_0_2_FN_CPU_OFF		KVM_PSCI_0_2_FN(2)
> +#define KVM_PSCI_0_2_FN_CPU_ON		KVM_PSCI_0_2_FN(3)
> +#define KVM_PSCI_0_2_FN_AFFINITY_INFO	KVM_PSCI_0_2_FN(4)
> +#define KVM_PSCI_0_2_FN_MIGRATE		KVM_PSCI_0_2_FN(5)
> +#define KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE \
> +					KVM_PSCI_0_2_FN(6)
> +#define KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU \
> +					KVM_PSCI_0_2_FN(7)
> +#define KVM_PSCI_0_2_FN_SYSTEM_OFF	KVM_PSCI_0_2_FN(8)
> +#define KVM_PSCI_0_2_FN_SYSTEM_RESET	KVM_PSCI_0_2_FN(9)
> +
> +#define KVM_PSCI_0_2_FN64_CPU_SUSPEND	KVM_PSCI_0_2_FN64(1)
> +#define KVM_PSCI_0_2_FN64_CPU_ON	KVM_PSCI_0_2_FN64(3)
> +#define KVM_PSCI_0_2_FN64_AFFINITY_INFO	KVM_PSCI_0_2_FN64(4)
> +#define KVM_PSCI_0_2_FN64_MIGRATE	KVM_PSCI_0_2_FN64(5)
> +#define KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU \
> +					KVM_PSCI_0_2_FN64(7)
> +
> +/* PSCI return values */
>  #define KVM_PSCI_RET_SUCCESS		0
>  #define KVM_PSCI_RET_NI			((unsigned long)-1)
>  #define KVM_PSCI_RET_INVAL		((unsigned long)-2)
>  #define KVM_PSCI_RET_DENIED		((unsigned long)-3)
> +#define KVM_PSCI_RET_ALREADY_ON		((unsigned long)-4)
> +#define KVM_PSCI_RET_ON_PENDING		((unsigned long)-5)
> +#define KVM_PSCI_RET_INTERNAL_FAILURE	((unsigned long)-6)
> +#define KVM_PSCI_RET_NOT_PRESENT	((unsigned long)-7)
> +#define KVM_PSCI_RET_DISABLED		((unsigned long)-8)
>  
>  #endif /* __ARM_KVM_H__ */
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 1d8248e..c8a71df 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -197,6 +197,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>  	case KVM_CAP_ONE_REG:
>  	case KVM_CAP_ARM_PSCI:
> +	case KVM_CAP_ARM_PSCI_0_2:
>  		r = 1;
>  		break;

I don't think we should advertise this to userspace before being spec
compliant.  For example, it would break bisecting with a newer user
space.

Just do all the internal implementation and add this as the last patch
when everything else is in place.


>  	case KVM_CAP_COALESCED_MMIO:
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 448f60e..e4ec4af 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -85,17 +85,57 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	return KVM_PSCI_RET_SUCCESS;
>  }
>  
> -/**
> - * kvm_psci_call - handle PSCI call if r0 value is in range
> - * @vcpu: Pointer to the VCPU struct
> - *
> - * Handle PSCI calls from guests through traps from HVC instructions.
> - * The calling convention is similar to SMC calls to the secure world where
> - * the function number is placed in r0 and this function returns true if the
> - * function number specified in r0 is withing the PSCI range, and false
> - * otherwise.
> - */
> -bool kvm_psci_call(struct kvm_vcpu *vcpu)
> +int kvm_psci_version(struct kvm_vcpu *vcpu)
> +{
> +	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
> +		return KVM_ARM_PSCI_0_2;
> +
> +	return KVM_ARM_PSCI_0_1;
> +}
> +
> +static bool kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
> +	unsigned long val;
> +
> +	switch (psci_fn) {
> +	case KVM_PSCI_0_2_FN_PSCI_VERSION:
> +		/*
> +		 * Bits[31:16] = Major Version = 0
> +		 * Bits[15:0] = Minor Version = 2
> +		 */
> +		val = 2;
> +		break;
> +	case KVM_PSCI_0_2_FN_CPU_OFF:
> +		kvm_psci_vcpu_off(vcpu);
> +		val = KVM_PSCI_RET_SUCCESS;
> +		break;
> +	case KVM_PSCI_0_2_FN_CPU_ON:
> +	case KVM_PSCI_0_2_FN64_CPU_ON:
> +		val = kvm_psci_vcpu_on(vcpu);
> +		break;
> +	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
> +	case KVM_PSCI_0_2_FN_AFFINITY_INFO:
> +	case KVM_PSCI_0_2_FN_MIGRATE:
> +	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> +	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
> +	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
> +	case KVM_PSCI_0_2_FN_SYSTEM_RESET:
> +	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
> +	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
> +	case KVM_PSCI_0_2_FN64_MIGRATE:
> +	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
> +		val = KVM_PSCI_RET_NI;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	*vcpu_reg(vcpu, 0) = val;
> +	return true;
> +}
> +
> +static bool kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>  	unsigned long val;
> @@ -112,7 +152,6 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
>  	case KVM_PSCI_FN_MIGRATE:
>  		val = KVM_PSCI_RET_NI;
>  		break;
> -
>  	default:
>  		return false;
>  	}
> @@ -120,3 +159,25 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
>  	*vcpu_reg(vcpu, 0) = val;
>  	return true;
>  }
> +
> +/**
> + * kvm_psci_call - handle PSCI call if r0 value is in range
> + * @vcpu: Pointer to the VCPU struct
> + *
> + * Handle PSCI calls from guests through traps from HVC instructions.
> + * The calling convention is similar to SMC calls to the secure world where
> + * the function number is placed in r0 and this function returns true if the
> + * function number specified in r0 is withing the PSCI range, and false
> + * otherwise.
> + */
> +bool kvm_psci_call(struct kvm_vcpu *vcpu)
> +{
> +	switch (kvm_psci_version(vcpu)) {
> +	case KVM_ARM_PSCI_0_2:
> +		return kvm_psci_0_2_call(vcpu);
> +	case KVM_ARM_PSCI_0_1:
> +		return kvm_psci_0_1_call(vcpu);
> +	default:
> +		return false;
> +	};
> +}
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0a1d697..92242ce 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -39,7 +39,7 @@
>  #include <kvm/arm_vgic.h>
>  #include <kvm/arm_arch_timer.h>
>  
> -#define KVM_VCPU_MAX_FEATURES 2
> +#define KVM_VCPU_MAX_FEATURES 3
>  
>  struct kvm_vcpu;
>  int kvm_target_cpu(void);
> diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
> index e301a48..e25c658 100644
> --- a/arch/arm64/include/asm/kvm_psci.h
> +++ b/arch/arm64/include/asm/kvm_psci.h
> @@ -18,6 +18,10 @@
>  #ifndef __ARM64_KVM_PSCI_H__
>  #define __ARM64_KVM_PSCI_H__
>  
> +#define KVM_ARM_PSCI_0_1	1
> +#define KVM_ARM_PSCI_0_2	2
> +
> +int kvm_psci_version(struct kvm_vcpu *vcpu);
>  bool kvm_psci_call(struct kvm_vcpu *vcpu);
>  
>  #endif /* __ARM64_KVM_PSCI_H__ */
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index eaf54a3..cadc318 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -77,6 +77,7 @@ struct kvm_regs {
>  
>  #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
> +#define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>  
>  struct kvm_vcpu_init {
>  	__u32 target;
> @@ -177,7 +178,7 @@ struct kvm_arch_memory_slot {
>  /* Highest supported SPI, from VGIC_NR_IRQS */
>  #define KVM_ARM_IRQ_GIC_MAX		127
>  
> -/* PSCI interface */
> +/* PSCI v0.1 interface */
>  #define KVM_PSCI_FN_BASE		0x95c1ba5e
>  #define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
>  
> @@ -186,10 +187,42 @@ struct kvm_arch_memory_slot {
>  #define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
>  #define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
>  
> +/* PSCI v0.2 interface */
> +#define KVM_PSCI_0_2_FN_BASE		0x84000000
> +#define KVM_PSCI_0_2_FN(n)		(KVM_PSCI_0_2_FN_BASE + (n))
> +#define KVM_PSCI_0_2_FN64_BASE		0xC4000000
> +#define KVM_PSCI_0_2_FN64(n)		(KVM_PSCI_0_2_FN64_BASE + (n))
> +
> +#define KVM_PSCI_0_2_FN_PSCI_VERSION	KVM_PSCI_0_2_FN(0)
> +#define KVM_PSCI_0_2_FN_CPU_SUSPEND	KVM_PSCI_0_2_FN(1)
> +#define KVM_PSCI_0_2_FN_CPU_OFF		KVM_PSCI_0_2_FN(2)
> +#define KVM_PSCI_0_2_FN_CPU_ON		KVM_PSCI_0_2_FN(3)
> +#define KVM_PSCI_0_2_FN_AFFINITY_INFO	KVM_PSCI_0_2_FN(4)
> +#define KVM_PSCI_0_2_FN_MIGRATE		KVM_PSCI_0_2_FN(5)
> +#define KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE \
> +					KVM_PSCI_0_2_FN(6)
> +#define KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU \
> +					KVM_PSCI_0_2_FN(7)
> +#define KVM_PSCI_0_2_FN_SYSTEM_OFF	KVM_PSCI_0_2_FN(8)
> +#define KVM_PSCI_0_2_FN_SYSTEM_RESET	KVM_PSCI_0_2_FN(9)
> +
> +#define KVM_PSCI_0_2_FN64_CPU_SUSPEND	KVM_PSCI_0_2_FN64(1)
> +#define KVM_PSCI_0_2_FN64_CPU_ON	KVM_PSCI_0_2_FN64(3)
> +#define KVM_PSCI_0_2_FN64_AFFINITY_INFO	KVM_PSCI_0_2_FN64(4)
> +#define KVM_PSCI_0_2_FN64_MIGRATE	KVM_PSCI_0_2_FN64(5)
> +#define KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU \
> +					KVM_PSCI_0_2_FN64(7)
> +
> +/* PSCI return values */
>  #define KVM_PSCI_RET_SUCCESS		0
>  #define KVM_PSCI_RET_NI			((unsigned long)-1)
>  #define KVM_PSCI_RET_INVAL		((unsigned long)-2)
>  #define KVM_PSCI_RET_DENIED		((unsigned long)-3)
> +#define KVM_PSCI_RET_ALREADY_ON		((unsigned long)-4)
> +#define KVM_PSCI_RET_ON_PENDING		((unsigned long)-5)
> +#define KVM_PSCI_RET_INTERNAL_FAILURE	((unsigned long)-6)
> +#define KVM_PSCI_RET_NOT_PRESENT	((unsigned long)-7)
> +#define KVM_PSCI_RET_DISABLED		((unsigned long)-8)
>  
>  #endif
>  
> -- 
> 1.7.9.5
> 

Otherwise,
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
