From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Mar 2012 01:57:42 +0000
Subject: [PATCH 0/7 v4] ARM: kirkwood: fdt: convert kirkwood to fdt
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <cover.1331601448.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series begins the process of converting all of the drivers initialized
from kirkwood_init() to devicetree.

The first three patches are code cleanup from Andrew Lunn.

The rest of the series is the initial conversion to devicetree for kirkwood,
use by dreamplug, and devicetree bindings for drivers that don't use tclk or
pinux.  These should be safe to merge as they won't interfere with the
clk/clkdev work Andrew Lunn is working on.

Overall changes since v3:

	- squashed several fixup patches into the series (use mrvl, use
	  inclusive address sizes)
	- applied Arnd's suggestion for serial ports in kirkwood.dtsi, added my
	  idea of defining serial clock in dts.
	- moved dreamplug_init() out of board-dt.c (into board-dreamplug.c) to
	  facilitate the orderly arrival of new boards with fdt support (Jamie
	  Lentin's boards)
	- moved all non-fdt cleanups to the beginning of the series.
	- removed mv_cesa, mv_sata, and orion-ehci from this series as they
	  depend on intc/dma/clock to work properly
	- removed Ack's and Reviewed-By's on patches with significant changes
		- Grant's Ack remains on the "wdt: use resource" patch as it is
		  a reduced scope version (no fdt bindings), otherwise,
		  identical to code originally Acked.  Please let me know if
		  that's not appropriate.

Overall changes since v2:

	- added Andrew Lunn's cleanup patches
	- reshuffled to more logical order
	- wrapped all struct of_device_id[]'s in #ifdef CONFIG_OF
	- s/marvell,/mrvl,/g
	- added orion-ehci
	- added mv_sata
	- prevent clocks from gating when booting from devicetree

Drivers yet to be converted are:

	mv_cesa:    needs intc in fdt (next on list)
	mv_sata:    needs dma, intc
	orion-ehci: needs dma, intc
	orion-spi:  uses tclk
	orion-wdt:  uses tclk
	mvsdio:     uses tclk
	i2c:        uses freq_m/freq_n, not sure if that should use clk/clkdev
	mv_xor:     haven't figured out howto do shared resources/dma in fdt
	ge0/ge1:    haven't looked at it yet
	nand:       not needed for dreamplug, Jamie Lentin is working on it

Please be aware that this is a complete reshuffle of the whole series and is
based purely against v3.3-rc3.

Interested folks can pull from:

git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_for_3.4


Andrew Lunn (3):
  ARM: orion: spi: remove enable_clock_fix which is not used
  ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.
  ARM: orion: wdt: use resource vice direct access

Jason Cooper (4):
  ARM: kirkwood: add dreamplug (fdt) support.
  ARM: kirkwood: convert uart0 to devicetree.
  ARM: kirkwood: rtc-mv devicetree bindings
  ARM: kirkwood: use devicetree for rtc-mv

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   24 +++++
 arch/arm/boot/dts/kirkwood.dtsi          |   36 +++++++
 arch/arm/mach-kirkwood/Kconfig           |   14 +++
 arch/arm/mach-kirkwood/Makefile          |    2 +
 arch/arm/mach-kirkwood/Makefile.boot     |    2 +
 arch/arm/mach-kirkwood/board-dreamplug.c |  149 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c        |   75 +++++++++++++++
 arch/arm/mach-kirkwood/common.c          |   11 +-
 arch/arm/mach-kirkwood/common.h          |   11 ++
 arch/arm/plat-orion/common.c             |    7 +-
 arch/arm/plat-orion/include/plat/audio.h |    1 -
 drivers/rtc/rtc-mv.c                     |    9 ++
 drivers/spi/spi-orion.c                  |    5 -
 drivers/watchdog/orion_wdt.c             |   24 +++--
 include/linux/spi/orion_spi.h            |    1 -
 15 files changed, 348 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c
 create mode 100644 arch/arm/mach-kirkwood/board-dt.c

-- 
1.7.3.4
