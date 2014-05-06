From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:48 +0530
Subject: [PATCH v4 13/15] clk: exynos5420: update clocks for MAU Block
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-14-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing MAU block specific clocks.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   14 +++++++++++++-
 include/dt-bindings/clock/exynos5420.h |    2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index ba7273a..e0e749d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -62,7 +62,9 @@
 #define SRC_TOP11		0x10284
 #define SRC_TOP12		0x10288
 #define SRC_MASK_TOP2		0x10308
+#define SRC_MASK_TOP7		0x1031c
 #define SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_MAU		0x10334
 #define SRC_MASK_FSYS		0x10340
 #define SRC_MASK_PERIC0		0x10350
 #define SRC_MASK_PERIC1		0x10354
@@ -155,6 +157,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	SRC_TOP11,
 	SRC_TOP12,
 	SRC_MASK_TOP2,
+	SRC_MASK_TOP7,
 	SRC_MASK_DISP10,
 	SRC_MASK_FSYS,
 	SRC_MASK_PERIC0,
@@ -351,6 +354,8 @@ PNAME(mout_hdmi_p) = {"dout_hdmi_pixel", "sclk_hdmiphy"};
 PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
 			 "mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
 			 "mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_mau_epll_clk_p) = {"mout_sclk_epll", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
@@ -373,6 +378,9 @@ static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initda
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
 	MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
+	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p,
+			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
+
 	MUX(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
 	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
 	MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
@@ -520,7 +528,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			TOP_SPARE2, 8, 1, CLK_SET_RATE_PARENT, 0),
 
 	/* MAU Block */
-	MUX(0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
+	MUX_F(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
+						CLK_SET_RATE_PARENT, 0),
 
 	/* FSYS Block */
 	MUX(0, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
@@ -713,6 +722,9 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_ACLK300_DISP1, "aclk300_disp1", "mout_user_aclk300_disp1",
 			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),
 
+	GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
+			SRC_MASK_TOP7, 20, CLK_IGNORE_UNUSED, 0),
+
 	/* sclk */
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
 		GATE_TOP_SCLK_PERIC, 0, CLK_SET_RATE_PARENT, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index f5459c1..4831267 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -58,6 +58,7 @@
 #define CLK_SCLK_GSCL_WA	156
 #define CLK_SCLK_GSCL_WB	157
 #define CLK_SCLK_HDMIPHY	158
+#define CLK_MAU_EPLL		159
 
 /* gate clocks */
 #define CLK_ACLK66_PERIC	256
@@ -197,6 +198,7 @@
 #define CLK_MOUT_HDMI		640
 #define CLK_MOUT_G3D		641
 #define CLK_MOUT_VPLL		642
+#define CLK_MOUT_MAUDIO0	643
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
-- 
1.7.9.5
