From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:34 +0100
Subject: [PATCH 37/62] ARM: sa1100/pxa: fix MTD_XIP build
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-38-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 3169663ac5902 "ARM: sa11x0/pxa: convert OS timer registers
to IOMEM", the definition of the OSCR macro was changed to be an
__iomem pointer, but the same register is also used by the XIP
code. This patch does the corresponding change here as well.

Since PXA now uses a local variable for the base address of the
ICIP register, the xip_irqpending function has to be moved
into irq.c in the process.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-pxa/include/mach/mtd-xip.h    | 7 ++++---
 arch/arm/mach-pxa/irq.c                     | 8 ++++++++
 arch/arm/mach-sa1100/include/mach/mtd-xip.h | 4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mtd-xip.h b/arch/arm/mach-pxa/include/mach/mtd-xip.h
index 990d2bf..c4c90d1 100644
--- a/arch/arm/mach-pxa/include/mach/mtd-xip.h
+++ b/arch/arm/mach-pxa/include/mach/mtd-xip.h
@@ -17,11 +17,12 @@
 
 #include <mach/regs-ost.h>
 
-#define xip_irqpending()	(ICIP & ICMR)
+extern bool xip_irqpending(void);
 
 /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
+#define xip_irqpending()	xip_irqpending()
+#define xip_currtime()		readl(OSCR)
+#define xip_elapsed_since(x)	(signed)((readl(OSCR) - (x)) / 4)
 
 /*
  * xip_cpu_idle() is used when waiting for a delay equal or larger than
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 0eecd83..dcc8522 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -81,6 +81,14 @@ void pxa_unmask_irq(struct irq_data *d)
 	__raw_writel(icmr, base + ICMR);
 }
 
+#ifdef CONFIG_MTD_XIP
+bool xip_irqpending(void)
+{
+	return readl(pxa_irq_base + ICIP) & readl(pxa_irq_base + ICMR);
+}
+EXPORT_SYMBOL_GPL(xip_irqpending);
+#endif
+
 static struct irq_chip pxa_internal_irq_chip = {
 	.name		= "SC",
 	.irq_ack	= pxa_mask_irq,
diff --git a/arch/arm/mach-sa1100/include/mach/mtd-xip.h b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
index b3d6840..cb76096 100644
--- a/arch/arm/mach-sa1100/include/mach/mtd-xip.h
+++ b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
@@ -20,7 +20,7 @@
 #define xip_irqpending()	(ICIP & ICMR)
 
 /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
+#define xip_currtime()		readl_relaxed(OSCR)
+#define xip_elapsed_since(x)	(signed)((readl_relaxed(OSCR) - (x)) / 4)
 
 #endif /* __ARCH_SA1100_MTD_XIP_H__ */
-- 
1.8.3.2
