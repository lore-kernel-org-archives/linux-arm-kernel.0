From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 01 Jan 2010 17:52:40 +0800
Subject: [PATCH] NUC900: Add clock divider API and modify some clk APIs
Message-ID: <4B3DC5E8.9070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

This patch implements mainly "nuc900_driver_clksrc_div", and re-adjust
clock source selecting, clock divider API.

There are four clock sources in nuc900,pll0,pll1,ext(15M),other.
This API must be used by specific driver,such as LCD. Select pll0 as lcd
clock source,and divider value range from 0-15,for example:

nuc900_driver_clksrc_div(&pdev->dev, "pll0",0x0).The "&pdev->dev" must
be your LCD driver's struct device of platform_device.


Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/clksel.c |  128
+++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-w90x900/clock.c  |    2 +
 arch/arm/mach-w90x900/cpu.c    |   48 +++------------
 arch/arm/mach-w90x900/cpu.h    |    5 +-
 4 files changed, 142 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-w90x900/clksel.c b/arch/arm/mach-w90x900/clksel.c
index 3de4a52..cc2fcd7 100644
--- a/arch/arm/mach-w90x900/clksel.c
+++ b/arch/arm/mach-w90x900/clksel.c
@@ -59,7 +59,14 @@ static void clock_source_select(const char *dev_id,
unsigned int clkval)
 	__raw_writel(clksel, REG_CLKSEL);
 }

-void nuc900_clock_source(struct device *dev, unsigned char *src)
+/*
+* There are four clock sources in nuc900,pll0,pll1,ext(15M),other.
+* select ext as cpu clock source: nuc900_clock_select(NULL, "ext")
+* select pll0 as lcd clock source: nuc900_clock_select(&pdev->dev, "pll0")
+* the &pdev->dev must be your LCD driver's struct device of
platform_device.
+*/
+
+void nuc900_clock_select(struct device *dev, unsigned char *src)
 {
 	unsigned int clkval;
 	const char *dev_id;
@@ -87,5 +94,122 @@ void nuc900_clock_source(struct device *dev,
unsigned char *src)

 	mutex_unlock(&clksel_sem);
 }
-EXPORT_SYMBOL(nuc900_clock_source);
+EXPORT_SYMBOL(nuc900_clock_select);
+
+void nuc900_clock_divider(struct device *dev, const char* nodev,
+							unsigned char divider)
+{
+	unsigned int dival;
+	const char *dev_id;
+
+	BUG_ON((!dev && !nodev) || (dev && nodev));
+
+	dival = 0;
+
+	mutex_lock(&clksel_sem);
+
+	if (dev)
+		dev_id = dev_name(dev);
+	else
+		dev_id = nodev;
+
+	dival = __raw_readl(REG_CLKDIV);
+
+	if (strcmp(dev_id, "g2d") == 0) {
+		if (divider > 1)
+			divider = 1;
+		dival &= ~(0x01 << 30);
+		dival |= divider << 30;
+	} else if (strcmp(dev_id, "adc") == 0) {
+		if (divider > 3)
+			divider = 3;
+		dival &= ~(0x03 << 28);
+		dival |= divider << 28;
+	} else if (strcmp(dev_id, "apb") == 0) {
+		if (divider > 3)
+			divider = 3;
+		dival &= ~(0x03 << 26);
+		dival |= divider << 26;
+	} else if (strcmp(dev_id, "ahb") == 0) {
+		if (divider > 3)
+			divider = 3;
+		dival &= ~(0x03 << 24);
+		dival |= divider << 24;
+	} else if (strcmp(dev_id, "nuc900-atapi") == 0) {
+		dival &= ~(0x0f << 20);
+		dival |= divider << 20;
+	} else if (strcmp(dev_id, "nuc900-uart1") == 0) {
+		dival &= ~(0x0f << 16);
+		dival |= divider << 16;
+	} else if (strcmp(dev_id, "nuc900-lcd") == 0) {
+		dival &= ~(0x0f << 12);
+		dival |= divider << 12;
+	} else if (strcmp(dev_id, "nuc900-audio") == 0) {
+		dival &= ~(0x0f << 8);
+		dival |= divider << 8;
+	} else if (strcmp(dev_id, "cpufreq") == 0) {
+		dival &= ~0x0f;
+		dival |= divider;
+	}
+
+	__raw_writel(dival, REG_CLKDIV);
+
+	mutex_unlock(&clksel_sem);
+}
+EXPORT_SYMBOL(nuc900_clock_divider);

