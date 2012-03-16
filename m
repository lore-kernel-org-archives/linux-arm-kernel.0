From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:20 +0000
Subject: [PATCH 0/9 v5] ARM: kirkwood: fdt: convert kirkwood to fdt
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <cover.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series continues the process of converting all of the drivers initialized
from kirkwood_init() to devicetree.

The first three patches are code cleanup from Andrew Lunn and myself.

The next three patches are cleanup and prep to facilitate adding new boards
during the transition to devicetree.

The next patch moves the uarts into the bus for all kirkwood boards and leaves
enabling them and specifying clock-frequency up to the board file.

The rest of the series is the initial conversion of rtc-mv to devicetree since
it  doesn't use tclk or pinmux.  These should be safe to merge as they won't
interfere with the clk/clkdev work Andrew Lunn is working on.

Overall changes since v4:

	- rebased off of arm-soc/next/boards
	- protected dreamplug_init() in common.h
	- corrected authorship of orion-wdt resource patch to me.

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
based purely against arm-soc/next/boards.

Interested folks can pull from:

git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_for_3.4_v3

Andrew Lunn (2):
  ARM: orion: spi: remove enable_clock_fix which is not used
  ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.

Jason Cooper (7):
  ARM: orion: wdt: use resource vice direct access
  ARM: kirkwood: fdt: use mrvl ticker symbol
  ARM: kirkwood: fdt: absorb kirkwood_init()
  ARM: kirkwood: fdt: facilitate new boards during fdt migration
  ARM: kirkwood: fdt: define uart[01] as disabled, enable uart0
  ARM: kirkwood: rtc-mv devicetree bindings
  ARM: kirkwood: use devicetree for rtc-mv

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   13 +--
 arch/arm/boot/dts/kirkwood.dtsi          |   34 ++++++-
 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/board-dreamplug.c |  152 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c        |  151 +++++-------------------------
 arch/arm/mach-kirkwood/common.c          |   11 +-
 arch/arm/mach-kirkwood/common.h          |   15 +++
 arch/arm/plat-orion/common.c             |    7 +-
 arch/arm/plat-orion/include/plat/audio.h |    1 -
 drivers/rtc/rtc-mv.c                     |    9 ++
 drivers/spi/spi-orion.c                  |    5 -
 drivers/watchdog/orion_wdt.c             |   24 +++--
 include/linux/spi/orion_spi.h            |    1 -
 13 files changed, 264 insertions(+), 160 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c

-- 
1.7.3.4
