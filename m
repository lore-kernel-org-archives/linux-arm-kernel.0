From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu,  5 Jan 2017 10:07:21 +0100
Subject: [PATCH v8 0/5] Add support for the STM32F4 I2C
Message-ID: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v7:
- Remove unneeded parenthesis in some macro definitions (Uwe)
- Fix some typo (s/KhzkHZ, s/PEC/POC) (Uwe)
- Fix alignment issues in some structures declaration (Uwe)
- Clarify comments to argue i2c_timing values chosen (Uwe)
- Raise an error if parent clk rate is out of scope during I2C hw config (Uwe)
- Use dev_dbg instead of dev_err message when I2C bus is busy  (Uwe)
- Add more comments about stuff done by stm32f4_i2c_handle_rx_btf() (Uwe)
- Simplify stm32f4_i2c_isr_error() routine implementation by removing possible
  status checking (Uwe)
- Rework stm32f4_i2c_isr_error() routine by removing the loop to check which status occured  (Uwe)
- Add open-drain property for SCL pins  (Uwe)
- Rework unneeded mul_ccr field from i2c_timing structure
- Remove min_ccr field from i2c_timing structure as default scl_period is chosen
  to have a correct minimal ccr value
- Execute hw_config once during probe
- Remove soft_reset after an I2C error as all errors are now handled and
  hw_config is done once during probe
- Generate STOP by software when Acknowledge failure occurs
- Set the max speed mode for I2C pins
- Add bias-disable property for I2C pins
- Use intrinsic limitation of APB bus to set I2C max input clk

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
  ARM: dts: stm32: Add I2C1 support for STM32429 eval board
  ARM: configs: stm32: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  23 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 866 +++++++++++++++++++++
 7 files changed, 942 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
