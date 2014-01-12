From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:00:31 +0100
Subject: [PATCH V2 2/4] ARM: shmobile: r8a7791: add QSPI clocks
In-Reply-To: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389524433-2823-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

The QSPI clock divider value depends on the MD1, MD2, and MD3 mode
switches.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - No changes

 arch/arm/mach-shmobile/clock-r8a7791.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index ca01dfe5f656..1185e5669a5e 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -101,6 +101,7 @@ static struct clk main_clk = {
  */
 SH_FIXED_RATIO_CLK_SET(pll1_clk,		main_clk,	1, 1);
 SH_FIXED_RATIO_CLK_SET(pll3_clk,		main_clk,	1, 1);
+SH_FIXED_RATIO_CLK_SET(qspi_clk,		pll1_clk,	1, 1);
 
 /* fixed ratio clock */
 SH_FIXED_RATIO_CLK_SET(extal_div2_clk,		extal_clk,	1, 2);
@@ -123,6 +124,7 @@ static struct clk *main_clks[] = {
 	&pll3_clk,
 	&hp_clk,
 	&p_clk,
+	&qspi_clk,
 	&rclk_clk,
 	&mp_clk,
 	&cp_clk,
@@ -133,6 +135,7 @@ static struct clk *main_clks[] = {
 /* MSTP */
 enum {
 	MSTP931, MSTP930, MSTP929, MSTP928, MSTP927, MSTP925,
+	MSTP917,
 	MSTP813,
 	MSTP811, MSTP810, MSTP809,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
@@ -151,6 +154,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
 	[MSTP927] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 27, MSTPSR9, 0), /* I2C4 */
 	[MSTP925] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 25, MSTPSR9, 0), /* I2C5 */
+	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
 	[MSTP813] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR8, 13, MSTPSR8, 0), /* Ether */
 	[MSTP811] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 11, MSTPSR8, 0), /* VIN0 */
 	[MSTP810] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 10, MSTPSR8, 0), /* VIN1 */
@@ -189,6 +193,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("zg",		&zg_clk),
 	CLKDEV_CON_ID("hp",		&hp_clk),
 	CLKDEV_CON_ID("p",		&p_clk),
+	CLKDEV_CON_ID("qspi",		&qspi_clk),
 	CLKDEV_CON_ID("rclk",		&rclk_clk),
 	CLKDEV_CON_ID("mp",		&mp_clk),
 	CLKDEV_CON_ID("cp",		&cp_clk),
@@ -214,6 +219,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
+	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
@@ -263,6 +269,11 @@ void __init r8a7791_clock_init(void)
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
