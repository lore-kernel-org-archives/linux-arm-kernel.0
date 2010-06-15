From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 15 Jun 2010 19:07:00 +0800
Subject: [PATCH] NUC900: patch for implement clk_get_rate
Message-ID: <4C175ED4.8080303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Baruch's advice, I re-orgnize previous patch named
'Add platform support for nuc900 i2c driver'.

This patch is for implementing clk_get_rate, there are four clk
rates were needed to get, cpufreq,ahb,apb and external crystal.
clk_get_rate return value is for external crystal.

---
 arch/arm/mach-w90x900/clock.c |    9 +++++++
 arch/arm/mach-w90x900/clock.h |    5 ++++
 arch/arm/mach-w90x900/cpu.c   |   50 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index 2c371ff..6325642 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -57,6 +57,15 @@ EXPORT_SYMBOL(clk_disable);

 unsigned long clk_get_rate(struct clk *clk)
 {
+	unsigned long flags, ret;
+
+	if (clk == NULL || IS_ERR(clk))
+		return -EPERM;
+	spin_lock_irqsave(&clocks_lock, flags);
+	ret = nuc900_get_cpuclock(&clk->cpufreq, &clk->ahbfreq, &clk->apbfreq);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+	if (ret)
+		return ret;
 	return 15000000;
 }
 EXPORT_SYMBOL(clk_get_rate);
diff --git a/arch/arm/mach-w90x900/clock.h b/arch/arm/mach-w90x900/clock.h
index c56ddab..af8e04c 100644
--- a/arch/arm/mach-w90x900/clock.h
+++ b/arch/arm/mach-w90x900/clock.h
@@ -14,10 +14,15 @@

 void nuc900_clk_enable(struct clk *clk, int enable);
 void nuc900_subclk_enable(struct clk *clk, int enable);
+int nuc900_get_cpuclock(unsigned int *cpuclk_khz,
+			unsigned int *ahbclk_khz, unsigned int *apbclk_khz);

 struct clk {
 	unsigned long		cken;
 	unsigned int		enabled;
+	unsigned int		cpufreq;
+	unsigned int		ahbfreq;
+	unsigned int		apbfreq;
 	void			(*enable)(struct clk *, int enable);
 };

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 642207e..c4cce24 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -195,6 +195,56 @@ static int __init nuc900_set_cpufreq(char *str)

 __setup("cpufreq=", nuc900_set_cpufreq);

+int nuc900_get_cpuclock(unsigned int *cpuclk_khz,
+			unsigned int *ahbclk_khz, unsigned int *apbclk_khz) {
+
+	int ahbspeed = 0, apbspeed = 0, cpuspeed = 0;
+
+	if (cpuclk_khz) {
+		cpuspeed = __raw_readl(REG_PLLCON0);
+		if (cpuspeed == PLL_200MHZ)
+			cpuspeed = 200 * 1000;
+		else if (cpuspeed == PLL_166MHZ)
+			cpuspeed = 166 * 1000;
+		else if (cpuspeed == PLL_120MHZ)
+			cpuspeed = 120 * 1000;
+		else if (cpuspeed == PLL_100MHZ)
+			cpuspeed = 100 * 1000;
+		else if (cpuspeed == PLL_66MHZ)
+			cpuspeed = 66 * 1000;
+		else {
+			printk(KERN_ERR "Can not read true cpuspeed!\n");
+			return -EPERM;
+		}
+		*cpuclk_khz = cpuspeed;
+	}
+
+	if (ahbclk_khz) {
+		ahbspeed = (__raw_readl(REG_CLKDIV) >> 24) & 0x03;
+		if (ahbspeed == AHB_CPUCLK_1_1)
+			ahbspeed = cpuspeed;
+		else if (ahbspeed == AHB_CPUCLK_1_2)
+			ahbspeed = cpuspeed / 2;
+		else {
+			printk(KERN_ERR "Can not read true ahbspeed!\n");
+			return -EPERM;
+		}
+		*ahbclk_khz = ahbspeed;
+	}
+
+	if (apbclk_khz) {
+		apbspeed = (__raw_readl(REG_CLKDIV) >> 26) & 0x03;
+		if (apbspeed == APB_AHB_1_2)
+			apbspeed = ahbspeed / 2;
+		else {
+			printk(KERN_ERR "Can not read true apbspeed!\n");
+			return -EPERM;
+		}
+		*apbclk_khz = apbspeed;
+	}
+	return 0;
+}
+
 /*Init NUC900 evb io*/

 void __init nuc900_map_io(struct map_desc *mach_desc, int mach_size)
-- 
1.6.3.3
