From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 23 Jun 2018 21:41:42 +0530
Subject: [PATCH 0/5] Add Actions Semi S900 I2C support
Message-ID: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds I2C controller support for Actions Semi S900 SoC.
This driver has been structured in a way such that there will be only
one controller driver for the whole OWL family series (S500, S700 and
S900 SoCs).

There are 6 I2C controllers with separate memory mapped register space.
The I2C controller can handle atmost two messages concatenated by a
repeated start via its internal address feature. Hence the driver
uses this feature for messages of length greater than 1. In those cases,
the first message of the combined message should be a `write` with maximum
message length 6 and the second message's maximum length should be 240 bytes.

As far as the bus speed is concerned, this driver only supports
Standard (100KHz) and High speed (400KHz) for now.

The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
With the mux option available only for I2C0.

For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
are exposed on the Low speed expansion connector are enabled.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
  arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
  i2c: Add Actions Semi OWL family S900 I2C driver

 .../devicetree/bindings/i2c/i2c-owl.txt       |  27 ++
 .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 ++
 .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
 drivers/i2c/busses/Kconfig                    |   7 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-owl.c                  | 459 ++++++++++++++++++
 7 files changed, 594 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
 create mode 100644 drivers/i2c/busses/i2c-owl.c

-- 
2.17.1
