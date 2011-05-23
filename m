From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 May 2011 16:22:48 +0100
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110523144126.GF20715@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201451160.3078@ionos>
	<20110520130721.GD10403@pengutronix.de>
	<alpine.LFD.2.02.1105201518030.3078@ionos>
	<20110521112947.GB11887@sirena.org.uk>
	<20110523062501.GA20715@pengutronix.de>
	<20110523104409.GA15635@opensource.wolfsonmicro.com>
	<20110523144126.GF20715@pengutronix.de>
Message-ID: <20110523152248.GC6489@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 04:41:26PM +0200, Sascha Hauer wrote:

> > This isn't terribly good, the only reason we're checking pdata here is
> > because we can't dereference it to look up irq_base if it's not there.

> I'm not sure what you mean here. Are you suggesting that we should
> default to dynamically requested irqs without platform data?

Yes, exactly.

> I did it this way because without platform data pdata->irq_high is
> unknown.

With platform data it has a default value, and indeed when the chip
powers on it has a default.

> > One other thing - it doesn't seem to be 100% desirable to making the
> > allocation of the IRQ descriptors depend on not specifying a base - for
> > many situations we're likely to want to know what the numbers we end up
> > with are (eg, for passing to another device) but if we don't call
> > irq_alloc_decs() the platform still has to arrange for the descriptors
> > to be there in advance.  It feels like the code should always use
> > irq_alloc_descs(), though obviously that's not going to work right now.

> If that's the case the platform still can provide irq_base and then it
> does know in advance. Also, shouldn't this other device be instantiated

You're missing my point here.  The platform not only has to allocate the
base number, it also has to do the allocation of the descriptors.  That
seems less than ideal as it means that any platform using the driver
has to replicate the code for allocating the IRQ range that was
assigned.

> from the wm8350 driver?

We normally instantiate drivers following the control bus heirachy, not
the interrupt controller heirachy...
