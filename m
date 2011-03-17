From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed, 16 Mar 2011 19:23:55 -0700
Subject: [PM8921 MFD V3 0/6]  pmic8921 core and subdevices
Message-ID: <1300328641-3855-1-git-send-email-adharmap@codeaurora.org>
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

Upates from v2
Thomas Gleixner's code cleanup comments, use of IRQCHIP_MASK_ON_SUSPEND.
Randy Dunlap's Kconfig cleanup comments.
Mark Brown's suggestion to move pm8921.h in include/linux/mfd/pm8xxx/pm8921.h
Grant Likely's suggestion of locking around the chip's list.

Thanks a lot for reviewing these patches.


Abhijeet Dharmapurikar (5):
  mfd: pm8921: Add PMIC 8921 core driver
  mfd: pm8xxx: Add irq support
  gpio: pm8xxx-gpio: Add pm8xxx gpio driver
  MAINTAINERS: Add patterns for pmic 8921 files to MSM subsystem
  msm: board-8960: Add support for pm8921

David Collins (1):
  mfd: pm8xxx-mpp: Add pm8xxx MPP driver

 MAINTAINERS                                |    2 +
 arch/arm/mach-msm/board-msm8960.c          |   47 +++-
 arch/arm/mach-msm/include/mach/irqs-8960.h |    9 +-
 drivers/gpio/Kconfig                       |    8 +
 drivers/gpio/Makefile                      |    1 +
 drivers/gpio/pm8xxx-gpio.c                 |  455 ++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                        |   36 +++
 drivers/mfd/Makefile                       |    3 +
 drivers/mfd/pm8921-core.c                  |  278 +++++++++++++++++
 drivers/mfd/pm8xxx-irq.c                   |  436 ++++++++++++++++++++++++++
 drivers/mfd/pm8xxx-mpp.c                   |  327 ++++++++++++++++++++
 include/linux/mfd/pm8xxx/core.h            |   75 +++++
 include/linux/mfd/pm8xxx/gpio.h            |  132 ++++++++
 include/linux/mfd/pm8xxx/irq.h             |   69 +++++
 include/linux/mfd/pm8xxx/mpp.h             |  233 ++++++++++++++
 include/linux/mfd/pm8xxx/pm8921.h          |   48 +++
 16 files changed, 2144 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpio/pm8xxx-gpio.c
 create mode 100644 drivers/mfd/pm8921-core.c
 create mode 100644 drivers/mfd/pm8xxx-irq.c
 create mode 100644 drivers/mfd/pm8xxx-mpp.c
 create mode 100644 include/linux/mfd/pm8xxx/core.h
 create mode 100644 include/linux/mfd/pm8xxx/gpio.h
 create mode 100644 include/linux/mfd/pm8xxx/irq.h
 create mode 100644 include/linux/mfd/pm8xxx/mpp.h
 create mode 100644 include/linux/mfd/pm8xxx/pm8921.h

 --
 Sent by an employee of the Qualcomm Innovation Center, Inc.
 The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
