From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 Aug 2014 18:05:21 +0200
Subject: [PATCH v4] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140811203823.2828.36074.stgit@joelaarch64.amd.com>
References: <20140811203823.2828.36074.stgit@joelaarch64.amd.com>
Message-ID: <20140812160521.GO10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 03:38:23PM -0500, Joel Schopp wrote:
> The current VTTBR_BADDR_MASK only masks 39 bits, which is broken on current
> systems.  Rather than just add a bit it seems like a good time to also set
> things at run-time instead of compile time to accomodate more hardware.
> 
> This patch sets TCR_EL2.PS, VTCR_EL2.T0SZ and vttbr_baddr_mask in runtime,
> not compile time.
> 
> In ARMv8, EL2 physical address size (TCR_EL2.PS) and stage2 input address
> size (VTCR_EL2.T0SZE) cannot be determined in compile time since they
> depend on hardware capability.
> 
> According to Table D4-23 and Table D4-25 in ARM DDI 0487A.b document,
> vttbr_x is calculated using different fixed values with consideration
> of T0SZ, granule size and the level of translation tables. Therefore,
> vttbr_baddr_mask should be determined dynamically.
> 
> Changes since v3:
> Another rebase
> Addressed minor comments from v2
> 
> Changes since v2:
> Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next branch
> 
> Changes since v1:
> Rebased fix on Jungseok Lee's patch https://lkml.org/lkml/2014/5/12/189 to
> provide better long term fix.  Updated that patch to log error instead of
> silently fail on unaligned vttbr.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Sungjinn Chung <sungjinn.chung@samsung.com>
> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> ---
>  arch/arm/kvm/arm.c               |  116 +++++++++++++++++++++++++++++++++++++-
>  arch/arm64/include/asm/kvm_arm.h |   17 +-----
>  arch/arm64/kvm/hyp-init.S        |   20 +++++--
>  3 files changed, 131 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 3c82b37..b4859fa 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -37,6 +37,7 @@
>  #include <asm/mman.h>
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
>  #include <asm/virt.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
> @@ -61,6 +62,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>  static u8 kvm_next_vmid;
>  static DEFINE_SPINLOCK(kvm_vmid_lock);
>  
> +static u64 vttbr_baddr_mask;
> +
>  static bool vgic_present;
>  
>  static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
> @@ -412,6 +415,103 @@ static bool need_new_vmid_gen(struct kvm *kvm)
>  	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
>  }
>  
> +
> +
> +	/*
> +	 * ARMv8 64K architecture limitations:
> +	 * 16 <= T0SZ <= 21 is valid under 3 level of translation tables
> +	 * 18 <= T0SZ <= 34 is valid under 2 level of translation tables
> +	 * 31 <= T0SZ <= 39 is valid under 1 level of transltaion tables
> +	 *
> +	 * ARMv8 4K architecture limitations:
> +	 * 16 <= T0SZ <= 24 is valid under 4 level of translation tables
> +	 * 21 <= T0SZ <= 30 is valid under 3 level of translation tables

this is still wrong, as I pointed out, it should be 21 <= T0SZ <= 30

> +	 * 30 <= T0SZ <= 39 is valid under 2 level of translation tables
> +	 *
> +	 * 
> +	 * We further limit T0SZ in ARM64 Linux by not supporting 1 level 
> +	 * translation tables at all, not supporting 2 level translation 
> +	 * tables with 4k pages, not supporting different levels of translation
> +	 * tables in stage 1 vs stage 2, not supporting different page sizes in
> +	 * stage 1 vs stage 2, not supporting less than 40 bit address space 
> +	 * with 64k pages, and not supporting less than 32 bit address space 
> +	 * with 4K pages.
> +	 *
> +	 * See Table D4-23 and Table D4-25 in ARM DDI 0487A.b to figure out
> +	 * the origin of the hardcoded values, 38 and 37.
> +	 */

nit: why is this block indented one level?

