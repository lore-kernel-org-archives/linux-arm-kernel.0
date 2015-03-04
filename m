From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Mar 2015 16:05:41 +0100
Subject: [PATCH v3 00/20] ARM: mvebu: Armada 39x basic support,
 and preparatory cleanups
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <54F71F45.3060503@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 03/03/2015 15:40, Thomas Petazzoni wrote:
> Hello,
> 
> This is the third version of the patch series adding Armada 39x basic
> support.
> 
> This set of patches add basic support for a new family of Marvell EBU
> processors: the Armada 39x. They are based on Cortex-A9 (like Armada
> 375 and 38x) and the most important new feature is probably the
> addition of 10 GbE support.
> 
> See http://www.marvell.com/embedded-processors/armada-39x/ for a basic
> introduction.
> 
> Note that this web page talks about an Armada 395 and Armada 398, but
> so far the technical documentation we have been given access to only
> describes Armada 390 and Armada 398, so this series supports only
> Armada 390 and Armada 398 so far. Support for Armada 395 might be
> added in the future, once we get access to the appropriate technical
> details.
> 
> Changes v2 -> v3:
> 
>  - Rebased on top of v4.0-rc1
> 
>  - Add support for the L2 cache
> 
>  - Added Acked-by from Gregory Clement on
> 
>    ARM: mvebu: add __initconst specifiers on DT_MACHINE_START dt_compat tables
>    ARM: mvebu: fix usb@ unit address on Armada 38x to match register address
>    ARM: mvebu: add missing UART alias on Armada 38x
>    devicetree: bindings: add DT binding for the Marvell Armada 39x SoC family
> 
>  - Renamed 'ARM: mvebu: add missing UART alias on Armada 38x' to 'ARM:
>    mvebu: add missing UART labels on Armada 38x'.
> 
>  - Added a patch 'ARM: mvebu: add UART labels to Armada 375'.
> 
>  - Change 'ARM: mvebu: add stdout-path to all armada-*.dts' to go
>    further and eliminate completely /chosen/bootargs. This removes the
>    non-desired 'earlyprintk' argument, and since console= was the only
>    remaining kernel parameter, using stdout-path makes more
>    sense. Requested by Rob Herring and Mark Rutland.
> 
>  - Dropped the patch "ARM: mvebu: use IRQ macros to define the SDHCI
>    interrupt on Armada 38x" from the series, since Gregory Clement
>    already submitted it as part of a different series.
> 
>  - Added patches 'ARM: mvebu: enable Armada 39x in mvebu_v7_defconfig'
>    and 'ARM: configs: enable Marvell Armada 39x in multi_v7_defconfig'
>    to update mvebu_v7_defconfig and multi_v7_defconfig so that they
>    enable Marvell Armada 39x by default. Suggested by Gregory Clement.
> 
>  - Fix the unit address of the MPIC interrupt controller, in both the
>    newly added Armada 39x support, as well as in the existing Armada
>    370, 375, 38x and XP support. Suggested by Gregory Clement.
> 
> Changes v1 -> v2:
> 
>  - At the SoC level, add the description of SPI controller 0 and 1,
>    NAND flash controller, SDHCI controller, Core Divider Clock (needed
>    by the NAND flash controller), the main PLL clock (needed by the
>    Core Divider Clock) and the XOR engines.
> 
>  - At the board level, add the description of the SPI flash connected
>    to SPI bus 1, which contains the bootloader, and the description of
>    the NAND flash.
> 
>  - Fix space vs. tab.
> 
>  - Use __initconst when defining the dt_compat table for Armada
>    39x. Suggested by Stephen Boyd.
> 
>  - Fix typo in commit log of "ARM: mvebu: add core support for Armada
>    39x", noticed by Maxime Ripard.
> 
>  - Remove earlyprintk from /chosen/bootargs. Suggested by Andrew Lunn.
> 
>  - Add aliases for uart[0-3]. Suggested by Andrew Lunn.
> 
>  - Add /chosen/stdout-path to Armada 398 DB DT. Suggested by Andrew
>    Lunn.
> 
>  - Move pinctrl configurations at the SoC level. Suggested by Andrew
>    Lunn.
> 
>  - Add several preparation/cleanup patches not related to Armada 39x
>    directly, but whose topics were found while working on Armada 39x
>    support:
> 
>      - Add __initconst to all dt_compat table in mach-mvebu.
>      - Fixup usb@ unit address on Armada 38x
>      - Add stdout-path to all armada-*.dts
>      - Use GIC and IRQ macros in SDHCI definition of Armada 38x
>      - Add missing UART alias on Armada 38x
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (20):
>   ARM: mvebu: add __initconst specifiers on DT_MACHINE_START dt_compat
>     tables
>   ARM: mvebu: fix usb@ unit address on Armada 38x to match register
>     address
>   ARM: mvebu: add missing UART labels on Armada 38x
>   ARM: mvebu: add UART labels to Armada 375
>   ARM: mvebu: remove aliases for Ethernet devices on Armada
>     370/375/38x/XP
>   ARM: mvebu: add serial port aliases on Armada 370/375/38x/XP
>   ARM: mvebu: use stdout-path in all armada-*.dts
>   ARM: mvebu: fix unit address of MPIC nodes
>   devicetree: bindings: add DT binding for the Marvell Armada 39x SoC
>     family
>   devicetree: bindings: update DT bindings for Marvell EBU clock support
>   devicetree: bindings: add Device Tree bindings for Armada 39x
>     pin-muxing controller
>   devicetree: bindings: add new SMP enable method for Marvell Armada 39x
>   clk: mvebu: extend common code to allow an optional refclk
>   clk: mvebu: add Marvell Armada 39x driver
>   pinctrl: mvebu: add pinctrl driver for Marvell Armada 39x
>   ARM: mvebu: add core support for Armada 39x
>   ARM: mvebu: add Device Tree files for Armada 39x SoC and board
>   Documentation: arm: update supported Marvell EBU processors
>   ARM: mvebu: enable Armada 39x in mvebu_v7_defconfig
>   ARM: configs: enable Marvell Armada 39x in multi_v7_defconfig

