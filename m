From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 19 Aug 2014 16:38:34 +0200
Subject: [PATCH v5] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <53F35DFD.9070804@amd.com>
References: <20140818203604.4654.99905.stgit@joelaarch64.amd.com>
 <20140819122420.GC31086@cbox> <53F35DFD.9070804@amd.com>
Message-ID: <20140819143834.GE31086@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 09:23:57AM -0500, Joel Schopp wrote:
> 
> On 08/19/2014 07:24 AM, Christoffer Dall wrote:
> > On Mon, Aug 18, 2014 at 03:36:04PM -0500, Joel Schopp wrote:
> >> The current VTTBR_BADDR_MASK only masks 39 bits, which is broken on current
> >> systems.  Rather than just add a bit it seems like a good time to also set
> >> things at run-time instead of compile time to accomodate more hardware.
> >>
> >> This patch sets TCR_EL2.PS, VTCR_EL2.T0SZ and vttbr_baddr_mask in runtime,
> >> not compile time.
> >>
> >> In ARMv8, EL2 physical address size (TCR_EL2.PS) and stage2 input address
> >> size (VTCR_EL2.T0SZE) cannot be determined in compile time since they
> >> depend on hardware capability.
> >>
> >> According to Table D4-23 and Table D4-25 in ARM DDI 0487A.b document,
> >> vttbr_x is calculated using different fixed values with consideration
> >> of T0SZ, granule size and the level of translation tables. Therefore,
> >> vttbr_baddr_mask should be determined dynamically.
> >>
> >> Changes since v4:
> >> More minor cleanups from review
> >> Moved some functions into headers
> >>
> >> Changes since v3:
> >> Another rebase
> >> Addressed minor comments from v2
> >>
> >> Changes since v2:
> >> Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next branch
> >>
> >> Changes since v1:
> >> Rebased fix on Jungseok Lee's patch https://lkml.org/lkml/2014/5/12/189 to
> >> provide better long term fix.  Updated that patch to log error instead of
> >> silently fail on unaligned vttbr.
> >>
> >> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >> Cc: Sungjinn Chung <sungjinn.chung@samsung.com>
> >> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> >> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> >> ---
> >>  arch/arm/include/asm/kvm_mmu.h   |   12 ++++++
> >>  arch/arm/kvm/arm.c               |   17 +++++++-
> >>  arch/arm64/include/asm/kvm_arm.h |   17 +-------
> >>  arch/arm64/include/asm/kvm_mmu.h |   78 ++++++++++++++++++++++++++++++++++++++
> >>  arch/arm64/kvm/hyp-init.S        |   20 +++++++---
> >>  5 files changed, 122 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> >> index 5c7aa3c..73f6ff6 100644
> >> --- a/arch/arm/include/asm/kvm_mmu.h
> >> +++ b/arch/arm/include/asm/kvm_mmu.h
> >> @@ -166,6 +166,18 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
> >>  
> >>  void stage2_flush_vm(struct kvm *kvm);
> >>  
> >> +static inline int kvm_get_phys_addr_shift(void)
> >> +{
> >> +	return KVM_PHYS_SHIFT;
> >> +}
> >> +
> >> +static inline int set_vttbr_baddr_mask(void)
> >> +{
> >> +	vttbr_baddr_mask = VTTBR_BADDR_MASK;
> >> +	return 0;
> >> +}
> >> +
> >> +
> >>  #endif	/* !__ASSEMBLY__ */
> >>  
> >>  #endif /* __ARM_KVM_MMU_H__ */
> >> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >> index 3c82b37..f396eb7 100644
> >> --- a/arch/arm/kvm/arm.c
> >> +++ b/arch/arm/kvm/arm.c
> >> @@ -37,6 +37,7 @@
> >>  #include <asm/mman.h>
> >>  #include <asm/tlbflush.h>
> >>  #include <asm/cacheflush.h>
> >> +#include <asm/cputype.h>
> >>  #include <asm/virt.h>
> >>  #include <asm/kvm_arm.h>
> >>  #include <asm/kvm_asm.h>
> >> @@ -466,8 +467,14 @@ static void update_vttbr(struct kvm *kvm)
> >>  	/* update vttbr to be used with the new vmid */
> >>  	pgd_phys = virt_to_phys(kvm->arch.pgd);
> >>  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
> >> -	kvm->arch.vttbr = pgd_phys & VTTBR_BADDR_MASK;
> >> -	kvm->arch.vttbr |= vmid;
> >> +
> >> +	/*
> >> +	 * If the VTTBR isn't aligned there is something wrong with the system
> >> +	 * or kernel.
> >> +	 */
> >> +	BUG_ON(pgd_phys & ~vttbr_baddr_mask);
> >> +
> >> +	kvm->arch.vttbr = pgd_phys | vmid;
> >>  
> >>  	spin_unlock(&kvm_vmid_lock);
> >>  }
> >> @@ -1052,6 +1059,12 @@ int kvm_arch_init(void *opaque)
> >>  		}
> >>  	}
> >>  
> >> +	err = set_vttbr_baddr_mask();
> >> +	if (err) {
> >> +		kvm_err("Cannot set vttbr_baddr_mask\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >>  	cpu_notifier_register_begin();
> >>  
> >>  	err = init_hyp_mode();
> >> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> >> index 3d69030..8dbef70 100644
> >> --- a/arch/arm64/include/asm/kvm_arm.h
> >> +++ b/arch/arm64/include/asm/kvm_arm.h
> >> @@ -94,7 +94,6 @@
> >>  /* TCR_EL2 Registers bits */
> >>  #define TCR_EL2_TBI	(1 << 20)
> >>  #define TCR_EL2_PS	(7 << 16)
> >> -#define TCR_EL2_PS_40B	(2 << 16)
> >>  #define TCR_EL2_TG0	(1 << 14)
> >>  #define TCR_EL2_SH0	(3 << 12)
> >>  #define TCR_EL2_ORGN0	(3 << 10)
> >> @@ -103,8 +102,6 @@
> >>  #define TCR_EL2_MASK	(TCR_EL2_TG0 | TCR_EL2_SH0 | \
> >>  			 TCR_EL2_ORGN0 | TCR_EL2_IRGN0 | TCR_EL2_T0SZ)
> >>  
> >> -#define TCR_EL2_FLAGS	(TCR_EL2_PS_40B)
> >> -
> >>  /* VTCR_EL2 Registers bits */
> >>  #define VTCR_EL2_PS_MASK	(7 << 16)
> >>  #define VTCR_EL2_TG0_MASK	(1 << 14)
> >> @@ -119,36 +116,28 @@
> >>  #define VTCR_EL2_SL0_MASK	(3 << 6)
> >>  #define VTCR_EL2_SL0_LVL1	(1 << 6)
> >>  #define VTCR_EL2_T0SZ_MASK	0x3f
> >> -#define VTCR_EL2_T0SZ_40B	24
> >> +#define VTCR_EL2_T0SZ(bits)	(64 - (bits))
> >>  
> >>  #ifdef CONFIG_ARM64_64K_PAGES
> >>  /*
> >>   * Stage2 translation configuration:
> >> - * 40bits output (PS = 2)
> >> - * 40bits input  (T0SZ = 24)
> >>   * 64kB pages (TG0 = 1)
> >>   * 2 level page tables (SL = 1)
> >>   */
> >>  #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
> >>  				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> >> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> >> -#define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
> >> +				 VTCR_EL2_SL0_LVL1)
> >>  #else
> >>  /*
> >>   * Stage2 translation configuration:
> >> - * 40bits output (PS = 2)
> >> - * 40bits input  (T0SZ = 24)
> >>   * 4kB pages (TG0 = 0)
> >>   * 3 level page tables (SL = 1)
> >>   */
> >>  #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
> >>  				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> >> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> >> -#define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
> >> +				 VTCR_EL2_SL0_LVL1)
> >>  #endif
> >>  
> >> -#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
> >> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
> >>  #define VTTBR_VMID_SHIFT  (48LLU)
> >>  #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
> >>  
> >> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> >> index 7d29847..b6ae83b 100644
> >> --- a/arch/arm64/include/asm/kvm_mmu.h
> >> +++ b/arch/arm64/include/asm/kvm_mmu.h
> >> @@ -152,5 +152,83 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
> >>  
> >>  void stage2_flush_vm(struct kvm *kvm);
> >>  
> >> +/*
> >> + * ARMv8 64K architecture limitations:
> >> + * 16 <= T0SZ <= 21 is valid under 3 level of translation tables
> >> + * 18 <= T0SZ <= 34 is valid under 2 level of translation tables
> >> + * 31 <= T0SZ <= 39 is valid under 1 level of transltaion tables
> >> + *
> >> + * ARMv8 4K architecture limitations:
> >> + * 16 <= T0SZ <= 24 is valid under 4 level of translation tables
> >> + * 21 <= T0SZ <= 33 is valid under 3 level of translation tables
> >> + * 30 <= T0SZ <= 39 is valid under 2 level of translation tables
> >> + *
> >> + * For 4K pages we only support 3 or 4 level, giving T0SZ a range of 16 to 33.
> >> + * For 64K pages we only support 2 or 3 level, giving T0SZ a range of 16 to 34.
> >> + *
> >> + * See Table D4-23 and Table D4-25 in ARM DDI 0487A.b to figure out
> >> + * the origin of the hardcoded values, 38 and 37.
> >> + */
> >> +
> >> +#ifdef CONFIG_ARM64_64K_PAGES
> >> +static inline int t0sz_to_vttbr_x(int t0sz)
> >> +{
> >> +	if (t0sz < 16 || t0sz > 34) {
> >> +		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
> >> +		return 0;
> >> +	}
> >> +
> >> +	return 38 - t0sz;
> >> +}
> >> +#else /* 4K pages */
> >> +static inline int t0sz_to_vttbr_x(int t0sz)
> >> +{
> >> +	if (t0sz < 16 || t0sz > 33) {
> >> +		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
> >> +		return 0;
> > why not just return an error code directly here?  These are now
> > returning 0 on error which usually means everything was ok...
> The return is a value,not just an error code. Because of this returning
> an error overloads that value.  0 just seemed like a convenient invalid
> value to check since a vttbr_x of 0 is invalid, but returning a negative
> error code would be as equally invalid.  If this is the only issue it
> doesn't seem worth respinning the patch for, but I'll change it to
> -EINVAL if for some reason a v6 is needed.

Have you given up on doing the alignment check with the proper size on
the pgd allocation for this patch?

-Christoffer
