From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed,  2 Mar 2011 14:21:03 -0800
Subject: [Qualcomm PM8921 MFD 0/6] pmic 8921 core and subdevices
Message-ID: <1299104463-7432-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Earlier cover letter had an incorrect subject line, correcting it in this one.

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

Abhijeet Dharmapurikar (5):
  mfd: pm8921: Add PMIC 8921 core driver
  mfd: pm8xxx: Add irq support
  gpio: pm8xxx-gpio: Add pm8xxx gpio driver
  MAINTAINERS: Add pmic8921, pmic8xxx subdevices maintainers
  msm: board-8960: Add support for pm8921

David Collins (1):
  mfd: pm8xxx-mpp: Add pm8xxx MPP driver

 MAINTAINERS                                |    6 +
 arch/arm/mach-msm/board-msm8960.c          |   47 ++-
 arch/arm/mach-msm/include/mach/irqs-8960.h |    9 +-
 drivers/gpio/Kconfig                       |   10 +
 drivers/gpio/Makefile                      |    1 +
 drivers/gpio/pm8xxx-gpio.c                 |  452 +++++++++++++++++++++
 drivers/mfd/Kconfig                        |   41 ++
 drivers/mfd/Makefile                       |    3 +
 drivers/mfd/pm8921-core.c                  |  288 +++++++++++++
 drivers/mfd/pm8xxx-irq.c                   |  599 ++++++++++++++++++++++++++++
 drivers/mfd/pm8xxx-mpp.c                   |  319 +++++++++++++++
 include/linux/mfd/pm8921.h                 |   48 +++
 include/linux/mfd/pm8xxx/core.h            |   75 ++++
 include/linux/mfd/pm8xxx/gpio.h            |  132 ++++++
 include/linux/mfd/pm8xxx/irq.h             |   62 +++
 include/linux/mfd/pm8xxx/mpp.h             |  233 +++++++++++
 16 files changed, 2310 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpio/pm8xxx-gpio.c
 create mode 100644 drivers/mfd/pm8921-core.c
 create mode 100644 drivers/mfd/pm8xxx-irq.c
 create mode 100644 drivers/mfd/pm8xxx-mpp.c
 create mode 100644 include/linux/mfd/pm8921.h
 create mode 100644 include/linux/mfd/pm8xxx/core.h
 create mode 100644 include/linux/mfd/pm8xxx/gpio.h
 create mode 100644 include/linux/mfd/pm8xxx/irq.h
 create mode 100644 include/linux/mfd/pm8xxx/mpp.h

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
