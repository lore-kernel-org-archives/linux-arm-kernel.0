From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 19 Jan 2017 14:25:11 +0100
Subject: [PATCH v10 0/5] Add support for the STM32F4 I2C
Message-ID: <1484832316-5594-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v9:
- Fix minor typo in some comments
- Add some comments to explain how the driver check TRISE and CCR value have
  no chance of overflow

Changes since v8:
- Rework I2C Clock Control Register computation (Uwe)
- Save register accesses as often as possible (Uwe)
- Don't use mask before saving rx buffer (Uwe)
- Add more comments to explain hardware way of working (Uwe)
- Rename stm32f4_i2c_handle_rx_btf function by stm32f4_i2c_handle_rx_done (Uwe)
- Set/Clear Ack position bit during address match phase

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
- Rework stm32f4_i2c_isr_error() routine by removing the loop to check which
  status occured  (Uwe)
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

Changes since v6:
- Add commit message for the patches in defconfig, .dtsi and .dts files (Alex)
- Order I2C instance base address in .dtsi file (Alex)
- Add commit message for the patch in stm32429i-eval.dts  (Alex)
- Add link to the STM32F4 Soc ref manual where I2C device is described (Uwe)
- Use more usal way to define constants with several lines (Uwe)
- Remove rate variable from stm32f4_i2c_timings as it is not used (Uwe)
- Remove irq variable from stm32f4_i2c_dev struct are they are only needed
  during probe (Uwe)
- Add comment from datasheet to explain stm32f4_i2c_timings values (Uwe)
- Rework i2c soft_reset implementation (Uwe)
- Replace "it" by "irq" as it is a more usual abbreviation for interrupt (Uwe)
- Add comment from datasheet to explain periph clk freq calculation (Uwe)
- Use DIV_ROUND_UP instead of plain division when required (Uwe)
- Add comment from datasheet to explain timing rise calculation (Uwe)
- Rework timing rise calculation by using shorter computation (Uwe)
- Remove (u8) cast when reading I2C data register (Uwe)
- Rework isr_event routine to handle several events during one call of the
  routine (Uwe)
- Precise which type of irq is failed when a irq request error occurs (Uwe)
- Use devm_request_irq() instead of devm_request_threaded_irq() to avoid
  spurious evt irq when clearing status registers in threaded context

Changes since v5:
- Change commit header from "ARM: dts:" to "ARM: dts: stm32:" (Alex)
- Change commit header from "ARM: configs:" to "ARM: configs: stm32:" (Alex)
- Fix warnings due to variable set but unused (Wolfram)
- Remove double space in Kconfig (Wolfram)
- Fix warning due to bad type parameter when using clamp() function
  (build-bot)

Changes since v4:
- Use clamp() function to use a value in a given range as it was missed in V4

Changes since v3 after Wolfram's review:
- Add COMPILE_TEST flag in Kconfig
- Use correct driver name in Kconfig i.e i2c-stm32f4 instead of i2c-st
- Use more comprehensible name stm32f4_i2c_msg for client specific data
- Don't store reset control node as just needed in probe
- Use clamp() function to test value between 2 ranges
- Use new "i2c_8bit_addr_from_msg() function to build I2C address
- Don't write error messages for timeout
- Remove error message when i2c_add_adapter() fails as it is already handled by
  the i2c core driver

Changes since v2:
- remove interrupt configuration management from DT
- remove FIFO configuration management from DT except threshold as it is very
  hard to handle it in the driver due to many possible combinations according
  to burst and bus width
- update DMA client message in DT documentation file
- specify the order to be used to set per-channel DMA interrupts in the DT
- remove unused enumerations for channel and request ids
- keep as soon as possible 80 lines char for more readability
- replace unsigned int by u32
- return error if burst is not supported in stm32_dma_get_burst()
- return error if bus_width is not supported in stm32_dma_get_width()
- add FIFO configuration management inside the driver except for threshold
- add interrupt configuration management inside the driver
- rework stm32_dma_chan_irq() to handle error interrupt in one way
- rework stm32_dma_set_xfer_param() to be easier to read
- update stm32_dma_tx_status() to always return status from dma_cookie_status()
- disable clk if we don't manage to stop the DMA channel during channel
  resources allocation
- set driver as built-in as DMA will be required by other built-in driver

Changes since v1:
- use compatible st,stm32f4-i2c instead of st,i2c-stm32f4 (Rob)
- fix typo s/enmpty/empty (Maxime)
- use one function to handle TX fifo empty and byte xfer finished IT (Maxime)
- set duty cycle in timing struct in Fast mode
- Rework clock management (call prepare/unprepare at probe and remove, call
  clk_enable/clk_disable for each I2C transfer)

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
 drivers/i2c/busses/i2c-stm32f4.c                   | 897 +++++++++++++++++++++
 7 files changed, 973 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
