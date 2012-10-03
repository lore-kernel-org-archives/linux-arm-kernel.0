From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 3 Oct 2012 11:04:54 -0400 (EDT)
Subject: [PATCH] ARM: proc-v7: Ensure correct instruction set after
 cpu_reset
In-Reply-To: <1349256170-4367-1-git-send-email-dave.martin@linaro.org>
References: <1349256170-4367-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.02.1210031104180.24483@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Oct 2012, Dave Martin wrote:

> Because mov pc,<Rn> never switches instruction set when executed in
> Thumb code, Thumb-2 kernels will silently execute the target code
> after cpu_reset as Thumb code, even if the passed code pointer
> denotes ARM (bit 0 clear).
> 
> This patch uses bx instead, ensuring the correct instruction set
> for the target code.
> 
> Thumb code in the kernel is not supported prior to ARMv7, so other
> CPUs are not affected.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mm/proc-v7.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index c2e2b66..ca5b575 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -57,7 +57,7 @@ ENTRY(cpu_v7_reset)
>   THUMB(	bic	r1, r1, #1 << 30 )		@ SCTLR.TE (Thumb exceptions)
>  	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
>  	isb
> -	mov	pc, r0
> +	bx	r0
>  ENDPROC(cpu_v7_reset)
>  	.popsection
>  
> -- 
> 1.7.4.1
> 
