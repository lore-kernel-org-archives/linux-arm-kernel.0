From: ben@trinity.fluff.org (Ben Dooks)
Date: Sat, 26 Sep 2009 12:35:03 +0100
Subject: [PATCH] Fix booting pre-ARM6 machines
In-Reply-To: <1253912064-9444-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253912064-9444-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20090926113503.GJ31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2009 at 10:54:24PM +0200, Uwe Kleine-K?nig wrote:
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

hmm, this really shouldn'y be selected at compile time as what if we have
a kernel which supports V6 or later and pre-V6 in one image?

>  	.endm
> 
>  	.macro	restore_user_regs, fast = 0, offset = 0
> 
> Having neither CONFIG_THUMB2_KERNEL nor CONFIG_CPU_32v6K nor
> CONFIG_CPU_V6 this steals the ldmia instruction.  The result is that
> svc_exit doesn't work at all.  So reintroduce it.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jamie Lokier <jamie@shareable.org>
> ---
>  arch/arm/kernel/entry-header.S |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index e17e3c3..ac34c0d 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -83,6 +83,8 @@
>  	ldr	r0, [sp]
>  	strex	r1, r2, [sp]			@ clear the exclusive monitor
>  	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
> +#else
> +	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
>  #endif
>  	.endm
>  
> -- 
> 1.6.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
