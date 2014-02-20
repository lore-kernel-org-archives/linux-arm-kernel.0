From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Feb 2014 17:22:22 +0000
Subject: [RFC PATCH 1/2] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <1392396913-13570-2-git-send-email-steve.capper@linaro.org>
References: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
 <1392396913-13570-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20140220172222.GL3615@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Fri, Feb 14, 2014 at 04:55:12PM +0000, Steve Capper wrote:
> For LPAE, we have the following means for encoding writable or dirty
> ptes:
>                               L_PTE_DIRTY       L_PTE_RDONLY
>     !pte_dirty && !pte_write        0               1
>     !pte_dirty && pte_write         0               1
>     pte_dirty && !pte_write         1               1
>     pte_dirty && pte_write          1               0
> 
> So we can't distinguish between writable clean ptes and read only
> ptes. This can cause problems with ptes being incorrectly flagged as
> read only when they are writable but not dirty.
> 
> This patch re-introduces the L_PTE_WRITE bit for both short descriptors
> and long descriptors, by reverting:
>   36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
> 
> For short descriptors the L_PTE_RDONLY bit is renamed to L_PTE_WRITE
> and the pertinent logic changed. For long descriptors, L_PTE_WRITE is
> implemented as a new software bit and L_PTE_RDONLY is renamed to
> PTE_RDONLY to highlight the fact that it is a hardware bit.

This would be a lot easier to review if it was a true revert, but I guess
that doesn't apply cleanly to mainline?

> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm/include/asm/pgtable-2level.h |  2 +-
>  arch/arm/include/asm/pgtable-3level.h |  4 ++--
>  arch/arm/include/asm/pgtable.h        | 36 +++++++++++++++++------------------
>  arch/arm/mm/dump.c                    |  8 ++++----
>  arch/arm/mm/mmu.c                     | 25 ++++++++++++------------
>  arch/arm/mm/proc-macros.S             | 16 ++++++++--------
>  arch/arm/mm/proc-v7-2level.S          |  6 +++---
>  arch/arm/mm/proc-v7-3level.S          |  6 ++++--
>  arch/arm/mm/proc-xscale.S             |  4 ++--
>  9 files changed, 55 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index dfff709..ca43b84 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -120,7 +120,7 @@
>  #define L_PTE_YOUNG            (_AT(pteval_t, 1) << 1)
>  #define L_PTE_FILE             (_AT(pteval_t, 1) << 2) /* only when !PRESENT */
>  #define L_PTE_DIRTY            (_AT(pteval_t, 1) << 6)
> -#define L_PTE_RDONLY           (_AT(pteval_t, 1) << 7)
> +#define L_PTE_WRITE            (_AT(pteval_t, 1) << 7)
>  #define L_PTE_USER             (_AT(pteval_t, 1) << 8)
>  #define L_PTE_XN               (_AT(pteval_t, 1) << 9)
>  #define L_PTE_SHARED           (_AT(pteval_t, 1) << 10)        /* shared(v6), coherent(xsc3) */
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 03243f7..8a392ef 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -79,12 +79,12 @@
>  #define L_PTE_PRESENT          (_AT(pteval_t, 3) << 0)         /* Present */
>  #define L_PTE_FILE             (_AT(pteval_t, 1) << 2)         /* only when !PRESENT */
>  #define L_PTE_USER             (_AT(pteval_t, 1) << 6)         /* AP[1] */
> -#define L_PTE_RDONLY           (_AT(pteval_t, 1) << 7)         /* AP[2] */
> +#define PTE_RDONLY             (_AT(pteval_t, 1) << 7)         /* AP[2] */

Why? I think we're just using L_ for consistency here, rather than to
distinguish between h/w and Linux bits (e.g. L_PTE_XN).

>  #define L_PTE_SHARED           (_AT(pteval_t, 3) << 8)         /* SH[1:0], inner shareable */
>  #define L_PTE_YOUNG            (_AT(pteval_t, 1) << 10)        /* AF */
>  #define L_PTE_XN               (_AT(pteval_t, 1) << 54)        /* XN */
>  #define L_PTE_DIRTY            (_AT(pteval_t, 1) << 55)        /* unused */
> -#define L_PTE_SPECIAL          (_AT(pteval_t, 1) << 56)        /* unused */
> +#define L_PTE_WRITE            (_AT(pteval_t, 1) << 56)

Why have you killed L_PTE_SPECIAL? We could actually use that for LPAE...

>  #define L_PTE_NONE             (_AT(pteval_t, 1) << 57)        /* PROT_NONE */
> 
>  #define PMD_SECT_VALID         (_AT(pmdval_t, 1) << 0)
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index e3c48a3..c62fd89 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -97,7 +97,7 @@
>  #error PTE shared bit mismatch
>  #endif
>  #if !defined (CONFIG_ARM_LPAE) && \
> -       (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
> +       (L_PTE_XN+L_PTE_USER+L_PTE_WRITE+L_PTE_DIRTY+L_PTE_YOUNG+\
>          L_PTE_FILE+L_PTE_PRESENT) > L_PTE_SHARED
>  #error Invalid Linux PTE bit settings
>  #endif
> @@ -152,9 +152,9 @@
>         and     r2, r1, #L_PTE_MT_MASK
>         ldr     r2, [ip, r2]
> 
> -       eor     r1, r1, #L_PTE_DIRTY
> -       tst     r1, #L_PTE_DIRTY|L_PTE_RDONLY
> -       orrne   r3, r3, #PTE_EXT_APX
> +       tst     r1, #L_PTE_WRITE
> +       tstne   r1, #L_PTE_DIRTY
> +       orreq   r3, r3, #PTE_EXT_APX

Hehe, I have a patch pending in this macro which is sitting in -next. Take a
look at b6ccb9803e90 ("ARM: 7954/1: mm: remove remaining domain support
from ARMv6"), since this will probably conflict in horrible ways.

> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> index bdd3be4..297fccf 100644
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -84,9 +84,9 @@ ENTRY(cpu_v7_set_pte_ext)
>         tst     r1, #1 << 4
>         orrne   r3, r3, #PTE_EXT_TEX(1)
> 
> -       eor     r1, r1, #L_PTE_DIRTY
> -       tst     r1, #L_PTE_RDONLY | L_PTE_DIRTY
> -       orrne   r3, r3, #PTE_EXT_APX
> +       tst     r1, #L_PTE_WRITE
> +       tstne   r1, #L_PTE_DIRTY
> +       orreq   r3, r3, #PTE_EXT_APX
> 
>         tst     r1, #L_PTE_USER
>         orrne   r3, r3, #PTE_EXT_AP1
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index 01a719e..7793b2e 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -78,8 +78,10 @@ ENTRY(cpu_v7_set_pte_ext)
>         tst     r3, #1 << (57 - 32)             @ L_PTE_NONE
>         bicne   r2, #L_PTE_VALID
>         bne     1f
> -       tst     r3, #1 << (55 - 32)             @ L_PTE_DIRTY
> -       orreq   r2, #L_PTE_RDONLY
> +       bic     r2, #PTE_RDONLY

Why do you need this bic?

Will
