From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 28 Apr 2017 15:02:45 +0800
Subject: [PATCH v2 1/3] clk: rockchip: fix up the RK3228 clk cpu setting table
In-Reply-To: <1493362967-4040-1-git-send-email-zhangqing@rock-chips.com>
References: <1493362967-4040-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1493362967-4040-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support more cpu freq, and add armcore div setting.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3228.c | 50 ++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index db6e5a9e6de6..a6cdf8fc1e75 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -86,25 +86,43 @@ enum rk3228_plls {
 #define RK3228_DIV_PCLK_MASK		0x7
 #define RK3228_DIV_PCLK_SHIFT		12
 
-#define RK3228_CLKSEL1(_core_peri_div)					\
-	{									\
-		.reg = RK2928_CLKSEL_CON(1),					\
-		.val = HIWORD_UPDATE(_core_peri_div, RK3228_DIV_PERI_MASK,	\
-				RK3228_DIV_PERI_SHIFT)				\
-	}
+#define RK3228_CLKSEL1(_core_aclk_div, _core_peri_div)			\
+{									\
+	.reg = RK2928_CLKSEL_CON(1),					\
+	.val = HIWORD_UPDATE(_core_peri_div, RK3228_DIV_PERI_MASK,	\
+			     RK3228_DIV_PERI_SHIFT) |			\
+	       HIWORD_UPDATE(_core_aclk_div, RK3228_DIV_ACLK_MASK,	\
+			     RK3228_DIV_ACLK_SHIFT),			\
+}
 
-#define RK3228_CPUCLK_RATE(_prate, _core_peri_div)			\
-	{								\
-		.prate = _prate,					\
-		.divs = {						\
-			RK3228_CLKSEL1(_core_peri_div),		\
-		},							\
-	}
+#define RK3228_CPUCLK_RATE(_prate, _core_aclk_div, _core_peri_div)	\
+{									\
+	.prate = _prate,						\
+	.divs = {							\
+		RK3228_CLKSEL1(_core_aclk_div, _core_peri_div),		\
+	},								\
+}
 
 static struct rockchip_cpuclk_rate_table rk3228_cpuclk_rates[] __initdata = {
-	RK3228_CPUCLK_RATE(816000000, 4),
-	RK3228_CPUCLK_RATE(600000000, 4),
-	RK3228_CPUCLK_RATE(312000000, 4),
+	RK3228_CPUCLK_RATE(1800000000, 1, 7),
+	RK3228_CPUCLK_RATE(1704000000, 1, 7),
+	RK3228_CPUCLK_RATE(1608000000, 1, 7),
+	RK3228_CPUCLK_RATE(1512000000, 1, 7),
+	RK3228_CPUCLK_RATE(1488000000, 1, 5),
+	RK3228_CPUCLK_RATE(1416000000, 1, 5),
+	RK3228_CPUCLK_RATE(1392000000, 1, 5),
+	RK3228_CPUCLK_RATE(1296000000, 1, 5),
+	RK3228_CPUCLK_RATE(1200000000, 1, 5),
+	RK3228_CPUCLK_RATE(1104000000, 1, 5),
+	RK3228_CPUCLK_RATE(1008000000, 1, 5),
+	RK3228_CPUCLK_RATE(912000000, 1, 5),
+	RK3228_CPUCLK_RATE(816000000, 1, 3),
+	RK3228_CPUCLK_RATE(696000000, 1, 3),
+	RK3228_CPUCLK_RATE(600000000, 1, 3),
+	RK3228_CPUCLK_RATE(408000000, 1, 1),
+	RK3228_CPUCLK_RATE(312000000, 1, 1),
+	RK3228_CPUCLK_RATE(216000000,  1, 1),
+	RK3228_CPUCLK_RATE(96000000, 1, 1),
 };
 
 static const struct rockchip_cpuclk_reg_data rk3228_cpuclk_data = {
-- 
1.9.1
