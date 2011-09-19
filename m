From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Sep 2011 20:39:34 +0900
Subject: [PATCH] ARM: SAMSUNG: Cleanup plat/pll.h
Message-ID: <002201cc76c0$ce06c3d0$6a144b70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed
- arch/arm/plat-s3c24xx/include/plat/pll.h
- arch/arm/mach-s3c64xx/include/mach/pll.h
- arch/arm/plat-s5p/include/plat/pll.h
- arch/arm/plat-samsung/include/plat/pll6553x.h

And created
- arch/arm/plat-samsung/include/plat/pll.h

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c            |    6 +-
 arch/arm/mach-s3c2416/clock.c                 |    1 -
 arch/arm/mach-s3c64xx/clock.c                 |    5 +-
 arch/arm/mach-s3c64xx/include/mach/pll.h      |   45 -----
 arch/arm/plat-s3c24xx/include/plat/pll.h      |   62 ------
 arch/arm/plat-s5p/include/plat/pll.h          |  153 --------------
 arch/arm/plat-samsung/include/plat/pll.h      |  262
+++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/pll6553x.h |   51 -----
 8 files changed, 268 insertions(+), 317 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/pll.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/pll.h
 delete mode 100644 arch/arm/plat-s5p/include/plat/pll.h
 create mode 100644 arch/arm/plat-samsung/include/plat/pll.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/pll6553x.h

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c
b/arch/arm/mach-s3c2410/mach-h1940.c
index 2a2fa06..a9201ea 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -696,9 +696,9 @@ static void __init h1940_init(void)
 			      S3C2410_MISCCR_USBSUSPND0 |
 			      S3C2410_MISCCR_USBSUSPND1, 0x0);
 
-	tmp =   (0x78 << S3C24XX_PLLCON_MDIVSHIFT)
-	      | (0x02 << S3C24XX_PLLCON_PDIVSHIFT)
-	      | (0x03 << S3C24XX_PLLCON_SDIVSHIFT);
+	tmp =   (0x78 << S3C24XX_PLL_MDIV_SHIFT)
+	      | (0x02 << S3C24XX_PLL_PDIV_SHIFT)
+	      | (0x03 << S3C24XX_PLL_SDIV_SHIFT);
 	writel(tmp, S3C2410_UPLLCON);
 
 	gpio_request(S3C2410_GPC(0), "LCD power");
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 21a5e81..c7b91d0 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -21,7 +21,6 @@
 #include <plat/cpu.h>
 
 #include <plat/cpu-freq.h>
-#include <plat/pll6553x.h>
 #include <plat/pll.h>
 
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 8cf39e3..4adc51c 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -25,13 +25,13 @@
 
 #include <mach/regs-sys.h>
 #include <mach/regs-clock.h>
-#include <mach/pll.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
+#include <plat/pll.h>
 
 /* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
  * ext_xtal_mux for want of an actual name from the manual.
@@ -735,7 +735,8 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 	/* For now assume the mux always selects the crystal */
 	clk_ext_xtal_mux.parent = xtal_clk;
 
