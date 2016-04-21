From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:21:51 -0700
Subject: [PATCH v2 00/13] clk_hw based clkdev/DT providers
Message-ID: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
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

The first patch is a cleanup to the clkdev APIs that I found
while doing this work. I'd like to take that into clk-next
with Russell's ack.

Cc: Russell King <linux@arm.linux.org.uk>

Stephen Boyd (13):
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
 drivers/clk/clk-fixed-factor.c        |  42 +++++++--
 drivers/clk/clk-fixed-rate.c          |  44 +++++++--
 drivers/clk/clk-fractional-divider.c  |  40 +++++++-
 drivers/clk/clk-gate.c                |  43 +++++++--
 drivers/clk/clk-gpio.c                |  52 ++++++++---
 drivers/clk/clk-mux.c                 |  57 ++++++++++--
 drivers/clk/clk.c                     | 171 +++++++++++++++++++++++++++++++++-
 drivers/clk/clkdev.c                  |  75 +++++++++++----
 drivers/clk/qcom/clk-regmap.c         |   5 +-
 drivers/clk/qcom/clk-regmap.h         |   3 +-
 drivers/clk/qcom/common.c             |  58 ++++++------
 drivers/clk/qcom/gcc-msm8996.c        |   9 +-
 drivers/clk/qcom/mmcc-msm8996.c       |   9 +-
 include/linux/clk-provider.h          |  93 ++++++++++++++++++
 include/linux/clkdev.h                |   7 +-
 18 files changed, 716 insertions(+), 129 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
