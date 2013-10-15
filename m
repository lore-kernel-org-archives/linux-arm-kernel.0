From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:17 +0200
Subject: [PATCH 3/7] clk: samsung: exynos5250: Fix parents of gate clocks from
 GSCL domain
In-Reply-To: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
References: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381858881-25611-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mout_aclk266_gscl_sub mux clock and adjusts definitions
of GSCL domain gate clocks to use it as their parent, as specified in
SoC documentation.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index ce33a3f..f91e77d 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -36,6 +36,7 @@
 #define GPLL_CON0		0x10150
 #define SRC_TOP0		0x10210
 #define SRC_TOP2		0x10218
+#define SRC_TOP3		0x1021c
 #define SRC_GSCL		0x10220
 #define SRC_DISP1_0		0x1022c
 #define SRC_MAU			0x10240
@@ -138,6 +139,7 @@ static unsigned long exynos5250_clk_regs[] __initdata = {
 	SRC_CORE1,
 	SRC_TOP0,
 	SRC_TOP2,
+	SRC_TOP3,
 	SRC_GSCL,
 	SRC_DISP1_0,
 	SRC_MAU,
@@ -194,6 +196,7 @@ PNAME(mout_mpll_user_p)	= { "fin_pll", "mout_mpll" };
 PNAME(mout_bpll_user_p)	= { "fin_pll", "mout_bpll" };
 PNAME(mout_aclk166_p)	= { "mout_cpll", "mout_mpll_user" };
 PNAME(mout_aclk200_p)	= { "mout_mpll_user", "mout_bpll_user" };
+PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
@@ -269,6 +272,8 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "mout_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
 	MUX(none, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
 
+	MUX(none, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8, 1),
+
 	MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
 	MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
 	MUX(none, "mout_cam1", mout_group1_p, SRC_GSCL, 20, 4),
@@ -480,16 +485,20 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(sclk_spi2, "sclk_spi2", "div_spi_pre2",
 			SRC_MASK_PERIC1, 24, CLK_SET_RATE_PARENT, 0),
 
-	GATE(gscl0, "gscl0", "none", GATE_IP_GSCL, 0, 0, 0),
-	GATE(gscl1, "gscl1", "none", GATE_IP_GSCL, 1, 0, 0),
-	GATE(gscl2, "gscl2", "div_aclk266", GATE_IP_GSCL, 2, 0, 0),
-	GATE(gscl3, "gscl3", "div_aclk266", GATE_IP_GSCL, 3, 0, 0),
+	GATE(gscl0, "gscl0", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 0, 0, 0),
+	GATE(gscl1, "gscl1", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 1, 0, 0),
+	GATE(gscl2, "gscl2", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 2, 0, 0),
+	GATE(gscl3, "gscl3", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 3, 0, 0),
 	GATE(gscl_wa, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
 	GATE(gscl_wb, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
-	GATE(smmu_gscl0, "smmu_gscl0", "div_aclk266", GATE_IP_GSCL, 7, 0, 0),
-	GATE(smmu_gscl1, "smmu_gscl1", "div_aclk266", GATE_IP_GSCL, 8, 0, 0),
-	GATE(smmu_gscl2, "smmu_gscl2", "div_aclk266", GATE_IP_GSCL, 9, 0, 0),
-	GATE(smmu_gscl3, "smmu_gscl3", "div_aclk266", GATE_IP_GSCL, 10, 0, 0),
+	GATE(smmu_gscl0, "smmu_gscl0", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 7, 0, 0),
+	GATE(smmu_gscl1, "smmu_gscl1", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 8, 0, 0),
+	GATE(smmu_gscl2, "smmu_gscl2", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 9, 0, 0),
+	GATE(smmu_gscl3, "smmu_gscl3", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 10, 0, 0),
 
 	GATE(fimd1, "fimd1", "div_aclk200", GATE_IP_DISP1, 0, 0, 0),
 	GATE(mie1, "mie1", "div_aclk200", GATE_IP_DISP1, 1, 0, 0),
-- 
1.8.3.2
