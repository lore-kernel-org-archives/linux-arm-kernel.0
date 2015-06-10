From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 10 Jun 2015 21:09:35 +0100
Subject: [PATCH v3 0/3] clk: stm32: Add clock driver for STM32F4[23]xxx devices
In-Reply-To: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements a clock driver for STM32F42xxx and STM32F43xxx
series devices. It supports decoding the state configured by the
bootloader (PLL, clock select, bus dividers) and all the gates clocks.
It does not currently support the I2S and SAI PLLs.

Relies on "Add support to STMicroeletronics STM32 family" v9 by Maxime
Coquelin: http://thread.gmane.org/gmane.linux.kernel/1961049 .

v3:
 * Fix propagation of errors from clock idx lookup function (Maxime
   Coquelin).
 * Added const to a couple of static lookup tables (Maxime Coquelin).
 * Fixed typo in the binding docs (Maxime Coquelin).
 * Removed unnecessary header files and other small code simplifications
   (Stephen Boyd).
 * Remove CLK_IS_BASIC from the APB clock "multipliers" and improved
   commenting for the implementation (Stephen Boyd)
 * Fixed missing const and misplaced __initdata (Stephen Boyd)
 * Apply relavent review comments to existing code (Stephen Boyd)

v2:
 * Move the HSE crystal frequency to stm32f429-disco.dts (was
   prevsiously in stm32f429.dtsi)
 * Fixed compiler warning that I overlooked the first time round.
 * Removed dead code in the .dtsi file.
 * Rebased on linux-next+v9 from Maxime.

Daniel Thompson (3):
  dt-bindings: Document the STM32F4 clock bindings
  clk: stm32: Add clock driver for STM32F4[23]xxx devices
  ARM: dts: stm32f429: Adopt STM32F4 clock driver

 .../devicetree/bindings/clock/st,stm32-rcc.txt     |  65 ++++
 arch/arm/boot/dts/stm32f429-disco.dts              |   4 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  79 ++---
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-stm32f4.c                          | 379 +++++++++++++++++++++
 5 files changed, 473 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
 create mode 100644 drivers/clk/clk-stm32f4.c

--
2.4.2