+/*Set NUC900 series cpu frequence*/
+void nuc900_set_pllval(unsigned int cpufreq, const char *pll)
+{
+	unsigned int pllclk;
+
+	pllclk = 0;
+
+	BUG_ON(!pll);
+
+	switch (cpufreq) {
+	case 66:
+		pllclk = PLL_66MHZ;
+		break;
+
+	case 100:
+		pllclk = PLL_100MHZ;
+		break;
+
+	case 120:
+		pllclk = PLL_120MHZ;
+		break;
+
+	case 166:
+		pllclk = PLL_166MHZ;
+		break;
+
+	case 200:
+		pllclk = PLL_200MHZ;
+		break;
+	}
+
+	if (strcmp(pll, "pll0") == 0)
+		__raw_writel(pllclk, REG_PLLCON0);
+	else if (strcmp(pll, "pll1") == 0)
+		__raw_writel(pllclk, REG_PLLCON1);
+	else
+		printk(KERN_ERR "nuc900_set_pllval: pll0 or pll1?\n");
+}
+EXPORT_SYMBOL(nuc900_set_pllval);
+
+/*
+* There are four clock sources in nuc900,pll0,pll1,ext(15M),other.
+* this API must be used by specific driver,such as LCD.
+* select pll0 as lcd clock source,and divider value range from 0-15,for
example:
+* nuc900_driver_clksrc_div(&pdev->dev, "pll0",0x0).The "&pdev->dev"
must be your
+* LCD driver's struct device of platform_device.
+*/
+
+void nuc900_driver_clksrc_div(struct device *dev, unsigned char *src,
+							unsigned char divider)
+{
+	nuc900_clock_select(dev, src);
+	nuc900_clock_divider(dev, NULL, divider);
+}
+EXPORT_SYMBOL(nuc900_clock_select);
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index b785994..d67502e 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>

 #include <mach/hardware.h>
+#include <mach/regs-clock.h>

 #include "clock.h"

@@ -99,3 +100,4 @@ void clks_register(struct clk_lookup *clks, size_t num)
 	for (i = 0; i < num; i++)
 		clkdev_add(&clks[i]);
 }
+
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 1192424..6992144 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -119,55 +119,28 @@ struct platform_device nuc900_serial_device = {
 };

 /*Set NUC900 series cpu frequence*/
-static int __init nuc900_set_clkval(unsigned int cpufreq)
+int nuc900_set_cpu_clock(unsigned int cpufreq, const char *pll)
 {
-	unsigned int pllclk, ahbclk, apbclk, val;
-
-	pllclk = 0;
-	ahbclk = 0;
-	apbclk = 0;
-
 	switch (cpufreq) {
 	case 66:
-		pllclk = PLL_66MHZ;
-		ahbclk = AHB_CPUCLK_1_1;
-		apbclk = APB_AHB_1_2;
-		break;
-
 	case 100:
-		pllclk = PLL_100MHZ;
-		ahbclk = AHB_CPUCLK_1_1;
-		apbclk = APB_AHB_1_2;
+		nuc900_clock_divider(NULL, "ahb", 0x0);
+		nuc900_clock_divider(NULL, "apb", 0x1);
 		break;

 	case 120:
-		pllclk = PLL_120MHZ;
-		ahbclk = AHB_CPUCLK_1_2;
-		apbclk = APB_AHB_1_2;
-		break;
-
 	case 166:
-		pllclk = PLL_166MHZ;
-		ahbclk = AHB_CPUCLK_1_2;
-		apbclk = APB_AHB_1_2;
-		break;
-
 	case 200:
-		pllclk = PLL_200MHZ;
-		ahbclk = AHB_CPUCLK_1_2;
-		apbclk = APB_AHB_1_2;
+		nuc900_clock_divider(NULL, "ahb", 0x1);
+		nuc900_clock_divider(NULL, "apb", 0x1);
 		break;
 	}

-	__raw_writel(pllclk, REG_PLLCON0);
-
-	val = __raw_readl(REG_CLKDIV);
-	val &= ~(0x03 << 24 | 0x03 << 26);
-	val |= (ahbclk << 24 | apbclk << 26);
-	__raw_writel(val, REG_CLKDIV);
+	nuc900_set_pllval(cpufreq, "pll0");

 	return 	0;
 }
+
 static int __init nuc900_set_cpufreq(char *str)
 {
 	unsigned long cpufreq, val;
@@ -177,10 +150,9 @@ static int __init nuc900_set_cpufreq(char *str)

 	strict_strtoul(str, 0, &cpufreq);

-	nuc900_clock_source(NULL, "ext");
-
-	nuc900_set_clkval(cpufreq);
+	nuc900_clock_select(NULL, "ext");

+	nuc900_set_cpu_clock(cpufreq, "pll0");
 	mdelay(1);

 	val = __raw_readl(REG_CKSKEW);
@@ -188,7 +160,7 @@ static int __init nuc900_set_cpufreq(char *str)
 	val |= DEFAULTSKEW;
 	__raw_writel(val, REG_CKSKEW);

-	nuc900_clock_source(NULL, "pll0");
+	nuc900_clock_select(NULL, "pll0");

 	return 1;
 }
diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
index 4d58ba1..abf7d36 100644
--- a/arch/arm/mach-w90x900/cpu.h
+++ b/arch/arm/mach-w90x900/cpu.h
@@ -45,7 +45,10 @@

 /* extern file from cpu.c */

-extern void nuc900_clock_source(struct device *dev, unsigned char *src);
+extern void nuc900_clock_select(struct device *dev, unsigned char *src);
+extern void nuc900_clock_divider(struct device *dev, const char* nodev,
+							unsigned char divider);
+extern void nuc900_set_pllval(unsigned int cpufreq, const char *pll);
 extern void nuc900_init_clocks(void);
 extern void nuc900_map_io(struct map_desc *mach_desc, int mach_size);
 extern void nuc900_board_init(struct platform_device **device, int size);
-- 
1.5.6.3
