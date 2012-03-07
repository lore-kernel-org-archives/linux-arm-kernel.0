From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:41 +0000
Subject: [PATCH 0/14 v3] ARM: kirkwood: fdt: convert kirkwood to fdt
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <cover.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series begins the process of converting all of the drivers initialized
from kirkwood_init() to devicetree.

The first two patches are code cleanup from Andrew Lunn.

The rest of the series are devicetree bindings for drivers that don't use tclk.
These should be safe to merge as they won't interfere with the clk/clkdev work
Andrew Lunn is working on.

Several of these are patches created by Michael Walle several months ago and he
has agreed to let me usher them in.  I've changed them in minor ways to conform
with advice I've been given over the past several weeks.

Overall changes since v2:

	- added Andrew Lunn's cleanup patches
	- reshuffled to more logical order
	- wrapped all struct of_device_id[]'s in #ifdef CONFIG_OF
	- s/marvell,/mrvl,/g
	- added orion-ehci
	- added mv_sata
	- prevent clocks from gating when booting from devicetree

Drivers yet to be converted are:

	orion-spi: uses tclk
	orion-wdt: uses tclk
	mvsdio:    uses tclk
	i2c:       uses freq_m/freq_n, not sure if that should use clk/clkdev
	mv_xor:    haven't figured out howto do shared resources/dma in fdt
	ge0/ge1:   haven't looked at it yet
	nand:      not needed for dreamplug, haven't looked yet

Please be aware that this is a complete reshuffle of the whole series and is
based purely against v3.3-rc3.

Interested folks can pull from:

git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt


Andrew Lunn (2):
  ARM: orion: spi: remove enable_clock_fix which is not used
  ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.

Jason Cooper (9):
  ARM: kirkwood: add dreamplug (fdt) support.
  ARM: kirkwood: fdt: absorb kirkwood_init()
  ARM: kirkwood: add interrupt controller to devicetree.
  ARM: kirkwood: convert uart0 to devicetree.
  ARM: kirkwood: rtc-mv devicetree bindings
  ARM: kirkwood: use devicetree for rtc-mv
  ARM: kirkwood: mv_cesa devicetree support.
  ARM: kirkwood: use devicetree for orion-ehci
  ARM: kirkwood: use devicetree to init sata_mv

Michael Walle (3):
  ARM: kirkwood: mv_cesa devicetree bindings
  ARM: kirkwood: ehci-orion: add device tree binding
  ARM: kirkwood: sata_mv: add device tree binding

 .../devicetree/bindings/crypto/mv_cesa.txt         |   18 ++
 .../devicetree/bindings/usb/ehci-orion.txt         |    5 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   39 ++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   26 +++
 arch/arm/mach-kirkwood/Kconfig                     |   14 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/Makefile.boot               |    2 +
 arch/arm/mach-kirkwood/board-dt.c                  |  206 ++++++++++++++++++++
 arch/arm/mach-kirkwood/common.c                    |   41 ++++-
 arch/arm/mach-kirkwood/common.h                    |    6 +
 arch/arm/plat-orion/include/plat/audio.h           |    1 -
 drivers/ata/sata_mv.c                              |   18 ++-
 drivers/crypto/mv_cesa.c                           |   13 ++
 drivers/rtc/rtc-mv.c                               |    9 +
 drivers/spi/spi-orion.c                            |    5 -
 drivers/usb/host/ehci-orion.c                      |   50 +++++-
 include/linux/spi/orion_spi.h                      |    1 -
 17 files changed, 437 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-dt.c

-- 
1.7.3.4
