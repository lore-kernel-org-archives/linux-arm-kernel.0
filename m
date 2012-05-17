From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 May 2012 15:49:43 -0600
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <4F90D19B.9020408@gmail.com>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <201204181622.34692.arnd@arndb.de>
 <CACRpkdaTFatBK4GyzCzm=U6+h8Knnf6xY9X6Uc26sLxQb2OhtA@mail.gmail.com>
 <201204191623.07445.arnd@arndb.de> <4F90D19B.9020408@gmail.com>
Message-ID: <20120517214943.A350F3E0621@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Apr 2012 22:01:47 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 04/19/2012 11:23 AM, Arnd Bergmann wrote:
> > On Wednesday 18 April 2012, Linus Walleij wrote:
> >>
> >> On Wed, Apr 18, 2012 at 6:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >>> The problem is that we cannot put the interrupt resources into the platform
> >>> device until the irq domain has been added. Right now, we set the gic
> >>> interrupt domain from init_IRQ(), then add the load the gpio
> >>> driver from core_initcall(nmk_gpio_init) and add the platform devices
> >>> from arch_initcall(customize_machine).
> >>>
> >>> This feels fragile because it depends on the gpio device getting probed
> >>> before any device using the gpio interrupts. It does seem to work fine
> >>> right now, but I'm not convinced that this is just coincidence.
> >>
> >> Aha OK. Why not put in that big comment then, thus nobody will
> >> ever miss the point like I did :-)
> >>
> > 
> > I think I've just come up with a solution to this problem and would
> > like to hear what Rob and Grant think about this:
> > 
> > If we move the code that adds the resources to a platform_device
> > from of_device_alloc() to  platform_drv_probe(), we can defer
> > looking up the interrupt number until the driver actually gets
> > probed and bail out early with -EPROBE_DEFER if the irq domain
> > is not available yet. That will even work when we have a builtin
> > driver for a device that uses a GPIO interrupt and the gpio controller
> > driver is a loadable module.
> > 
> 
> That certainly seems like a plausible solution and I don't have any
> thing better to suggest. Does that affect non-DT platform devices in a
> negative way?

I've been thinking about doing something like this for a while.  If
drivers are encouraged to use something like platform_get_irq(), or
maybe a more generic interface for more than just platform devices,
then there can be hooks in there to resolve irqs at probe time instead
of device creation time.  So I certainly support that approach.

g.
