From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 10 Jun 2011 12:04:23 +0530
Subject: [PATCH 1/5] ARM: EXYNOS4: Add EPLL clock operations
In-Reply-To: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
References: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1307687667-9127-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EPLL specific clock get_rate/set_rate
operations on EXYNOS4.

Note: Initial code from S5PV210
http://permalink.gmane.org/gmane.linux.alsa.devel/77519

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |   78 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index b1b93b9..7aa4aef 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1276,6 +1276,82 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_audio2,
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
+static int exynos4_epll_set_rate(struct clk *clk, unsigned long rate)
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
+	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
+			clk->rate, rate);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static struct clk_ops exynos4_epll_ops = {
+	.set_rate = exynos4_epll_set_rate,
+	.get_rate = s5p_epll_get_rate,
+};
+
 static int xtal_rate;
 
 static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
@@ -1354,6 +1430,8 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
 
+	clk_fout_epll.ops = &exynos4_epll_ops;
+
 	clk_audiocdclk0.rate = PCM_EXTCLK0;
 	clk_set_parent(&clk_sclk_audio0.clk, &clk_audiocdclk0);
 }
-- 
1.7.2.3
