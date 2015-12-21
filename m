From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 21 Dec 2015 21:34:14 +0200
Subject: [PATCH v2 0/5] clk: lpc32xx: add clock support for NXP LPC32xx
In-Reply-To: <1449398757-16834-1-git-send-email-vz@mleia.com>
References: <1449398757-16834-1-git-send-email-vz@mleia.com>
Message-ID: <56785436.4000505@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Michael,

On 06.12.2015 12:45, Vladimir Zapolskiy wrote:
> This changeset adds common clock framework driver for NXP LPC32xx
> boards.
> 
> The change can be applied without any dependencies, LPC32xx device tree
> and mach changes will be done, when this changeset is accepted.
> 
> The v1 version of CCF driver can be found here:
>   http://www.spinics.net/lists/arm-kernel/msg461632.html
> 
> The RFC version of CCF driver 9/11 can be found here:
>   http://www.spinics.net/lists/devicetree/msg100583.html
> 
> Changes from v1 to v2:
> * removed dependency on the recent LPC32xx device tree changes,
>   also removed LPC32xx device tree and mach changes, which depend
>   on this series,
> * use lowercase hex numbers in a DT binding example,
> * incremented by 1 all clock values, possibly clock "0" may have a
>   special meaning in future,
> * removed explicit COMMON_CLK selection for NXP LPC18xx,
> * LPC32XX_CLK_DEFINE() does not stringify clock names,
> * fixed a minor bug in clk_pll_set_rate().
> 
> Changes from RFC to v1:
> * added definitions of a missed IRDA clock,
> * renamed compatible property from lpc32xx-scb to lpc32xx-clk
> * switched to regmap interface instead of mmio, this is required to
>   secure access to registers shared between pinmux, dma and clock
>   driver, unfortunately this change has to pull some code snippets
>   from common gate, divider and mux helpers rebased on regmap API,
> * split clock definitions from the driver to be able to update
>   dts files separately from CCF driver.
> 
> The driver is written from scratch, here are main functional
> differences with the legacy driver arch/arm/mach-lpc32xx/clock.c:
> * serialized access to SCB registers,
> * reworked routines to select PLL parameters,
> * now the clock driver has detailed description of all clocks,
>   the original driver misses several clock entries and most of fine
>   grained clock controls, here every mux and divider are accounted,
> * now clocks and clock hierarchies can be described in board DT file,
> * sophisticated management of USB clocks, for example now USB device
>   controller needs only one clock instead of USB PLL, USB OTG and USB
>   device clocks,
> * other benefits from a driver powered by CCF.
> 
> Patch 5/5 may produce false positives from checkpatch.pl, the fix
> to checkpatch is found in Andrew's tree
> 
> Vladimir Zapolskiy (5):
>   dt-bindings: clock: add description of LPC32xx clock controller
>   dt-bindings: clock: add description of LPC32xx USB clock controller
>   dt-bindings: clock: add NXP LPC32xx clock list for consumers
>   clk: lpc18xx: add NXP specific COMMON_CLK_NXP configuration symbol
>   clk: lpc32xx: add common clock framework driver
> 
>  .../devicetree/bindings/clock/nxp,lpc3220-clk.txt  |   30 +
>  .../bindings/clock/nxp,lpc3220-usb-clk.txt         |   22 +
>  drivers/clk/Kconfig                                |    6 +
>  drivers/clk/Makefile                               |    2 +-
>  drivers/clk/nxp/Makefile                           |    1 +
>  drivers/clk/nxp/clk-lpc32xx.c                      | 1569 ++++++++++++++++++++
>  include/dt-bindings/clock/lpc32xx-clock.h          |   56 +
>  7 files changed, 1685 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
>  create mode 100644 drivers/clk/nxp/clk-lpc32xx.c
>  create mode 100644 include/dt-bindings/clock/lpc32xx-clock.h
> 

this is a gentle ping, the first version of the driver was published
in October, the only functional change is switching from iomap to regmap
API to access the registers.

A couple of words about the change to mitigate your impression of
apparently imperfect code.

The NXP LPC32xx platform is unmaintained and broken for about one
and a half years, so I presume you won't get an ack from Roland, who
is an official maintainer. Adding a CCF driver will be a huge progress,
since it allows in +1 kernel release to fix the platform -- there is
a critical problem in legacy IRQ handling based on hardware IRQs,
irqchip driver change is ready as well, but CCF should go first,
because it allows to remove a legacy clocksource/clockevent driver
arch/arm/mach-lpc32xx/timer.c. That driver depends on legacy broken
irqchip (hardware IRQs are used, irqchip with virtual IRQs will break
the driver), it has a proper replacement drivers/clocksource/time-lpc32xx.c,
but to use the new driver common clock support is needed. The CCF
driver will let me remove tons of other legacy stuff as well, and this
should be a step towards inclusion of the platform to multiarch builds.

If you find impossible to include this CCF driver to v4.5, please add
the first 4 of 5 changes, dt bindings include file is needed to
update DTS files independently on CCF driver inclusion status.

Thank you in advance.

Merry Christmas, Happy Holidays!

--
With best wishes,
Vladimir
