From: sw.youn@samsung.com (Seungwhan Youn)
Date: Tue, 12 Oct 2010 20:42:35 +0900
Subject: [PATCH v2 3/6] ARM: S5PV210: Add EPLL clock operations
In-Reply-To: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286883755-27755-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EPLL specific clock get_rate/set_rate operations
on S5PV210.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   77 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index f1ec5bb..fdfadac 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -1003,6 +1003,79 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_spdif,
 };
 
+static u32 epll_div[][6] = {
+	{  48000000, 0, 48, 3, 3, 0 },
+	{  96000000, 0, 48, 3, 2, 0 },
+	{ 144000000, 1, 72, 3, 2, 0 },
+	{ 192000000, 0, 48, 3, 1, 0 },
+	{ 288000000, 1, 72, 3, 1, 0 },
+	{  32750000, 1, 65, 3, 4, 35127 },
+	{  32768000, 1, 65, 3, 4, 35127 },
+	{  45158400, 0, 45, 3, 3, 10355 },
+	{  45000000, 0, 45, 3, 3, 10355 },
+	{  45158000, 0, 45, 3, 3, 10355 },
+	{  49125000, 0, 49, 3, 3, 9961 },
+	{  49152000, 0, 49, 3, 3, 9961 },
+	{  67737600, 1, 67, 3, 3, 48366 },
+	{  67738000, 1, 67, 3, 3, 48366 },
+	{  73800000, 1, 73, 3, 3, 47710 },
+	{  73728000, 1, 73, 3, 3, 47710 },
+	{  36000000, 1, 32, 3, 4, 0 },
+	{  60000000, 1, 60, 3, 3, 0 },
+	{  72000000, 1, 72, 3, 3, 0 },
+	{  80000000, 1, 80, 3, 3, 0 },
+	{  84000000, 0, 42, 3, 2, 0 },
+	{  50000000, 0, 50, 3, 3, 0 },
+};
+
+static int s5pv210_epll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int epll_con, epll_con_k;
+	unsigned int i;
+
+	/* Return if nothing changed */
+	if (clk->rate == rate)
+		return 0;
+
+	epll_con = __raw_readl(S5P_EPLL_CON);
+	epll_con_k = __raw_readl(S5P_EPLL_CON1);
+
+	epll_con_k &= ~PLL46XX_KDIV_MASK;
+	epll_con &= ~(1 << 27 |
+			PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT |
+			PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT |
+			PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
+
+	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
+		if (epll_div[i][0] == rate) {
+			epll_con_k |= epll_div[i][5] << 0;
+			epll_con |= (epll_div[i][1] << 27 |
+					epll_div[i][2] << PLL46XX_MDIV_SHIFT |
+					epll_div[i][3] << PLL46XX_PDIV_SHIFT |
+					epll_div[i][4] << PLL46XX_SDIV_SHIFT);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(epll_div)) {
+		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	__raw_writel(epll_con, S5P_EPLL_CON);
+	__raw_writel(epll_con_k, S5P_EPLL_CON1);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static struct clk_ops s5pv210_epll_ops = {
+	.set_rate = s5pv210_epll_set_rate,
+	.get_rate = s5p_epll_get_rate,
+};
+
 void __init_or_cpufreq s5pv210_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -1022,6 +1095,10 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned int ptr;
 	u32 clkdiv0, clkdiv1;
 
+	/* Set functions for clk_fout_epll */
+	clk_fout_epll.enable = s5p_epll_enable;
+	clk_fout_epll.ops = &s5pv210_epll_ops;
+
 	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
 
 	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
-- 
1.6.2.5
