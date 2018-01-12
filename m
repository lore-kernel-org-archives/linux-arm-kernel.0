From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 12 Jan 2018 13:15:54 +0100
Subject: [PATCH 00/14] Add MMCI support for STM32F SoCs family
Message-ID: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This series reworks patches submitted one year ago by Andrea Merello [1] 
but without succeed to merged it.

STM32F4 and STM32F7 SoCs families embeds a variant of the ARM PrimeCell 
PL18x SD host controller, for which the mmci driver exists. 
This series adds support for these SoCs to the mmci driver.

As other variants, this one need some specific quirks, that this 
series address. 

This series has been tested on following boards :
	_ stm32f429-eval
	_ stm32f469-disco
	_ stm32f746-eval
	_ stm32f769-disco

DT update for stm32f7 pinctrl, stm32f746-eval and stm32f769-disco boards
will be sent later to avoid conflict with pending stm32f7 series [1] which
is not yet merged on kernel mainline.

[1] https://www.spinics.net/lists/linux-mmc/msg41616.html
[2] https://patchwork.kernel.org/patch/10104447/


Andrea Merello (2):
  ARM: dts: stm32: Add pin map for SDIO controller on stm32f4
  ARM: dts: stm32: Enable SDIO controller on stm32f469 disco board

Patrice Chotard (12):
  mmc: mmci: Don't pretend all variants to have MMCIMASK1 register
  mmc: mmci: Don't pretend all variants to have MCI_STARBITERR flag
  mmc: mmci: Add support for setting pad type via pinctrl
  mmc: mmci: Add STM32 variant
  ARM: dts: stm32: Add SDIO controller for stm32f746
  ARM: dts: stm32: Add SDIO controller for stm32f429
  ARM: dts: stm32: Enable SDIO controller on stm32429i-eval board
  ARM: stm32: Add AMBA support for STM32F4 and STM32F7 SoCs
  ARM: configs: stm32: Enable MMC_ARMMMCI support
  ARM: configs: stm32: Enable EXT3_FS support
  clk: stm32: Add clk entry for SDMMC2 on stm32F769
  gpio: stmpe: i2c transfer are forbiden in atomic context

 arch/arm/boot/dts/stm32429i-eval.dts   |  19 ++++++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi |  31 +++++++++
 arch/arm/boot/dts/stm32f429.dtsi       |  11 +++
 arch/arm/boot/dts/stm32f469-disco.dts  |  19 ++++++
 arch/arm/boot/dts/stm32f746.dtsi       |  22 ++++++
 arch/arm/configs/stm32_defconfig       |   3 +
 arch/arm/mach-stm32/Kconfig            |   3 +
 drivers/clk/clk-stm32f4.c              |   3 +-
 drivers/gpio/gpio-stmpe.c              |  20 +++---
 drivers/mmc/host/mmci.c                | 120 ++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h                |   6 ++
 11 files changed, 231 insertions(+), 26 deletions(-)

-- 
1.9.1
