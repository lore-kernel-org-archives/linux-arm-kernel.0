From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 08:30:22 +0000
Subject: [PATCH 13/14] ARM: ux500: enable AB8500 GPIO for HREF
In-Reply-To: <5112F284.3040002@wwwdotorg.org>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-14-git-send-email-linus.walleij@stericsson.com>
 <5112F284.3040002@wwwdotorg.org>
Message-ID: <201302070830.22719.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Stephen Warren wrote:
> On 02/05/2013 12:48 PM, Linus Walleij wrote:
> > From: Lee Jones <lee.jones@linaro.org>
> > 
> > The AB8500 GPIO driver has been un-BROKEN and rewritten as a pinctrl
> > driver. Now that it's back in use, let's ensure that it's available
> > when booting HREF with Device Tree enabled.
> 
> > diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
> 
> >       soc-u9500 {
> > +             prcmu at 80157000 {
> > +                     ab8500 at 5 {
> > +                             ab8500-gpio {
> > +                                     compatible = "stericsson,ab8500-gpio";
> 
> The MFDs I've looked at (which admittedly might not be that many) all
> have the top-level chip described in device tree, but not all the
> component sub-devices, since they're all a static part of the top-level
> chip. Instead, the top-level MFD instantiates all the sub-devices
> itself. I'm curious why this MFD device works differently - do many work
> like this?

I think in general, describing only the top level in DT is preferred.
However, that does not work if you have devices outside of the MFD
refer to devices inside of it, such as GPIO, clocks or interrupts:

In order to connect a button or an LED to this GPIO controller
in DT, you need to have a node you can refer to that follows the
GPIO binding. Putting all of that into the top-level device
would get messy here.

	Arnd
