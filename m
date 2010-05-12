From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:55 +0100
Subject: [PATCH 04/15] ARM: SAMSUNG: Move S3C6400 PLL code to <plat/pll.h> for
	re-use
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C6400 EPLL code matches the S3C2416 and compatible SoCs, so move
it from mach-s3c64xx into <plat/pll.h> for easy reuse.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/include/mach/pll.h      |   35 +---------------
 arch/arm/plat-samsung/include/plat/pll6553x.h |   51 +++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/pll6553x.h

diff --git a/arch/arm/mach-s3c64xx/include/mach/pll.h b/arch/arm/mach-s3c64xx/include/mach/pll.h
index 90bbd72..5ef0bb6 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pll.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pll.h
@@ -20,6 +20,7 @@
 #define S3C6400_PLL_SDIV_SHIFT	(0)
 
 #include <asm/div64.h>
+#include <plat/pll6553x.h>
 
 static inline unsigned long s3c6400_get_pll(unsigned long baseclk,
 					    u32 pllcon)
@@ -37,38 +38,8 @@ static inline unsigned long s3c6400_get_pll(unsigned long baseclk,
 	return (unsigned long)fvco;
 }
 
-#define S3C6400_EPLL_MDIV_MASK	((1 << (23-16)) - 1)
-#define S3C6400_EPLL_PDIV_MASK	((1 << (13-8)) - 1)
-#define S3C6400_EPLL_SDIV_MASK	((1 << (2-0)) - 1)
-#define S3C6400_EPLL_MDIV_SHIFT	(16)
-#define S3C6400_EPLL_PDIV_SHIFT	(8)
-#define S3C6400_EPLL_SDIV_SHIFT	(0)
-#define S3C6400_EPLL_KDIV_MASK  (0xffff)
-
 static inline unsigned long s3c6400_get_epll(unsigned long baseclk)
 {
-	unsigned long result;
-	u32 epll0 = __raw_readl(S3C_EPLL_CON0);
-	u32 epll1 = __raw_readl(S3C_EPLL_CON1);
-	u32 mdiv, pdiv, sdiv, kdiv;
-	u64 tmp;
-
-	mdiv = (epll0 >> S3C6400_EPLL_MDIV_SHIFT) & S3C6400_EPLL_MDIV_MASK;
-	pdiv = (epll0 >> S3C6400_EPLL_PDIV_SHIFT) & S3C6400_EPLL_PDIV_MASK;
-	sdiv = (epll0 >> S3C6400_EPLL_SDIV_SHIFT) & S3C6400_EPLL_SDIV_MASK;
-	kdiv = epll1 & S3C6400_EPLL_KDIV_MASK;
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
+	return s3c_get_pll6553x(baseclk, __raw_readl(S3C_EPLL_CON0),
+				__raw_readl(S3C_EPLL_CON1));
 }
diff --git a/arch/arm/plat-samsung/include/plat/pll6553x.h b/arch/arm/plat-samsung/include/plat/pll6553x.h
new file mode 100644
index 0000000..b8b7e1d
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/pll6553x.h
@@ -0,0 +1,51 @@
+/* arch/arm/plat-samsung/include/plat/pll6553x.h
+ *	partially from arch/arm/mach-s3c64xx/include/mach/pll.h
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * Samsung PLL6553x PLL code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* S3C6400 and compatible (S3C2416, etc.) EPLL code */
+
+#define PLL6553X_MDIV_MASK	((1 << (23-16)) - 1)
+#define PLL6553X_PDIV_MASK	((1 << (13-8)) - 1)
+#define PLL6553X_SDIV_MASK	((1 << (2-0)) - 1)
+#define PLL6553X_MDIV_SHIFT	(16)
+#define PLL6553X_PDIV_SHIFT	(8)
+#define PLL6553X_SDIV_SHIFT	(0)
+#define PLL6553X_KDIV_MASK	(0xffff)
+
+static inline unsigned long s3c_get_pll6553x(unsigned long baseclk,
+					     u32 pll0, u32 pll1)
+{
+	unsigned long result;
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (pll0 >> PLL6553X_MDIV_SHIFT) & PLL6553X_MDIV_MASK;
+	pdiv = (pll0 >> PLL6553X_PDIV_SHIFT) & PLL6553X_PDIV_MASK;
+	sdiv = (pll0 >> PLL6553X_SDIV_SHIFT) & PLL6553X_SDIV_MASK;
+	kdiv = pll1 & PLL6553X_KDIV_MASK;
+
+	/* We need to multiple baseclk by mdiv (the integer part) and kdiv
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
-- 
1.6.3.3
