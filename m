From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Mon, 19 Jan 2015 18:23:36 +0800
Subject: [PATCH v4 0/8] Support for Fujitsu MB86S7X SoCs
Message-ID: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  Fujitsu have a series of SoC already shipping based around
variations of 2xCA7+2xCA15 big.LITTLE architecture, and we would like
to upstream the basic support in this series.

  MB86S70 is a big.LITTLE platform with 2xCA7+2xCA15 and an additional
CM3 as the master. MB86S73 is a simple 2xCA7 and an additional CM3
master.

  The DT includes references to sdhci patches which are being sent to
the mmc list at the same time.

  We welcome any comments or questions.

Changes since v3:
* Identify platform, by checking presence of DT node
"fujitsu,mb86s70-scb-1.0" before populating cpu clocks and MCPM
support.
* Disable clock upon gpio module remove
* Lower init level of gpio driver from subsys_initcall to module_init
* Use managed device resource allocation in MHU driver

Changes since v2:
* Minor cleanup of MCPM as suggested by Nicolas Pitre.

Changes since v1:
* Thanks to Arnd, modified clock driver to populate clocks only when
some user need them. Node name changed from "fujitsu,mb86s70-clk" to
"fujitsu,mb86s70-crg11" . Controller+Domain+Port of a clock are now
three cells specified by the user node.
* aliases moved into board DTS files
* Voltage supply moved as per-board DT node.
* Removed default overly verbose loglevel=8
* Specify -march=armv7-a flag for mcpm.c and smc.S that contain ARMv7
specific code.
* Removed wrongly put outer_flush_all(), now using standard
v7_exit_coherency_flush() instead of platform specific macro.
* Simplified GPIO offset calculations in gpio-mb86s70.c driver. And
added .remove() for the driver
* ARM MHU driver provided a .remove() to enable module unloading.
* A few other misc cleanups suggested in v1 submission.

Thanks.

Jassi Brar (8):
  ARM: Add platform support for Fujitsu MB86S7X SoCs
  mailbox: arm_mhu: add driver for ARM MHU controller
  ARM: MB86S7X: Add MCPM support
  clk: Add clock driver for mb86s7x
  gpio: Add Fujitsu MB86S7x GPIO driver
  dt: mb86s7x: add dt files for MB86S7x evbs
  of: add Fujitsu vendor prefix
  ARM: MB86S7x: Add configs

 Documentation/devicetree/bindings/arm/mb86s7x.txt  |   8 +
 .../bindings/clock/fujitsu,mb86s70-crg11.txt       |  26 +
 .../bindings/gpio/fujitsu,mb86s70-gpio.txt         |  20 +
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  33 ++
 .../devicetree/bindings/soc/mb86s7x/scb_mhu.txt    |  35 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mb86s70.dtsi                     |  91 ++++
 arch/arm/boot/dts/mb86s70eb.dts                    |  57 +++
 arch/arm/boot/dts/mb86s73.dtsi                     |  63 +++
 arch/arm/boot/dts/mb86s73eb.dts                    |  44 ++
 arch/arm/boot/dts/mb86s7x.dtsi                     | 140 ++++++
 arch/arm/configs/fujitsu_defconfig                 | 232 +++++++++
 arch/arm/configs/multi_v7_defconfig                |   5 +
 arch/arm/mach-mb86s7x/Kconfig                      |  19 +
 arch/arm/mach-mb86s7x/Makefile                     |   3 +
 arch/arm/mach-mb86s7x/board.c                      |  23 +
 arch/arm/mach-mb86s7x/mcpm.c                       | 318 +++++++++++++
 arch/arm/mach-mb86s7x/smc.S                        |  27 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-mb86s7x.c                          | 386 +++++++++++++++
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-mb86s7x.c                        | 232 +++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          | 211 ++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/mb86s7x/Makefile                       |   4 +
 drivers/soc/mb86s7x/scb_mhu.c                      | 528 +++++++++++++++++++++
 include/soc/mb86s7x/scb_mhu.h                      | 105 ++++
 34 files changed, 2640 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mb86s7x.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mb86s7x/scb_mhu.txt
 create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s7x.dtsi
 create mode 100644 arch/arm/configs/fujitsu_defconfig
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile
 create mode 100644 arch/arm/mach-mb86s7x/board.c
 create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
 create mode 100644 arch/arm/mach-mb86s7x/smc.S
 create mode 100644 drivers/clk/clk-mb86s7x.c
 create mode 100644 drivers/gpio/gpio-mb86s7x.c
 create mode 100644 drivers/mailbox/arm_mhu.c
 create mode 100644 drivers/soc/mb86s7x/Makefile
 create mode 100644 drivers/soc/mb86s7x/scb_mhu.c
 create mode 100644 include/soc/mb86s7x/scb_mhu.h

-- 
1.9.0
