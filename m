From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 16:10:58 +0530
Subject: [PATCH V3 0/7] SPEAr DT support updates
Message-ID: <cover.1333017183.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset updates DT support for SPEAr3xx and 6xx.
It has following changes:
- updates DT support Mainly for SPEAr3xx family
- updates dma support for SPEAr6xx
- updates defconfig

It has dependency on following patchsets:
- ehci & ohci: http://www.spinics.net/lists/linux-usb/msg60362.html
- rtc: http://lkml.org/lkml/2012/3/26/96
- keyboard: http://www.spinics.net/lists/linux-input/msg19904.html

V2->V3:
- Removed macro for adding entries in auxdata array for ssp and dma
- removed IO_ADDRESS() completely
- Create 16M static mappings instead of 4K mappings
- Don't return error from spear*dt_init() if board doesn't match for padmux
- Config symbols and #ifdef,#endif are not updated for DT
- interrupt-parenti=<&vic> moved to root node.

V1->V2:
- Separate DT_MACHINE_INIT macros are defined per SoC.
- PATCH 1/7 was sent earlier as individual patch, and is now included in this
  patchset for completeness.
- clock support for ehci and ohci added
- plat data for UART PL011 removed as it is not required
- Minor issues fixed

Viresh Kumar (7):
  SPEAr: Use CLKDEV_INIT for defining clk_lookups
  SPEAr3xx: Add clock instance of usb hosts - ehci and ohci 0 and 1
  SPEAr6xx: Add compilation support for dtbs using 'make dtbs'
  SPEAr3xx: Replace printk() with pr_*()
  ARM: SPEAr3xx: Add device-tree support to SPEAr3xx architecture
  SPEAr: Add PL080 DMA support for 3xx and 6xx
  SPEAr: Update defconfigs

 Documentation/arm/SPEAr/overview.txt            |   13 +-
 Documentation/devicetree/bindings/arm/spear.txt |   18 ++
 arch/arm/boot/dts/spear300-evb.dts              |  183 +++++++++++
 arch/arm/boot/dts/spear300.dtsi                 |   72 +++++
 arch/arm/boot/dts/spear310-evb.dts              |  111 +++++++
 arch/arm/boot/dts/spear310.dtsi                 |   75 +++++
 arch/arm/boot/dts/spear320-evb.dts              |  112 +++++++
 arch/arm/boot/dts/spear320.dtsi                 |   90 ++++++
 arch/arm/boot/dts/spear3xx.dtsi                 |  144 +++++++++
 arch/arm/boot/dts/spear600-evb.dts              |    4 +
 arch/arm/boot/dts/spear600.dtsi                 |    8 +
 arch/arm/configs/spear3xx_defconfig             |   52 +++-
 arch/arm/configs/spear6xx_defconfig             |   41 ++-
 arch/arm/mach-spear3xx/Kconfig                  |   34 +--
 arch/arm/mach-spear3xx/Makefile                 |   13 +-
 arch/arm/mach-spear3xx/Makefile.boot            |    4 +
 arch/arm/mach-spear3xx/clock.c                  |  182 +++++++-----
 arch/arm/mach-spear3xx/include/mach/generic.h   |   31 +--
 arch/arm/mach-spear3xx/include/mach/hardware.h  |    3 -
 arch/arm/mach-spear3xx/include/mach/spear.h     |    9 +-
 arch/arm/mach-spear3xx/spear300.c               |  294 ++++++++++++++++--
 arch/arm/mach-spear3xx/spear300_evb.c           |   75 -----
 arch/arm/mach-spear3xx/spear310.c               |  329 +++++++++++++++++++--
 arch/arm/mach-spear3xx/spear310_evb.c           |   81 -----
 arch/arm/mach-spear3xx/spear320.c               |  328 +++++++++++++++++++--
 arch/arm/mach-spear3xx/spear320_evb.c           |   79 -----
 arch/arm/mach-spear3xx/spear3xx.c               |  148 +++++----
 arch/arm/mach-spear6xx/Makefile.boot            |    2 +
 arch/arm/mach-spear6xx/clock.c                  |   80 +++---
 arch/arm/mach-spear6xx/spear6xx.c               |  372 ++++++++++++++++++++++-
 arch/arm/plat-spear/Kconfig                     |    3 +-
 arch/arm/plat-spear/Makefile                    |    2 +-
 arch/arm/plat-spear/include/plat/pl080.h        |   21 ++
 arch/arm/plat-spear/pl080.c                     |   79 +++++
 34 files changed, 2505 insertions(+), 587 deletions(-)
 create mode 100644 arch/arm/boot/dts/spear300-evb.dts
 create mode 100644 arch/arm/boot/dts/spear300.dtsi
 create mode 100644 arch/arm/boot/dts/spear310-evb.dts
 create mode 100644 arch/arm/boot/dts/spear310.dtsi
 create mode 100644 arch/arm/boot/dts/spear320-evb.dts
 create mode 100644 arch/arm/boot/dts/spear320.dtsi
 create mode 100644 arch/arm/boot/dts/spear3xx.dtsi
 delete mode 100644 arch/arm/mach-spear3xx/spear300_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear310_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear320_evb.c
 create mode 100644 arch/arm/plat-spear/include/plat/pl080.h
 create mode 100644 arch/arm/plat-spear/pl080.c

-- 
1.7.9
