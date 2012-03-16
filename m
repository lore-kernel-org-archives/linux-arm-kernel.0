From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 16 Mar 2012 18:36:54 +0100
Subject: [RFC/PATCH 2/4] pxa2xx: move clkops definitions into a separate
 object file
Message-ID: <1331919414.31118.21.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids the layering violation discussed in Documentation/clk.txt:
static clock definitions and clk_ops implementations have to reside
in separate files.

An alternative would be to move the static clock definitions out of
pxa*.c, but given that there are already clock-pxa2xx.c and clock-pxa3xx.c,
this seems like the more logical choice.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/Makefile       |    4 +-
 arch/arm/mach-pxa/clock-pxa25x.c |  133 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/clock-pxa27x.c |  123 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/clock.h        |    8 ++
 arch/arm/mach-pxa/pxa25x.c       |  118 ---------------------------------
 arch/arm/mach-pxa/pxa27x.c       |  108 ------------------------------
 6 files changed, 266 insertions(+), 228 deletions(-)
 create mode 100644 arch/arm/mach-pxa/clock-pxa25x.c
 create mode 100644 arch/arm/mach-pxa/clock-pxa27x.c

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index be0f7df..0a1fc28 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -16,8 +16,8 @@ endif
 # Generic drivers that other drivers may depend upon
 
 # SoC-specific code
-obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa25x.o
-obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa27x.o
+obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o clock-pxa2xx.o clock-pxa25x.o pxa2xx.o pxa25x.o
+obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o clock-pxa2xx.o clock-pxa27x.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
 obj-$(CONFIG_PXA95x)		+= mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o pxa95x.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
