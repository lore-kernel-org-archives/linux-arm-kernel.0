From: mohun106@gmail.com (Radha Mohan)
Date: Thu, 6 Mar 2014 11:36:07 +0530
Subject: [RFC PATCH 1/1] arm64: Add boot time configuration of
 Intermediate Physical Address size
In-Reply-To: <1393830037-25499-2-git-send-email-mohun106@gmail.com>
References: <1393830037-25499-1-git-send-email-mohun106@gmail.com>
 <1393830037-25499-2-git-send-email-mohun106@gmail.com>
Message-ID: <CAC8NTUVjMGKXWxVWqa0=CS0EDxRwD1yfB_VoMHE0FSOHD7dNeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Any comments?

regards,
Radha Mohan


On Mon, Mar 3, 2014 at 12:30 PM,  <mohun106@gmail.com> wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>
> ARMv8 supports a range of physical address bit sizes. The PARange bits
> from ID_AA64MMFR0_EL1 register are read during boot-time and the
> intermediate physical address size bits are written in the translation
> control registers (TCR_EL1 and VTCR_EL2).
>
> There is no change in the VA bits and levels of translation.
>
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h       |   15 ++++++---------
>  arch/arm64/include/asm/pgtable-hwdef.h |    5 ++---
>  arch/arm64/kvm/hyp-init.S              |    7 +++++++
>  arch/arm64/mm/proc.S                   |    9 ++++++++-
>  4 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 0eb3986..21ef48d 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -106,7 +106,6 @@
>
>  /* VTCR_EL2 Registers bits */
>  #define VTCR_EL2_PS_MASK       (7 << 16)
> -#define VTCR_EL2_PS_40B                (2 << 16)
>  #define VTCR_EL2_TG0_MASK      (1 << 14)
>  #define VTCR_EL2_TG0_4K                (0 << 14)
>  #define VTCR_EL2_TG0_64K       (1 << 14)
> @@ -129,10 +128,9 @@
>   * 64kB pages (TG0 = 1)
>   * 2 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_FLAGS         (VTCR_EL2_PS_40B | VTCR_EL2_TG0_64K | \
> -                                VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
> -                                VTCR_EL2_IRGN0_WBWA | VTCR_EL2_SL0_LVL1 | \
> -                                VTCR_EL2_T0SZ_40B)
> +#define VTCR_EL2_FLAGS         (VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
> +                                VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> +                                VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
>  #define VTTBR_X                (38 - VTCR_EL2_T0SZ_40B)
>  #else
>  /*
> @@ -142,10 +140,9 @@
>   * 4kB pages (TG0 = 0)
>   * 3 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_FLAGS         (VTCR_EL2_PS_40B | VTCR_EL2_TG0_4K | \
> -                                VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
> -                                VTCR_EL2_IRGN0_WBWA | VTCR_EL2_SL0_LVL1 | \
> -                                VTCR_EL2_T0SZ_40B)
> +#define VTCR_EL2_FLAGS         (VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
> +                                VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> +                                VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
>  #define VTTBR_X                (37 - VTCR_EL2_T0SZ_40B)
>  #endif
>
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index b1d2e26..f7af66b 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -100,9 +100,9 @@
>  #define PTE_HYP                        PTE_USER
>
>  /*
> - * 40-bit physical address supported.
> + * Highest possible physical address supported.
>   */
> -#define PHYS_MASK_SHIFT                (40)
> +#define PHYS_MASK_SHIFT                (48)
>  #define PHYS_MASK              ((UL(1) << PHYS_MASK_SHIFT) - 1)
>
>  /*
> @@ -122,7 +122,6 @@
>  #define TCR_SHARED             ((UL(3) << 12) | (UL(3) << 28))
>  #define TCR_TG0_64K            (UL(1) << 14)
>  #define TCR_TG1_64K            (UL(1) << 30)
> -#define TCR_IPS_40BIT          (UL(2) << 32)
>  #define TCR_ASID16             (UL(1) << 36)
>  #define TCR_TBI0               (UL(1) << 37)
>
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index 2b0244d..642fec9 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -68,6 +68,13 @@ __do_hyp_init:
>         msr     tcr_el2, x4
>
>         ldr     x4, =VTCR_EL2_FLAGS
> +       /*
> +        * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
> +        * VTCR_EL2.
> +        */
> +       mrs     x5, ID_AA64MMFR0_EL1
> +       ubfiz   x5, x5, #16, #3
> +       orr     x4, x4, x5
>         msr     vtcr_el2, x4
>
>         mrs     x4, mair_el1
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 1333e6f..0657247 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -215,8 +215,15 @@ ENTRY(__cpu_setup)
>          * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
>          * both user and kernel.
>          */
> -       ldr     x10, =TCR_TxSZ(VA_BITS) | TCR_FLAGS | TCR_IPS_40BIT | \
> +       ldr     x10, =TCR_TxSZ(VA_BITS) | TCR_FLAGS | \
>                       TCR_ASID16 | TCR_TBI0 | (1 << 31)
> +       /*
> +        * Read the PARange bits from ID_AA64MMFR0_EL1 and set the IPS bits in
> +        * TCR_EL1.
> +        */
> +       mrs     x9, ID_AA64MMFR0_EL1
> +       ubfiz   x9, x9, #32, #3
> +       orr     x10, x10, x9
>  #ifdef CONFIG_ARM64_64K_PAGES
>         orr     x10, x10, TCR_TG0_64K
>         orr     x10, x10, TCR_TG1_64K
> --
> 1.7.1
>
