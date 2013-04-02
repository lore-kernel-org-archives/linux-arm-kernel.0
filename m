From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:16 +0900
Subject: [PATCH 20/30] ARM: shmobile: r8a7779: remove DIV4 clocks and use
 fixed ratio clock
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-21-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car H1 has many clocks, and it is possible to read/use clock ratio
of these clocks from FRQMRx as DIV4 clocks.
But, these ratio are fixed value and these are decided
by MD pin status.
This means that we can use fixed ratio clock via MD pin status,
instead of DIV4 clocks.

This patch reads MD pin status, and sets PLLA clock (= root clock),
and used fixed ratio clock for other clocks.
It was tesed on marzen board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |  196 ++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 87 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index d9edeaf..7d86bfb 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -17,13 +17,17 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 
+#define MD(nr)	BIT(nr)
+
 #define FRQMR		IOMEM(0xffc80014)
 #define MSTPCR0		IOMEM(0xffc80030)
 #define MSTPCR1		IOMEM(0xffc80034)
@@ -36,6 +40,9 @@
 #define MSTPCR6		IOMEM(0xffc80058)
 #define MSTPCR7		IOMEM(0xffc80040)
 
+#define MODEMR		0xffcc0020
+
+
 /* ioremap() through clock mapping mandatory to avoid
  * collision with ARM coherent DMA virtual memory range.
  */
