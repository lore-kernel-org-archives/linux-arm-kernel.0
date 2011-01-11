From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 11 Jan 2011 11:56:09 +0100
Subject: Locking in the clk API
In-Reply-To: <20110111104709.GB11039@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111103929.GN24920@pengutronix.de>
	<20110111104709.GB11039@n2100.arm.linux.org.uk>
Message-ID: <20110111105609.GO24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Jan 11, 2011 at 10:47:09AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 11, 2011 at 11:39:29AM +0100, Uwe Kleine-K?nig wrote:
> > A quick look into Digi's BSP (digiEL-5.0) shows they implemented
> > something I suggested earlier here:
> >
> > [...]
> > 
> > 
> > I think the idea is nice.  At least it allows with a single lock to
> > implement both, sleeping and atomic clks without the need to mark the
> > atomicity in a global flag.
> 
> It doesn't.  clk_enable() here can still end up trying to sleep when
> it's called from IRQ context - the code doesn't solve that.  All it
> means is that the intermediate code doesn't care whether clk->endisable
> ends up sleeping or not.
Obviousley you're right and your last sentence is all I intended to
claim.

> What it does do is return -EBUSY if there are two concurrent attempts
> to enable the same clock.  How many drivers today deal sanely with
> such an error from clk_enable(), and how many would just fail their
> probe() call on such an occurance?
Yes, that's the ugly part.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
