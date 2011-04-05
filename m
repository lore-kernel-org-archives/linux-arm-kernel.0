From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Tue,  5 Apr 2011 14:40:51 -0700
Subject: [PM8921 MFD V5 0/6] pm8921 core and subdevices
Message-ID: <1302039657-19395-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for pmic 8921 chip and its subdevices.
The pmic 8921 chip is used as a power management ic for 8960 based boards. It
communicates over the ssbi bus, ssbi bus can be found here

https://patchwork.kernel.org/patch/601771/

The patch set contains support for interrupt, gpio and mpp (multi purpose pin)
subdevices.

Note that gpio and mpp subdevices need the interrupt subdevice to
be operational, this is becuase the reading the the value of gpio/mpp lines
happens by doing a transaction over registers managed by the interrupt subdev.
The code invokes a call on interrupt subdevice, rather than writing to those
registers directly, avoiding race conditions.

Updates from V4
Few things have changed in kernel proper since I last sent this series
-The interrupt macro names have changed (more structured)- had to update the irq
patch to use the new macro names
- mfd_cell does not have platfrom_data anymore - use mfd data instead.
- Had a mutex_destroy in the mpp code, I had updated mpp driver to use spinlocks
but that mutex_destroy was still hanging there. Removed the mutex_destroy.
- since mpp code has been moved to gpio, updated the CONFIG name to reflect it 
is a gpio instead of a subdevice for mfd IOW use CONFIG_GPIO_PM8XXX_MPP instead
of CONFIG_MFD_PM8XXX_MPP

Abhijeet Dharmapurikar (5):
  mfd: pm8921: Add PMIC 8921 core driver
  mfd: pm8xxx: Add irq support
  gpio: pm8xxx-gpio: Add pm8xxx gpio driver
  MAINTAINERS: Add patterns for pmic 8921 files to MSM subsystem
  msm: board-8960: Add support for pm8921

David Collins (1):
  mfd: pm8xxx-mpp: Add pm8xxx MPP driver

 MAINTAINERS                                |    2 +
 arch/arm/mach-msm/board-msm8960.c          |   40 +++-
 arch/arm/mach-msm/include/mach/irqs-8960.h |    9 +-
 drivers/gpio/Kconfig                       |   17 +
 drivers/gpio/Makefile                      |    2 +
 drivers/gpio/pm8xxx-gpio.c                 |  455 ++++++++++++++++++++++++++++
 drivers/gpio/pm8xxx-mpp.c                  |  325 ++++++++++++++++++++
 drivers/mfd/Kconfig                        |   28 ++
 drivers/mfd/Makefile                       |    2 +
 drivers/mfd/pm8921-core.c                  |  277 +++++++++++++++++
 drivers/mfd/pm8xxx-irq.c                   |  371 +++++++++++++++++++++++
 include/linux/mfd/pm8xxx/core.h            |   81 +++++
 include/linux/mfd/pm8xxx/gpio.h            |  136 +++++++++
 include/linux/mfd/pm8xxx/irq.h             |   59 ++++
 include/linux/mfd/pm8xxx/mpp.h             |  233 ++++++++++++++
 include/linux/mfd/pm8xxx/pm8921.h          |   49 +++
 16 files changed, 2077 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpio/pm8xxx-gpio.c
 create mode 100644 drivers/gpio/pm8xxx-mpp.c
 create mode 100644 drivers/mfd/pm8921-core.c
 create mode 100644 drivers/mfd/pm8xxx-irq.c
 create mode 100644 include/linux/mfd/pm8xxx/core.h
 create mode 100644 include/linux/mfd/pm8xxx/gpio.h
 create mode 100644 include/linux/mfd/pm8xxx/irq.h
 create mode 100644 include/linux/mfd/pm8xxx/mpp.h
 create mode 100644 include/linux/mfd/pm8xxx/pm8921.h

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
