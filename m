From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Wed,  4 Mar 2015 18:52:47 +0800
Subject: [PATCH v7 0/7] Support for Fujitsu MB86S7X SoCs
Message-ID: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  Fujitsu have a series of SoC already shipping based around
variations of 2xCA7+2xCA15 big.LITTLE architecture, and we would like
to upstream the basic support in this series.

  MB86S70 is a big.LITTLE platform with 2xCA7+2xCA15 and an additional
CM3 as the master. MB86S73 is a simple 2xCA7 and an additional CM3
master.

  We will send a pull request for this series in the next few days
if there are no further issues.

Changes since v6:
* s/freqency/frequency in clock driver
* Macros for number of channels and register offset in MHU driver
* Added more comments in Documentation
* Removed unneeded amba_request_regions() from MHU driver

Changes since v5:
* Pass u32* instead of u32 value to/from mailbox api.
* devm_ioremap_resource() instead of devm_ioremap()
* Decrease verbosity of probe success print.

Changes since v4:
* Convert ARM MHU driver to be an AMBA driver

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

Jassi Brar (7):
  ARM: Add platform support for Fujitsu MB86S7X SoCs
  mailbox: arm_mhu: add driver for ARM MHU controller
  ARM: MB86S7X: Add MCPM support
  clk: Add clock driver for mb86s7x
  dt: mb86s7x: add dt files for MB86S7x evbs
  of: add Fujitsu vendor prefix
  ARM: MB86S7x: Add configs

 Documentation/devicetree/bindings/arm/mb86s7x.txt  |   8 +
 .../bindings/clock/fujitsu,mb86s70-crg11.txt       |  26 +
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 ++
 .../devicetree/bindings/soc/mb86s7x/scb_mhu.txt    |  35 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/mb86s70.dtsi                     |  91 ++++
 arch/arm/boot/dts/mb86s70eb.dts                    |  57 +++
 arch/arm/boot/dts/mb86s73.dtsi                     |  63 +++
 arch/arm/boot/dts/mb86s73eb.dts                    |  44 ++
 arch/arm/boot/dts/mb86s7x.dtsi                     | 142 ++++++
 arch/arm/configs/fujitsu_defconfig                 | 232 +++++++++
 arch/arm/configs/multi_v7_defconfig                |   5 +
 arch/arm/mach-mb86s7x/Kconfig                      |  19 +
 arch/arm/mach-mb86s7x/Makefile                     |   3 +
 arch/arm/mach-mb86s7x/board.c                      |  23 +
 arch/arm/mach-mb86s7x/mcpm.c                       | 318 ++++++++++++
 arch/arm/mach-mb86s7x/smc.S                        |  27 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-mb86s7x.c                          | 386 +++++++++++++++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          | 195 ++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/mb86s7x/Makefile                       |   4 +
 drivers/soc/mb86s7x/scb_mhu.c                      | 531 +++++++++++++++++++++
 include/soc/mb86s7x/scb_mhu.h                      | 105 ++++
 30 files changed, 2384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mb86s7x.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
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
 create mode 100644 drivers/mailbox/arm_mhu.c
 create mode 100644 drivers/soc/mb86s7x/Makefile
 create mode 100644 drivers/soc/mb86s7x/scb_mhu.c
 create mode 100644 include/soc/mb86s7x/scb_mhu.h

-- 
1.9.0
