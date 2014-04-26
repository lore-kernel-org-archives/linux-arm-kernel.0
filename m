From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun, 27 Apr 2014 02:08:41 +0530
Subject: [PATCH RFC 1/8] clk: exynos5250: add aliases for clocks used by
 devfreq
In-Reply-To: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
References: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398544728-2075-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

Devfreq does not support DT-based lookup of these peripheral clocks,
so add aliases for them.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index d1d16cf..f44fb2e 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -37,6 +37,7 @@
 #define VPLL_CON0		0x10140
 #define GPLL_CON0		0x10150
 #define SRC_TOP0		0x10210
+#define SRC_TOP1		0x10214
 #define SRC_TOP2		0x10218
 #define SRC_TOP3		0x1021c
 #define SRC_GSCL		0x10220
@@ -100,6 +101,7 @@ static unsigned long exynos5250_clk_regs[] __initdata = {
 	DIV_CPU0,
 	SRC_CORE1,
 	SRC_TOP0,
+	SRC_TOP1,
 	SRC_TOP2,
 	SRC_TOP3,
 	SRC_GSCL,
@@ -196,6 +198,11 @@ PNAME(mout_aclk200_p)	= { "mout_mpll_user", "mout_bpll_user" };
 PNAME(mout_aclk200_sub_p) = { "fin_pll", "div_aclk200" };
 PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
 PNAME(mout_aclk333_sub_p) = { "fin_pll", "div_aclk333" };
+PNAME(mout_aclk300_disp1_p) = { "mout_aclk300_disp1_mid",
+				"mout_aclk300_disp1_mid1" };
+PNAME(mout_aclk300_gscl_p) = { "mout_aclk300_gscl_mid",
+				"mout_aclk300_gscl_mid1" };
+PNAME(mout_aclk300_gscl_mid1_p) = { "mout_vpll", "mout_cpll" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
@@ -273,6 +280,15 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
 	MUX(0, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
 	MUX(0, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
+	MUX(0, "mout_aclk300_disp1_mid", mout_aclk200_p, SRC_TOP0, 14, 1),
+	MUX(0, "mout_aclk300_disp1", mout_aclk300_disp1_p, SRC_TOP0, 15, 1),
+	MUX(0, "mout_aclk300_gscl", mout_aclk300_gscl_p, SRC_TOP0, 25, 2),
+	MUX(0, "mout_aclk300_gscl_mid", mout_aclk200_p, SRC_TOP0, 24, 1),
+
+	MUX(0, "mout_aclk300_disp1_mid1", mout_aclk300_gscl_mid1_p,
+					SRC_TOP1, 8, 1),
+	MUX(0, "mout_aclk300_gscl_mid1", mout_aclk300_gscl_mid1_p,
+					SRC_TOP1, 12, 1),
 
 	MUX(0, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
 	MUX(0, "mout_epll", mout_epll_p, SRC_TOP2, 12, 1),
@@ -347,11 +363,15 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	 * CMU_TOP
 	 */
 	DIV(0, "div_aclk66", "div_aclk66_pre", DIV_TOP0, 0, 3),
-	DIV(0, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
-	DIV(0, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
-	DIV(0, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3),
-	DIV(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
-
+	DIV_A(0, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3, "aclk166_d"),
+	DIV_A(0, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3, "aclk200_d"),
+	DIV_A(0, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3, "aclk266_d"),
+	DIV_A(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3, "aclk333_d"),
+	DIV_A(0, "div_aclk300_disp1", "mout_aclk300_disp1",
+					DIV_TOP0, 28, 3, "aclk300_disp1_d"),
+
+	DIV_A(0, "div_aclk300_gscl", "mout_aclk300_gscl",
+					DIV_TOP1, 12, 3, "aclk300_gscl_d"),
 	DIV(0, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
 
 	DIV(0, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
-- 
1.8.3.2
