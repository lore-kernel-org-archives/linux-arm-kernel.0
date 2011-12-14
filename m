From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:31:26 -0800
Subject: [PATCH 4/6] HACK: cpufreq: omap: change mpu_clk's rate
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Message-ID: <1323837088-2469-5-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a proof of concept, change OMAP's cpufreq driver to use mpu_clk in
place of directly using the DPLL.  This better reflects reality as there
are some functional clks between the ARM IP and the PLL.

To make this work mpu_clk uses the new .round_rate function
omap2_passthrough_round_rate, which simplies passing up a rate change
request to the parent.

Not for merging, just to get discussion going around the common clk
patches and future OMAP adaptations.

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5d04c57..45cb7f9 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -247,7 +247,7 @@ static int __init omap_cpufreq_init(void)
 	else if (cpu_is_omap34xx())
 		mpu_clk_name = "dpll1_ck";
 	else if (cpu_is_omap44xx())
-		mpu_clk_name = "dpll_mpu_ck";
+		mpu_clk_name = "mpu_clk";
 
 	if (!mpu_clk_name) {
 		pr_err("%s: unsupported Silicon?\n", __func__);
-- 
1.7.5.4
