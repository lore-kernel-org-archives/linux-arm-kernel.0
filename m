From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 May 2015 10:33:12 +0200
Subject: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
In-Reply-To: <1430430247-9632-1-git-send-email-dianders@chromium.org>
References: <1430430247-9632-1-git-send-email-dianders@chromium.org>
Message-ID: <20150504083312.GN25193@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 02:44:07PM -0700, Doug Anderson wrote:
> While it's not sensible for an i2c command to _actually_ need more
> than 200ms to complete, let's increase the timeout anyway.  Why?  It
> turns out that if you've got a large number of printks going out to a
> serial console, interrupts on a CPU can be disabled for hundreds of
> milliseconds. That's not a great situation to be in to start with
> (maybe we should put a cap in vprintk_emit()) but it's pretty annoying
> to start seeing unexplained i2c timeouts.
> 
> A normal system shouldn't see i2c timeouts anyway, so increasing the
> timeout should help people debugging without hurting other people
> excessively.
Hmm, correct me if I'm wrong: You say that the following can happen:

	rk3x_i2c_xfer calls wait_event_timeout and blocks
	schedule ... disable_irqs ... xfer complete ... do some work ... enable_irqs
	control back to i2c driver after timeout elapsed
	wait_event_timeout returned 0

The documentation of wait_event_timeout tells:

 * Returns:
 * 0 if the @condition evaluated to %false after the @timeout elapsed,
 * 1 if the @condition evaluated to %true after the @timeout elapsed,
 * or the remaining jiffies (at least 1) if the @condition evaluated
 * to %true before the @timeout elapsed.

Where is the misunderstanding?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
