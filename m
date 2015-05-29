From: bintian.wang@huawei.com (Bintian Wang)
Date: Fri, 29 May 2015 10:08:32 +0800
Subject: [PATCH v8 0/7] arm64,hi6220: Enable Hisilicon Hi6220 SoC
Message-ID: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bintian Wang <wangbintian@gmail.com>

Hi6220 is one mobile solution of Hisilicon, this patchset contains
initial support for Hi6220 SoC and HiKey development board, which
supports octal ARM Cortex A53 cores. Initial support is minimal and
includes just the arch configuration, clock driver, device tree
configuration.

PSCI is enabled in device tree and there is no problem to boot all the
octal cores, and the CPU hotplug is also working now, you can download
and compile the latest firmware based on the following link to run this
patch set:
https://github.com/96boards/documentation/wiki/UEFI

Changes v6~v8:
This three versions only modified the clock drivers based on the
Stephen's review advices.
* clk-hi6220.c:
  ** Split the clock header file from clock driver
  ** Delete setting the parents clock of UART1 to HI6220_150M in clock
     driver, we can do that using assigned-clock in dts when enable
     UART1 in the future.
* clkdivider-hi6220.c: 
  ** Reuse some functions exported by clk-divider.c
  ** Remove "pr_err" and CLK_IS_BASIC flag
  ** Fix some programing style problems
* hisilicon/clk.h: remove the "__init" markings on some funcition
  prototypes.

Changes v5:
* Rebase to kernel 4.1-rc2
* Add compatible string "hisilicon,hi6220-pl011" for Hisilicon designed
  UART
* clk-hi6220.c: use __initdata for non-const arrays based on the commit
  692d8328e8c039f9497eb862c6cf835de922c061 

Changes v4:
* Rebase to kernel 4.1-rc1
* Delete "arm,cortex-a15-gic" from the gic node in dts 

Changes v3:
* Verified the CPU hotplug based on the new released firmware
* Redefined the compatible strings of four system controllers in dts 
* Setting COMMON_CLK_HI6220 to a bool symbol
* Keep CONFGI_ARCH_HISI sorted alphabetically

Changes v2:
* Split the DT bindings documents into earlier patches
* Change SMP enable method from spin-table to PSCI in device tree
* Remove "clock-frequency" from armv8-timer device node in device tree
* Add more description about Hisilicon designed system controllers
  in DT bindings document
* Enable high speed clock on UART1 mux
* Other changes based on the discussion in the mailing list:
  https://lkml.org/lkml/2015/2/5/147

Bintian Wang (7):
  arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
  clk: hi6220: Document devicetree bindings for hi6220 clock
  Documentation: DT: PL011: hi6220: add compatible string for Hisilicon
    designed UART
  clk: hisilicon: Remove __init for marking function prototypes
  dt-bindings: Add header file of hi6220 clock driver
  clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
  arm64: dts: Add dts files for Hisilicon Hi6220 SoC

 .../bindings/arm/hisilicon/hisilicon.txt           |  87 +++++++
 .../devicetree/bindings/clock/hi6220-clock.txt     |  34 +++
 Documentation/devicetree/bindings/serial/pl011.txt |   4 +-
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/hisilicon/Makefile             |   5 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  31 +++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 172 +++++++++++++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   4 +-
 drivers/clk/hisilicon/Kconfig                      |   6 +
 drivers/clk/hisilicon/Makefile                     |   3 +-
 drivers/clk/hisilicon/clk-hi6220.c                 | 284 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |  29 +++
 drivers/clk/hisilicon/clk.h                        |  39 ++-
 drivers/clk/hisilicon/clkdivider-hi6220.c          | 156 +++++++++++
 include/dt-bindings/clock/hi6220-clock.h           | 173 +++++++++++++
 16 files changed, 1013 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
 create mode 100644 drivers/clk/hisilicon/Kconfig
 create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
 create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
 create mode 100644 include/dt-bindings/clock/hi6220-clock.h

-- 
1.9.1
