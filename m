From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 27 Apr 2012 10:09:13 -0600
Subject: [PATCH] ARM:mfd: fix ezx-pcap build failure
In-Reply-To: <20120426215258.GG24211@n2100.arm.linux.org.uk>
References: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
 <20120426215258.GG24211@n2100.arm.linux.org.uk>
Message-ID: <20120427160913.87CE93E1290@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Apr 2012 22:52:58 +0100, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Apr 25, 2012 at 11:02:43AM -0400, Mark Asselstine wrote:
> > Attempting to build the ezx_defconfig we get a build failure:
> > 
> > drivers/mfd/ezx-pcap.c: In function 'pcap_isr_work':
> > drivers/mfd/ezx-pcap.c:205: error: implicit declaration of function 'irq_to_gpio'
> > 
> > Looking at this failure we can find that commit 4929f5a8a99f
> > [ARM:pxa: rename gpio_to_irq and irq_to_gpio] renamed irq_to_gpio()
> > to pxa_irq_to_gpio() but this change was not made in the ezx-pcap
> > driver.
> 
> That's because drivers shouldn't have knowledge about the SoC they're
> running on.  This driver is not restricted to only being built for PXA,
> and so with your change, this will cause a link error should this be
> built on non-PXA.
> 
> However, there's a big problem with code using irq_to_gpio() or any
> variant of that in this manner:
> 
>         } while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
> 
> What is the effect when the supplied IRQ does not have a mapping to a
> GPIO - or it _does_ by way of a badly coded irq_to_gpio() function
> but that GPIO is not the correct one.

... like if multiple gpios map to the same IRQ.

> There is no prevention against endlessly looping, so it could cause a
> system lockup.
> 
> The real answer is to fix SPI et.al. so that its possible to pass the
> _GPIO_ number into this driver (that's what the driver wants for its
> interrupt line after all).  To fix that, SPI folk need to get involved
> (added Grant as a first step.)

This doesn't look like a core SPI problem to me.  This specific driver
needs a gpio connection to work and therefore it should be passed in
via either the DT binding or platform_data as Mark suggests.

g.