diff --git a/arch/arm/mach-pxa/clock-pxa25x.c b/arch/arm/mach-pxa/clock-pxa25x.c
new file mode 100644
index 0000000..d6f525c
--- /dev/null
+++ b/arch/arm/mach-pxa/clock-pxa25x.c
@@ -0,0 +1,133 @@
+/*
+ * linux/arch/arm/mach-pxa/clock-pxa25x.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <mach/pxa2xx-regs.h>
+
+#include "clock.h"
+
+/*
+ * Various clock factors driven by the CCCR register.
+ */
+
+/* Crystal Frequency to Memory Frequency Multiplier (L) */
+static unsigned char L_clk_mult[32] = { 0, 27, 32, 36, 40, 45, 0, };
+
+/* Memory Frequency to Run Mode Frequency Multiplier (M) */
+static unsigned char M_clk_mult[4] = { 0, 1, 2, 4 };
+
+/* Run Mode Frequency to Turbo Mode Frequency Multiplier (N) */
+/* Note: we store the value N * 2 here. */
+static unsigned char N2_clk_mult[8] = { 0, 0, 2, 3, 4, 0, 6, 0 };
+
+/* Crystal clock */
+#define BASE_CLK	3686400
+
+/*
+ * Get the clock frequency as reflected by CCCR and the turbo flag.
+ * We assume these values have been applied via a fcs.
+ * If info is not 0 we also display the current settings.
+ */
+unsigned int pxa25x_get_clk_frequency_khz(int info)
+{
+	unsigned long cccr, turbo;
+	unsigned int l, L, m, M, n2, N;
+
+	cccr = CCCR;
+	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (turbo) );
+
+	l  =  L_clk_mult[(cccr >> 0) & 0x1f];
+	m  =  M_clk_mult[(cccr >> 5) & 0x03];
+	n2 = N2_clk_mult[(cccr >> 7) & 0x07];
+
+	L = l * BASE_CLK;
+	M = m * L;
+	N = n2 * M / 2;
+
+	if(info)
+	{
+		L += 5000;
+		printk( KERN_INFO "Memory clock: %d.%02dMHz (*%d)\n",
+			L / 1000000, (L % 1000000) / 10000, l );
+		M += 5000;
+		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
+			M / 1000000, (M % 1000000) / 10000, m );
+		N += 5000;
+		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
+			N / 1000000, (N % 1000000) / 10000, n2 / 2, (n2 % 2) * 5,
+			(turbo & 1) ? "" : "in" );
+	}
+
+	return (turbo & 1) ? (N/1000) : (M/1000);
+}
+
+static unsigned long clk_pxa25x_mem_getrate(struct clk *clk)
+{
+	return L_clk_mult[(CCCR >> 0) & 0x1f] * BASE_CLK;
+}
+
+const struct clkops clk_pxa25x_mem_ops = {
+	.enable		= clk_dummy_enable,
+	.disable	= clk_dummy_disable,
+	.getrate	= clk_pxa25x_mem_getrate,
+};
+
+const struct clkops clk_pxa25x_lcd_ops = {
+	.enable		= clk_pxa2xx_cken_enable,
+	.disable	= clk_pxa2xx_cken_disable,
+	.getrate	= clk_pxa25x_mem_getrate,
+};
+
+static unsigned long gpio12_config_32k[] = {
+	GPIO12_32KHz,
+};
+
+static unsigned long gpio12_config_gpio[] = {
+	GPIO12_GPIO,
+};
+
+static void clk_gpio12_enable(struct clk *clk)
+{
+	pxa2xx_mfp_config(gpio12_config_32k, 1);
+}
+
+static void clk_gpio12_disable(struct clk *clk)
+{
+	pxa2xx_mfp_config(gpio12_config_gpio, 1);
+}
+
+const struct clkops clk_pxa25x_gpio12_ops = {
+	.enable         = clk_gpio12_enable,
+	.disable        = clk_gpio12_disable,
+};
+
+static unsigned long gpio11_config_3m6[] = {
+	GPIO11_3_6MHz,
+};
+
+static unsigned long gpio11_config_gpio[] = {
+	GPIO11_GPIO,
+};
+
+static void clk_gpio11_enable(struct clk *clk)
+{
+	pxa2xx_mfp_config(gpio11_config_3m6, 1);
+}
+
+static void clk_gpio11_disable(struct clk *clk)
+{
+	pxa2xx_mfp_config(gpio11_config_gpio, 1);
+}
+
+const struct clkops clk_pxa25x_gpio11_ops = {
+	.enable         = clk_gpio11_enable,
+	.disable        = clk_gpio11_disable,
+};
+
diff --git a/arch/arm/mach-pxa/clock-pxa27x.c b/arch/arm/mach-pxa/clock-pxa27x.c
new file mode 100644
index 0000000..dd97c6d
--- /dev/null
+++ b/arch/arm/mach-pxa/clock-pxa27x.c
@@ -0,0 +1,123 @@
+/*
+ * linux/arch/arm/mach-pxa/clock-pxa27x.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <mach/pxa2xx-regs.h>
+
+#include "clock.h"
+
+/* Crystal clock: 13MHz */
+#define BASE_CLK	13000000
+
+/*
+ * Get the clock frequency as reflected by CCSR and the turbo flag.
+ * We assume these values have been applied via a fcs.
+ * If info is not 0 we also display the current settings.
+ */
+unsigned int pxa27x_get_clk_frequency_khz(int info)
+{
+	unsigned long ccsr, clkcfg;
+	unsigned int l, L, m, M, n2, N, S;
+	int cccr_a, t, ht, b;
+
+	ccsr = CCSR;
+	cccr_a = CCCR & (1 << 25);
+
+	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
+	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
+	t  = clkcfg & (1 << 0);
+	ht = clkcfg & (1 << 2);
+	b  = clkcfg & (1 << 3);
+
+	l  = ccsr & 0x1f;
+	n2 = (ccsr>>7) & 0xf;
+	m  = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
+
+	L  = l * BASE_CLK;
+	N  = (L * n2) / 2;
+	M  = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
+	S  = (b) ? L : (L/2);
+
+	if (info) {
+		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
+			L / 1000000, (L % 1000000) / 10000, l );
+		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
+			N / 1000000, (N % 1000000)/10000, n2 / 2, (n2 % 2)*5,
+			(t) ? "" : "in" );
+		printk( KERN_INFO "Memory clock: %d.%02dMHz (/%d)\n",
+			M / 1000000, (M % 1000000) / 10000, m );
+		printk( KERN_INFO "System bus clock: %d.%02dMHz \n",
+			S / 1000000, (S % 1000000) / 10000 );
+	}
+
+	return (t) ? (N/1000) : (L/1000);
+}
+
+/*
+ * Return the current mem clock frequency as reflected by CCCR[A], B, and L
+ */
+static unsigned long clk_pxa27x_mem_getrate(struct clk *clk)
+{
+	unsigned long ccsr, clkcfg;
+	unsigned int l, L, m, M;
+	int cccr_a, b;
+
+	ccsr = CCSR;
+	cccr_a = CCCR & (1 << 25);
+
+	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
+	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
+	b = clkcfg & (1 << 3);
+
+	l = ccsr & 0x1f;
+	m = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
+
+	L = l * BASE_CLK;
+	M = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
+
+	return M;
+}
+
+const struct clkops clk_pxa27x_mem_ops = {
+	.enable		= clk_dummy_enable,
+	.disable	= clk_dummy_disable,
+	.getrate	= clk_pxa27x_mem_getrate,
+};
+
+/*
+ * Return the current LCD clock frequency in units of 10kHz as
+ */
+static unsigned int pxa27x_get_lcdclk_frequency_10khz(void)
+{
+	unsigned long ccsr;
+	unsigned int l, L, k, K;
+
+	ccsr = CCSR;
+
+	l = ccsr & 0x1f;
+	k = (l <= 7) ? 1 : (l <= 16) ? 2 : 4;
+
+	L = l * BASE_CLK;
+	K = L / k;
+
+	return (K / 10000);
+}
+
+static unsigned long clk_pxa27x_lcd_getrate(struct clk *clk)
+{
+	return pxa27x_get_lcdclk_frequency_10khz() * 10000;
+}
+
+const struct clkops clk_pxa27x_lcd_ops = {
+	.enable		= clk_pxa2xx_cken_enable,
+	.disable	= clk_pxa2xx_cken_disable,
+	.getrate	= clk_pxa27x_lcd_getrate,
+};
+
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index 2946fa2..a3585a2 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -45,6 +45,14 @@ struct clk clk_##_name = {				\
 
 extern const struct clkops clk_pxa2xx_cken_ops;
 
