From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 16:07:56 +0200
Subject: [PATCH] ARM: mmp: replace NO_IRQ
Message-ID: <20160906140808.2883875-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmp platform has its own definitions with the old NO_IRQ meaning,
but compares against the global NO_IRQ macro that we should have
removed long ago.

The specific usage in arch/arm/mach-mmp/devices.c is awkward, but
fixing it properly would require a larger scale rewrite of the entire
file, or even using devicetree for all machines. As I'm not able to
do that any time soon, let's make the current behavior more explit
instead and avoid the literal use of NO_IRQ.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/devices.c | 2 +-
 arch/arm/mach-mmp/irqs.h    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 671c7a09ab3d..d0cd9687d6b2 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -39,7 +39,7 @@ int __init pxa_register_device(struct pxa_device_desc *desc,
 		nres++;
 	}
 
-	if (desc->irq != NO_IRQ) {
+	if (desc->irq != IRQ_MMP_NONE) {
 		res[nres].start	= desc->irq;
 		res[nres].end	= desc->irq;
 		res[nres].flags	= IORESOURCE_IRQ;
diff --git a/arch/arm/mach-mmp/irqs.h b/arch/arm/mach-mmp/irqs.h
index fb492a50a817..4f9f27ae4dbc 100644
--- a/arch/arm/mach-mmp/irqs.h
+++ b/arch/arm/mach-mmp/irqs.h
@@ -1,10 +1,12 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
+#define IRQ_MMP_NONE			(-1)
+
 /*
  * Interrupt numbers for PXA168
  */
-#define IRQ_PXA168_NONE			(-1)
+#define IRQ_PXA168_NONE			IRQ_MMP_NONE
 #define IRQ_PXA168_SSP4			0
 #define IRQ_PXA168_SSP3			1
 #define IRQ_PXA168_SSP2			2
@@ -54,7 +56,7 @@
 /*
  * Interrupt numbers for PXA910
  */
-#define IRQ_PXA910_NONE			(-1)
+#define IRQ_PXA910_NONE			IRQ_MMP_NONE
 #define IRQ_PXA910_AIRQ			0
 #define IRQ_PXA910_SSP3			1
 #define IRQ_PXA910_SSP2			2
@@ -116,7 +118,7 @@
 /*
  * Interrupt numbers for MMP2
  */
-#define IRQ_MMP2_NONE			(-1)
+#define IRQ_MMP2_NONE			IRQ_MMP_NONE
 #define IRQ_MMP2_SSP1			0
 #define IRQ_MMP2_SSP2			1
 #define IRQ_MMP2_SSPA1			2
-- 
2.9.0
