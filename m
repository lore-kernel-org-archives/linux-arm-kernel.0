From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  4 Apr 2018 22:52:49 +0530
Subject: [PATCH v7 0/9] Add Actions Semi S900 pinctrl and gpio support
Message-ID: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds pinctrl and gpio support for Actions Semi S900 SoC.
Pinctrl and gpio subsystems share the common set of register range but
implemented as individual drivers for making it less complex.

Pinmux functions are only accessible for pin groups while pinconf
parameters are available for both pin groups and individual pins.

gpio-line-names has been added for the Bubblegum-96 board matching the
96Boards CE specification v1.0.

Both pinctrl and gpio drivers are verified using the Bubblegum-96 board.

This patchset depends on the clock driver which is still under review:
https://lkml.org/lkml/2018/2/9/831

There is also S500 pinctrl and gpio driver developed by Andreas Farber
independently to this patchset.
https://github.com/afaerber/linux/commits/bg96-next

If this patchseries seems to be good enough to add base OWL pinctrl and
gpio support. Then, we may decide on adding S500 support on top of this later
by reusing the pinctrl definitions from Andreas.

Thanks,
Mani

Changes in v7:

* Added spinlock to gpio driver per Andy's suggestion
* Introduced helper functions, owl_read_field and owl_write_field in pinctrl
  driver as suggested by Andy
* Fixed comma usage for structs

Changes in v6:

* Changed owl_gpio_set_reg to owl_gpio_update_reg in gpio driver
* Reused owl_gpio_update_reg in owl_gpio_set in gpio driver
* Removed ngpio property from DT for nodes with 32 gpios
* Fixed size values in DT for gpio nodes
* Added Reviewed-by tags from Linus for adding gpio-line-names in DT

Changes in v5:

* Removed alias for gpio nodes
* Removed duplicate address from gpio nodes and modified the driver accordingly
* Used ngpios property for specifying number of gpios per bank
* Used generic gpio node name in DT and binding
* Modified pinctrl driver to save space
* Dropped pinctrl bindings patch since it got applied
* Added Reviewed-by tags from Linus for DT and platform Kconfig changes

Changes in v4:

* Incorporated Andy's review for pinctrl driver
* Used _relaxed functions for pinctrl driver
* Added Andy's Reviewed-by tag for gpio driver
* Added (back) Rob's Reviewed-by tag for pinctrl bindings

Changes in v3:

* Simplified owl_gpio_set_reg() with _relaxed functions
* Added interrupt controller properties to gpio node bindings as suggested
  by Rob
* Minor code cleanups

Changes in v2:

* Implemented each GPIO bank as its own gpio-controller
* Added gpio-ranges property
* Modified pin group to follow pad names instead of register names
* Incorporated review comments from Andy
* Incorporated review comments from Andreas
* Fixed the MODULE_LICENSE with respect to SPDX tag
* Added Reviewed by tag from Rob for pinctrl binding

Manivannan Sadhasivam (9):
  arm64: dts: actions: Add pinctrl node for S900
  arm64: actions: Enable PINCTRL in platforms Kconfig
  pinctrl: actions: Add Actions S900 pinctrl driver
  dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
  arm64: dts: actions: Add S900 gpio nodes
  arm64: dts: actions: Add gpio line names to Bubblegum-96 board
  gpio: Add gpio driver for Actions OWL S900 SoC
  MAINTAINERS: Add reviewer for ACTIONS platforms
  MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries

 .../devicetree/bindings/gpio/actions,owl-gpio.txt  |   87 +
 MAINTAINERS                                        |    5 +
 arch/arm64/Kconfig.platforms                       |    1 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  195 ++
 arch/arm64/boot/dts/actions/s900.dtsi              |   57 +
 drivers/gpio/Kconfig                               |    8 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-owl.c                            |  184 ++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/actions/Kconfig                    |   12 +
 drivers/pinctrl/actions/Makefile                   |    2 +
 drivers/pinctrl/actions/pinctrl-owl.c              |  585 ++++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  142 ++
 drivers/pinctrl/actions/pinctrl-s900.c             | 1861 ++++++++++++++++++++
 15 files changed, 3142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
 create mode 100644 drivers/gpio/gpio-owl.c
 create mode 100644 drivers/pinctrl/actions/Kconfig
 create mode 100644 drivers/pinctrl/actions/Makefile
 create mode 100644 drivers/pinctrl/actions/pinctrl-owl.c
 create mode 100644 drivers/pinctrl/actions/pinctrl-owl.h
 create mode 100644 drivers/pinctrl/actions/pinctrl-s900.c

-- 
2.14.1
