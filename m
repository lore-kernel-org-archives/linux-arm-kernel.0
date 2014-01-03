From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri,  3 Jan 2014 16:34:15 +0100
Subject: [PATCH 2/3] ARM: shmobile: r8a7791: add QSPI clock
In-Reply-To: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388763256-25851-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/clock-r8a7791.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index f5461262ee25..740c06968994 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -93,6 +93,7 @@ static struct clk main_clk = {
  */
 SH_FIXED_RATIO_CLK_SET(pll1_clk,		main_clk,	1, 1);
 SH_FIXED_RATIO_CLK_SET(pll3_clk,		main_clk,	1, 1);
+SH_FIXED_RATIO_CLK_SET(qspi_clk,		pll1_clk,	1, 1);
 
 /* fixed ratio clock */
 SH_FIXED_RATIO_CLK_SET(extal_div2_clk,		extal_clk,	1, 2);
@@ -114,6 +115,7 @@ static struct clk *main_clks[] = {
 	&pll3_clk,
 	&hp_clk,
 	&p_clk,
+	&qspi_clk,
 	&rclk_clk,
 	&mp_clk,
 	&cp_clk,
@@ -122,6 +124,7 @@ static struct clk *main_clks[] = {
 
 /* MSTP */
 enum {
+	MSTP917,
 	MSTP813,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
@@ -133,6 +136,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP724] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 24, 0), /* DU0 */
@@ -167,6 +171,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pll3",		&pll3_clk),
 	CLKDEV_CON_ID("hp",		&hp_clk),
 	CLKDEV_CON_ID("p",		&p_clk),
+	CLKDEV_CON_ID("qspi",		&qspi_clk),
 	CLKDEV_CON_ID("rclk",		&rclk_clk),
 	CLKDEV_CON_ID("mp",		&mp_clk),
 	CLKDEV_CON_ID("cp",		&cp_clk),
@@ -192,6 +197,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
+	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("r8a7791-ether", &mstp_clks[MSTP813]), /* Ether */
@@ -232,6 +238,11 @@ void __init r8a7791_clock_init(void)
 		break;
 	}
 
+	if ((mode & (MD(3) | MD(2) | MD(1))) == MD(2))
+		SH_CLK_SET_RATIO(&qspi_clk_ratio, 1, 16);
+	else
+		SH_CLK_SET_RATIO(&qspi_clk_ratio, 1, 20);
+
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
-- 
1.7.9.5
