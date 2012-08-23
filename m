From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 23 Aug 2012 16:45:25 +0530
Subject: [PATCH v3 0/4] pinctrl: add support for samsung pinctrl driver
Message-ID: <1345720529-32315-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
- Fixes as suggested by Linus Walleij <linus.walleij@linaro.org>

Changes since v1:
- Added support for external gpio and wakeup interrupts for Exynos4.

This patch series adds a common pinctrl driver for all Samsung platforms and
enables the pinctrl driver support for Exynos4210 based device tree enabled
platforms. The scope of this driver is limited to only device tree enabled
platforms.

The intention of this driver is to replace the existing gpiolib driver and
provide pinctrl subsystem interface to configure the pins/mux instead
of existing platform callbacks.

Note that, the Samsung pinctrl driver is usable only on device tree enabled
Samsung platforms. Legacy platforms would still continue to use the older
gpiolib driver and hence updates to device drivers to use the pinctrl api
should ensure that support for legacy platforms is maintained.

The first patch adds a new pinctrl driver for Samsung. It provides interfaces
to the pinctrl and gpiolib subsystems. This driver provides a common framework
for all Samsung SoC's to enable the pinctrl and gpiolib support. The driver
accepts the information about pins, groups and functions from the device tree
and the information about gpio banks is supplied using driver data.

The second patch adds the driver data required to operate the pinctrl driver
on Exynos4210 based platforms. It allows includes support for Exynos4210
specific external gpio and wakeup interrupts which are provides to the Samsung
pinctrl driver as extensions.

The third patch modifies the existing gpiolib driver to skip the gpio pin
registrations if pinctrl driver support is found to be enabled. The fourth
patch skips the external wakeup interrupt configuration process in the
Exynos4 platform code if the external wakeup interrupt support is provided
by the pin-control driver.

Thomas Abraham (4):
  pinctrl: add samsung pinctrl and gpiolib driver
  pinctrl: add exynos4210 specific extensions for samsung pinctrl driver
  gpio: exynos4: skip gpiolib registration if pinctrl driver is used
  ARM: EXYNOS: skip wakeup interrupt setup if pinctrl driver is used

 .../bindings/pinctrl/samsung-pinctrl.txt           |  196 +++++
 arch/arm/mach-exynos/common.c                      |   26 +
 drivers/gpio/gpio-samsung.c                        |   21 +
 drivers/pinctrl/Kconfig                            |    9 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/pinctrl-exynos.c                   |  560 ++++++++++++
 drivers/pinctrl/pinctrl-exynos.h                   |  217 +++++
 drivers/pinctrl/pinctrl-samsung.c                  |  888 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-samsung.h                  |  239 ++++++
 9 files changed, 2158 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-exynos.c
 create mode 100644 drivers/pinctrl/pinctrl-exynos.h
 create mode 100644 drivers/pinctrl/pinctrl-samsung.c
 create mode 100644 drivers/pinctrl/pinctrl-samsung.h
