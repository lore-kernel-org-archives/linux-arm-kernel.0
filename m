From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 31 Jul 2018 10:10:59 +0100
Subject: [PATCH] arm64: drop unused kernel_neon_begin_partial() macro
In-Reply-To: <20180731073545.32607-1-ard.biesheuvel@linaro.org>
References: <20180731073545.32607-1-ard.biesheuvel@linaro.org>
Message-ID: <20180731091057.GB4240@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 09:35:45AM +0200, Ard Biesheuvel wrote:
> When kernel mode NEON was first introduced to the arm64 kernel,
> every call to kernel_neon_begin()/_end() stacked resp. unstacked
> the entire NEON register file, making it worthwile to reduce the
> number of used NEON registers to a bare minimum, and only stack
> those. kernel_neon_begin_partial() was introduced for this purpose,
> but after the refactoring for SVE and other changes, it no longer
> exists and was simply #define'd to kernel_neon_begin() directly.
> 
> In the mean time, all users have been updated, so let's remove
> the fallback macro.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Makes sense, and nobody seems to use it any more.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/neon.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
> index f922eaf780f9..fb9d137256a6 100644
> --- a/arch/arm64/include/asm/neon.h
> +++ b/arch/arm64/include/asm/neon.h
> @@ -19,11 +19,4 @@
>  void kernel_neon_begin(void);
>  void kernel_neon_end(void);
>  
> -/*
> - * Temporary macro to allow the crypto code to compile. Note that the
> - * semantics of kernel_neon_begin_partial() are now different from the
> - * original as it does not allow being called in an interrupt context.
> - */
> -#define kernel_neon_begin_partial(num_regs)	kernel_neon_begin()
> -
>  #endif /* ! __ASM_NEON_H */
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
