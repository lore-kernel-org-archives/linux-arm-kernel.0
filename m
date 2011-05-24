From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 May 2011 09:28:14 +0200
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110523224045.GA19533@opensource.wolfsonmicro.com>
References: <alpine.LFD.2.02.1105201451160.3078@ionos>
	<20110520130721.GD10403@pengutronix.de>
	<alpine.LFD.2.02.1105201518030.3078@ionos>
	<20110521112947.GB11887@sirena.org.uk>
	<20110523062501.GA20715@pengutronix.de>
	<20110523104409.GA15635@opensource.wolfsonmicro.com>
	<20110523144126.GF20715@pengutronix.de>
	<20110523152248.GC6489@sirena.org.uk>
	<20110523164601.GG20715@pengutronix.de>
	<20110523224045.GA19533@opensource.wolfsonmicro.com>
Message-ID: <20110524072814.GC22096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 06:41:00AM +0800, Mark Brown wrote:
> On Mon, May 23, 2011 at 06:46:01PM +0200, Sascha Hauer wrote:
> > On Mon, May 23, 2011 at 04:22:48PM +0100, Mark Brown wrote:
> 
> > > With platform data it has a default value, and indeed when the chip
> > > powers on it has a default.
> 
> > Ok, what should be the default for irq_high then if we do not have
> > platform data?
> 
> Off - the default value for platform data is all zeros.

Ok.

> 
> > > You're missing my point here.  The platform not only has to allocate the
> > > base number, it also has to do the allocation of the descriptors.  That
> > > seems less than ideal as it means that any platform using the driver
> > > has to replicate the code for allocating the IRQ range that was
> > > assigned.
> 
> > We can do the irq_alloc_descs unconditionally then. If irq_base is
> > not given, we are happy with any irq irq_alloc_descs returns. If
> > irq_base is given, we check the return value of irq_alloc_descs for
> > exactly irq_base.
> 
> That's what I'm suggesting, but like I say I'm not convinced that's
> actually going to do the right thing currently on non-sparse systems or

non-sparse systems handle this correctly.

> on systems that do actually have the IRQ range allocated for some other
> reason.

By 'some other reason' you mean an implementation bug? If the range is
already allocated the wm8350 driver should better not use it.

> 
> > > We normally instantiate drivers following the control bus heirachy, not
> > > the interrupt controller heirachy...
> 
> > I assumed that drivers using the irqs from the wm8350 are usually
> > children of the wm8350, like the watchdog, rtc, regulator drivers already are.
> > This may not be true for the gpio interrupts, but you can calculate the
> > irq from the gpio number.
> 
> You can only do that if the device is using the GPIO as a GPIO as well
> as using it as an interrupt.  If the device is just using the GPIO on
> the PMIC as an interrupt then it doesn't help as the driver isn't using
> the GPIO API at all.

You are right. As we agreed on allocating the irq descs unconditionally
and preserve the possibility for a fixed range passed in from platform
data this shouldn't be a problem. A platform can still use fixed irq
numbers if it wishes to.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
