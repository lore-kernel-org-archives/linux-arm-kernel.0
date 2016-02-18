From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Feb 2016 17:16:23 +0100
Subject: [PATCH v2] irqchip: irq-mvebu-odmi: new driver for platform MSI
 on Marvell 7K/8K
In-Reply-To: <3923904.c50oLNXXZ1@wuerfel>
References: <1455811134-3679-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <3923904.c50oLNXXZ1@wuerfel>
Message-ID: <20160218171623.664dabd1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Thu, 18 Feb 2016 17:08:05 +0100, Arnd Bergmann wrote:
> On Thursday 18 February 2016 16:58:54 Thomas Petazzoni wrote:
> > +- marvell,spi-base     : List of GIC base SPI interrupts, one for each
> > +                         ODMI frame. Those SPI interrupts are 0-based,
> > +                         i.e marvell,spi-base = <128> will use SPI #96.
> > +                         See Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> > +                         for details about the GIC Device Tree binding.
> > 
> 
> Why are these not just in an 'interrupts' property as we do for other
> nested irqchips?

I modeled this after the GICv2m bindings. I think the reason is that if
we were to use the interrupts property, we should be listing *all*
interrupts of the parent interrupt controller we are using. Which would
be quite painful when your ODMI interrupt controller uses 32 interrupts
of the parent controller (I think for the GICv2m, it's even more).

I.e, we currently say:

	marvell,spi-base = <128>, <136>, <144>, <152>

but in fact we are using 128, 129, 130, 131, 132, 133, 134, 135, 136,
137, etc. until 159.

If you think

	interrupts = <128>, <136>, <144>, <152>

is still correct, then why not. But I believe this might be confusing,
as people will think that we are only using interrupts 128, 136, 144
and 152, and not 129, 133, 147 or 158.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
