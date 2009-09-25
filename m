From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 25 Sep 2009 17:09:09 -0400 (EDT)
Subject: [PATCH] Fix booting pre-ARM6 machines
In-Reply-To: <1253912064-9444-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253912064-9444-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.00.0909251703530.4997@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Sep 2009, Uwe Kleine-K?nig wrote:

> Commit 200b812d0084f800bc52465e273b118ff5f8141f includes the following
> hunk:
> 
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index a4eaf4f..e17e3c3 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -76,13 +76,25 @@
>  #ifndef CONFIG_THUMB2_KERNEL
>  	.macro	svc_exit, rpsr
>  	msr	spsr_cxsf, \rpsr
> +#if defined(CONFIG_CPU_32v6K)
> +	clrex					@ clear the exclusive monitor
>  	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
> +#elif defined (CONFIG_CPU_V6)
> +	ldr	r0, [sp]
> +	strex	r1, r2, [sp]			@ clear the exclusive monitor
> +	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
> +#endif
>  	.endm
> 
>  	.macro	restore_user_regs, fast = 0, offset = 0
> 

I've sent the same patch directly to Linus already in the hope that 
he'll merge it before -rc1.

Also you should avoid quoting patch hunks without indenting them or 
prefixing them with some quotation mark, otherwise the tools used to 
apply patches from emails will pick on that "diff" above as if it was 
the actual patch and discard everything that follows it.


Nicolas
