From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 8 Nov 2013 14:56:01 +0100
Subject: [PATCH v6 4/8] ARM: dts: imx27 pinctrl
In-Reply-To: <CACRpkdazhujHpjVuOhee9UXfi=zV3Z7TjbxzQ_3H+gmFrgDmWA@mail.gmail.com>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-5-git-send-email-mpa@pengutronix.de>
 <CAHCPf3sz6eOYrnNDfOTo5Z5dZP2U9+GtQMKYZEb-1WfuXepa6A@mail.gmail.com>
 <CACRpkdazhujHpjVuOhee9UXfi=zV3Z7TjbxzQ_3H+gmFrgDmWA@mail.gmail.com>
Message-ID: <20131108135601.GA30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 10:45:01AM +0100, Linus Walleij wrote:
> On Wed, Nov 6, 2013 at 11:43 PM, Matt Sealey <neko@bakuhatsu.net> wrote:
> > On Mon, Oct 28, 2013 at 4:00 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> >>
> >> +                       iomuxc: iomuxc at 10015000 {
> >> +                               compatible = "fsl,imx27-iomuxc";
> >> +                               reg = <0x10015000 0x600>;
> >> +
> >> +                       };
> >> +
> >>                         gpio1: gpio at 10015000 {
> >>                                 compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> >>                                 reg = <0x10015000 0x100>;
> >
> > Linus,
> >
> > Case in point, you can't have two nodes which overlap registers.
> >
> > Probably the most reasonable way to effect this is to keep the GPIO
> > bindings, put pinctrl definitions in there (there's no reason pinctrl
> > and gpio drivers can't probe the same compatible property) and use
> > regmap internally on that single node.
> 
> If the I/O region is tightly coupled across two subsystems like
> that we usually merge the driver into one combined
> pinctrl+gpio driver and put it into drivers/pinctrl/*.

The gpio module does not necessarily include a pinctrl module. Most of
the imx SoCs have the same gpio function registers but without pinctrl.
They all use the same gpio driver.

> 
> This often solves more problems and make the code
> simpler too.
> 
> An alternative if address 0x10015000- 0x100150ff is
> really only used for GPIO is to map the pinctrl like
> that:
> 
> reg = <0x10015100 0x500>
> 
> and rewrite all the base offset handling in the driver.

There are 6 gpio modules in the memory region from 0x10015000 to
0x100155ff. pinctrl is in the same memory region.

I could change the bindings back to that from v1 [1]. One pinmux
controller over the full memory range (0x10015000 0x600) and the gpio
modules as subnodes using 0x100 each. This would preserve the currently
used references to the gpio nodes.

Regards,

Markus Pargmann


[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/257180/focus=257184


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
