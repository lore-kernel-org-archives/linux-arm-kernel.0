From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 12 Dec 2013 14:30:40 -0600
Subject: [PATCHv6 0/5] socfpga: Enable SD/MMC support
Message-ID: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v6 of the patch series to enable SD/MMC on the SOCFPGA platform.

V6 differences from V5:

* Adds a new patch to the series.
  [mmc: dw_mmc: Add support to set the SDR and DDR timing through clock framework]
  This patch enables the setting for the SDR and DDR setting through the common
  clock framework. This patch can be independently applied on its own. I lumped
  it into this series to show how the SOCFPGA can make use of it.

* Add a new clock type "altr,socfpga-sdmmc-sdr-clk" to the SOCFPGA clock driver.
  This clock type implements the clk_set_rate function which can set the SD/MMC's
  clock phase settings. Can now use the syscon driver in the set_rate function.

* Will have to CC DTS Maintainers as I am adding a new binding to the clock
  driver.

Thanks,

Dinh Nguyen (5):
  mmc: dw_mmc: Add support to set the SDR and DDR timing through clock
    framework
  clk: socfpga: Add a clock type for the SD/MMC driver
  dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
  mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
  ARM: socfpga_defconfig: enable SD/MMC support

 .../devicetree/bindings/clock/altr_socfpga.txt     |   11 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   19 ++-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   12 ++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   12 ++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++
 arch/arm/configs/socfpga_defconfig                 |    2 +
 drivers/clk/socfpga/clk.c                          |   86 ++++++++++++
 drivers/mmc/host/Kconfig                           |    8 --
 drivers/mmc/host/dw_mmc-socfpga.c                  |  138 --------------------
 drivers/mmc/host/dw_mmc.c                          |   23 ++++
 include/linux/mmc/dw_mmc.h                         |    6 +
 11 files changed, 180 insertions(+), 149 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5