+extern const struct clkops clk_pxa25x_mem_ops;
+extern const struct clkops clk_pxa25x_lcd_ops;
+extern const struct clkops clk_pxa25x_gpio12_ops;
+extern const struct clkops clk_pxa25x_gpio11_ops;
+
+extern const struct clkops clk_pxa27x_mem_ops;
+extern const struct clkops clk_pxa27x_lcd_ops;
+
 void clk_pxa2xx_cken_enable(struct clk *clk);
 void clk_pxa2xx_cken_disable(struct clk *clk);
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 99dd55e..2c2eb41 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -41,124 +41,6 @@
 #include "clock.h"
 
 /*
- * Various clock factors driven by the CCCR register.
- */
-
-/* Crystal Frequency to Memory Frequency Multiplier (L) */
-static unsigned char L_clk_mult[32] = { 0, 27, 32, 36, 40, 45, 0, };
-
-/* Memory Frequency to Run Mode Frequency Multiplier (M) */
-static unsigned char M_clk_mult[4] = { 0, 1, 2, 4 };
-
-/* Run Mode Frequency to Turbo Mode Frequency Multiplier (N) */
-/* Note: we store the value N * 2 here. */
-static unsigned char N2_clk_mult[8] = { 0, 0, 2, 3, 4, 0, 6, 0 };
-
-/* Crystal clock */
-#define BASE_CLK	3686400
-
-/*
- * Get the clock frequency as reflected by CCCR and the turbo flag.
- * We assume these values have been applied via a fcs.
- * If info is not 0 we also display the current settings.
- */
-unsigned int pxa25x_get_clk_frequency_khz(int info)
-{
-	unsigned long cccr, turbo;
-	unsigned int l, L, m, M, n2, N;
-
-	cccr = CCCR;
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (turbo) );
-
-	l  =  L_clk_mult[(cccr >> 0) & 0x1f];
-	m  =  M_clk_mult[(cccr >> 5) & 0x03];
-	n2 = N2_clk_mult[(cccr >> 7) & 0x07];
-
-	L = l * BASE_CLK;
-	M = m * L;
-	N = n2 * M / 2;
-
-	if(info)
-	{
-		L += 5000;
-		printk( KERN_INFO "Memory clock: %d.%02dMHz (*%d)\n",
-			L / 1000000, (L % 1000000) / 10000, l );
-		M += 5000;
-		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
-			M / 1000000, (M % 1000000) / 10000, m );
-		N += 5000;
-		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
-			N / 1000000, (N % 1000000) / 10000, n2 / 2, (n2 % 2) * 5,
-			(turbo & 1) ? "" : "in" );
-	}
-
-	return (turbo & 1) ? (N/1000) : (M/1000);
-}
-
-static unsigned long clk_pxa25x_mem_getrate(struct clk *clk)
-{
-	return L_clk_mult[(CCCR >> 0) & 0x1f] * BASE_CLK;
-}
-
-static const struct clkops clk_pxa25x_mem_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
-	.getrate	= clk_pxa25x_mem_getrate,
-};
-
-static const struct clkops clk_pxa25x_lcd_ops = {
-	.enable		= clk_pxa2xx_cken_enable,
-	.disable	= clk_pxa2xx_cken_disable,
-	.getrate	= clk_pxa25x_mem_getrate,
-};
-
-static unsigned long gpio12_config_32k[] = {
-	GPIO12_32KHz,
-};
-
-static unsigned long gpio12_config_gpio[] = {
-	GPIO12_GPIO,
-};
-
-static void clk_gpio12_enable(struct clk *clk)
-{
-	pxa2xx_mfp_config(gpio12_config_32k, 1);
-}
-
-static void clk_gpio12_disable(struct clk *clk)
-{
-	pxa2xx_mfp_config(gpio12_config_gpio, 1);
-}
-
-static const struct clkops clk_pxa25x_gpio12_ops = {
-	.enable         = clk_gpio12_enable,
-	.disable        = clk_gpio12_disable,
-};
-
-static unsigned long gpio11_config_3m6[] = {
-	GPIO11_3_6MHz,
-};
-
-static unsigned long gpio11_config_gpio[] = {
-	GPIO11_GPIO,
-};
-
-static void clk_gpio11_enable(struct clk *clk)
-{
-	pxa2xx_mfp_config(gpio11_config_3m6, 1);
-}
-
-static void clk_gpio11_disable(struct clk *clk)
-{
-	pxa2xx_mfp_config(gpio11_config_gpio, 1);
-}
-
-static const struct clkops clk_pxa25x_gpio11_ops = {
-	.enable         = clk_gpio11_enable,
-	.disable        = clk_gpio11_disable,
-};
-
-/*
  * 3.6864MHz -> OST, GPIO, SSP, PWM, PLLs (95.842MHz, 147.456MHz)
  * 95.842MHz -> MMC 19.169MHz, I2C 31.949MHz, FICP 47.923MHz, USB 47.923MHz
  * 147.456MHz -> UART 14.7456MHz, AC97 12.288MHz, I2S 5.672MHz (allegedly)
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 2ece3e2..b9dc6ac 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -65,114 +65,6 @@ void pxa27x_assert_ac97reset(int reset_gpio, int on)
 }
 EXPORT_SYMBOL_GPL(pxa27x_assert_ac97reset);
 
-/* Crystal clock: 13MHz */
-#define BASE_CLK	13000000
-
-/*
- * Get the clock frequency as reflected by CCSR and the turbo flag.
- * We assume these values have been applied via a fcs.
- * If info is not 0 we also display the current settings.
- */
-unsigned int pxa27x_get_clk_frequency_khz(int info)
-{
-	unsigned long ccsr, clkcfg;
-	unsigned int l, L, m, M, n2, N, S;
-       	int cccr_a, t, ht, b;
-
-	ccsr = CCSR;
-	cccr_a = CCCR & (1 << 25);
-
-	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
-	t  = clkcfg & (1 << 0);
-	ht = clkcfg & (1 << 2);
-	b  = clkcfg & (1 << 3);
-
-	l  = ccsr & 0x1f;
-	n2 = (ccsr>>7) & 0xf;
-	m  = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
-
-	L  = l * BASE_CLK;
-	N  = (L * n2) / 2;
-	M  = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
-	S  = (b) ? L : (L/2);
-
-	if (info) {
-		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
-			L / 1000000, (L % 1000000) / 10000, l );
-		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
-			N / 1000000, (N % 1000000)/10000, n2 / 2, (n2 % 2)*5,
-			(t) ? "" : "in" );
-		printk( KERN_INFO "Memory clock: %d.%02dMHz (/%d)\n",
-			M / 1000000, (M % 1000000) / 10000, m );
-		printk( KERN_INFO "System bus clock: %d.%02dMHz \n",
-			S / 1000000, (S % 1000000) / 10000 );
-	}
-
-	return (t) ? (N/1000) : (L/1000);
-}
-
-/*
- * Return the current mem clock frequency as reflected by CCCR[A], B, and L
- */
-static unsigned long clk_pxa27x_mem_getrate(struct clk *clk)
-{
-	unsigned long ccsr, clkcfg;
-	unsigned int l, L, m, M;
-       	int cccr_a, b;
-
-	ccsr = CCSR;
-	cccr_a = CCCR & (1 << 25);
-
-	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
-	b = clkcfg & (1 << 3);
-
-	l = ccsr & 0x1f;
-	m = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
-
-	L = l * BASE_CLK;
-	M = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
-
-	return M;
-}
-
-static const struct clkops clk_pxa27x_mem_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
-	.getrate	= clk_pxa27x_mem_getrate,
-};
-
-/*
- * Return the current LCD clock frequency in units of 10kHz as
- */
-static unsigned int pxa27x_get_lcdclk_frequency_10khz(void)
-{
-	unsigned long ccsr;
-	unsigned int l, L, k, K;
-
-	ccsr = CCSR;
-
-	l = ccsr & 0x1f;
-	k = (l <= 7) ? 1 : (l <= 16) ? 2 : 4;
-
-	L = l * BASE_CLK;
-	K = L / k;
-
-	return (K / 10000);
-}
-
-static unsigned long clk_pxa27x_lcd_getrate(struct clk *clk)
-{
-	return pxa27x_get_lcdclk_frequency_10khz() * 10000;
-}
-
-static const struct clkops clk_pxa27x_lcd_ops = {
-	.enable		= clk_pxa2xx_cken_enable,
-	.disable	= clk_pxa2xx_cken_disable,
-	.getrate	= clk_pxa27x_lcd_getrate,
-};
-
 static DEFINE_PXA2_CKEN(pxa27x_ffuart, FFUART, 14857000, 1);
 static DEFINE_PXA2_CKEN(pxa27x_btuart, BTUART, 14857000, 1);
 static DEFINE_PXA2_CKEN(pxa27x_stuart, STUART, 14857000, 1);
-- 
1.7.9.1
