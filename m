From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 12:43:03 +0100
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <CACRpkdbdDHyg4uz0tAMccB8yGxsoF4JaHocAxbV_bTJ832kbQw@mail.gmail.com>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
 <201401072052.30599.arnd@arndb.de>
 <CACRpkdbdDHyg4uz0tAMccB8yGxsoF4JaHocAxbV_bTJ832kbQw@mail.gmail.com>
Message-ID: <201401081243.04326.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014, Linus Walleij wrote:
> On Tue, Jan 7, 2014 at 8:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > What is actually the bigger worry here is that the contents
> > of the new file, while correctly moved out of mach/gpio.h also
> > don't belong into include/linux/platform_data, because they don't
> > define a pdata structure but rather the contents that are supposed
> > to be passed from the platform code. I would much prefer if you could
> > move the file back into mach-s3c24xx/ under a new name and keep it out of
> > platform_data.
> 
> Unfortunately it cannot live right under mach-s3c24xx because there
> are drivers here and there referring directly to the contents of this
> file.

I think they only reference a small portion of the total contents.
The idea was to make whatever is really needed by drivers visible in
a header and keep everything else in the mach directory.

> The only quick-fix option would be to move it back to
> <mach/gpio-samsung-s3c24xx.h>
> but the real solution is of course to augment all drivers to use
> gpio descriptors and add descriptor tables to the boardfiles.

Right. I would use <mach/gpio-samsung.h> though, so you don't
have to #ifdef it on the platform as you currently do in the
gpio driver.

> I'm a bit reluctant to do that as I'd prefer to be able to test
> such modifications on HW ... plus time may be better invested
> in DT migration (as I think is the conclusion of this thread
> eventually).

Doing the full DT migration would of course be best, but I would
suspect that to take quite a while still.

> > I suspect that the only thing actually needed by the
> > gpio driver is the number of GPIO lines per platform, and we can
> > find another way to communicate that.
> 
> A bit more: if you look in drivers/gpio/gpio-samsung.c you see
> bank base GPIO offset for each bank into the global scope
> *and* the number of GPIOs for each bank propagated from
> machine headers instead of using platform data.
> 
> Again the proper solution (if the boardfiles are kept) is to switch
> to using a GPIO descriptor table. Or using DT.

Ok.

> > Most of the contents should
> > be private to the mach-s3c code and not be visible to either the
> > gpio driver or any drivers using the plat/gpio-cfg.h interface.
> 
> Samsungs <plat/gpio-cfg.h> is basically a custom legacy pin
> control implementation.
> 
> The real solution to getting rid of that file is to switch over
> to using pinctrl-[samsung|s3c24xx] which as Heiko describes
> mandates also using DT, and thus blocks attempts
> at using this path for fixing the legacy boardfiles.
> 
> It's one of these situations where we end up with an
> all-or-nothing conversion path: either you change everything
> over to device tree or everything stays in two copies ...
> I'm trying to refactor the existing board files here maybe
> that is in vain :-/ as GPIO maintainer I want to get rid of
> <mach/gpio.h>.

Well, we can't do it all at once, and we have to start untangling
this somewhere. Getting rid of mach/gpio.h sounds as good to me
as any other part of the puzzle, as long as we don't do something
bad along the lines that comes back to bite us later.

> >> > Note that on Exynos, the solution for the gpio driver dependencies
> >> > was to scrap the driver and use pinctrl-exynos instead.
> >>
> >> I think the S3C driver is a different piece of hardware unfortunately.
> >
> > But exynos was using this driver before it moved to the new pinctrl
> > driver.
> 
> I was wrong about this, too much in my head. As Tomasz says,
> pinctrl-samsung can be used, but mandates that everything is
> moved over to device tree.
> 
> Probably the best thing now that I have one problem less is to
> leave it to the S3C maintainers to complete their DT migration?

Let me have another look first, maybe I can find an intermediate
step that helps you on your conquest to kill mach/gpio.h.

	Arnd
