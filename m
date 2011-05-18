From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 18 May 2011 16:27:41 +0530
Subject: [PATCH] OMAP4: clock: Add CPU local timer clock node.
Message-ID: <mailman.243.1305718380.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Local timer clock is sourced from the CPU clock and hence changes
along with CPU clock. These per CPU local timers are used as
clock-events, so they need to be reconfigured on CPU frequency
as part of CPUfreq governor.

Newly introduced clockevents_reconfigure() needs to know the
TWD clock-rate. Provide a clock-node to make clk_get_rate() work
for TWD.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..5477f4b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3010,6 +3010,14 @@ static struct clk auxclkreq5_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk smp_twd = {
+	.name		= "smp_twd",
+	.parent		= &dpll_mpu_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
 /*
  * clkdev
  */
@@ -3283,6 +3291,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
+	CLK(NULL,	"smp_twd",		&smp_twd,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.6.0.4


--------------060809020102030908080805--
