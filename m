From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 15 Oct 2014 09:25:23 -0700
Subject: [PATCH v2 01/15] arm/arm64: KVM: rework MPIDR assignment and add
 accessors
In-Reply-To: <1408626416-11326-2-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-2-git-send-email-andre.przywara@arm.com>
Message-ID: <20141015162523.GB14272@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:06:42PM +0100, Andre Przywara wrote:
> The virtual MPIDR registers (containing topology information) for the
> guest are currently mapped linearily to the vcpu_id. Improve this
> mapping for arm64 by using three levels to not artificially limit the
> number of vCPUs. Also add an accessor to later allow easier access to
> a vCPU with a given MPIDR.
> Use this new accessor in the PSCI emulation.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/kvm_emulate.h   |    2 +-
>  arch/arm/include/asm/kvm_host.h      |    2 ++
>  arch/arm/kvm/arm.c                   |   15 +++++++++++++++
>  arch/arm/kvm/psci.c                  |   15 ++++-----------
>  arch/arm64/include/asm/kvm_emulate.h |    3 ++-
>  arch/arm64/include/asm/kvm_host.h    |    2 ++
>  arch/arm64/kvm/sys_regs.c            |   11 +++++++++--
>  7 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 69b7469..18e45f7 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -159,7 +159,7 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
>  
>  static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
>  {
> -	return vcpu->arch.cp15[c0_MPIDR];
> +	return vcpu->arch.cp15[c0_MPIDR] & MPIDR_HWID_BITMASK;

why?

>  }
>  
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 6dfb404..cf99ad0 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -233,4 +233,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
> +
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 7d5065e..addb990 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -990,6 +990,21 @@ static void check_kvm_target_cpu(void *ret)
>  	*(int *)ret = kvm_target_cpu();
>  }
>  
> +struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
> +{
> +	unsigned long c_mpidr;
> +	struct kvm_vcpu *vcpu;
> +	int i;
> +
> +	mpidr &= MPIDR_HWID_BITMASK;
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		c_mpidr = kvm_vcpu_get_mpidr(vcpu);
> +		if (c_mpidr == mpidr)
> +			return vcpu;
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * Initialize Hyp-mode and memory mappings on all CPUs.
>   */
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 09cf377..49f0992 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -21,6 +21,7 @@
>  #include <asm/cputype.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_psci.h>
> +#include <asm/kvm_host.h>
>  
>  /*
>   * This is an implementation of the Power State Coordination Interface
> @@ -65,25 +66,17 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  {
>  	struct kvm *kvm = source_vcpu->kvm;
> -	struct kvm_vcpu *vcpu = NULL, *tmp;
> +	struct kvm_vcpu *vcpu = NULL;
>  	wait_queue_head_t *wq;
>  	unsigned long cpu_id;
>  	unsigned long context_id;
> -	unsigned long mpidr;
>  	phys_addr_t target_pc;
> -	int i;
>  
> -	cpu_id = *vcpu_reg(source_vcpu, 1);
> +	cpu_id = *vcpu_reg(source_vcpu, 1) & MPIDR_HWID_BITMASK;
>  	if (vcpu_mode_is_32bit(source_vcpu))
>  		cpu_id &= ~((u32) 0);
>  
> -	kvm_for_each_vcpu(i, tmp, kvm) {
> -		mpidr = kvm_vcpu_get_mpidr(tmp);
> -		if ((mpidr & MPIDR_HWID_BITMASK) == (cpu_id & MPIDR_HWID_BITMASK)) {
> -			vcpu = tmp;
> -			break;
> -		}
> -	}
> +	vcpu = kvm_mpidr_to_vcpu(kvm, cpu_id);
>  
>  	/*
>  	 * Make sure the caller requested a valid CPU and that the CPU is
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index fdc3e21..4b8d636 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -27,6 +27,7 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmio.h>
>  #include <asm/ptrace.h>
> +#include <asm/cputype.h>
>  
>  unsigned long *vcpu_reg32(const struct kvm_vcpu *vcpu, u8 reg_num);
>  unsigned long *vcpu_spsr32(const struct kvm_vcpu *vcpu);
> @@ -179,7 +180,7 @@ static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>  
>  static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
>  {
> -	return vcpu_sys_reg(vcpu, MPIDR_EL1);
> +	return vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;

why?

>  }
>  
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e10c45a..017fbae 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -244,4 +244,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
>  	}
>  }
>  
> +struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
> +
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5805e7c..a79538a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -252,10 +252,17 @@ static void reset_amair_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  
>  static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  {
> +	u64 mpidr;
> +
>  	/*
> -	 * Simply map the vcpu_id into the Aff0 field of the MPIDR.
> +	 * Map the vcpu_id into the first three Aff fields of the MPIDR.
> +	 * Aff0 uses only 16 CPUs, since there is a SGI injection
> +	 * limitation of GICv3.

We limit the number of VCPUs in Aff0 due to a limitation in the
ICC_SGIxR registers of the GICv3.

>  	 */
> -	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1UL << 31) | (vcpu->vcpu_id & 0xff);
> +	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
> +	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
> +	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
> +	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1ULL << 31) | mpidr;
>  }
>  
>  /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
> -- 
> 1.7.9.5
> 
