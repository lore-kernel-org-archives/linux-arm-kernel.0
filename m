From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Sep 2014 16:28:54 +0100
Subject: [PATCH v6] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140908230852.2118.97400.stgit@joelaarch64.amd.com>
References: <20140908230852.2118.97400.stgit@joelaarch64.amd.com>
Message-ID: <20140919152853.GH2295@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 12:08:52AM +0100, Joel Schopp wrote:
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

So I agree with vttbr_baddr_mask being determined dynamically. I also
agree with setting TCR_EL2.PS at run-time but the VTCR_EL2.T0SZ
determines the input of the stage 2 translation. That's a KVM
configuration about what IPA size it provides to the guests (and
platform model it intends to support) and it doesn't need to be the same
as the physical address range.

> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 5cc0b0f..03a08bb 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -21,6 +21,7 @@
> 
>  #include <asm/memory.h>
>  #include <asm/page.h>
> +#include <asm/kvm_arm.h>
> 
>  /*
>   * We directly use the kernel VA for the HYP, as we can directly share
> @@ -178,6 +179,18 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
> 
>  void stage2_flush_vm(struct kvm *kvm);
> 
> +static inline int kvm_get_phys_addr_shift(void)
> +{
> +       return KVM_PHYS_SHIFT;
> +}
> +
> +
> +static inline u32 get_vttbr_baddr_mask(void)
> +{
> +       return VTTBR_BADDR_MASK;
> +}

It should be u64 as it truncates the top 32 bits of the mask.

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index a99e0cd..d0fca8f 100644
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
> @@ -61,6 +62,12 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>  static u8 kvm_next_vmid;
>  static DEFINE_SPINLOCK(kvm_vmid_lock);
> 
> +#ifdef CONFIG_ARM64
> +static u64 vttbr_baddr_mask;
> +#else
> +static u32 vttbr_baddr_mask;
> +#endif

This mask should always be 64-bit as it relates to the physical address
which is 64-bit even on arm32 with LPAE enabled (same with the
get_vttbr_baddr_mask() return type above).

> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index cc83520..ff4a4fa 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -95,7 +95,6 @@
>  /* TCR_EL2 Registers bits */
>  #define TCR_EL2_TBI    (1 << 20)
>  #define TCR_EL2_PS     (7 << 16)
> -#define TCR_EL2_PS_40B (2 << 16)
>  #define TCR_EL2_TG0    (1 << 14)
>  #define TCR_EL2_SH0    (3 << 12)
>  #define TCR_EL2_ORGN0  (3 << 10)
> @@ -104,8 +103,6 @@
>  #define TCR_EL2_MASK   (TCR_EL2_TG0 | TCR_EL2_SH0 | \
>                          TCR_EL2_ORGN0 | TCR_EL2_IRGN0 | TCR_EL2_T0SZ)
> 
> -#define TCR_EL2_FLAGS  (TCR_EL2_PS_40B)
> -
>  /* VTCR_EL2 Registers bits */
>  #define VTCR_EL2_PS_MASK       (7 << 16)
>  #define VTCR_EL2_TG0_MASK      (1 << 14)
> @@ -120,36 +117,28 @@
>  #define VTCR_EL2_SL0_MASK      (3 << 6)
>  #define VTCR_EL2_SL0_LVL1      (1 << 6)
>  #define VTCR_EL2_T0SZ_MASK     0x3f
> -#define VTCR_EL2_T0SZ_40B      24
> +#define VTCR_EL2_T0SZ(bits)    (64 - (bits))
> 
>  #ifdef CONFIG_ARM64_64K_PAGES
>  /*
>   * Stage2 translation configuration:
> - * 40bits output (PS = 2)
> - * 40bits input  (T0SZ = 24)
>   * 64kB pages (TG0 = 1)
>   * 2 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_FLAGS         (VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
>                                  VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> -                                VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> -#define VTTBR_X                (38 - VTCR_EL2_T0SZ_40B)
> +                                VTCR_EL2_SL0_LVL1)
>  #else
>  /*
>   * Stage2 translation configuration:
> - * 40bits output (PS = 2)
> - * 40bits input  (T0SZ = 24)
>   * 4kB pages (TG0 = 0)
>   * 3 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_FLAGS         (VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
>                                  VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> -                                VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> -#define VTTBR_X                (37 - VTCR_EL2_T0SZ_40B)
> +                                VTCR_EL2_SL0_LVL1)
>  #endif

The PS = 2 comment was misleading as it doesn't seem to be set here. But
why dropping T0SZ? That gives the input address for stage 2 (IPA), so
whether KVM exposes a 40-bit IPA to guests is independent of whether the
kernel would use 48-bit VA.

> -#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
>  #define VTTBR_VMID_SHIFT  (48LLU)
>  #define VTTBR_VMID_MASK          (0xffLLU << VTTBR_VMID_SHIFT)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 8e138c7..1c70b2f 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -167,5 +167,80 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
> 
>  void stage2_flush_vm(struct kvm *kvm);
> 
> +/*
> + * ARMv8 64K architecture limitations:
> + * 16 <= T0SZ <= 21 is valid under 3 level of translation tables
> + * 18 <= T0SZ <= 34 is valid under 2 level of translation tables
> + * 31 <= T0SZ <= 39 is valid under 1 level of transltaion tables
> + *
> + * ARMv8 4K architecture limitations:
> + * 16 <= T0SZ <= 24 is valid under 4 level of translation tables
> + * 21 <= T0SZ <= 33 is valid under 3 level of translation tables
> + * 30 <= T0SZ <= 39 is valid under 2 level of translation tables
> + *
> + * For 4K pages we only support 3 or 4 level, giving T0SZ a range of 16 to 33.
> + * For 64K pages we only support 2 or 3 level, giving T0SZ a range of 16 to 34.
> + *
> + * See Table D4-23 and Table D4-25 in ARM DDI 0487A.b to figure out
> + * the origin of the hardcoded values, 38 and 37.
> + */

