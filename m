From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jun 2016 16:32:17 +0100
Subject: [PATCH 3/6] arm64: include alternative handling in
 dcache_by_line_op
In-Reply-To: <1462812590-4494-4-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
 <1462812590-4494-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20160624153216.GE22608@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 05:49:47PM +0100, Andre Przywara wrote:
> The newly introduced dcache_by_line_op macro is used at least in
> one occassion at the moment to issue a "dc cvau" instruction,
> which is affected by ARM errata 819472, 826319, 827319 and 824069.
> Change the macro to allow for alternative patching in there to
> protect affected Cortex-A53 cores.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/mm/proc-macros.S | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
> index e6a30e1..5786017 100644
> --- a/arch/arm64/mm/proc-macros.S
> +++ b/arch/arm64/mm/proc-macros.S
> @@ -78,7 +78,14 @@
>  	add	\size, \kaddr, \size
>  	sub	\tmp2, \tmp1, #1
>  	bic	\kaddr, \kaddr, \tmp2
> -9998:	dc	\op, \kaddr
> +9998:
> +	alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE, (\op == cvau || \op == cvac)
> +	dc	\op, \kaddr
> +	.if	(\op == cvau || \op == cvac)
> +	alternative_else
> +	dc	civac, \kaddr
> +	alternative_endif
> +	.endif

We can revert commit 77ee306c0aea ("arm64: alternatives: add enable
parameter to conditional asm macros"), drop the first patch in this
series and move the .if outside the alternative block (with a
duplication of the "dc \op, \kaddr" line.

-- 
Catalin
