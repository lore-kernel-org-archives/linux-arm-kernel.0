From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  8 Feb 2016 17:45:27 -0800
Subject: [PATCH 00/14] clk_hw based clkdev/DT providers
Message-ID: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've mostly split the clk API between consumers and providers
along struct clk and struct clk_hw, but the registration and
clkdev/DT code is still struct clk focused. This series
lays the foundation for changing that design by making
clk_register() return an int instead of a struct clk and
clkdev/DT lookups take a struct clk_hw instead of a struct clk.

After this series is applied, we can avoid using struct clk
in provider drivers entirely, unless we want to use the consumer
APIs. There are quite a few registration callers, so this change
will require converting all of them. I plan to do that gradually
over the coming weeks, but I've included a change to qcom
platforms because I could easily test it and show how things
will work.

The first two patches are cleanups to clkdev APIs that I found
while doing this work. I'd like to take those into clk-next
with the appropriate acks. They're mostly included because
they cause merge conflicts otherwise.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <linux@arm.linux.org.uk>

Stephen Boyd (14):
  mfd: intel_quark_i2c_gpio: Use clkdev_create()
  clkdev: Remove clk_register_clkdevs()
  clk: Add {devm_}clk_hw_{register,unregister}() APIs
  clk: Add clk_hw OF clk providers
  clkdev: Add clk_hw based registration APIs
  clk: divider: Add hw based registration APIs
  clk: gate: Add hw based registration APIs
  clk: mux: Add hw based registration APIs
  clk: fixed-factor: Add hw based registration APIs
  clk: fractional-divider: Add hw based registration APIs
  clk: composite: Add hw based registration APIs
  clk: gpio: Add hw based registration APIs
  clk: fixed-rate: Add hw based registration APIs
  clk: qcom: Migrate to clk_hw based registration and OF APIs

 Documentation/driver-model/devres.txt |   1 +
 drivers/clk/clk-composite.c           |  45 ++++++---
 drivers/clk/clk-divider.c             |  91 ++++++++++++++++--
 drivers/clk/clk-fixed-factor.c        |  41 ++++++--
 drivers/clk/clk-fixed-rate.c          |  44 +++++++--
 drivers/clk/clk-fractional-divider.c  |  40 +++++++-
 drivers/clk/clk-gate.c                |  43 +++++++--
 drivers/clk/clk-gpio.c                |  52 ++++++++---
 drivers/clk/clk-mux.c                 |  57 ++++++++++--
 drivers/clk/clk.c                     | 170 +++++++++++++++++++++++++++++++++-
 drivers/clk/clkdev.c                  |  71 ++++++++++----
 drivers/clk/qcom/clk-regmap.c         |   5 +-
 drivers/clk/qcom/clk-regmap.h         |   3 +-
 drivers/clk/qcom/common.c             |  41 ++++----
 drivers/clk/qcom/gcc-msm8996.c        |   9 +-
 drivers/clk/qcom/mmcc-msm8996.c       |   9 +-
 drivers/mfd/intel_quark_i2c_gpio.c    |  26 ++----
 include/linux/clk-provider.h          |  92 ++++++++++++++++++
 include/linux/clkdev.h                |   8 +-
 19 files changed, 706 insertions(+), 142 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
