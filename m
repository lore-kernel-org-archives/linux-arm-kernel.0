From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 11 Aug 2015 12:46:22 +0900
Subject: [PATCH 2/4] clk: samsung: exynos3250: Add MMC2 clock
In-Reply-To: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
References: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1439264784-30322-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the MMC2 clocks (mux, divider, gate) of Exynos3250 SoC.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c   | 9 +++++++++
 include/dt-bindings/clock/exynos3250.h | 7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 2105863a3ace..2683cf03e656 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -303,6 +303,7 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
 
 	/* SRC_FSYS */
 	MUX(CLK_MOUT_TSADC, "mout_tsadc", group_sclk_p, SRC_FSYS, 28, 4),
+	MUX(CLK_MOUT_MMC2, "mout_mmc2", group_sclk_p, SRC_FSYS, 8, 4),
 	MUX(CLK_MOUT_MMC1, "mout_mmc1", group_sclk_p, SRC_FSYS, 4, 4),
 	MUX(CLK_MOUT_MMC0, "mout_mmc0", group_sclk_p, SRC_FSYS, 0, 4),
 
@@ -389,6 +390,11 @@ static struct samsung_div_clock div_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0),
 	DIV(CLK_DIV_MMC0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
 
+	/* DIV_FSYS2 */
+	DIV_F(CLK_DIV_MMC2_PRE, "div_mmc2_pre", "div_mmc2", DIV_FSYS2, 8, 8,
+		CLK_SET_RATE_PARENT, 0),
+	DIV(CLK_DIV_MMC2, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
+
 	/* DIV_PERIL0 */
 	DIV(CLK_DIV_UART2, "div_uart2", "mout_uart2", DIV_PERIL0, 8, 4),
 	DIV(CLK_DIV_UART1, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
@@ -539,6 +545,8 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
 		GATE_SCLK_FSYS, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_EBI, "sclk_ebi", "div_ebi",
 		GATE_SCLK_FSYS, 6, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_MMC2, "sclk_mmc2", "div_mmc2_pre",
+		GATE_SCLK_FSYS, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_MMC1, "sclk_mmc1", "div_mmc1_pre",
 		GATE_SCLK_FSYS, 1, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "div_mmc0_pre",
@@ -634,6 +642,7 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
 	GATE(CLK_USBOTG, "usbotg", "div_aclk_200", GATE_IP_FSYS, 13, 0, 0),
 	GATE(CLK_USBHOST, "usbhost", "div_aclk_200", GATE_IP_FSYS, 12, 0, 0),
 	GATE(CLK_SROMC, "sromc", "div_aclk_200", GATE_IP_FSYS, 11, 0, 0),
+	GATE(CLK_SDMMC2, "sdmmc2", "div_aclk_200", GATE_IP_FSYS, 7, 0, 0),
 	GATE(CLK_SDMMC1, "sdmmc1", "div_aclk_200", GATE_IP_FSYS, 6, 0, 0),
 	GATE(CLK_SDMMC0, "sdmmc0", "div_aclk_200", GATE_IP_FSYS, 5, 0, 0),
 	GATE(CLK_PDMA1, "pdma1", "div_aclk_200", GATE_IP_FSYS, 1, 0, 0),
diff --git a/include/dt-bindings/clock/exynos3250.h b/include/dt-bindings/clock/exynos3250.h
index 89a7d97b002c..fbc9ef61b191 100644
--- a/include/dt-bindings/clock/exynos3250.h
+++ b/include/dt-bindings/clock/exynos3250.h
@@ -79,6 +79,7 @@
 #define CLK_MOUT_APLL			59
 #define CLK_MOUT_ACLK_266_SUB		60
 #define CLK_MOUT_UART2			61
+#define CLK_MOUT_MMC2			62
 
 /* Dividers */
 #define CLK_DIV_GPL			64
@@ -128,6 +129,8 @@
 #define CLK_DIV_HPM			108
 #define CLK_DIV_COPY			109
 #define CLK_DIV_UART2			110
+#define CLK_DIV_MMC2_PRE		111
+#define CLK_DIV_MMC2			112
 
 /* Gates */
 #define CLK_ASYNC_G3D			128
@@ -225,6 +228,7 @@
 #define CLK_BLOCK_CAM			220
 #define CLK_SMIES			221
 #define CLK_UART2			222
+#define CLK_SDMMC2			223
 
 /* Special clocks */
 #define CLK_SCLK_JPEG			224
@@ -252,12 +256,13 @@
 #define CLK_SCLK_UART1			246
 #define CLK_SCLK_UART0			247
 #define CLK_SCLK_UART2			248
+#define CLK_SCLK_MMC2			249
 
 /*
  * Total number of clocks of main CMU.
  * NOTE: Must be equal to last clock ID increased by one.
  */
-#define CLK_NR_CLKS			249
+#define CLK_NR_CLKS			250
 
 /*
  * CMU DMC
-- 
1.8.5.5
