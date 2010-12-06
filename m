From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 Dec 2010 17:13:43 +0100
Subject: [PATCH] prevent 'BUG: sleeping function called from invalid
	context' in arch_reset()
In-Reply-To: <20101129095833.GB20449@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
	<19695.32386.279224.624305@ipc1.ka-ro>
	<20101126095733.GA27637@pengutronix.de>
	<19695.36407.793411.550458@ipc1.ka-ro>
	<20101126113255.GC27637@pengutronix.de>
	<19699.29070.822244.938508@ipc1.ka-ro>
	<20101129095833.GB20449@pengutronix.de>
Message-ID: <20101206161343.GB21020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[extended the audience, some context:  arch/arm/plat-mxc currently uses
a clk_enable in arch_reset which might sleep]

On Mon, Nov 29, 2010 at 10:58:33AM +0100, Uwe Kleine-K?nig wrote:
> Hello Lothar,
> 
> On Mon, Nov 29, 2010 at 10:25:34AM +0100, Lothar Wa?mann wrote:
> > arch_reset() may be called from interrupt context (e.g. induced by
> > SYSRQ-B), thus clk_get() and clk_enable() must not be called from
> > within arch_reset(). Move these calls to mxc_arch_reset_init().
> I wonder if SYSRQ-B is the only way to trigger that.  And if yes if that
> could be "fixed" to allow sleeping?!
Hmmm, the comment for emergency_restart() says:

/**
 *      emergency_restart - reboot the system
 *
 *      Without shutting down any hardware or taking any locks
 *      reboot the system.  This is called when we know we are in
 *      trouble so this is our best effort to reboot.  This is
 *      safe to call in interrupt context.
 */

emergency_restart has several callers apart from sysrq (watchdog, ocfs2,
kdb, panic), so I think allowing to sleep isn't that easy.

Moreover the sysrq function is called with the uart port's lock hold,
that would need fixing in the serial driver.  I found the same problem
in amba-pl011 (the only driver I checked), so this seems to be a big
task.  Sysrq holds a lock, too, while calling the handler.

I still think it's wrong to enable the watchdog clock unconditionally
during boot and wonder if that sleep in atomic can just be ignored?!

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
