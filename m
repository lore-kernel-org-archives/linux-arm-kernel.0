From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  6 Jan 2016 17:12:46 -0800
Subject: [PATCH 0/3] Make qcom pinctrl drivers tristate again
Message-ID: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of my recent changes to the qcom pinctrl drivers introduced
a module build failure due to of_irq_count() missing an export.
Rob doesn't want us to export that API though, so this series
introduces platform_irq_count() and uses it in the pinctrl
drivers. Linus changed the Kconfig to bool so that the build
failure went away, so I've reverted that patch here after
we fix the build failure with the new API.

Greg, please ack the first patch so it can go through Linus'
tree.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Gross <andy.gross@linaro.org>

Stephen Boyd (3):
  driver-core: platform: Add platform_irq_count()
  pinctrl: qcom: Use platform_irq_count() instead of of_irq_count()
  Revert "pinctrl: qcom: make PMIC drivers bool"

 drivers/base/platform.c                  | 20 ++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig             |  4 ++--
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c |  4 +++-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  |  4 +++-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c |  9 ++++++---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  |  9 ++++++---
 include/linux/platform_device.h          |  1 +
 7 files changed, 41 insertions(+), 10 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
