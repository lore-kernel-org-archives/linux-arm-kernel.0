From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 9 Feb 2011 11:38:45 -0500 (EST)
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
In-Reply-To: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
References: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1102091133050.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Feb 2011, Dave Martin wrote:

> The content for ALT_SMP() in the definition of WFE() expands to 6
> bytes (IT cc ; WFEcc.W), which breaks the assumptions of the fixup
> code, leading to lockups when the affected code gets run.
> 
> This patch works around the problem by explicitly using an
> IT + WFEcc.N pair.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/include/asm/spinlock.h |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index da1af52..7cba79c 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -18,7 +18,12 @@
>  
>  #ifdef CONFIG_THUMB2_KERNEL
>  #define SEV		ALT_SMP("sev.w", "nop.w")
> -#define WFE(cond)	ALT_SMP("wfe" cond ".w", "nop.w")
> +#define WFE(cond)	ALT_SMP(		\
> +	"it " cond "\n\t"			\
> +	"wfe" cond ".n",			\
> +						\
> +	"nop.w"					\
> +)

In addition to a comment inline for this as others have suggested 
already, I'd write it differently to save some realestate:

#define WFE(cond)	ALT_SMP("it " cond " ; wfe" cond ".n", "nop.w")


Nicolas
