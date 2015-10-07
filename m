From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 7 Oct 2015 07:17:02 +0100
Subject: [PATCH v2 01/10] arm64: mm: remove unused cpu_set_idmap_tcr_t0sz
 function
In-Reply-To: <1444153590-24173-2-git-send-email-will.deacon@arm.com>
References: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
 <1444153590-24173-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu_6H0gAhotNHzS5L46ywJaS+0d_EdB5wMXTJmCe_6A6vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2015 at 18:46, Will Deacon <will.deacon@arm.com> wrote:
> With commit b08d4640a3dc ("arm64: remove dead code"),
> cpu_set_idmap_tcr_t0sz is no longer called and can therefore be removed
> from the kernel.
>
> This patch removes the function and effectively inlines the helper
> function __cpu_set_tcr_t0sz into cpu_set_default_tcr_t0sz.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/mmu_context.h | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 8ec41e5f56f0..549b89554ce8 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -77,34 +77,23 @@ static inline bool __cpu_uses_extended_idmap(void)
>                 unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
>  }
>
> -static inline void __cpu_set_tcr_t0sz(u64 t0sz)
> -{
> -       unsigned long tcr;
> -
> -       if (__cpu_uses_extended_idmap())
> -               asm volatile (
> -               "       mrs     %0, tcr_el1     ;"
> -               "       bfi     %0, %1, %2, %3  ;"
> -               "       msr     tcr_el1, %0     ;"
> -               "       isb"
> -               : "=&r" (tcr)
> -               : "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
> -}
> -
> -/*
> - * Set TCR.T0SZ to the value appropriate for activating the identity map.
> - */
> -static inline void cpu_set_idmap_tcr_t0sz(void)
> -{
> -       __cpu_set_tcr_t0sz(idmap_t0sz);
> -}
> -
>  /*
>   * Set TCR.T0SZ to its default value (based on VA_BITS)
>   */
>  static inline void cpu_set_default_tcr_t0sz(void)
>  {
> -       __cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS));
> +       unsigned long tcr;
> +
> +       if (!__cpu_uses_extended_idmap())
> +               return;
> +
> +       asm volatile (
> +       "       mrs     %0, tcr_el1     ;"
> +       "       bfi     %0, %1, %2, %3  ;"
> +       "       msr     tcr_el1, %0     ;"
> +       "       isb"
> +       : "=&r" (tcr)
> +       : "r"(TCR_T0SZ(VA_BITS)), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
>  }
>
>  static inline void switch_new_context(struct mm_struct *mm)
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
