From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Jan 2011 11:57:34 +0100 (CET)
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <4D2FFCBE.3010704@eukrea.com>
References: <20110113091355.GP24920@pengutronix.de>
	<4D2EDE10.3040809@atmel.com>
	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
	<4D2F6AB7.30800@eukrea.com> <20110113212401.GZ24920@pengutronix.de>
	<4D2FFCBE.3010704@eukrea.com>
Message-ID: <alpine.LFD.2.00.1101141138480.2678@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Jan 2011, Eric B?nard wrote:

> On 13/01/2011 22:24, Uwe Kleine-K?nig wrote:
> > On Thu, Jan 13, 2011 at 10:12:23PM +0100, Eric B?nard wrote:
> > > On 13/01/2011 19:15, Thomas Gleixner wrote:
> > > > On Thu, 13 Jan 2011, Nicolas Ferre wrote:
> > > > > Le 13/01/2011 10:13, Uwe Kleine-K?nig :
> > > > > > On Thu, Jan 13, 2011 at 09:25:19AM +0100, Eric B?nard wrote:
> > > > > > > Commenting out this line in the ads7846 driver makes it work
> > > > > > > again.
> > > > > > > Am I missing something obvious or is there a reason for
> > > > > > > IRQF_ONESHOT
> > > > > > > creating trouble with gpio irq or SPI on i.MX ?
> > > > > > I don't know.  Is the irq masked?  pending?
> > > > > 
> > > > > Just to let you know that I have the same issue on my at91sam9g10ek:
> > > > > atmel_spi + ads7846 (using ADS7843e actually).
> > > > > ... solved by same workaround.
> > > > 
> > > > Eric, Nicolas: How are the interrupt handlers set for the relevant
> > > > interrupt lines and how are the interrupt pins configured?
> > > > 
> > > on the i.MX27 :
> > > - gpio configured as a plain input (in function ads7846_dev_init()
> > > in arch/arm/mach-imx/eukrea_mbimx27-baseboard.c)
> > > - threaded interrupt handler registered with flags
> > > IRQF_TRIGGER_FALLING | IRQF_ONESHOT (in function ads7846_probe() in
> > > drivers/input/touchscreen/ads7846.c)
> > I didn't recheck the hw manual, but adding IRQF_TRIGGER_FALLING calls
> > gpio_set_irq_type (defined in arch/arm/plat-mxc/gpio.c) which results
> > into something called GPIO_INT_FALL_EDGE being written into a register.
> > 
> > So I'd say it's configured to be edge sensitive.
> > 
> I confirm this point : the gpio is configured to trigger an irq on falling
> edge.

Right, but that does not tell me which flow handler is used for this
particular irq. Looking at arch/arm/plat-mxc/gpio.c it seems that the
gpio irqs are set up using handle_level_irq ! That explains the
ONESHOT wreckage nicely as you are missing an edge irq which comes in
_BEFORE_ the finalize code unmasks the line.

So there are several things wrong here:

1) Using handle_level_irq for an edge interrupt is wrong. That's not
   restricted to the TS driver problem at hand. That's wrong in
   general. Other set_type() functions adjust the handler as well when
   they switch the edge/level types.

2) Using ONESHOT for an edge interrupt is wrong as well. Removing the
   ONESHOT flag is just papering over the problem because it does not
   make the #1 problem go away, it just hides it.

The TS driver uses probably edge for historical reasons to avoid an
interrupt storm. But now with the oneshot mechanism we really should
use level type interrupts and keep the ONESHOT flag. 

Thanks,

	tglx
