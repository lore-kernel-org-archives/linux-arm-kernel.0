From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 14 Feb 2017 13:01:14 -0800
Subject: [PATCH] clk: rockchip: Set "ignore unused" for PMU M0 clocks on rk3399
Message-ID: <20170214210114.5846-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMU Cortex M0 on rk3399 is intended to be used for things like
DDRFreq transitions, suspend/resume, and other things that are the
purview of ARM Trusted Firmware and not the kernel.  As such, the
kernel shouldn't be messing with the clocks.  Add CLK_IGNORE_UNUSED to
these clocks.

Without this change, the following was observed on a Chromebook with a
rk3399 (using not-yet-upstream ARM Trusted Firmware code and
not-yet-upstream kernel code based on kernel-4.4):

1. We init the clock framework.

2. We start up "DDRFreq", which causes ATF to occasionally fire up the
   M0 for transitions.  Each time ATF fires up the M0 it will turn on
   these clocks and each time it is done it will turn them off.

3. We finally get to the the part of the kernel that calls
   clk_disable_unused() and we disables the clocks.

You can see the race above.  Basically everything is fine as long as
ARM Trusted Firmware isn't starting up the M0 at exactly the same time
that the kernel is disabling unused clocks.  ...but if the race
happens then we go boom.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/clk/rockchip/clk-rk3399.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 73121b144634..fa3cbef08776 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1477,10 +1477,10 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 	GATE(PCLK_UART4_PMU, "pclk_uart4_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 14, GFLAGS),
 	GATE(PCLK_WDT_M0_PMU, "pclk_wdt_m0_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 15, GFLAGS),
 
-	GATE(FCLK_CM0S_PMU, "fclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0, RK3399_PMU_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(SCLK_CM0S_PMU, "sclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0, RK3399_PMU_CLKGATE_CON(2), 1, GFLAGS),
-	GATE(HCLK_CM0S_PMU, "hclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0, RK3399_PMU_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(DCLK_CM0S_PMU, "dclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0, RK3399_PMU_CLKGATE_CON(2), 3, GFLAGS),
+	GATE(FCLK_CM0S_PMU, "fclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 0, GFLAGS),
+	GATE(SCLK_CM0S_PMU, "sclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 1, GFLAGS),
+	GATE(HCLK_CM0S_PMU, "hclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 2, GFLAGS),
+	GATE(DCLK_CM0S_PMU, "dclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 3, GFLAGS),
 	GATE(HCLK_NOC_PMU, "hclk_noc_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 5, GFLAGS),
 };
 
-- 
2.11.0.483.g087da7b7c-goog