> +
> +#ifdef CONFIG_ARM64_64K_PAGES
> +static inline int t0sz_to_vttbr_x(int t0sz){
> +	if (t0sz < 16 || t0sz > 24) {

How are you getting at this?  The comment above is now almost useless,
the whole point of listing the options with the various levels of
translation tables given a page size is to show how we get to these
limits.

I think what you mean here, is:
	if (t0sz < 18 || t0sz > 34) {

> +		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
> +		return -EINVAL;
> +	}
> +
> +	return 38 - t0sz;
> +}
> +#elif CONFIG_ARM64 && !CONFIG_ARM64_64K_PAGES
> +static inline int t0sz_to_vttbr_x(int t0sz){
> +	if (t0sz < 16 || t0sz > 32) {

And here:
	if (t0sz < 21 || t0sz > 33)

> +		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
> +		return -EINVAL;
> +	}
> +	return 37 - t0sz;
> +}
> +#endif

I'd really much more like to see these two with the comment in
arch/arm64/include/asm/kvm_mmu.h as that is the scheme we've used for
all the other KVM code.

> +
> +
> +/**
> + * set_vttbr_baddr_mask - set mask value for vttbr base address
> + *
> + * In ARMv8, vttbr_baddr_mask cannot be determined in compile time since the
> + * stage2 input address size depends on hardware capability. Thus, we first
> + * need to read ID_AA64MMFR0_EL1.PARange first and then set vttbr_baddr_mask

nit: drop second 'first' (sorry, this is a result of my fist review)

> + * with consideration of both granule size and the level of translation tables.

the granule...

> + */
> +#ifndef CONFIG_ARM64
> +static int set_vttbr_baddr_mask(void)
> +{
> +	vttbr_baddr_mask = VTTBR_BADDR_MASK;
> +	return 0;
> +}
> +#else
> +static int set_vttbr_baddr_mask(void)
> +{
> +  int pa_range, t0sz, vttbr_x;

wrong indentation

> +
> +	pa_range = read_cpuid(ID_AA64MMFR0_EL1) & 0xf;
> +
> +	switch (pa_range) {
> +	case 0:
> +		t0sz = VTCR_EL2_T0SZ(32);
> +		break;
> +	case 1:
> +		t0sz = VTCR_EL2_T0SZ(36);
> +		break;
> +	case 2:
> +		t0sz = VTCR_EL2_T0SZ(40);
> +		break;
> +	case 3:
> +		t0sz = VTCR_EL2_T0SZ(42);
> +		break;
> +	case 4:
> +		t0sz = VTCR_EL2_T0SZ(44);
> +		break;
> +	case 5:
> +		t0sz = VTCR_EL2_T0SZ(48);
> +		break;
> +	default:
> +		kvm_err("Invalid EL2 pa_range");
> +		return -EINVAL;
> +	}
> +
> +	vttbr_x = t0sz_to_vttbr_x(t0sz);
> +	vttbr_baddr_mask = (((1LLU << (48 - vttbr_x)) - 1) << (vttbr_x - 1));
> +
> +	return 0;
> +}
> +#endif

I actually do think it's more consistent if we move this to the header
files as well.

But to make sure our allocation is correct and reuse some of this code,
how about we fefactor it to be kvm_get_phys_addr_shift() instead?  See
my example below which should be blended into this patch.

>  /**
>   * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
>   * @kvm	The guest that we are about to run
> @@ -466,8 +566,14 @@ static void update_vttbr(struct kvm *kvm)
>  	/* update vttbr to be used with the new vmid */
>  	pgd_phys = virt_to_phys(kvm->arch.pgd);
>  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
> -	kvm->arch.vttbr = pgd_phys & VTTBR_BADDR_MASK;
> -	kvm->arch.vttbr |= vmid;
> +
> +	/*
> +	 * If the VTTBR isn't aligned there is something wrong with the system
> +	 * or kernel.  
> +	 */
> +	BUG_ON(pgd_phys & ~vttbr_baddr_mask);
> +

I think we should introduce a nice run-time check along with this in
kvm_alloc_stage2_pgd, see below.

> +	kvm->arch.vttbr = pgd_phys | vmid;
>  
>  	spin_unlock(&kvm_vmid_lock);
>  }
> @@ -1052,6 +1158,12 @@ int kvm_arch_init(void *opaque)
>  		}
>  	}
>  
> +	err = set_vttbr_baddr_mask();
> +	if (err) {
> +		kvm_err("Cannot set vttbr_baddr_mask\n");
> +		return -EINVAL;
> +	}
> +
>  	cpu_notifier_register_begin();
>  
>  	err = init_hyp_mode();
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 3d69030..8dbef70 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -94,7 +94,6 @@
>  /* TCR_EL2 Registers bits */
>  #define TCR_EL2_TBI	(1 << 20)
>  #define TCR_EL2_PS	(7 << 16)
> -#define TCR_EL2_PS_40B	(2 << 16)
>  #define TCR_EL2_TG0	(1 << 14)
>  #define TCR_EL2_SH0	(3 << 12)
>  #define TCR_EL2_ORGN0	(3 << 10)
> @@ -103,8 +102,6 @@
>  #define TCR_EL2_MASK	(TCR_EL2_TG0 | TCR_EL2_SH0 | \
>  			 TCR_EL2_ORGN0 | TCR_EL2_IRGN0 | TCR_EL2_T0SZ)
>  
> -#define TCR_EL2_FLAGS	(TCR_EL2_PS_40B)
> -
>  /* VTCR_EL2 Registers bits */
>  #define VTCR_EL2_PS_MASK	(7 << 16)
>  #define VTCR_EL2_TG0_MASK	(1 << 14)
> @@ -119,36 +116,28 @@
>  #define VTCR_EL2_SL0_MASK	(3 << 6)
>  #define VTCR_EL2_SL0_LVL1	(1 << 6)
>  #define VTCR_EL2_T0SZ_MASK	0x3f
> -#define VTCR_EL2_T0SZ_40B	24
> +#define VTCR_EL2_T0SZ(bits)	(64 - (bits))



