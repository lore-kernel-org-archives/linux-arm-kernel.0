From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 12 Aug 2011 17:27:05 +0800
Subject: [PATCH 2/6] arm/imx: remove the uses of gpio_to_irq()
In-Reply-To: <20110812085759.GH4775@n2100.arm.linux.org.uk>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
	<1313135701-22456-3-git-send-email-shawn.guo@linaro.org>
	<20110812080000.GF4775@n2100.arm.linux.org.uk>
	<20110812082211.GD6618@S2100-06.ap.freescale.net>
	<20110812082538.GF6618@S2100-06.ap.freescale.net>
	<20110812085759.GH4775@n2100.arm.linux.org.uk>
Message-ID: <20110812092704.GG6618@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 09:57:59AM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 12, 2011 at 04:25:39PM +0800, Shawn Guo wrote:
> > On Fri, Aug 12, 2011 at 04:22:12PM +0800, Shawn Guo wrote:
> > > On Fri, Aug 12, 2011 at 09:00:00AM +0100, Russell King - ARM Linux wrote:
> > > > On Fri, Aug 12, 2011 at 03:54:57PM +0800, Shawn Guo wrote:
> > > > > gpio_to_irq() is too generic to be defined and used by i.mx platform
> > > > > code.  The patch defines IMX_GPIO_TO_IRQ() in mach/hardware.h and
> > > > > replaces all the uses of gpio_to_irq() with IMX_GPIO_TO_IRQ().
> > > > 
> > > > That makes no sense.  Why not continue to use gpio_to_irq() but provide
> > > > the .to_irq method in your gpiolib driver so it can work, and use that
> > > > in the places where its used at runtime?
> > > > 
> > > I did provide .to_irq in patch #3. 
> > > 
> > > > (You won't be able to use it for static initialization obviously.)
> > > > 
> > > All users of gpio_to_irq() in platform codes are static initialization.
> > 
> > Sorry, not all but most.
> 
> It would probably be a good idea to leave the runtime places using
> gpio_to_irq() and only convert the static initializers.
> 
Ok.

> > > And IMX_GPIO_TO_IRQ() is actually a renaming of gpio_to_irq().  Only
> > > difference there is naming and place change, which I think is good, no?
> > > 
> > 
> > But adding IMX namespace is still worth of the LOC changes?
> 
> Well, the static initializers still need something... the alternative is
> to initialize them at runtime which probably wouldn't be so nice.
> 
Let's leave static initializers with IMX_GPIO_TO_IRQ() for now, since
all of them will get killed by device tree support anyway?  With DT
support, the gpio number should be encoded in DT and needs to be
retrieved from DT at runtime, and gpio_to_irq() has to be used for
acquiring irq number then.

-- 
Regards,
Shawn
