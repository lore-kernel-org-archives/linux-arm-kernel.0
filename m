From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 20:47:06 +0200
Subject: [PATCH] ARM: imx: clk-vf610: introduce clks_init_on
In-Reply-To: <2a672a5d28af5425e1c406b0607befd5@agner.ch>
References: <1406643628-4061-1-git-send-email-stefan@agner.ch>
 <2815679.ZycfkLhBgI@wuerfel> <2a672a5d28af5425e1c406b0607befd5@agner.ch>
Message-ID: <4686885.gCEsaTZ3ps@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 20:39:20 Stefan Agner wrote:
> Am 2014-07-29 16:44, schrieb Arnd Bergmann:
> > On Tuesday 29 July 2014 16:20:28 Stefan Agner wrote:
> >> At the end of the boot process, the clock framework might disable
> >> required main PLL's. So far, this was no issue since drivers
> >> requested clocks, which are descended of the main PLL's (e.g.
> >> pll1_pfd1, which provides the system clock).
> >>
> >> To archive the full 500MHz system clock, DDR clock need to be a
> >> descendant of PLL2 rather than PLL1 (DDRC_CLK_SEL set to 0). The
> >> bootloader sets up the clocks accordingly before making use of
> >> DDR at all. However, in Linux, there is no driver using PLL2,
> >> which lead to PLL2 being disabled by the clock framework.
> >>
> >> With this patch, we make sure that the main system clock and the
> >> DDR clock are initially enabled and are kept enabled.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>
> > 
> > Wouldn't it be better to list this in the DT as a default for
> > the respective clocks?
> > 
> 
> What do you mean by that exactly? Creating a driver for the main PLL's
> and add device tree entries to instantiate them, along with a property
> like "boot-enabled" or similar?

I was under the assumption that you already have a driver for the main PLL,
I think most other SoCs have that.

We talked about the general problem at some point during a conference
and the conclusion was that it makes most sense to have defaults encoded
as properties in the device node of the clock controller. If you don't
have a device node for that, it won't work.

> The approach chosen in this patch is aligned the way it's done for i.MX6
> (see arch/arm/mach-imx/clk-imx6q.c). The whole clock module(s) in Vybrid
> are slightly striped variants found in i.MX6. For now, I would prefer to
> leave it that way. 

Ok, makes sense. Just leave it like this then. I believe i.MX is a bit
different from other SoCs, because it adopted some concepts like common
clk earlier than the rest, but consistency within the family is more
important than consistency across SoC families.

	Arnd