-	epll = s3c6400_get_epll(xtal);
+	epll = s3c_get_pll6553x(xtal, __raw_readl(S3C_EPLL_CON0),
+				__raw_readl(S3C_EPLL_CON1));
 	mpll = s3c6400_get_pll(xtal, __raw_readl(S3C_MPLL_CON));
 	apll = s3c6400_get_pll(xtal, __raw_readl(S3C_APLL_CON));
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/pll.h
b/arch/arm/mach-s3c64xx/include/mach/pll.h
deleted file mode 100644
index 5ef0bb6..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/pll.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* arch/arm/plat-s3c64xx/include/plat/pll.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX PLL code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C6400_PLL_MDIV_MASK	((1 << (25-16+1)) - 1)
-#define S3C6400_PLL_PDIV_MASK	((1 << (13-8+1)) - 1)
-#define S3C6400_PLL_SDIV_MASK	((1 << (2-0+1)) - 1)
-#define S3C6400_PLL_MDIV_SHIFT	(16)
-#define S3C6400_PLL_PDIV_SHIFT	(8)
-#define S3C6400_PLL_SDIV_SHIFT	(0)
-
-#include <asm/div64.h>
-#include <plat/pll6553x.h>
-
-static inline unsigned long s3c6400_get_pll(unsigned long baseclk,
-					    u32 pllcon)
-{
-	u32 mdiv, pdiv, sdiv;
-	u64 fvco = baseclk;
-
-	mdiv = (pllcon >> S3C6400_PLL_MDIV_SHIFT) & S3C6400_PLL_MDIV_MASK;
-	pdiv = (pllcon >> S3C6400_PLL_PDIV_SHIFT) & S3C6400_PLL_PDIV_MASK;
-	sdiv = (pllcon >> S3C6400_PLL_SDIV_SHIFT) & S3C6400_PLL_SDIV_MASK;
-
-	fvco *= mdiv;
-	do_div(fvco, (pdiv << sdiv));
-
-	return (unsigned long)fvco;
-}
-
-static inline unsigned long s3c6400_get_epll(unsigned long baseclk)
-{
-	return s3c_get_pll6553x(baseclk, __raw_readl(S3C_EPLL_CON0),
-				__raw_readl(S3C_EPLL_CON1));
-}
diff --git a/arch/arm/plat-s3c24xx/include/plat/pll.h
b/arch/arm/plat-s3c24xx/include/plat/pll.h
deleted file mode 100644
index 005729a..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/pll.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/include/plat/pll.h
- *
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C24xx - common pll registers and code
- */
-
-#define S3C24XX_PLLCON_MDIVSHIFT	12
-#define S3C24XX_PLLCON_PDIVSHIFT	4
-#define S3C24XX_PLLCON_SDIVSHIFT	0
-#define S3C24XX_PLLCON_MDIVMASK		((1<<(1+(19-12)))-1)
-#define S3C24XX_PLLCON_PDIVMASK		((1<<5)-1)
-#define S3C24XX_PLLCON_SDIVMASK		3
-
-#include <asm/div64.h>
-
-static inline unsigned int
-s3c24xx_get_pll(unsigned int pllval, unsigned int baseclk)
-{
-	unsigned int mdiv, pdiv, sdiv;
-	uint64_t fvco;
-
-	mdiv = pllval >> S3C24XX_PLLCON_MDIVSHIFT;
-	pdiv = pllval >> S3C24XX_PLLCON_PDIVSHIFT;
-	sdiv = pllval >> S3C24XX_PLLCON_SDIVSHIFT;
-
-	mdiv &= S3C24XX_PLLCON_MDIVMASK;
-	pdiv &= S3C24XX_PLLCON_PDIVMASK;
-	sdiv &= S3C24XX_PLLCON_SDIVMASK;
-
-	fvco = (uint64_t)baseclk * (mdiv + 8);
-	do_div(fvco, (pdiv + 2) << sdiv);
-
-	return (unsigned int)fvco;
-}
-
-#define S3C2416_PLL_M_SHIFT	(14)
-#define S3C2416_PLL_P_SHIFT	(5)
-#define S3C2416_PLL_S_MASK	(7)
-#define S3C2416_PLL_M_MASK	((1 << 10) - 1)
-#define S3C2416_PLL_P_MASK	(63)
-
-static inline unsigned int
-s3c2416_get_pll(unsigned int pllval, unsigned int baseclk)
-{
-	unsigned int m, p, s;
-	uint64_t fvco;
-
-	m = pllval >> S3C2416_PLL_M_SHIFT;
-	p = pllval >> S3C2416_PLL_P_SHIFT;
-
-	s = pllval & S3C2416_PLL_S_MASK;
-	m &= S3C2416_PLL_M_MASK;
-	p &= S3C2416_PLL_P_MASK;
-
-	fvco = (uint64_t)baseclk * m;
-	do_div(fvco, (p << s));
-
-	return (unsigned int)fvco;
-}
diff --git a/arch/arm/plat-s5p/include/plat/pll.h
b/arch/arm/plat-s5p/include/plat/pll.h
deleted file mode 100644
index bf28fad..0000000
--- a/arch/arm/plat-s5p/include/plat/pll.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/* arch/arm/plat-s5p/include/plat/pll.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P PLL code
- *
- * Based on arch/arm/plat-s3c64xx/include/plat/pll.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define PLL45XX_MDIV_MASK	(0x3FF)
-#define PLL45XX_PDIV_MASK	(0x3F)
-#define PLL45XX_SDIV_MASK	(0x7)
-#define PLL45XX_MDIV_SHIFT	(16)
-#define PLL45XX_PDIV_SHIFT	(8)
-#define PLL45XX_SDIV_SHIFT	(0)
-
-#include <asm/div64.h>
-
-enum pll45xx_type_t {
-	pll_4500,
-	pll_4502,
-	pll_4508
-};
-
-static inline unsigned long s5p_get_pll45xx(unsigned long baseclk, u32
pll_con,
-					    enum pll45xx_type_t pll_type)
-{
-	u32 mdiv, pdiv, sdiv;
-	u64 fvco = baseclk;
-
-	mdiv = (pll_con >> PLL45XX_MDIV_SHIFT) & PLL45XX_MDIV_MASK;
-	pdiv = (pll_con >> PLL45XX_PDIV_SHIFT) & PLL45XX_PDIV_MASK;
-	sdiv = (pll_con >> PLL45XX_SDIV_SHIFT) & PLL45XX_SDIV_MASK;
-
-	if (pll_type == pll_4508)
-		sdiv = sdiv - 1;
-
-	fvco *= mdiv;
-	do_div(fvco, (pdiv << sdiv));
-
-	return (unsigned long)fvco;
-}
-
-#define PLL46XX_KDIV_MASK	(0xFFFF)
-#define PLL4650C_KDIV_MASK	(0xFFF)
-#define PLL46XX_MDIV_MASK	(0x1FF)
-#define PLL46XX_PDIV_MASK	(0x3F)
-#define PLL46XX_SDIV_MASK	(0x7)
-#define PLL46XX_MDIV_SHIFT	(16)
-#define PLL46XX_PDIV_SHIFT	(8)
-#define PLL46XX_SDIV_SHIFT	(0)
-
-enum pll46xx_type_t {
-	pll_4600,
-	pll_4650,
-	pll_4650c,
-};
-
-static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
-					    u32 pll_con0, u32 pll_con1,
-					    enum pll46xx_type_t pll_type)
-{
-	unsigned long result;
-	u32 mdiv, pdiv, sdiv, kdiv;
-	u64 tmp;
-
-	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
-	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
-	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
-	kdiv = pll_con1 & PLL46XX_KDIV_MASK;
-
-	if (pll_type == pll_4650c)
-		kdiv = pll_con1 & PLL4650C_KDIV_MASK;
-	else
-		kdiv = pll_con1 & PLL46XX_KDIV_MASK;
-
-	tmp = baseclk;
-
-	if (pll_type == pll_4600) {
-		tmp *= (mdiv << 16) + kdiv;
-		do_div(tmp, (pdiv << sdiv));
-		result = tmp >> 16;
-	} else {
-		tmp *= (mdiv << 10) + kdiv;
-		do_div(tmp, (pdiv << sdiv));
-		result = tmp >> 10;
-	}
-
-	return result;
-}
-
-#define PLL90XX_MDIV_MASK	(0xFF)
-#define PLL90XX_PDIV_MASK	(0x3F)
-#define PLL90XX_SDIV_MASK	(0x7)
-#define PLL90XX_KDIV_MASK	(0xffff)
-#define PLL90XX_MDIV_SHIFT	(16)
-#define PLL90XX_PDIV_SHIFT	(8)
-#define PLL90XX_SDIV_SHIFT	(0)
-#define PLL90XX_KDIV_SHIFT	(0)
-
-static inline unsigned long s5p_get_pll90xx(unsigned long baseclk,
-					    u32 pll_con, u32 pll_conk)
-{
-	unsigned long result;
-	u32 mdiv, pdiv, sdiv, kdiv;
-	u64 tmp;
-
-	mdiv = (pll_con >> PLL90XX_MDIV_SHIFT) & PLL90XX_MDIV_MASK;
-	pdiv = (pll_con >> PLL90XX_PDIV_SHIFT) & PLL90XX_PDIV_MASK;
-	sdiv = (pll_con >> PLL90XX_SDIV_SHIFT) & PLL90XX_SDIV_MASK;
-	kdiv = pll_conk & PLL90XX_KDIV_MASK;
-
-	/* We need to multiple baseclk by mdiv (the integer part) and kdiv
-	 * which is in 2^16ths, so shift mdiv up (does not overflow) and
-	 * add kdiv before multiplying. The use of tmp is to avoid any
-	 * overflows before shifting bac down into result when multipling
-	 * by the mdiv and kdiv pair.
-	 */
-
-	tmp = baseclk;
-	tmp *= (mdiv << 16) + kdiv;
-	do_div(tmp, (pdiv << sdiv));
-	result = tmp >> 16;
-
-	return result;
-}
-
-#define PLL65XX_MDIV_MASK	(0x3FF)
-#define PLL65XX_PDIV_MASK	(0x3F)
-#define PLL65XX_SDIV_MASK	(0x7)
-#define PLL65XX_MDIV_SHIFT	(16)
-#define PLL65XX_PDIV_SHIFT	(8)
-#define PLL65XX_SDIV_SHIFT	(0)
-
-static inline unsigned long s5p_get_pll65xx(unsigned long baseclk, u32
pll_con)
-{
-	u32 mdiv, pdiv, sdiv;
-	u64 fvco = baseclk;
-
-	mdiv = (pll_con >> PLL65XX_MDIV_SHIFT) & PLL65XX_MDIV_MASK;
-	pdiv = (pll_con >> PLL65XX_PDIV_SHIFT) & PLL65XX_PDIV_MASK;
-	sdiv = (pll_con >> PLL65XX_SDIV_SHIFT) & PLL65XX_SDIV_MASK;
-
-	fvco *= mdiv;
-	do_div(fvco, (pdiv << sdiv));
-
-	return (unsigned long)fvco;
-}
diff --git a/arch/arm/plat-samsung/include/plat/pll.h
b/arch/arm/plat-samsung/include/plat/pll.h
new file mode 100644
index 0000000..98dd15e
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/pll.h
@@ -0,0 +1,262 @@
+/* linux/arch/arm/plat-samsung/include/plat/pll.h
+ *
+ * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * Samsung PLL codes
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <asm/div64.h>
+
+#define S3C24XX_PLL_MDIV_MASK		(0xFF)
+#define S3C24XX_PLL_PDIV_MASK		(0x1F)
+#define S3C24XX_PLL_SDIV_MASK		(0x3)
+#define S3C24XX_PLL_MDIV_SHIFT		(12)
+#define S3C24XX_PLL_PDIV_SHIFT		(4)
+#define S3C24XX_PLL_SDIV_SHIFT		(0)
+
+static inline unsigned int s3c24xx_get_pll(unsigned int pllval,
+					   unsigned int baseclk)
+{
+	unsigned int mdiv, pdiv, sdiv;
+	uint64_t fvco;
+
+	mdiv = (pllval >> S3C24XX_PLL_MDIV_SHIFT) & S3C24XX_PLL_MDIV_MASK;
+	pdiv = (pllval >> S3C24XX_PLL_PDIV_SHIFT) & S3C24XX_PLL_PDIV_MASK;
+	sdiv = (pllval >> S3C24XX_PLL_SDIV_SHIFT) & S3C24XX_PLL_SDIV_MASK;
+
+	fvco = (uint64_t)baseclk * (mdiv + 8);
+	do_div(fvco, (pdiv + 2) << sdiv);
+
+	return (unsigned int)fvco;
+}
+
+#define S3C2416_PLL_MDIV_MASK		(0x3FF)
+#define S3C2416_PLL_PDIV_MASK		(0x3F)
+#define S3C2416_PLL_SDIV_MASK		(0x7)
+#define S3C2416_PLL_MDIV_SHIFT		(14)
+#define S3C2416_PLL_PDIV_SHIFT		(5)
+#define S3C2416_PLL_SDIV_SHIFT		(0)
+
+static inline unsigned int s3c2416_get_pll(unsigned int pllval,
+					   unsigned int baseclk)
+{
+	unsigned int mdiv, pdiv, sdiv;
+	uint64_t fvco;
+
+	mdiv = (pllval >> S3C2416_PLL_MDIV_SHIFT) & S3C2416_PLL_MDIV_MASK;
+	pdiv = (pllval >> S3C2416_PLL_PDIV_SHIFT) & S3C2416_PLL_PDIV_MASK;
+	sdiv = (pllval >> S3C2416_PLL_SDIV_SHIFT) & S3C2416_PLL_SDIV_MASK;
+
+	fvco = (uint64_t)baseclk * mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned int)fvco;
+}
+
+#define S3C6400_PLL_MDIV_MASK		(0x3FF)
+#define S3C6400_PLL_PDIV_MASK		(0x3F)
+#define S3C6400_PLL_SDIV_MASK		(0x7)
+#define S3C6400_PLL_MDIV_SHIFT		(16)
+#define S3C6400_PLL_PDIV_SHIFT		(8)
+#define S3C6400_PLL_SDIV_SHIFT		(0)
+
+static inline unsigned long s3c6400_get_pll(unsigned long baseclk,
+					    u32 pllcon)
+{
+	u32 mdiv, pdiv, sdiv;
+	u64 fvco = baseclk;
+
+	mdiv = (pllcon >> S3C6400_PLL_MDIV_SHIFT) & S3C6400_PLL_MDIV_MASK;
+	pdiv = (pllcon >> S3C6400_PLL_PDIV_SHIFT) & S3C6400_PLL_PDIV_MASK;
+	sdiv = (pllcon >> S3C6400_PLL_SDIV_SHIFT) & S3C6400_PLL_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
+
+#define PLL6553X_MDIV_MASK	(0x7F)
+#define PLL6553X_PDIV_MASK	(0x1F)
+#define PLL6553X_SDIV_MASK	(0x3)
+#define PLL6553X_KDIV_MASK	(0xFFFF)
+#define PLL6553X_MDIV_SHIFT	(16)
+#define PLL6553X_PDIV_SHIFT	(8)
+#define PLL6553X_SDIV_SHIFT	(0)
+
+static inline unsigned long s3c_get_pll6553x(unsigned long baseclk,
+					     u32 pll_con0, u32 pll_con1)
+{
+	unsigned long result;
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (pll_con0 >> PLL6553X_MDIV_SHIFT) & PLL6553X_MDIV_MASK;
+	pdiv = (pll_con0 >> PLL6553X_PDIV_SHIFT) & PLL6553X_PDIV_MASK;
+	sdiv = (pll_con0 >> PLL6553X_SDIV_SHIFT) & PLL6553X_SDIV_MASK;
+	kdiv = pll_con1 & PLL6553X_KDIV_MASK;
+
+	/*
+	 * We need to multiple baseclk by mdiv (the integer part) and kdiv
+	 * which is in 2^16ths, so shift mdiv up (does not overflow) and
+	 * add kdiv before multiplying. The use of tmp is to avoid any
+	 * overflows before shifting bac down into result when multipling
+	 * by the mdiv and kdiv pair.
+	 */
+
+	tmp = baseclk;
+	tmp *= (mdiv << 16) + kdiv;
+	do_div(tmp, (pdiv << sdiv));
+	result = tmp >> 16;
+
+	return result;
+}
+
+#define PLL45XX_MDIV_MASK	(0x3FF)
+#define PLL45XX_PDIV_MASK	(0x3F)
+#define PLL45XX_SDIV_MASK	(0x7)
+#define PLL45XX_MDIV_SHIFT	(16)
+#define PLL45XX_PDIV_SHIFT	(8)
+#define PLL45XX_SDIV_SHIFT	(0)
+
+enum pll45xx_type_t {
+	pll_4500,
+	pll_4502,
+	pll_4508
+};
+
+static inline unsigned long s5p_get_pll45xx(unsigned long baseclk, u32
pll_con,
+					    enum pll45xx_type_t pll_type)
+{
+	u32 mdiv, pdiv, sdiv;
+	u64 fvco = baseclk;
+
+	mdiv = (pll_con >> PLL45XX_MDIV_SHIFT) & PLL45XX_MDIV_MASK;
+	pdiv = (pll_con >> PLL45XX_PDIV_SHIFT) & PLL45XX_PDIV_MASK;
+	sdiv = (pll_con >> PLL45XX_SDIV_SHIFT) & PLL45XX_SDIV_MASK;
+
+	if (pll_type == pll_4508)
+		sdiv = sdiv - 1;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
+
+#define PLL46XX_KDIV_MASK	(0xFFFF)
+#define PLL4650C_KDIV_MASK	(0xFFF)
+#define PLL46XX_MDIV_MASK	(0x1FF)
+#define PLL46XX_PDIV_MASK	(0x3F)
+#define PLL46XX_SDIV_MASK	(0x7)
+#define PLL46XX_MDIV_SHIFT	(16)
+#define PLL46XX_PDIV_SHIFT	(8)
+#define PLL46XX_SDIV_SHIFT	(0)
+
+enum pll46xx_type_t {
+	pll_4600,
+	pll_4650,
+	pll_4650c,
+};
+
+static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
+					    u32 pll_con0, u32 pll_con1,
+					    enum pll46xx_type_t pll_type)
+{
+	unsigned long result;
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
+	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
+	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
+	kdiv = pll_con1 & PLL46XX_KDIV_MASK;
+
+	if (pll_type == pll_4650c)
+		kdiv = pll_con1 & PLL4650C_KDIV_MASK;
+	else
+		kdiv = pll_con1 & PLL46XX_KDIV_MASK;
+
+	tmp = baseclk;
+
+	if (pll_type == pll_4600) {
+		tmp *= (mdiv << 16) + kdiv;
+		do_div(tmp, (pdiv << sdiv));
+		result = tmp >> 16;
+	} else {
+		tmp *= (mdiv << 10) + kdiv;
+		do_div(tmp, (pdiv << sdiv));
+		result = tmp >> 10;
+	}
+
+	return result;
+}
+
+#define PLL90XX_MDIV_MASK	(0xFF)
+#define PLL90XX_PDIV_MASK	(0x3F)
+#define PLL90XX_SDIV_MASK	(0x7)
+#define PLL90XX_KDIV_MASK	(0xffff)
+#define PLL90XX_MDIV_SHIFT	(16)
+#define PLL90XX_PDIV_SHIFT	(8)
+#define PLL90XX_SDIV_SHIFT	(0)
+#define PLL90XX_KDIV_SHIFT	(0)
+
+static inline unsigned long s5p_get_pll90xx(unsigned long baseclk,
+					    u32 pll_con, u32 pll_conk)
+{
+	unsigned long result;
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (pll_con >> PLL90XX_MDIV_SHIFT) & PLL90XX_MDIV_MASK;
+	pdiv = (pll_con >> PLL90XX_PDIV_SHIFT) & PLL90XX_PDIV_MASK;
+	sdiv = (pll_con >> PLL90XX_SDIV_SHIFT) & PLL90XX_SDIV_MASK;
+	kdiv = pll_conk & PLL90XX_KDIV_MASK;
+
+	/*
+	 * We need to multiple baseclk by mdiv (the integer part) and kdiv
+	 * which is in 2^16ths, so shift mdiv up (does not overflow) and
+	 * add kdiv before multiplying. The use of tmp is to avoid any
+	 * overflows before shifting bac down into result when multipling
+	 * by the mdiv and kdiv pair.
+	 */
+
+	tmp = baseclk;
+	tmp *= (mdiv << 16) + kdiv;
+	do_div(tmp, (pdiv << sdiv));
+	result = tmp >> 16;
+
+	return result;
+}
+
+#define PLL65XX_MDIV_MASK	(0x3FF)
+#define PLL65XX_PDIV_MASK	(0x3F)
+#define PLL65XX_SDIV_MASK	(0x7)
+#define PLL65XX_MDIV_SHIFT	(16)
+#define PLL65XX_PDIV_SHIFT	(8)
+#define PLL65XX_SDIV_SHIFT	(0)
+
+static inline unsigned long s5p_get_pll65xx(unsigned long baseclk, u32
pll_con)
+{
+	u32 mdiv, pdiv, sdiv;
+	u64 fvco = baseclk;
+
+	mdiv = (pll_con >> PLL65XX_MDIV_SHIFT) & PLL65XX_MDIV_MASK;
+	pdiv = (pll_con >> PLL65XX_PDIV_SHIFT) & PLL65XX_PDIV_MASK;
+	sdiv = (pll_con >> PLL65XX_SDIV_SHIFT) & PLL65XX_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
diff --git a/arch/arm/plat-samsung/include/plat/pll6553x.h
b/arch/arm/plat-samsung/include/plat/pll6553x.h
deleted file mode 100644
index b8b7e1d..0000000
--- a/arch/arm/plat-samsung/include/plat/pll6553x.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/pll6553x.h
- *	partially from arch/arm/mach-s3c64xx/include/mach/pll.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Samsung PLL6553x PLL code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* S3C6400 and compatible (S3C2416, etc.) EPLL code */
-
-#define PLL6553X_MDIV_MASK	((1 << (23-16)) - 1)
-#define PLL6553X_PDIV_MASK	((1 << (13-8)) - 1)
-#define PLL6553X_SDIV_MASK	((1 << (2-0)) - 1)
-#define PLL6553X_MDIV_SHIFT	(16)
-#define PLL6553X_PDIV_SHIFT	(8)
-#define PLL6553X_SDIV_SHIFT	(0)
-#define PLL6553X_KDIV_MASK	(0xffff)
-
-static inline unsigned long s3c_get_pll6553x(unsigned long baseclk,
-					     u32 pll0, u32 pll1)
-{
-	unsigned long result;
-	u32 mdiv, pdiv, sdiv, kdiv;
-	u64 tmp;
-
-	mdiv = (pll0 >> PLL6553X_MDIV_SHIFT) & PLL6553X_MDIV_MASK;
-	pdiv = (pll0 >> PLL6553X_PDIV_SHIFT) & PLL6553X_PDIV_MASK;
-	sdiv = (pll0 >> PLL6553X_SDIV_SHIFT) & PLL6553X_SDIV_MASK;
-	kdiv = pll1 & PLL6553X_KDIV_MASK;
-
-	/* We need to multiple baseclk by mdiv (the integer part) and kdiv
-	 * which is in 2^16ths, so shift mdiv up (does not overflow) and
-	 * add kdiv before multiplying. The use of tmp is to avoid any
-	 * overflows before shifting bac down into result when multipling
-	 * by the mdiv and kdiv pair.
-	 */
-
-	tmp = baseclk;
-	tmp *= (mdiv << 16) + kdiv;
-	do_div(tmp, (pdiv << sdiv));
-	result = tmp >> 16;
-
-	return result;
-}
-- 
1.7.1
