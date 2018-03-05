From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Mar 2018 10:15:29 +0000
Subject: [RFC PATCH] arm64: kaslr: Set TCR_EL1.NFD1 when
 CONFIG_RANDOMIZE_BASE=y
In-Reply-To: <1520244528-9649-1-git-send-email-will.deacon@arm.com>
References: <1520244528-9649-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu_k6Dat=5oo3gYLR0E19YfDSjTFYs2vfzqBdx55rm4oFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2018 at 10:08, Will Deacon <will.deacon@arm.com> wrote:
> TCR_EL1.NFD1 was allocated by SVE and ensures that fault-surpressing SVE
> memory accesses (e.g. speculative accesses from a first-fault gather load)
> which translate via TTBR1_EL1 result in a translation fault if they
> miss in the TLB when executed from EL0. This mitigates some timing attacks
> against KASLR, where the kernel address space could otherwise be probed
> efficiently using the FFR in conjunction with suppressed faults on SVE
> loads.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> Sending as RFC because this doesn't make any difference if kpti is enabled,
> which is the default with KASLR. It helps if kpti=off is being passed and
> shouldn't have an impact on performance.
>

This just makes it harder/slower to probe the kernel address space
using SVE instructions, right?

>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>  arch/arm64/mm/proc.S                   | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index cdfe3e657a9e..fd208eac9f2a 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -291,6 +291,7 @@
>  #define TCR_TBI0               (UL(1) << 37)
>  #define TCR_HA                 (UL(1) << 39)
>  #define TCR_HD                 (UL(1) << 40)
> +#define TCR_NFD1               (UL(1) << 54)
>
>  /*
>   * TTBR.
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index c0af47617299..8f074d64b760 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -36,6 +36,12 @@
>  #define TCR_TG_FLAGS   TCR_TG0_4K | TCR_TG1_4K
>  #endif
>
> +#ifdef CONFIG_RANDOMIZE_BASE
> +#define TCR_KASLR_FLAGS        TCR_NFD1
> +#else
> +#define TCR_KASLR_FLAGS        0
> +#endif
> +
>  #define TCR_SMP_FLAGS  TCR_SHARED
>
>  /* PTWs cacheable, inner/outer WBWA */
> @@ -432,7 +438,8 @@ ENTRY(__cpu_setup)
>          * both user and kernel.
>          */
>         ldr     x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
> -                       TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
> +                       TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> +                       TCR_TBI0 | TCR_A1
>         tcr_set_idmap_t0sz      x10, x9
>
>         /*
> --
> 2.1.4
>
