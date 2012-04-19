From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 16:23:06 +0000
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <CACRpkdaTFatBK4GyzCzm=U6+h8Knnf6xY9X6Uc26sLxQb2OhtA@mail.gmail.com>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <201204181622.34692.arnd@arndb.de>
 <CACRpkdaTFatBK4GyzCzm=U6+h8Knnf6xY9X6Uc26sLxQb2OhtA@mail.gmail.com>
Message-ID: <201204191623.07445.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Linus Walleij wrote:
> 
> On Wed, Apr 18, 2012 at 6:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The problem is that we cannot put the interrupt resources into the platform
> > device until the irq domain has been added. Right now, we set the gic
> > interrupt domain from init_IRQ(), then add the load the gpio
> > driver from core_initcall(nmk_gpio_init) and add the platform devices
> > from arch_initcall(customize_machine).
> >
> > This feels fragile because it depends on the gpio device getting probed
> > before any device using the gpio interrupts. It does seem to work fine
> > right now, but I'm not convinced that this is just coincidence.
> 
> Aha OK. Why not put in that big comment then, thus nobody will
> ever miss the point like I did :-)
> 

I think I've just come up with a solution to this problem and would
like to hear what Rob and Grant think about this:

If we move the code that adds the resources to a platform_device
from of_device_alloc() to  platform_drv_probe(), we can defer
looking up the interrupt number until the driver actually gets
probed and bail out early with -EPROBE_DEFER if the irq domain
is not available yet. That will even work when we have a builtin
driver for a device that uses a GPIO interrupt and the gpio controller
driver is a loadable module.

	Arnd
