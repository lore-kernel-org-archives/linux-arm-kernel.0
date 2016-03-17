From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:33 -0500
Subject: [PATCH v2 00/11] da8xx USB clocks
Message-ID: <1458181615-27782-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, ready for round two.

I've added a new callback in the davinci clocks so that they can properly
handle clock muxing. The clock functions are pretty much the same as in the
previous patch set other than clk_set_parent() now works.

The next new thing is a phy driver for the CFGCHIP2 register that controls the
SoC USB PHY (both USB 1.1 and USB 2.0). The ohci and musb drivers have been
updated to use this new phy driver.

David Lechner (10):
  ARM: davinci: add set_parent callback for mux clocks
  ARM: davinci: da850: use clk->set_parent for async3
  ARM: davinci: da8xx: add usb phy clocks
  dt-bindings: Add bindings for phy-da8xx-usb
  phy: da8xx-usb: new driver for DA8XX SoC USB PHY
  ARM: davinci: da8xx: Add USB PHY platform declaration
  ARM: dt: da850: Add usb phy node
  usb: ohci-da8xx: Remove code that references mach
  usb: musb: da8xx: Use devm in probe
  usb: musb: da8xx: Remove mach code

Petr Kulhavy (1):
  ARM: davinci: defined missing CFGCHIP2_REFFREQ_* macros for MUSB PHY

 .../devicetree/bindings/phy/phy-da8xx-usb.txt      |  34 +++
 arch/arm/boot/dts/da850.dtsi                       |   6 +
 arch/arm/mach-davinci/board-da830-evm.c            |  12 -
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   7 -
 arch/arm/mach-davinci/clock.c                      |  17 +-
 arch/arm/mach-davinci/clock.h                      |   1 +
 arch/arm/mach-davinci/da830.c                      | 143 ++++++++++
 arch/arm/mach-davinci/da850.c                      | 231 ++++++++++++----
 arch/arm/mach-davinci/include/mach/da8xx.h         |   1 +
 arch/arm/mach-davinci/usb.c                        |  24 +-
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-da8xx-usb.c                        | 295 +++++++++++++++++++++
 drivers/usb/host/ohci-da8xx.c                      |  90 +++----
 drivers/usb/musb/da8xx.c                           | 150 +++--------
 include/linux/platform_data/usb-davinci.h          |   6 +
 16 files changed, 799 insertions(+), 228 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
 create mode 100644 drivers/phy/phy-da8xx-usb.c

-- 
1.9.1
