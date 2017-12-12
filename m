From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 12 Dec 2017 14:50:55 -0600
Subject: [PATCH 0/3] [v9] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1513111858-6251-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A series of patches that add support for GPIO maps that have holes in
them.  That is, even though a client driver has N consecutive GPIOs,
some are just unavailable for whatever reason, and the hardware should
not be accessed for those GPIOs.

Patch 1 reverts an old patch that triggers a get_direction of every
pin upon init, without attempting to request the pins first.  The
direction is already being queried when the pin is requested.

Patch 2 adds support to pinctrl-msm for "unavailable" GPIOs.

Patch 3 extends that support to pinctrl-qdf2xxx.  A recent ACPI change
on QDF2400 platforms blocks access to most pins, so the driver can only
register a subset.

This version drops the availability check in gpiolib, because it's no
necessary.  Instead, just having pinctrl-msm return -EACCES is enough
to block all unavailable GPIOs.  Patch 1 removes the only instance where
an unrequested GPIO is being accessed.

v9:
  Removed "gpiolib: add bitmask for valid GPIO lines"

Timur Tabi (3):
  [v2] Revert "gpio: set up initial state from .get_direction()"
  [v8] pinctrl: qcom: disable GPIO groups with no pins
  [v5] pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/gpio/gpiolib.c                 |  31 ++-----
 drivers/pinctrl/qcom/pinctrl-msm.c     |  28 +++++--
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 143 ++++++++++++++++++++++++---------
 3 files changed, 137 insertions(+), 65 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
