From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 17 Oct 2014 21:41:52 +0530
Subject: [PATCH 4/7] clk: samsung: exynos7: add gate clocks for WDT,
 TMU and PWM blocks
In-Reply-To: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
References: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1413562315-12283-5-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Add clock support for the watchdog timer, pwm timer and thermal
management unit IPs in Exynos7.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c       |   14 ++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h |    9 +++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index 3a30f43..17e5cf4 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -486,9 +486,12 @@ static struct samsung_gate_clock peric0_gate_clks[] __initdata = {
 		ENABLE_PCLK_PERIC0, 14, 0, 0),
 	GATE(PCLK_UART0, "pclk_uart0", "mout_aclk_peric0_66_user",
 		ENABLE_PCLK_PERIC0, 16, 0, 0),
+	GATE(PCLK_PWM, "pclk_pwm", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 21, 0, 0),
 
 	GATE(SCLK_UART0, "sclk_uart0_user", "mout_sclk_uart0_user",
 		ENABLE_SCLK_PERIC0, 16, 0, 0),
+	GATE(SCLK_PWM, "sclk_pwm", "fin_pll", ENABLE_SCLK_PERIC0, 21, 0, 0),
 };
 
 static struct samsung_cmu_info peric0_cmu_info __initdata = {
@@ -586,7 +589,9 @@ CLK_OF_DECLARE(exynos7_clk_peric1, "samsung,exynos7-clock-peric1",
 
 /* Register Offset definitions for CMU_PERIS (0x10040000) */
 #define MUX_SEL_PERIS			0x0200
+#define ENABLE_PCLK_PERIS		0x0900
 #define ENABLE_PCLK_PERIS_SECURE_CHIPID	0x0910
+#define ENABLE_SCLK_PERIS		0x0A00
 #define ENABLE_SCLK_PERIS_SECURE_CHIPID	0x0A10
 
 /* List of parent clocks for Muxes in CMU_PERIS */
@@ -594,7 +599,9 @@ PNAME(mout_aclk_peris_66_p) = { "fin_pll", "dout_aclk_peris_66" };
 
 static unsigned long peris_clk_regs[] __initdata = {
 	MUX_SEL_PERIS,
+	ENABLE_PCLK_PERIS,
 	ENABLE_PCLK_PERIS_SECURE_CHIPID,
+	ENABLE_SCLK_PERIS,
 	ENABLE_SCLK_PERIS_SECURE_CHIPID,
 };
 
@@ -604,10 +611,17 @@ static struct samsung_mux_clock peris_mux_clks[] __initdata = {
 };
 
 static struct samsung_gate_clock peris_gate_clks[] __initdata = {
+	GATE(PCLK_WDT, "pclk_wdt", "mout_aclk_peris_66_user",
+		ENABLE_PCLK_PERIS, 6, 0, 0),
+	GATE(PCLK_TMU, "pclk_tmu_apbif", "mout_aclk_peris_66_user",
+		ENABLE_PCLK_PERIS, 10, 0, 0),
+
 	GATE(PCLK_CHIPID, "pclk_chipid", "mout_aclk_peris_66_user",
 		ENABLE_PCLK_PERIS_SECURE_CHIPID, 0, 0, 0),
 	GATE(SCLK_CHIPID, "sclk_chipid", "fin_pll",
 		ENABLE_SCLK_PERIS_SECURE_CHIPID, 0, 0, 0),
+
+	GATE(SCLK_TMU, "sclk_tmu", "fin_pll", ENABLE_SCLK_PERIS, 10, 0, 0),
 };
 
 static struct samsung_cmu_info peris_cmu_info __initdata = {
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 3227679..28c8aa7 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -53,7 +53,9 @@
 #define PCLK_HSI2C9			7
 #define PCLK_HSI2C10			8
 #define PCLK_HSI2C11			9
-#define PERIC0_NR_CLK			10
+#define PCLK_PWM			10
+#define SCLK_PWM			11
+#define PERIC0_NR_CLK			12
 
 /* PERIC1 */
 #define PCLK_UART1			1
@@ -72,7 +74,10 @@
 /* PERIS */
 #define PCLK_CHIPID			1
 #define SCLK_CHIPID			2
-#define PERIS_NR_CLK			3
+#define PCLK_WDT			3
+#define PCLK_TMU			4
+#define SCLK_TMU			5
+#define PERIS_NR_CLK			6
 
 /* FSYS0 */
 #define ACLK_MMC2			1
-- 
1.7.9.5
