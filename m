From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 16:19:05 +0100
Subject: [PATCH v3 2/7] arm64: Factor out TTBR0_EL1 post-update
 workaround into a specific asm macro
In-Reply-To: <1473788797-10879-3-git-send-email-catalin.marinas@arm.com>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
 <1473788797-10879-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160915151905.GE9316@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 06:46:32PM +0100, Catalin Marinas wrote:
> This patch takes the errata workaround code out of cpu_do_switch_mm into
> a dedicated post_ttbr0_update_workaround macro which will be reused in a
> subsequent patch.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h | 17 +++++++++++++++++
>  arch/arm64/mm/proc.S               | 11 +----------
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index d5025c69ca81..0a47632787d9 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -350,4 +350,21 @@ alternative_endif
>  	movk	\reg, :abs_g0_nc:\val
>  	.endm
>  
> +/*
> + * Errata workaround post TTBR0_EL1 update.
> + */
> +	.macro	post_ttbr0_update_workaround
> +#ifdef CONFIG_CAVIUM_ERRATUM_27456
> +alternative_if_not ARM64_WORKAROUND_CAVIUM_27456
> +	nop
> +	nop
> +	nop
> +alternative_else
> +	ic	iallu
> +	dsb	nsh
> +	isb
> +alternative_endif
> +#endif
> +	.endm
> +
>  #endif	/* __ASM_ASSEMBLER_H */

As a general note, it's unfortunate that we put asm with alternatives in
<asm/assembler.h>, as that's included by <asm/alternative.h>, so we're
relying on things that aren't defined yet, and users have to remember to
include <asm/alternative.h>.

That's already the case for dcache_by_line_op, so I guess that's
something to deal with another day.

Otherwise, this looks good, and I guess this wil be auto-nopped in a
subsqeuent version, so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
