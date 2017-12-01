From: timur@codeaurora.org (Timur Tabi)
Date: Fri,  1 Dec 2017 17:28:20 -0600
Subject: [PATCH 0/4] [v8] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A series of patches that add support for GPIO maps that have holes in
them.  That is, even though a client driver has N consecutive GPIOs,
some are just unavailable for whatever reason, and the hardware should
not be accessed for those GPIOs.

Note that this version does not address the failure of gpiod_get()
when GPIO 0 is not available.  I don't know how to fix that because I 
don't understand what gpiod_get() is trying to do.

Also note that I would prefer to have the call to gpiochip_available()
be inside gpiod_request(), but I don't know how to get the GPIO index
inside that function (without adding a function a parameter).

In other words, there will be a v9, but I need help.


v8:
  rebased onto 4.15-rc1
  fix issues raised during review of v7

Timur Tabi (4):
  [v2] Revert "gpio: set up initial state from .get_direction()"
  [v2] gpiolib: add bitmask for valid GPIO lines
  [v7] pinctrl: qcom: disable GPIO groups with no pins
  [v4] pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/gpio/gpiolib.c                 |  80 ++++++++++++------
 drivers/pinctrl/qcom/pinctrl-msm.c     |  44 ++++++++--
 drivers/pinctrl/qcom/pinctrl-msm.h     |   2 +
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 145 +++++++++++++++++++++++++--------
 include/linux/gpio/driver.h            |   3 +
 5 files changed, 207 insertions(+), 67 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
