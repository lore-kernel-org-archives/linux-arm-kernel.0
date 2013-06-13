From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:01:00 +0900
Subject: [PATCH 10/11] ARM: shmobile: r8a73a4: add clock definitions and
 aliases for MMCIF and SDHI
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add MSTP clock definitions and fix aliases for the two MMCIF and three SDHI
interfaces on r8a73a4 (APE6).

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index f6227bb..5f7fe62 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -29,6 +29,7 @@
 #define CPG_LEN 0x270
 
 #define SMSTPCR2 0xe6150138
+#define SMSTPCR3 0xe615013c
 #define SMSTPCR5 0xe6150144
 
 #define FRQCRA		0xE6150000
@@ -348,6 +349,7 @@ static struct clk div6_clks[DIV6_NR] = {
 /* MSTP */
 enum {
 	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
+	MSTP315, MSTP314, MSTP313, MSTP312, MSTP305,
 	MSTP522,
 	MSTP_NR
 };
@@ -359,6 +361,11 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP207] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 7, 0), /* SCIFB1 */
 	[MSTP216] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 16, 0), /* SCIFB2 */
 	[MSTP217] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 17, 0), /* SCIFB3 */
+	[MSTP305] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC1],SMSTPCR3, 5, 0), /* MMCIF1 */
+	[MSTP312] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI2],SMSTPCR3, 12, 0), /* SDHI2 */
+	[MSTP313] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI1],SMSTPCR3, 13, 0), /* SDHI1 */
+	[MSTP314] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI0],SMSTPCR3, 14, 0), /* SDHI0 */
+	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0],SMSTPCR3, 15, 0), /* MMCIF0 */
 	[MSTP522] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR5, 22, 0), /* Thermal */
 };
 
@@ -381,11 +388,6 @@ static struct clk_lookup lookups[] = {
 
 	/* DIV6 */
 	CLKDEV_CON_ID("zb",			&div6_clks[DIV6_ZB]),
-	CLKDEV_CON_ID("sdhi0",			&div6_clks[DIV6_SDHI0]),
-	CLKDEV_CON_ID("sdhi1",			&div6_clks[DIV6_SDHI1]),
-	CLKDEV_CON_ID("sdhi2",			&div6_clks[DIV6_SDHI2]),
-	CLKDEV_CON_ID("mmc0",			&div6_clks[DIV6_MMC0]),
-	CLKDEV_CON_ID("mmc1",			&div6_clks[DIV6_MMC1]),
 	CLKDEV_CON_ID("vck1",			&div6_clks[DIV6_VCK1]),
 	CLKDEV_CON_ID("vck2",			&div6_clks[DIV6_VCK2]),
 	CLKDEV_CON_ID("vck3",			&div6_clks[DIV6_VCK3]),
@@ -406,6 +408,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
+	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
+	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
 
 	/* for DT */
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
-- 
1.8.2.1
