From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Sep 2011 10:52:06 +0530
Subject: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Local timer clock is sourced from the CPU clock and hence changes
along with CPU clock. These per CPU local timers are used as
clock-events, so they need to be reconfigured on CPU frequency
change as part of CPUfreq governor.

Newly introduced clockevents_reconfigure() needs to know the
twd clock-rate. Provide a clock-node to make clk_get_rate() work
for TWD.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2af0e3f..8c981ab 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3091,6 +3091,14 @@ static struct clk auxclkreq5_ck = {
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
@@ -3363,6 +3371,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"smp_twd",			&smp_twd,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.4.1
