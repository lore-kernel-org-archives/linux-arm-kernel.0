From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 26 Sep 2009 10:39:44 +0200
Subject: [PATCH] make Linux bootable on ARM again
In-Reply-To: <alpine.LFD.2.00.0909251613240.4997@xanadu.home>
References: <200909252039.19789.elendil@planet.nl>
	<alpine.LFD.2.00.0909251613240.4997@xanadu.home>
Message-ID: <20090926083944.GA31699@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 25, 2009 at 04:28:02PM -0400, Nicolas Pitre wrote:
> Commit 200b812d00 "Clear the exclusive monitor when returning from an 
> exception" broke the vast majority of ARM systems in the wild which are 
> still pre ARMv6.  The kernel is crashing on the first occurrence of an 
> exception due to the removal of the actual return instruction for them.  
> Let's add it back.
> 
> Signed-off-by: Nicolas Pitre <nico@marvell.com>
> ---
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
I sent the same patch only 30 minutes later (and only to LAKML).  So
please take that as an

	Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

and the plea to take it before -rc1.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
