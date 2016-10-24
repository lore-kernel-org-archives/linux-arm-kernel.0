From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:17 +0200
Subject: [PATCH/RFT v2 00/17] Add DT support for ohci-da8xx
Message-ID: <20161024164634.4330-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The purpose of this patch series is to add DT support and modernize
the ohci-da8xx glue driver without breaking the non-DT boot,
which is still used in unconverted davinci devices.

The first couple of patches, are the recent and ongoing efforts from
David Lechner to clean up davinci-mach code and the ochi-da8xx driver,
Im including these patches on this series for completeness sake.

Then I re-based an old patch by Manjunath Goudar[4] to be able to build
the driver as a module. We can now add this patch because we removed
references to sysconf registers by using David's patches.

Then I prepare the stage for a DT boot which does not depend on any
mach-arch/* callbacks by using a regulator to handle the vbus and
over current gpios. For this, i extended the fixed regulator driver to
register for an irq and send a regulator notification if an over curent
pin is specified.

The only dependency left for this series is the recently re-posted patch
by David to remove references to mach-code[1], which is approved and
should be picked up soon.

Note 1: Testing was done on a omap138-lcdk board, using DT, and non-DT boot,
and checking that in both cases the hub, usb mass storage and an input
device are correctly enumerated and working. The omap138-lcdk does not
have gpios to control vbus and get over current interrupt notifications.
If anyone has a da830-evm based board and could confirm that ohci is
correctly working, i would appreciate it.
(the OHCI option needs to be enabled in menuconfig)

Note 2: It seems that the davinci-gpio driver is broken for DT based boot
and any gpio > 32. (luckly none of the DT based boards use gpios yet)
The issue is discussed here [2]

Note 3: A git branch based on tag: next-20161021 with the dependencies
is available in my github here [3].

[1] usb: ohci-da8xx: Remove code that references mach
http://marc.info/?l=linux-kernel&m=147632744323084&w=4

[2] thread about invalid gpio in davinci
http://www.gossamer-threads.com/lists/linux/kernel/2550178

[3] Git branch:
https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt-v2.1

[4] Separate ohci-da8xx driver patch
https://patches.linaro.org/patch/18234/

Changes from v1->v2
* Rebased and added patch to make ohci a separate driver
* Use a regulator instead of handling Gpios (David Lechner)
* Add an overcurrent mode to regulator framework
* Fixed regulator is able to register for and overcurrent irq
* Added patch by Alexandre to remove build warnings
* Moved global variables into private hcd structure.

Alexandre Bailon (1):
  ARM: davinci: da8xx: Fix some redefined symbol warnings

Axel Haslam (10):
  ARM: davinci: da8xx: Enable the usb20 "per" clk on phy_clk_enable
  ARM: davinci: hawk: add full constraints for ohci plat boot
  regulator: fixed: Add over current event
  USB: da8xx: use flag instead of bitmask for over current change
  USB: ochi-da8xx: Use a regulator for vbus/overcurrent
  USB: da8xx: use ohci priv data instead of globals
  ARM: davinci: register the usb20_phy clock on the DT file
  usb: host: ohci-da8xx: Add devicetree bindings documentation
  USB: ohci-da8xx: Allow probing from DT
  ARM: dts: da850: add usb device node

David Lechner (5):
  ARM: davinci: da8xx: add usb phy clocks
  ARM: davinci: da8xx: Add CFGCHIP syscon platform declaration.
  ARM: davinci: da8xx: Add USB PHY platform declaration
  ARM: DTS: da850: Add cfgchip syscon node
  ARM: DTS: da850: Add usb phy node

Manjunath Goudar (1):
  USB: OHCI: make ohci-da8xx a separate driver

 .../bindings/regulator/fixed-regulator.txt         |   4 +
 .../devicetree/bindings/usb/ohci-da8xx.txt         |  39 +++
 arch/arm/boot/dts/da850-lcdk.dts                   |   8 +
 arch/arm/boot/dts/da850.dtsi                       |  17 +
 arch/arm/mach-davinci/board-da830-evm.c            | 152 +++-----
 arch/arm/mach-davinci/board-da850-evm.c            |   4 +
 arch/arm/mach-davinci/board-mityomapl138.c         |   4 +
 arch/arm/mach-davinci/board-omapl138-hawk.c        | 122 ++-----
 arch/arm/mach-davinci/da8xx-dt.c                   |   2 +
 arch/arm/mach-davinci/devices-da8xx.c              |  28 ++
 arch/arm/mach-davinci/include/mach/da8xx.h         |   8 +-
 arch/arm/mach-davinci/usb-da8xx.c                  | 244 ++++++++++++-
 drivers/regulator/fixed.c                          |  64 ++++
 drivers/usb/host/Kconfig                           |   2 +-
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ohci-da8xx.c                      | 382 +++++++++++----------
 drivers/usb/host/ohci-hcd.c                        |  18 -
 include/linux/platform_data/usb-davinci.h          |  43 ---
 include/linux/regulator/consumer.h                 |   5 +
 include/linux/regulator/fixed.h                    |   3 +
 20 files changed, 703 insertions(+), 447 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

-- 
1.9.1
