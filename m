From: peda@axentia.se (Peter Rosin)
Date: Fri, 29 Jun 2018 06:13:31 +0200
Subject: [PATCH v2 0/6] Add Actions Semi S900 I2C support
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
Message-ID: <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On June 28, 2018 8:10:36 PM GMT+02:00, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
>This patchset adds I2C controller support for Actions Semi S900 SoC.
>This driver has been structured in a way such that there will be only
>one controller driver for the whole OWL family series (S500, S700 and
>S900 SoCs).
>
>There are 6 I2C controllers with separate memory mapped register space.
>The I2C controller can handle atmost two messages concatenated by a
>repeated start via its internal address feature. Hence the driver
>uses this feature for messages of length greater than 1. In those
>cases,
>the first message of the combined message should be a `write` with
>maximum
>message length 6 and the second message's maximum length should be 240
>bytes.
>
>As far as the bus speed is concerned, this driver only supports
>Standard (100KHz) and High speed (400KHz) for now.
>
>The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
>With the mux option available only for I2C0.
>
>For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
>are exposed on the Low speed expansion connector are enabled.
>
>Thanks,
>Mani
>
>Changes in v2:
>
>As per Andy's review:
>* Modified infinite loops to fixed number of retries
>* Used i2c_8bit_addr_from_msg for constructing the slave address
>* Removed unnecessary parenthesis around defines
>* Modified certain dev_warn to dev_dbg
>* Modified the error handling to more generic pattern
>
>* Fixed the return value in owl_i2c_master_xfer
>* Added MAINTAINERS patch for I2C driver and its binding
>
>Manivannan Sadhasivam (6):
>  dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
>  arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
>  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
>  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
>  i2c: Add Actions Semi OWL family S900 I2C driver
>  MAINTAINERS: Add entry for Actions Semi OWL I2C driver
>
> .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
> MAINTAINERS                                   |   2 +
> .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 ++
> .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
> arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
> drivers/i2c/busses/Kconfig                    |   7 +
> drivers/i2c/busses/Makefile                   |   1 +
> drivers/i2c/busses/i2c-owl.c                  | 471 ++++++++++++++++++
> 8 files changed, 608 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
>create mode 100644
>arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
> create mode 100644 drivers/i2c/busses/i2c-owl.c

Hi!

I don't know for sure, but over here the arch/arm64/boot/dts/actions folder has no pinctrl nodes at all (v4.18-rc2). So, what is this series based on? The reason I started looking was that patch 2 *appears* to depend on patch 3, and I just wanted to double check that...

Cheers,
Peter