>  
>  #ifdef CONFIG_ARM64_64K_PAGES
>  /*
>   * Stage2 translation configuration:
> - * 40bits output (PS = 2)
> - * 40bits input  (T0SZ = 24)
>   * 64kB pages (TG0 = 1)
>   * 2 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
>  				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> -#define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
> +				 VTCR_EL2_SL0_LVL1)
>  #else
>  /*
>   * Stage2 translation configuration:
> - * 40bits output (PS = 2)
> - * 40bits input  (T0SZ = 24)
>   * 4kB pages (TG0 = 0)
>   * 3 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
>  				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> -#define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
> +				 VTCR_EL2_SL0_LVL1)
>  #endif
>  
> -#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
>  #define VTTBR_VMID_SHIFT  (48LLU)
>  #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
>  
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index d968796..c0f7634 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -63,17 +63,21 @@ __do_hyp_init:
>  	mrs	x4, tcr_el1
>  	ldr	x5, =TCR_EL2_MASK
>  	and	x4, x4, x5
> -	ldr	x5, =TCR_EL2_FLAGS
> -	orr	x4, x4, x5
> -	msr	tcr_el2, x4
> -
> -	ldr	x4, =VTCR_EL2_FLAGS
>  	/*
>  	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
> -	 * VTCR_EL2.
> +	 * TCR_EL2 and both PS bits and T0SZ bits in VTCR_EL2.
>  	 */
>  	mrs	x5, ID_AA64MMFR0_EL1
>  	bfi	x4, x5, #16, #3
> +	msr	tcr_el2, x4
> +
> +	ldr	x4, =VTCR_EL2_FLAGS
> +	bfi	x4, x5, #16, #3
> +	and	x5, x5, #0xf
> +	adr	x6, t0sz
> +	add	x6, x6, x5, lsl #2
> +	ldr	w5, [x6]
> +	orr	x4, x4, x5
>  	msr	vtcr_el2, x4
>  
>  	mrs	x4, mair_el1
> @@ -109,6 +113,10 @@ target: /* We're now in the trampoline code, switch page tables */
>  
>  	/* Hello, World! */
>  	eret
> +
> +t0sz:
> +	.word	VTCR_EL2_T0SZ(32), VTCR_EL2_T0SZ(36), VTCR_EL2_T0SZ(40)
> +	.word	VTCR_EL2_T0SZ(42), VTCR_EL2_T0SZ(44), VTCR_EL2_T0SZ(48)
>  ENDPROC(__kvm_hyp_init)
>  
>  	.ltorg
> 

So I'm thinking that we should have something like this (completely
untested and not-even-compile-tested-shoot-me-now) as
part of this patch.  Apologies for not mentioning this in the first round
of review:


diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 5cc0b0f..5cf7aa5 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -178,6 +178,11 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 
 void stage2_flush_vm(struct kvm *kvm);
 
+static inline int kvm_get_phys_addr_shift(void)
+{
+	return KVM_PHYS_SHIFT;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 16e7994..70f0f02 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -521,6 +521,7 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t phys_addr)
  */
 int kvm_alloc_stage2_pgd(struct kvm *kvm)
 {
+	unsigned int s2_pgds, s2_pgd_order;
 	pgd_t *pgd;
 
 	if (kvm->arch.pgd != NULL) {
@@ -528,10 +529,18 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 		return -EINVAL;
 	}
 
-	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
+	s2_pgds = (1 << (kvm_get_phys_addr_shift() - PGDIR_SHIFT));
+	s2_pgd_order = get_order(s2_pgds * sizeof(pgd_t));
+
+	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, s2_pgd_order);
 	if (!pgd)
 		return -ENOMEM;
 
+	if ((unsigned long)pgd & ~vttbr_baddr_mask) {
+		kvm_err("Stage-2 pgd not correctly aligned: %p\n", pgd);
+		return -EFAULT;
+	}
+
 	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
 	kvm_clean_pgd(pgd);
 	kvm->arch.pgd = pgd;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 8e138c7..4341806 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -167,5 +167,23 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 
 void stage2_flush_vm(struct kvm *kvm);
 
+
+static inline int kvm_get_phys_addr_shift(void) 
+{
+	pa_range = read_cpuid(ID_AA64MMFR0_EL1) & 0xf;
+
+	switch (pa_range) {
+	case 0: return 32;
+	case 1: return 36;
+	case 2: return 40;
+	case 3: return 42;
+	case 4: return 44;
+	case 5: return 48;
+	default:
+		BUG();
+		return 0;
+	}
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
