From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:48 +0900
Subject: [PATCH 07/12] ARM: shmobile: r8a7740: Add OF support to initialze the
 GIC
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

We add a variant to initalize the interrupt controller in case we describe
the GIC using the Device Tree and not platform data.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
 arch/arm/mach-shmobile/intc-r8a7740.c         |   24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index abdc4d4..19c0423 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -534,6 +534,7 @@ enum {
 
 extern void r8a7740_meram_workaround(void);
 extern void r8a7740_init_irq(void);
+extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index b741c84..8871f77 100644
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ b/arch/arm/mach-shmobile/intc-r8a7740.c
@@ -20,19 +20,15 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 
-void __init r8a7740_init_irq(void)
+static void __init r8a7740_init_irq_common(void)
 {
-	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
-	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
 	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
 	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
 	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
 
-	/* initialize the Generic Interrupt Controller PL390 r0p0 */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-
 	/* route signals to GIC */
 	iowrite32(0x0, pfc_inta_ctrl);
 
@@ -54,3 +50,19 @@ void __init r8a7740_init_irq(void)
 	iounmap(intc_msk_base);
 	iounmap(pfc_inta_ctrl);
 }
+
+void __init r8a7740_init_irq_of(void)
+{
+	irqchip_init();
+	r8a7740_init_irq_common();
+}
+
+void __init r8a7740_init_irq(void)
+{
+	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
+
+	/* initialize the Generic Interrupt Controller PL390 r0p0 */
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+	r8a7740_init_irq_common();
+}
-- 
1.7.10.4
