From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Jul 2014 10:33:38 -0700
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <CACRpkdbc=NDmmjLi_FKvXaQ7H6gY+xHWso=Vi=tgubME4JUfyg@mail.gmail.com>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <CACRpkdbc=NDmmjLi_FKvXaQ7H6gY+xHWso=Vi=tgubME4JUfyg@mail.gmail.com>
Message-ID: <eded8c93-3961-4153-9c0d-8bb427fd8230@BL2FFO11FD050.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-07-07 at 04:45PM +0200, Linus Walleij wrote:
> On Wed, Jun 18, 2014 at 1:39 PM, Harini Katakam <harinik@xilinx.com> wrote:
> 
> > From: Harini Katakam <harini.katakam@xilinx.com>
> >
> > Add support for GPIO controller used by Xilinx Zynq.
> >
> > Signed-off-by: Harini Katakam <harinik@xilinx.com>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >
> > v2 changes:
> >  - convert to pm_runtime_force_(suspend|resume)
> >  - add pm_runtime_set_active in probe()
> >  - also (un)prepare clocks when they are dis-/enabled
> >  - add some missing calls to pm_runtime_get()
> >  - use pm_runtime_put() instead of sync variant
> >  - remove gpio chip in driver remove()
> >  - remove redundant type casts
> >  - directly use IO helpers
> >  - use BIT macro to set/clear bits
> >  - migrate to GPIOLIB_IRQCHIP
> 
> This is a great improvement! Only small stuff remains.
> 
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/gpio.h>
> 
> This should be:
> #include <linux/gpio/driver.h>
> 
> If that doesn't work ... why?
Works just fine.

> 
> > +/**
> > + * struct zynq_gpio - gpio device private data structure
> > + * @chip:      instance of the gpio_chip
> > + * @base_addr: base address of the GPIO device
> > + * @irq:       irq associated with the controller
> > + * @clk:       clock resource for this controller
> > + */
> > +struct zynq_gpio {
> > +       struct gpio_chip chip;
> > +       void __iomem *base_addr;
> > +       int irq;
> 
> Why is irq kept around in this struct? It looks like it could just
> be a local variable in probe()?
You're right.

I think that were both part of the legacy in this driver.

	S?ren