@@ -50,40 +57,39 @@ static struct clk_mapping cpg_mapping = {
  * from the platform code.
  */
 static struct clk plla_clk = {
-	.rate		= 1500000000,
+	/* .rate will be updated on r8a7779_clock_init() */
 	.mapping	= &cpg_mapping,
 };
 
+/*
+ * clock ratio of these clock will be updated
+ * on r8a7779_clock_init()
+ */
+SH_FIXED_RATIO_CLK_SET(clkz_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clkzs_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clki_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clks_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clks1_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clks3_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clks4_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clkb_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clkout_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clkp_clk,	plla_clk, 1, 1);
+SH_FIXED_RATIO_CLK_SET(clkg_clk,	plla_clk, 1, 1);
+
 static struct clk *main_clks[] = {
 	&plla_clk,
-};
-
-static int divisors[] = { 0, 0, 0, 6, 8, 12, 16, 0, 24, 32, 36, 0, 0, 0, 0, 0 };
-
-static struct clk_div_mult_table div4_div_mult_table = {
-	.divisors = divisors,
-	.nr_divisors = ARRAY_SIZE(divisors),
-};
-
-static struct clk_div4_table div4_table = {
-	.div_mult_table = &div4_div_mult_table,
-};
-
-enum { DIV4_S, DIV4_OUT, DIV4_S4, DIV4_S3, DIV4_S1, DIV4_P, DIV4_NR };
-
-static struct clk div4_clks[DIV4_NR] = {
-	[DIV4_S]	= SH_CLK_DIV4(&plla_clk, FRQMR, 20,
-				      0x0018, CLK_ENABLE_ON_INIT),
-	[DIV4_OUT]	= SH_CLK_DIV4(&plla_clk, FRQMR, 16,
-				      0x0700, CLK_ENABLE_ON_INIT),
-	[DIV4_S4]	= SH_CLK_DIV4(&plla_clk, FRQMR, 12,
-				      0x0040, CLK_ENABLE_ON_INIT),
-	[DIV4_S3]	= SH_CLK_DIV4(&plla_clk, FRQMR, 8,
-				      0x0010, CLK_ENABLE_ON_INIT),
-	[DIV4_S1]	= SH_CLK_DIV4(&plla_clk, FRQMR, 4,
-				      0x0060, CLK_ENABLE_ON_INIT),
-	[DIV4_P]	= SH_CLK_DIV4(&plla_clk, FRQMR, 0,
-				      0x0300, CLK_ENABLE_ON_INIT),
+	&clkz_clk,
+	&clkzs_clk,
+	&clki_clk,
+	&clks_clk,
+	&clks1_clk,
+	&clks3_clk,
+	&clks4_clk,
+	&clkb_clk,
+	&clkout_clk,
+	&clkp_clk,
+	&clkg_clk,
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
@@ -96,52 +102,28 @@ enum { MSTP323, MSTP322, MSTP321, MSTP320,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
-	[MSTP323] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 23, 0), /* SDHI0 */
-	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
-	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
-	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
-	[MSTP115] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 15, 0), /* SATA */
-	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR1,  3, 0), /* DU */
-	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
-	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  0, 0), /* USB0/1 */
-	[MSTP030] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 30, 0), /* I2C0 */
-	[MSTP029] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 29, 0), /* I2C1 */
-	[MSTP028] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 28, 0), /* I2C2 */
-	[MSTP027] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 27, 0), /* I2C3 */
-	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0), /* SCIF0 */
-	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0), /* SCIF1 */
-	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0), /* SCIF2 */
-	[MSTP023] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 23, 0), /* SCIF3 */
-	[MSTP022] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 22, 0), /* SCIF4 */
-	[MSTP021] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 21, 0), /* SCIF5 */
-	[MSTP016] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 16, 0), /* TMU0 */
-	[MSTP015] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 15, 0), /* TMU1 */
-	[MSTP014] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 14, 0), /* TMU2 */
-	[MSTP007] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR0,  7, 0), /* HSPI */
-};
-
-static unsigned long mul4_recalc(struct clk *clk)
-{
-	return clk->parent->rate * 4;
-}
-
-static struct sh_clk_ops mul4_clk_ops = {
-	.recalc		= mul4_recalc,
-};
-
-struct clk clkz_clk = {
-	.ops		= &mul4_clk_ops,
-	.parent		= &div4_clks[DIV4_S],
-};
-
-struct clk clkzs_clk = {
-	/* clks x 4 / 4 = clks */
-	.parent		= &div4_clks[DIV4_S],
-};
-
-static struct clk *late_main_clks[] = {
-	&clkz_clk,
-	&clkzs_clk,
+	[MSTP323] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 23, 0), /* SDHI0 */
+	[MSTP322] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 22, 0), /* SDHI1 */
+	[MSTP321] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 21, 0), /* SDHI2 */
+	[MSTP320] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 20, 0), /* SDHI3 */
+	[MSTP115] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 15, 0), /* SATA */
+	[MSTP103] = SH_CLK_MSTP32(&clks_clk, MSTPCR1,  3, 0), /* DU */
+	[MSTP101] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  1, 0), /* USB2 */
+	[MSTP100] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  0, 0), /* USB0/1 */
+	[MSTP030] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 30, 0), /* I2C0 */
+	[MSTP029] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 29, 0), /* I2C1 */
+	[MSTP028] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 28, 0), /* I2C2 */
+	[MSTP027] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 27, 0), /* I2C3 */
+	[MSTP026] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 26, 0), /* SCIF0 */
+	[MSTP025] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 25, 0), /* SCIF1 */
+	[MSTP024] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 24, 0), /* SCIF2 */
+	[MSTP023] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 23, 0), /* SCIF3 */
+	[MSTP022] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 22, 0), /* SCIF4 */
+	[MSTP021] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 21, 0), /* SCIF5 */
+	[MSTP016] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 16, 0), /* TMU0 */
+	[MSTP015] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 15, 0), /* TMU1 */
+	[MSTP014] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 14, 0), /* TMU2 */
+	[MSTP007] = SH_CLK_MSTP32(&clks_clk, MSTPCR0,  7, 0), /* HSPI */
 };
 
 static struct clk_lookup lookups[] = {
@@ -151,12 +133,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("clkzs_clk", &clkzs_clk),
 
 	/* DIV4 clocks */
-	CLKDEV_CON_ID("shyway_clk",	&div4_clks[DIV4_S]),
-	CLKDEV_CON_ID("bus_clk",	&div4_clks[DIV4_OUT]),
-	CLKDEV_CON_ID("shyway4_clk",	&div4_clks[DIV4_S4]),
-	CLKDEV_CON_ID("shyway3_clk",	&div4_clks[DIV4_S3]),
-	CLKDEV_CON_ID("shyway1_clk",	&div4_clks[DIV4_S1]),
-	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
+	CLKDEV_CON_ID("shyway_clk",	&clks_clk),
+	CLKDEV_CON_ID("bus_clk",	&clkout_clk),
+	CLKDEV_CON_ID("shyway4_clk",	&clks4_clk),
+	CLKDEV_CON_ID("shyway3_clk",	&clks3_clk),
+	CLKDEV_CON_ID("shyway1_clk",	&clks1_clk),
+	CLKDEV_CON_ID("peripheral_clk",	&clkp_clk),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
@@ -190,20 +172,60 @@ static struct clk_lookup lookups[] = {
 
 void __init r8a7779_clock_init(void)
 {
+	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
+	u32 mode;
 	int k, ret = 0;
 
+	BUG_ON(!modemr);
+	mode = ioread32(modemr);
+	iounmap(modemr);
+
+	if (mode & MD(1)) {
+		plla_clk.rate = 1500000000;
+
+		SH_CLK_SET_RATIO(&clkz_clk_ratio,	2, 3);
+		SH_CLK_SET_RATIO(&clkzs_clk_ratio,	1, 6);
+		SH_CLK_SET_RATIO(&clki_clk_ratio,	1, 2);
+		SH_CLK_SET_RATIO(&clks_clk_ratio,	1, 6);
+		SH_CLK_SET_RATIO(&clks1_clk_ratio,	1, 12);
+		SH_CLK_SET_RATIO(&clks3_clk_ratio,	1, 8);
+		SH_CLK_SET_RATIO(&clks4_clk_ratio,	1, 16);
+		SH_CLK_SET_RATIO(&clkp_clk_ratio,	1, 24);
+		SH_CLK_SET_RATIO(&clkg_clk_ratio,	1, 24);
+		if (mode & MD(2)) {
+			SH_CLK_SET_RATIO(&clkb_clk_ratio,	1, 36);
+			SH_CLK_SET_RATIO(&clkout_clk_ratio,	1, 36);
+		} else {
+			SH_CLK_SET_RATIO(&clkb_clk_ratio,	1, 24);
+			SH_CLK_SET_RATIO(&clkout_clk_ratio,	1, 24);
+		}
+	} else {
+		plla_clk.rate = 1600000000;
+
+		SH_CLK_SET_RATIO(&clkz_clk_ratio,	1, 2);
+		SH_CLK_SET_RATIO(&clkzs_clk_ratio,	1, 8);
+		SH_CLK_SET_RATIO(&clki_clk_ratio,	1, 2);
+		SH_CLK_SET_RATIO(&clks_clk_ratio,	1, 8);
+		SH_CLK_SET_RATIO(&clks1_clk_ratio,	1, 16);
+		SH_CLK_SET_RATIO(&clks3_clk_ratio,	1, 8);
+		SH_CLK_SET_RATIO(&clks4_clk_ratio,	1, 16);
+		SH_CLK_SET_RATIO(&clkp_clk_ratio,	1, 32);
+		SH_CLK_SET_RATIO(&clkg_clk_ratio,	1, 24);
+		if (mode & MD(2)) {
+			SH_CLK_SET_RATIO(&clkb_clk_ratio,	1, 32);
+			SH_CLK_SET_RATIO(&clkout_clk_ratio,	1, 32);
+		} else {
+			SH_CLK_SET_RATIO(&clkb_clk_ratio,	1, 24);
+			SH_CLK_SET_RATIO(&clkout_clk_ratio,	1, 24);
+		}
+	}
+
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
 	if (!ret)
-		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
-
-	if (!ret)
 		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
-	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
-		ret = clk_register(late_main_clks[k]);
-
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	if (!ret)
-- 
1.7.10.4
