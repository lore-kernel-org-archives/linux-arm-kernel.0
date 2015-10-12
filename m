From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 15:44:49 +0200
Subject: [PATCH] ARM: pxa: fix pxa3xx DFI lockup hack
Message-ID: <5287252.pkh9x0t1Y6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some recently added code to avoid a bug introduced a build error
when CONFIG_PM is disabled and a macro is hidden:

arch/arm/mach-pxa/pxa3xx.c: In function 'pxa3xx_init':
arch/arm/mach-pxa/pxa3xx.c:439:3: error: 'NDCR' undeclared (first use in this function)
   NDCR = (NDCR & ~NDCR_ND_ARB_EN) | NDCR_ND_ARB_CNTL;
   ^

This moves the macro outside of the #ifdef so it can be
referenced correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: adf3442cc890 ("ARM: pxa: fix DFI bus lockups on startup")
---
We merged the patch that introduced this as a fix for 4.3, so we should
probably add this one too.

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 06005d3f2ba3..20ce2d386f17 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -42,10 +42,6 @@
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
 extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
-#ifdef CONFIG_PM
-
-#define ISRAM_START	0x5c000000
-#define ISRAM_SIZE	SZ_256K
 
 /*
  * NAND NFC: DFI bus arbitration subset
@@ -54,6 +50,11 @@ extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
 #define NDCR_ND_ARB_EN		(1 << 12)
 #define NDCR_ND_ARB_CNTL	(1 << 19)
 
+#ifdef CONFIG_PM
+
+#define ISRAM_START	0x5c000000
+#define ISRAM_SIZE	SZ_256K
+
 static void __iomem *sram;
 static unsigned long wakeup_src;
 
