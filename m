From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 6 Jul 2010 10:40:43 +0300
Subject: [RFC PATCH] arm/imx/gpio: add spinlock protection
In-Reply-To: <20100706071702.GI26079@pengutronix.de>
References: <7fe710a6bc27460852588d2e561ec4c4a4644ab0.1278227668.git.baruch@tkos.co.il>
	<20100705075218.GC26079@pengutronix.de>
	<20100706050033.GA28547@jasper.tkos.co.il>
	<20100706071702.GI26079@pengutronix.de>
Message-ID: <20100706074043.GC28547@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jul 06, 2010 at 09:17:02AM +0200, Sascha Hauer wrote:
> On Tue, Jul 06, 2010 at 08:00:34AM +0300, Baruch Siach wrote:
> > On Mon, Jul 05, 2010 at 09:52:18AM +0200, Sascha Hauer wrote:
> > > On Sun, Jul 04, 2010 at 10:15:13AM +0300, Baruch Siach wrote:
> > > > The GPIO and IRQ/GPIO registers need protection from concurrent access for
> > > > operations that are not atomic.
> > > 
> > > I don't think we need locking here. mxc_gpio_irq_handler is called with
> > > desc->lock held (from the parent interrupt, not the chained interrupts).
> > > Other functions like enable_irq/disable_irq which result in mask/unmask
> > > operations run with interrupts disabled.
> > 
> > What about the .set_type method?
> 
> Is only called with interrupts disabled.

OK.

> > > Apart from this other architectures do not use locking here aswell.
> > 
> > The Nomadic gpio driver does use a spinlock for mask/unmask operations.
> > 
> > What about the _set_gpio_direction, and mxc_gpio_set? These functions may be 
> > called from a process context (e.g., via sysfs). A context switch between 
> > __raw_readl and __raw_writel will cause corruption.
> 
> The gpio_chip functions are protected by a single spinlock in
> gpiolib.

gpio_direction_input uses the gpio_lock for its own internal sanity check, and 
releases it before calling chip->direction_input. The same goes for 
gpio_direction_output.

The __gpio_set_value function seems not acquire any lock before calling 
chip->set.

> The gpio related registers and the irq related regsiters are
> totally orthogonal, so we need no locking between these registers.

True.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