Patches 1 applied to mvebu/cleanup
Patches 2 to 8 and patch 17 applied to mvebu/dt
Patches 9,12,16 and 18 applied to mvebu/soc
Patch 19 applied to mvebu/defconfig

and

Patches 10,13 and 14 applied to mvebu/clk as requested by Mike.

I had to amend the patch "ARM: mvebu: fix unit address of MPIC nodes"
by removing the armada-38x related part which was already applied by the
patch "ARM: mvebu: Fix MPIC unit address".

Patch 20 should be directly taken by the arm-soc maintainer.


Thanks,

Gregory



> 
>  Documentation/arm/Marvell/README                   |   5 +
>  .../devicetree/bindings/arm/armada-39x.txt         |  20 +
>  Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   9 +
>  .../bindings/clock/mvebu-gated-clock.txt           |  15 +-
>  .../pinctrl/marvell,armada-39x-pinctrl.txt         |  78 ++++
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/armada-370-db.dts                |   2 +-
>  arch/arm/boot/dts/armada-370-mirabox.dts           |   2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   2 +-
>  arch/arm/boot/dts/armada-370-rd.dts                |   2 +-
>  arch/arm/boot/dts/armada-370-synology-ds213j.dts   |   3 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   6 +-
>  arch/arm/boot/dts/armada-370.dtsi                  |   2 +-
>  arch/arm/boot/dts/armada-375-db.dts                |   2 +-
>  arch/arm/boot/dts/armada-375.dtsi                  |  10 +-
>  arch/arm/boot/dts/armada-385-db-ap.dts             |   3 +-
>  arch/arm/boot/dts/armada-388-db.dts                |   4 +-
>  arch/arm/boot/dts/armada-388-gp.dts                |   5 +-
>  arch/arm/boot/dts/armada-388-rd.dts                |   2 +-
>  arch/arm/boot/dts/armada-38x.dtsi                  |  11 +-
>  .../dts/{armada-xp-matrix.dts => armada-390.dtsi}  |  71 +---
>  .../dts/{armada-388-db.dts => armada-398-db.dts}   | 111 ++---
>  .../dts/{armada-xp-matrix.dts => armada-398.dtsi}  |  70 +---
>  .../boot/dts/{armada-375.dtsi => armada-39x.dtsi}  | 446 ++++++++-------------
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts          |   2 +-
>  arch/arm/boot/dts/armada-xp-db.dts                 |   2 +-
>  arch/arm/boot/dts/armada-xp-gp.dts                 |   2 +-
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   3 +-
>  arch/arm/boot/dts/armada-xp-matrix.dts             |   2 +-
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   1 -
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   1 -
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   2 +-
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   2 +-
>  arch/arm/boot/dts/armada-xp-synology-ds414.dts     |   3 +-
>  arch/arm/boot/dts/armada-xp.dtsi                   |   5 +-
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm/configs/mvebu_v7_defconfig                |   1 +
>  arch/arm/mach-mvebu/Kconfig                        |  14 +
>  arch/arm/mach-mvebu/board-v7.c                     |  20 +-
>  arch/arm/mach-mvebu/dove.c                         |   2 +-
>  arch/arm/mach-mvebu/kirkwood.c                     |   2 +-
>  arch/arm/mach-mvebu/platsmp-a9.c                   |   2 +
>  drivers/clk/mvebu/Kconfig                          |   4 +
>  drivers/clk/mvebu/Makefile                         |   1 +
>  drivers/clk/mvebu/armada-39x.c                     | 156 +++++++
>  drivers/clk/mvebu/common.c                         |  17 +
>  drivers/clk/mvebu/common.h                         |   1 +
>  drivers/pinctrl/mvebu/Kconfig                      |   4 +
>  drivers/pinctrl/mvebu/Makefile                     |   1 +
>  drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 432 ++++++++++++++++++++
>  52 files changed, 1045 insertions(+), 524 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
>  copy arch/arm/boot/dts/{armada-xp-matrix.dts => armada-390.dtsi} (61%)
>  copy arch/arm/boot/dts/{armada-388-db.dts => armada-398-db.dts} (70%)
>  copy arch/arm/boot/dts/{armada-xp-matrix.dts => armada-398.dtsi} (61%)
>  copy arch/arm/boot/dts/{armada-375.dtsi => armada-39x.dtsi} (55%)
>  create mode 100644 drivers/clk/mvebu/armada-39x.c
>  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-39x.c
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
