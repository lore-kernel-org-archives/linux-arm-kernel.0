From: jason@lakedaemon.net (Jason)
Date: Tue, 6 Mar 2012 10:58:40 -0500
Subject: [RFC 00/14] Generic clk for Orion platforms.
In-Reply-To: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
References: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120306155840.GS5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 07:30:56AM +0100, Andrew Lunn wrote:
> This patch set starts the process of changing Orion based platforms to
> use the generic clk framework. The first patch fixes compile problems
> with the framework, and is expected to be dropped once fixed upstream.
> Then clks are added. This is a fixed rate clk for tclk and for
> kirkwood, most of the gated clocks also get a clk. The following
> patches then modified the drivers to make use of these clocks,
> getting, prepareing, enabling at probe time, and disableing,
> unprepareing, and putting at remove time. Rather than pass the clock
> frequency as platform_data, the driver now uses clk_get_rate(). This
> results in some platform_data structures becoming redundant, and so
> are removed.

Awesome, thanks for posting!

> TODO:
> 
>  0) Cleanup the white space changes, and hunks in the wrong patches.

It would be helpful to break out code cleanup as well.  eg spi_clock_fix
removal, sound platform data removal, and anything else I didn't see on
initial read through.

>  1) PCIe needs adopting to use clks.
>  2) Strip out all references to kirkwood_clk_ctrl
>  3) Find a solution for turning off unused clks - Probably needs
>     framework support, which Mike has already suggested.

I'm assuming the driver(s) will increment a reference, so when it
reaches zero, the framework would call a clk_gate hook.

>  4) Find a solution for tuning off unused SATA and PCIe PHYs. Maybe
>     use the unprepare() method, but the current basic clk providers 
>     don't support this.

It looks like each SATA and PCIe PHY has it's own clock and it's own
shutdown (kirkwood_clock_gate()).  If the return value of unprepare
indicated a clock was gated (all references gone), then the driver could
shut down the PHY.  Or, am I missing something?

> If we are willing to accept a regression in power usage, we could skip
> 3) and 4) for the moment in order to get this code into use. That
> would help the device tree work which benefits from not having to deal
> with clock frequencies when setting up device driver bindings.
> 
> Boot tested on kirkwood. No testing what so ever on other Orion
> platforms.
> 
> Based on 
> 
> git://git.linaro.org/people/mturquette/linux.git v3.3-rc5-clkv5
> 
> 
> Andrew Lunn (14):
>   [clk] Fix compile errors in DEFINE_CLK_GATE()
>   ARM: Orion: Add clocks using the generic clk infrastructure.
>   Arm: Orion: spi: Add clk/clkdev support.
>   orion: spi: remove enable_clock_fix which is not used
>   Arm: Orion: eth: Add clk/clkdev support.
>   ARM: Orion: wdt: Add clk/clkdev support
>   ARM: Orion: uart: Get the clock rate via clk_get_rate().
>   ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.
>   MV SATA: Add per channel clk/clkdev support.
>   [Orion ehci] Add support for enabling clocks
>   [Orion nand] Add support for clk, if there is one.
>   [Orion sdio] Add support for clk.
>   [Orion crypto] Add support for clk
>   [Orion xor] Add support for clk
> 
>  arch/arm/Kconfig                                  |    3 +
>  arch/arm/mach-dove/common.c                       |   37 ++++---
>  arch/arm/mach-dove/dove-db-setup.c                |    1 -
>  arch/arm/mach-kirkwood/common.c                   |  119 +++++++++++++++++----
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |   16 +++
>  arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    1 -
>  arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    1 -
>  arch/arm/mach-kirkwood/t5325-setup.c              |    1 -
>  arch/arm/mach-kirkwood/tsx1x-common.c             |    1 -
>  arch/arm/mach-mv78xx0/common.c                    |   44 +++++---
>  arch/arm/mach-orion5x/common.c                    |   26 ++++-
>  arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c      |    1 -
>  arch/arm/plat-orion/common.c                      |   88 ++++++++-------
>  arch/arm/plat-orion/include/plat/audio.h          |    1 -
>  arch/arm/plat-orion/include/plat/common.h         |   26 +++--
>  arch/arm/plat-orion/include/plat/orion_wdt.h      |   18 ---
>  drivers/ata/sata_mv.c                             |   43 +++++++-
>  drivers/clk/clk.c                                 |    1 +
>  drivers/crypto/mv_cesa.c                          |   15 +++
>  drivers/dma/mv_xor.c                              |   16 +++
>  drivers/dma/mv_xor.h                              |    1 +
>  drivers/mmc/host/mvsdio.c                         |   14 +++
>  drivers/mtd/nand/orion_nand.c                     |   18 +++
>  drivers/net/ethernet/marvell/mv643xx_eth.c        |   46 ++++++--
>  drivers/spi/spi-orion.c                           |   37 +++++--
>  drivers/usb/host/ehci-orion.c                     |   16 +++
>  drivers/watchdog/orion_wdt.c                      |   18 ++-
>  include/linux/clk-private.h                       |    4 +-
>  include/linux/mv643xx_eth.h                       |    1 -
>  include/linux/spi/orion_spi.h                     |   18 ---
>  30 files changed, 443 insertions(+), 189 deletions(-)
>  delete mode 100644 arch/arm/plat-orion/include/plat/orion_wdt.h
>  delete mode 100644 include/linux/spi/orion_spi.h
> 
> -- 
> 1.7.9.1
> 
