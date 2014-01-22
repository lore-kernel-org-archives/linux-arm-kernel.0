From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 11:20:55 +0000
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140122112055.GF1621@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 01:05:21PM +0000, Leif Lindholm wrote:
> A new macro for setting/clearing bits in the SCTLR.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Suggested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/assembler.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 5c22851..aba6458 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -383,4 +383,17 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  #endif
>  	.endm
>  
> +#ifdef CONFIG_CPU_CP15
> +/* Macro for setting/clearing bits in sctlr */
> +	.macro update_sctlr, set:req, clear:req, tmp:req, tmp2:req
> +	mrc	p15, 0, \tmp, c1, c0, 0
> +	ldr	\tmp2, =\set
> +	orr	\tmp, \tmp, \tmp2
> +	ldr	\tmp2, =\clear
> +	mvn	\tmp2, \tmp2
> +	and	\tmp, \tmp, \tmp2
> +	mcr	p15, 0, \tmp, c1, c0, 0

I think this would be cleaner if you force the caller to put set and clear
into registers beforehand, rather than have to do the literal load every
time. Also, I don't think set and clear should be required (and then you can
lose tmp2 as well).

Will