Again, why do we care about this w.r.t. the IPA?

> +
> +#ifdef CONFIG_ARM64_64K_PAGES
> +static inline int t0sz_to_vttbr_x(int t0sz)
> +{
> +       if (t0sz < 16 || t0sz > 34) {
> +               kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
> +               return -EINVAL;
> +       }
> +
> +       return 38 - t0sz;
> +}
> +#else /* 4K pages */
> +static inline int t0sz_to_vttbr_x(int t0sz)
> +{
> +       if (t0sz < 16 || t0sz > 33) {
> +               kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
> +               return -EINVAL;
> +       }
> +       return 37 - t0sz;
> +}
> +#endif
> +static inline int kvm_get_phys_addr_shift(void)
> +{
> +       int pa_range = read_cpuid(ID_AA64MMFR0_EL1) & 0xf;
> +
> +       switch (pa_range) {
> +       case 0: return 32;
> +       case 1: return 36;
> +       case 2: return 40;
> +       case 3: return 42;
> +       case 4: return 44;
> +       case 5: return 48;
> +       default:
> +               BUG();
> +               return 0;
> +       }
> +}
> +
> +/**
> + * get_vttbr_baddr_mask - get mask value for vttbr base address
> + *
> + * In ARMv8, vttbr_baddr_mask cannot be determined in compile time since the
> + * stage2 input address size depends on hardware capability. Thus, we first
> + * need to read ID_AA64MMFR0_EL1.PARange and then set vttbr_baddr_mask with
> + * consideration of both the granule size and the level of translation tables.
> + */
> +static inline u64 get_vttbr_baddr_mask(void)
> +{
> +       int t0sz, vttbr_x;
> +
> +       t0sz = VTCR_EL2_T0SZ(kvm_get_phys_addr_shift());

So what you try to do here is making IPA as wide as PA. Do we actually
care about this? I don't think we do, whether KVM presents a 48-bit IPA
to the guest should be a KVM configuration independent of the hardware
PA range.

-- 
Catalin
