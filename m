From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 15 Jun 2011 19:57:13 -0400 (EDT)
Subject: [RFC PATCH v2 1/5] ARM: mm: Add generic proc/arch struct
	definition macros
In-Reply-To: <1308049105-16080-2-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<1308049105-16080-2-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1106151944240.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jun 2011, Dave Martin wrote:

> This patch adds some generic macros to reduce boilerplate when
> declaring certain common structures in arch/arm/mm/*.S
> 
> Thanks to Russell King for outlining what the
> define_processor_functions macro could look like.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/mm/proc-macros.S |   79 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 79 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 34261f9..3c5ffbb 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -254,3 +255,81 @@
>  	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
>  	mcr	p15, 0, ip, c7, c10, 4		@ data write barrier
>  	.endm
> +
> +.macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0
> +	.pushsection .text
> +
> +	__INITDATA

Was this __INITDATA right after a .pushsection intentional?  One might 
be confused about the effective section after this.

The __INITDATA tag is actually doing a

	.section	".init.data","aw",%progbits

Maybe this could be used as argument to .pushsection instead of .text 
(which in this case should probably have been .rodata otherwise anyway).


Nicolas
