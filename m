From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 20:53:52 +0000
Subject: [PATCH V3 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <cover.1358983578.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
Message-ID: <cover.1359146831.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This is a third cut at cleaning up mach-kirkwood/.  There are a few DT
conversions (topkick -> mvsdio, pinctrl) which, once reviewed, I'll put in the
normal pull request cycle.

The others which remove board-*.c files, I'll keep updating against
mvebu/for-next, and then apply at the end of the merge window.

Please test as you are able.

Changes since V1:
 - Included Ian Molton's patch to add DT bindings to mv643xx_eth
 - little doc cleanup
 - tested on dreamplug
   - good: boots fine to bash prompt
   - bad: hangs within one minute of booting (even with init=/bin/sh)
     - no output, just frozen hard
     - will debug more tomorrow

Changes since V2:
 - discovered source of hang.  ge0/1 clocks getting gated
   - changed alias for clocks
   - able to pull ip address and ping though the interface

thx,

Jason.

Ian Molton (1):
  mv643xx.c: Add basic device tree support.

Jason Cooper (7):
  ARM: kirkwood: topkick: init mvsdio via DT
  ARM: kirkwood: topkick: convert to pinctrl
  ARM: kirkwood: nsa310: cleanup includes and unneeded code
  ARM: kirkwood: nsa310: convert to pinctrl
  ARM: kirkwood: consolidate DT init of pcie
  ARM: mvebu: correct gated clock documentation
  ARM: kirkwood: mv643xx_eth dt conversion

 .../bindings/clock/mvebu-gated-clock.txt           |   2 +-
 Documentation/devicetree/bindings/net/mv643xx.txt  |  75 +++++++++++++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   9 ++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   8 ++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  16 ++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   7 ++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   9 ++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   9 ++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  18 ++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  18 ++++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   9 ++
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |   5 +
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |   5 +
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  99 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   8 ++
 arch/arm/boot/dts/kirkwood-topkick.dts             | 103 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |  38 ++++++++
 arch/arm/mach-kirkwood/Kconfig                     | 101 --------------------
 arch/arm/mach-kirkwood/Makefile                    |  15 ---
 arch/arm/mach-kirkwood/board-dnskw.c               |   7 --
 arch/arm/mach-kirkwood/board-dockstar.c            |  32 -------
 arch/arm/mach-kirkwood/board-dreamplug.c           |  35 -------
 arch/arm/mach-kirkwood/board-dt.c                  |  64 +++++--------
 arch/arm/mach-kirkwood/board-goflexnet.c           |  34 -------
 arch/arm/mach-kirkwood/board-ib62x0.c              |  29 ------
 arch/arm/mach-kirkwood/board-iconnect.c            |  32 -------
 arch/arm/mach-kirkwood/board-lsxl.c                |  36 -------
 arch/arm/mach-kirkwood/board-mplcec4.c             |  36 -------
 arch/arm/mach-kirkwood/board-ns2.c                 |  34 -------
 arch/arm/mach-kirkwood/board-nsa310.c              |  58 ------------
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  26 ------
 arch/arm/mach-kirkwood/board-ts219.c               |  13 ---
 arch/arm/mach-kirkwood/board-usi_topkick.c         |  77 ---------------
 arch/arm/mach-kirkwood/common.h                    |  69 --------------
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  93 +++++++++++++++++--
 35 files changed, 548 insertions(+), 681 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mv643xx.txt
 delete mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 delete mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c
 delete mode 100644 arch/arm/mach-kirkwood/board-goflexnet.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c
 delete mode 100644 arch/arm/mach-kirkwood/board-iconnect.c
 delete mode 100644 arch/arm/mach-kirkwood/board-lsxl.c
 delete mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ns2.c
 delete mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
 delete mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
 delete mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c

-- 
1.8.1.1
