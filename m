From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 08:31:29 -0600
Subject: [PATCH] pinctrl: at91: fix deferred probing support
In-Reply-To: <CACRpkdaSdFZOi+swmuFa8JdSTuVeE8j0W+2b+W3rfMD+ve999Q@mail.gmail.com>
References: <20180712192222.32481-1-robh@kernel.org>
 <20180713094717.GQ16084@piout.net>
 <CAL_Jsq+aT3kSLwcm+g0MHV6Gy+4mde17fUDa9HwiexQ1dHn5Bg@mail.gmail.com>
 <CACRpkdaSdFZOi+swmuFa8JdSTuVeE8j0W+2b+W3rfMD+ve999Q@mail.gmail.com>
Message-ID: <CAL_JsqKzsgJ9Cqs=_seB41wLKNXe=6bvzjG1XFdZ6vTsKr=XQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 7:58 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jul 13, 2018 at 5:27 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jul 13, 2018 at 3:47 AM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On 12/07/2018 13:22:22-0600, Rob Herring wrote:
> > > > AT91 pinctrl deferred probing support is broken if the GPIO devices
> > > > haven't probed first and set gpio_banks to non-zero. The later condition
> > > > that only some GPIO devices haven't probed can't actually happen as
> > > > either all the GPIO devices have probed first or none of them have. Plus
> > > > the pinctrl driver has already returned -EINVAL, so it's not on the
> > > > deferred list to retry probing.
> > > >
> > > > Fix this by consolidating the checking that all GPIO devices are probed.
> > > >
> > > > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > Cc: linux-gpio at vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > This is a result of trying to remove of_platform_default_populate from
> > > > at91 code and relying on the DT core handling populating devices. That
> > > > changed the probe order and broke booting.
> > > >
> > >
> > > This solves part of the issue but when tested with the
> > > of_platform_default_populate removal, many drivers will fail with
> > > gpiod_set_value: invalid GPIO (errorpointer)
> > >
> > > or
> > >
> > > gpiod_get_value: invalid GPIO (errorpointer)
> > >
> > > This happens both before and after the pinctrl driver probed.
> > >
> > > I didn't investigate much yet.
> >
> > Looks to me like it may be a circular dependency. The GPIO request
> > functions depend on the pinctrl driver which depends on the gpio
> > driver. Maybe returning EPROBE_DEFER in at91_gpio_request_enable and
> > removing the requirement that the GPIO driver probe first would fix
> > it...
>
> I think you're spot in.
>
> This kind of problem has cropped up in these subsystems since day
> one and we probably just have different lame attempts to paper
> over it all over.
>
> I suspect that what we need to do is more akin to the DRM model
> which I recently learned about (drivers/gpu/drm/vc4/vc4_drv.c is a very
> clean and good example) using the core kernel component
> infrastructure:
>
> 1. Drivers probe() independently, doing intiialization of state
>   container struct and retreiveing resources like I/O memory,
>   regulators, IRQ, DMA... but no registering interfaces to
>   the subsystems yet.
>
> 2. The probe of the main component (master) matches the
>   subcomponents on the platform bus. In this case, whatever
>   needs to come first is the master. I guess pin control.
>   return component_master_add_with_match(dev, &vc4_drm_ops, match);
>
> 3. Subcomponents:
>    return component_add(&pdev->dev, &vc4_dsi_ops);
>
> 4. Later on we take control over the binding order.
>    the .bind callback of the main component issues
>    component_bind_all(dev, drm) and there the subdevices
>    are bound.
>
> The process is perfectly reversible. The idea here is to break the
> neck of the problem by doing enough set-up in probe() so that
> bind() can commence with all its resources. My Nomadik driver
> already makes a half-assed attempt at this (not using the component
> framework) but I could refactor it to provide an example if
> there is interest.

I'm not really a fan of the component f/w. It feels bolted on and
should be more integrated into the driver model IMHO (though I've not
given any thought to what that would look like).

The problem in this case could be easily avoided by removing
"simple-bus" from the pinctrl node (having a driver for a node should
be a clue that "simple-bus" is not appropriate). Then the pinctrl
driver can properly sequence things by calling of_platform_populate to
instantiate the GPIO devices first and then registering with pinctrl
subsys. However, we can't just remove "simple-bus" to fix this without
having a compatibility problem.

Rob
