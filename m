From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Nov 2013 10:51:41 +0000
Subject: [PATCH] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <1384157427-31613-2-git-send-email-victor.kamensky@linaro.org>
References: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
 <1384157427-31613-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131111105141.GB28302@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 08:10:27AM +0000, Victor Kamensky wrote:
> In case of armv7-m architecture arm instructions are not allowed.
> For this architecture CONFIG_CPU_THUMBONLY is set. Use this macro
> to emit conditionally arm instructions or nops in thumb mode.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kernel/sigreturn_codes.S | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
> index 3c5d0f2..899fb86 100644
> --- a/arch/arm/kernel/sigreturn_codes.S
> +++ b/arch/arm/kernel/sigreturn_codes.S
> @@ -41,17 +41,29 @@
>  	.arch armv4t
>  #endif
>  
> +/*
> + * In CPU_THUMBONLY kernel case arm opcodes are not allowed
> + */
> +#ifndef CONFIG_CPU_THUMBONLY

Is this THUMBONLY stuff actually destined for mainline?

> +#define ARM_INSTR(code...) .arm ; \
> +			   code
> +#else
> +#define ARM_INSTR(code...) .thumb ; \
> +			   nop ;    \
> +			   nop ;
> +#endif

Why can't you solve this with the ARM(...) and THUMB(...) macros, like we do
in places like head.S?

Will
