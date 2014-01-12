From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 11:48:40 +0100
Subject: [PATCH V3 2/5] ARM: shmobile: r7s72100: Add RSPI clocks
In-Reply-To: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
References: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389523723-2288-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - Correct platform device names ("rspi%u" -> "rspi.%u")
V3:
  - No changes

 arch/arm/mach-shmobile/clock-r7s72100.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 0242ca5f499a..6ae341ca713c 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -22,13 +22,15 @@
 #include <mach/common.h>
 #include <mach/r7s72100.h>
 
-/* registers */
+/* Frequency Control Registers */
 #define FRQCR		0xfcfe0010
 #define FRQCR2		0xfcfe0014
+/* Standby Control Registers */
 #define STBCR3		0xfcfe0420
 #define STBCR4		0xfcfe0424
 #define STBCR7		0xfcfe0430
 #define STBCR9		0xfcfe0438
+#define STBCR10		0xfcfe043c
 
 #define PLL_RATE 30
 
@@ -146,12 +148,20 @@ struct clk div4_clks[DIV4_NR] = {
 					| CLK_ENABLE_ON_INIT),
 };
 
-enum {	MSTP97, MSTP96, MSTP95, MSTP94,
+enum {
+	MSTP107, MSTP106, MSTP105, MSTP104, MSTP103,
+	MSTP97, MSTP96, MSTP95, MSTP94,
 	MSTP74,
 	MSTP47, MSTP46, MSTP45, MSTP44, MSTP43, MSTP42, MSTP41, MSTP40,
-	MSTP33,	MSTP_NR };
+	MSTP33,	MSTP_NR
+};
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP107] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 7, 0), /* RSPI0 */
+	[MSTP106] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 6, 0), /* RSPI1 */
+	[MSTP105] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 5, 0), /* RSPI2 */
+	[MSTP104] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 4, 0), /* RSPI3 */
+	[MSTP103] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 3, 0), /* RSPI4 */
 	[MSTP97] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 7, 0), /* RIIC0 */
 	[MSTP96] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 6, 0), /* RIIC1 */
 	[MSTP95] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 5, 0), /* RIIC2 */
@@ -179,6 +189,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_DEV_ID("rspi.0", &mstp_clks[MSTP107]),
+	CLKDEV_DEV_ID("rspi.1", &mstp_clks[MSTP106]),
+	CLKDEV_DEV_ID("rspi.2", &mstp_clks[MSTP105]),
+	CLKDEV_DEV_ID("rspi.3", &mstp_clks[MSTP104]),
+	CLKDEV_DEV_ID("rspi.4", &mstp_clks[MSTP103]),
 	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
 	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
 	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
-- 
1.7.9.5
