From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 22 May 2017 12:52:26 +0800
Subject: [PATCH v3 0/2] Hi3660: enable sp804 timer
Message-ID: <1495428748-11153-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to enable sp804 timer on Hi3660 for Hikey960 platform.

On Hi3660, the sp804 timer co-exists with CPUs' architecture timer; but
sp804 timer is located in SoC level but CPU's architecture timer is in
CPU power domain. sp804 timer is used as broadcast timer when CPU enters
idle states and the CPU (includes architecture timer) power domain is
powered off. So sp804 timer enabling is prerequisite before we enable
CPUIdle on Hi3660.

This patch set is to enable sp804 timer, the first patch is to adjust
subset of crgctrl clock regiseration to CLK_OF_DECLARE_DRIVER method
so ensure timer clock is avaiable when timer probing. The second patch
is to add description for timer in dts. Have rebased this patch set on
Guodong's dts patch set [1] and verified this patch set on Hikey960.

[1] http://archive.armlinux.org.uk/lurker/message/20170517.083733.8207a50e.en.html

Changes from v2:
* According to Stephen's suggestion, only changed necessary clocks
  of fixed_rate_clks to CLK_OF_DECLARE_DRIVER method.

Changes from v1:
* Follow Steven's suggestion on IRC, Change to only use
  CLK_OF_DECLARE_DRIVER for crgctrl clock.

Leo Yan (2):
  clk: Hi3660: register fixed_rate_clks with CLK_OF_DECLARE_DRIVER
  arm64: dts: add sp804 timer node for Hi3660

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 11 +++++++
 drivers/clk/hisilicon/clk-hi3660.c        | 48 ++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 10 deletions(-)

-- 
1.9.1
