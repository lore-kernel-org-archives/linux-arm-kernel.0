From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 18 Nov 2014 11:35:03 +0100
Subject: [PATCH v4 01/19] arm/arm64: KVM: rework MPIDR assignment and
 add accessors
In-Reply-To: <1415959683-26027-2-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-2-git-send-email-andre.przywara@arm.com>
Message-ID: <546B20D7.2060408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 11:07 AM, Andre Przywara wrote:
> The virtual MPIDR registers (containing topology information) for the
> guest are currently mapped linearily to the vcpu_id. Improve this
> mapping for arm64 by using three levels to not artificially limit the
> number of vCPUs.
> To help this, change and rename the kvm_vcpu_get_mpidr() function to
> mask off the non-affinity bits in the MPIDR register.
> Also add an accessor to later allow easier access to a vCPU with a
> given MPIDR. Use this new accessor in the PSCI emulation.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v3...v4:
> - rename kvm_vcpu_get_mpidr() to kvm_vcpu_get_mpidr_aff()
> - simplify kvm_mpidr_to_vcpu()
> - fixup comment
> 
>  arch/arm/include/asm/kvm_emulate.h   |    5 +++--
>  arch/arm/include/asm/kvm_host.h      |    2 ++
>  arch/arm/kvm/arm.c                   |   13 +++++++++++++
>  arch/arm/kvm/psci.c                  |   17 +++++------------
>  arch/arm64/include/asm/kvm_emulate.h |    5 +++--
>  arch/arm64/include/asm/kvm_host.h    |    2 ++
>  arch/arm64/kvm/sys_regs.c            |   11 +++++++++--
>  7 files changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index b9db269..3ae88ac 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -23,6 +23,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmio.h>
>  #include <asm/kvm_arm.h>
> +#include <asm/cputype.h>
>  
>  unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
>  unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
> @@ -162,9 +163,9 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
>  	return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
>  }
>  
> -static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
> +static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
>  {
> -	return vcpu->arch.cp15[c0_MPIDR];
> +	return vcpu->arch.cp15[c0_MPIDR] & MPIDR_HWID_BITMASK;
Hi Andre,

Can't we use a single naming here? aff or hwid
>  }
>  
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 53036e2..b443dfe 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -236,6 +236,8 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
> +
>  static inline void kvm_arch_hardware_disable(void) {}
>  static inline void kvm_arch_hardware_unsetup(void) {}
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 9e193c8..c2a5c69 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -977,6 +977,19 @@ static void check_kvm_target_cpu(void *ret)
>  	*(int *)ret = kvm_target_cpu();
>  }
>  
> +struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
> +{
> +	struct kvm_vcpu *vcpu;
> +	int i;
> +
> +	mpidr &= MPIDR_HWID_BITMASK;
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (mpidr == kvm_vcpu_get_mpidr_aff(vcpu))
> +			return vcpu;
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * Initialize Hyp-mode and memory mappings on all CPUs.
>   */
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 09cf377..84121b2 100644
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
> @@ -154,7 +147,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>  	 * then ON else OFF
>  	 */
>  	kvm_for_each_vcpu(i, tmp, kvm) {
> -		mpidr = kvm_vcpu_get_mpidr(tmp);
> +		mpidr = kvm_vcpu_get_mpidr_aff(tmp);
>  		if (((mpidr & target_affinity_mask) == target_affinity) &&
>  		    !tmp->arch.pause) {
>  			return PSCI_0_2_AFFINITY_LEVEL_ON;
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 5674a55..d4daaa5 100644
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
> @@ -182,9 +183,9 @@ static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
>  	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC_TYPE;
>  }
>  
> -static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
> +static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
>  {
> -	return vcpu_sys_reg(vcpu, MPIDR_EL1);
> +	return vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
>  }
>  
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 2012c4b..286bb61 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -207,6 +207,8 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
> +
>  static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>  				       phys_addr_t pgd_ptr,
>  				       unsigned long hyp_stack_ptr,
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 4cc3b71..fd3ffc3 100644
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
> +	 * We limit the number of VCPUs in Aff0 due to a limitation in the
> +	 * ICC_SGIxR registers of the GICv3.
>  	 */
I had some difficulties to understand that comment. Is that limitation a
bug, a limitation bound to be fixed later? I found in the doc each
affinity level might have between 1 and 256 children. But target
a.b.c.{target list} for SGI is limited to 16 processors only. To me it
is clearer stated that way.

Best Regards

Eric

> -	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1UL << 31) | (vcpu->vcpu_id & 0xff);
> +	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
> +	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
> +	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
> +	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1ULL << 31) | mpidr;
>  }
>  
>  /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
> 
