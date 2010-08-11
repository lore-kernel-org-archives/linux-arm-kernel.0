From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 11 Aug 2010 12:55:24 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <20100811105125.GI10432@buzzloop.caiaq.de>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<AANLkTimH9xhjRUaoqr-GMy4gj27VTtrafHU=bqfT6oZ-@mail.gmail.com>
	<20100811105125.GI10432@buzzloop.caiaq.de>
Message-ID: <201008111255.24657.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 11. srpna 2010 12:51:25 Daniel Mack napsal(a):
> On Wed, Aug 11, 2010 at 02:46:15PM +0400, Yuri Ludkevich wrote:
> > 2010/8/11 Daniel Mack <daniel@caiaq.de>
> > 
> > > On Wed, Aug 11, 2010 at 02:08:10PM +0400, Yuri Ludkevich wrote:
> > > > 2010/8/11 Daniel Mack <daniel@caiaq.de>
> > > > 
> > > > > Yes, they are aliases to the signals without the "_2" suffix.
> > > > > Quoting the PXA reference manual, chapter 5.3:
> > > > > 
> > > > > GPIO<6_0>_2:
> > > > > 
> > > > > General-Purpose IO Ports, second instantiation. The same signals as
> > > > > GPIO<6:0>, but they are given separate names because they are
> > > 
> > > configured
> > > 
> > > > > on separate multi-function pins. The recommended configuration is
> > > > > for both multi-function pin instantiations of these GPIOs not to
> > > > > be configured simultaneously for GPIO functionality. The preferred
> > > > > configuration for dual instantiation GPIO usage (that is, using
> > > > > both GPIO<6:0> and GPIO<6:0>_2 functions) is to configure one
> > > > > multi-function pin as a GPIO and the second multi-function pin
> > > > > instantiation for an alternate function other than a GPIO
> > > > > function. Configuring GPIO<6:0> to be present on two separate
> > > > > multi-function pins is not recommended. However, when GPIO<6:0> is
> > > > > configured as an output and both multi-function pin instantiations
> > > > > are programmed for GPIO function, the primary and secondary
> > > > > instantiation of the multi-function pins are both outputs from the
> > > > > common GGPIO<6:0> signal. However, when GPIO<6:0> is
> > > 
> > > an
> > > 
> > > > > input, the inputs from both multi-function pin instantiations are
> > > > > ORed together before the result is sent to the internal GPIO<6:0>
> > > > > input logic.
> > > > 
> > > > Hmmm. I found with pxaregs tool what both GPIO4 and GPIO4_2
> > > > configured as GPIO. May be this cause irq autodetection to fail?
> > > 
> > > No - if you don't tell the driver which GPIO the interrupt line is
> > > connected to, it can't know. But as the reference manual says, such
> > > configurations should be avoided.
> > > 
> > > You're welcome to come up with a patch :)
> > > 
> > > Daniel
> > 
> > I configure GPIO4 pin as nCS3 (alternate function #1) in colibri-pxa320.c
> > and after that irq autoprobing found valid irq for UCB1400. So
> > touchscreen now working just fine.
> 
> Good. Can you share a patch?

nCS3 is the chipselect for CPLD space actually (and the EXT chipselects). If 
it's configured as nCS3, you can write to the CPLD, but in case you don't need 
PCMCIA (and ext. chipselects), you should be ok either way.

And as Dan said, don't mix GPIO4 and GPIO4_2 :)

Cheers
> 
> > May be I need to check other second instantiation pins for same thing?
> 
> Sure, double-checking can't harm. If you find anything, feel free to fix
> it up.
> 
> Just make sure you read Documentation/SubmittingPatches in order to
> avoid the most common pitfalls :)
> 
> Thanks,
> Daniel
