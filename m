From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  3 Mar 2013 20:22:06 +0400
Subject: [PATCH] ARM: s3c24xx: Add special bus clock ratio mode support for
 S3C2410A
Message-ID: <1362327726-8193-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a special bus clock ratio mode support (1:4:4) for
S3C2410A CPU targets. This mode means that the HCLK and PCLK frequency
is the same as the FCLK/4.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-s3c24xx/cpufreq-s3c2410.c         | 36 ++++++++++++++-----------
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h |  1 +
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h  |  1 +
 arch/arm/mach-s3c24xx/s3c2410.c                 | 11 ++++++--
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c b/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
index cfa0dd8..0890ab7 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
@@ -24,22 +24,25 @@
 #include <asm/mach/map.h>
 
 #include <mach/regs-clock.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/cpu-freq-core.h>
 
-/* Note, 2410A has an extra mode for 1:4:4 ratio, bit 2 of CLKDIV */
-
 static void s3c2410_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 {
 	u32 clkdiv = 0;
 
-	if (cfg->divs.h_divisor == 2)
-		clkdiv |= S3C2410_CLKDIVN_HDIVN;
+	if (cfg->divs.h_divisor == 4) {
+		clkdiv = S3C2410_CLKDIVN_HDIVN1;
+	} else {
+		if (cfg->divs.h_divisor == 2)
+			clkdiv = S3C2410_CLKDIVN_HDIVN;
 
-	if (cfg->divs.p_divisor != cfg->divs.h_divisor)
-		clkdiv |= S3C2410_CLKDIVN_PDIVN;
+		if (cfg->divs.p_divisor != cfg->divs.h_divisor)
+			clkdiv |= S3C2410_CLKDIVN_PDIVN;
+	}
 
 	__raw_writel(clkdiv, S3C2410_CLKDIVN);
 }
@@ -48,27 +51,27 @@ static int s3c2410_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
 {
 	unsigned long hclk, fclk, pclk;
 	unsigned int hdiv, pdiv;
-	unsigned long hclk_max;
 
 	fclk = cfg->freq.fclk;
-	hclk_max = cfg->max.hclk;
-
-	cfg->freq.armclk = fclk;
-
-	s3c_freq_dbg("%s: fclk is %lu, max hclk %lu\n",
-		      __func__, fclk, hclk_max);
 
 	hdiv = (fclk > cfg->max.hclk) ? 2 : 1;
 	hclk = fclk / hdiv;
+	pdiv = (hclk > cfg->max.pclk) ? 2 : 1;
+	pclk = hclk / pdiv;
+
+	if ((samsung_cpu_id == S3C2410_GSTATUS1_2410A) &&
+	    ((hclk > cfg->max.hclk) || (pclk > cfg->max.pclk))) {
+		hdiv = 4;
+		hclk = fclk / 4;
+		pdiv = 1;
+		pclk = fclk / 4;
+	}
 
 	if (hclk > cfg->max.hclk) {
 		s3c_freq_dbg("%s: hclk too big\n", __func__);
 		return -EINVAL;
 	}
 
-	pdiv = (hclk > cfg->max.pclk) ? 2 : 1;
-	pclk = hclk / pdiv;
-
 	if (pclk > cfg->max.pclk) {
 		s3c_freq_dbg("%s: pclk too big\n", __func__);
 		return -EINVAL;
@@ -77,6 +80,7 @@ static int s3c2410_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
 	pdiv *= hdiv;
 
 	/* record the result */
+	cfg->freq.armclk = fclk;
 	cfg->divs.p_divisor = pdiv;
 	cfg->divs.h_divisor = hdiv;
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
index 3415b60..15b707b 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
@@ -62,6 +62,7 @@
 
 #define S3C2410_CLKDIVN_PDIVN	     (1<<0)
 #define S3C2410_CLKDIVN_HDIVN	     (1<<1)
+#define S3C2410_CLKDIVN_HDIVN1	     (1<<2)
 
 #define S3C2410_CLKSLOW_UCLK_OFF	(1<<7)
 #define S3C2410_CLKSLOW_MPLL_OFF	(1<<5)
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
index c2ef016..ff8ef6a 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
@@ -571,6 +571,7 @@
 
 #define S3C2410_GSTATUS1_IDMASK	   (0xffff0000)
 #define S3C2410_GSTATUS1_2410	   (0x32410000)
+#define S3C2410_GSTATUS1_2410A	   (0x32410002)
 #define S3C2410_GSTATUS1_2412	   (0x32412001)
 #define S3C2410_GSTATUS1_2416	   (0x32416003)
 #define S3C2410_GSTATUS1_2440	   (0x32440000)
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 9ebef95..c512dac 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -35,6 +35,7 @@
 #include <plat/cpu-freq.h>
 
 #include <mach/regs-clock.h>
+#include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
 
 #include <plat/s3c2410.h>
@@ -104,8 +105,14 @@ void __init_or_cpufreq s3c2410_setup_clocks(void)
 
 	/* work out clock scalings */
 
-	hclk = fclk / ((tmp & S3C2410_CLKDIVN_HDIVN) ? 2 : 1);
-	pclk = hclk / ((tmp & S3C2410_CLKDIVN_PDIVN) ? 2 : 1);
+	if ((samsung_cpu_id == S3C2410_GSTATUS1_2410A) &&
+	    (tmp & S3C2410_CLKDIVN_HDIVN1)) {
+		hclk = fclk / 4;
+		pclk = fclk / 4;
+	} else {
+		hclk = fclk / ((tmp & S3C2410_CLKDIVN_HDIVN) ? 2 : 1);
+		pclk = hclk / ((tmp & S3C2410_CLKDIVN_PDIVN) ? 2 : 1);
+	}
 
 	/* print brieft summary of clocks, etc */
 
-- 
1.7.12.4
