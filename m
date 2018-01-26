From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jan 2018 17:13:57 -0800
Subject: [PATCH v2 0/3] Support qcom pinctrl protected pins
Message-ID: <20180126011400.2191-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset proposes a solution to describing the valid
pins for a pin controller in a semi-generic way so that qcom
platforms can expose the pins that are really available.

Typically, this has been done by having drivers and firmware 
descriptions only use pins they know they have access to, and that
still works now because we no longer read the pin direction at
boot. But there are still some userspace drivers and debugfs facilities
that don't know what pins are available and attempt to read everything
they can. On qcom platforms, this may lead to a system hang, which isn't 
very nice behavior, even if root is the only user that can trigger it.

The proposal is to describe the valid pins and then not allow things to
cause problems by using the invalid pins. Obviously, the firmware may
mess this up, so this is mostly a nice to have feature or a safety net
so that things don't blow up easily.

Changes from v1:
 * Pushed into gpiolib-of core under irq valid line logic
 * Fixed up qcom driver patch to free stuff properly and remove custom code
 * Dropped export patch as it got picked up
 * Renamed binding to 'reserved-gpio-ranges'

Stephen Boyd (3):
  dt-bindings: pinctrl: Add a reserved-gpio-ranges property
  gpiolib-of: Support 'reserved-gpio-ranges' property
  pinctrl: qcom: Don't allow protected pins to be requested

 Documentation/devicetree/bindings/gpio/gpio.txt |  7 +--
 drivers/gpio/gpiolib-of.c                       | 28 ++++++++++
 drivers/gpio/gpiolib.c                          |  9 ++++
 drivers/pinctrl/qcom/pinctrl-msm.c              | 69 +++++++++++++++++++++++--
 4 files changed, 106 insertions(+), 7 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
