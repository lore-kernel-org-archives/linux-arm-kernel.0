From: andy.tang@nxp.com (Yuantian Tang)
Date: Thu, 6 Apr 2017 10:21:23 +0800
Subject: [PATCH 2/2] clk: qoriq: add pll clock to clock lookup table
In-Reply-To: <1491445283-13053-1-git-send-email-andy.tang@nxp.com>
References: <1491445283-13053-1-git-send-email-andy.tang@nxp.com>
Message-ID: <1491445283-13053-2-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register each PLL and its division clocks to clock
lookup table to facilitate the clock look up for
clock consumer.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/clk/clk-qoriq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 62cf32f..1bb691a 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/fsl/guts.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -1124,6 +1125,7 @@ static void __init create_one_pll(struct clockgen *cg, int idx)
 
 	for (i = 0; i < ARRAY_SIZE(pll->div); i++) {
 		struct clk *clk;
+		int ret;
 
 		snprintf(pll->div[i].name, sizeof(pll->div[i].name),
 			 "cg-pll%d-div%d", idx, i + 1);
@@ -1137,6 +1139,11 @@ static void __init create_one_pll(struct clockgen *cg, int idx)
 		}
 
 		pll->div[i].clk = clk;
+		ret = clk_register_clkdev(clk, pll->div[i].name, NULL);
+		if (ret != 0)
+			pr_err("%s: %s: register to lookup table failed %ld\n",
+			       __func__, pll->div[i].name, PTR_ERR(clk));
+
 	}
 }
 
-- 
2.1.0.27.g96db324
