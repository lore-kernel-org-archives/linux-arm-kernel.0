From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:32:00 +0900
Subject: [PATCH 21/22] ARM: shmobile: r8a7778: remove r8a7778_init_irq()
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <54aa4c48bc0d364565e7d1c722b07314efdc2a10.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch removes r8a7778_init_irq(), since no-one is using it.
And now, there is no reason to have r8a7778_init_irq_common().
r8a7778_init_irq_dt() includes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |   37 ++++++-------------------
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 851d027..9b561bf 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -33,7 +33,6 @@ extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
 
 extern void r8a7778_init_late(void);
 extern void r8a7778_init_delay(void);
-extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 2a101eb..a3a2e37 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -408,17 +408,25 @@ void __init r8a7778_init_irq_extpin(int irlm)
 			&irqpin_platform_data, sizeof(irqpin_platform_data));
 }
 
+void __init r8a7778_init_delay(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+}
+
+#ifdef CONFIG_USE_OF
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
 #define INT2SMSKCR1	0x8228c /* 0xfe78228c */
 
 #define INT2NTSR0	0x00018 /* 0xfe700018 */
 #define INT2NTSR1	0x0002c /* 0xfe70002c */
-static void __init r8a7778_init_irq_common(void)
+void __init r8a7778_init_irq_dt(void)
 {
 	void __iomem *base = ioremap_nocache(0xfe700000, 0x00100000);
 
 	BUG_ON(!base);
 
+	irqchip_init();
+
 	/* route all interrupts to ARM */
 	__raw_writel(0x73ffffff, base + INT2NTSR0);
 	__raw_writel(0xffffffff, base + INT2NTSR1);
@@ -430,33 +438,6 @@ static void __init r8a7778_init_irq_common(void)
 	iounmap(base);
 }
 
-void __init r8a7778_init_irq(void)
-{
-	void __iomem *gic_dist_base;
-	void __iomem *gic_cpu_base;
-
-	gic_dist_base = ioremap_nocache(0xfe438000, PAGE_SIZE);
-	gic_cpu_base  = ioremap_nocache(0xfe430000, PAGE_SIZE);
-	BUG_ON(!gic_dist_base || !gic_cpu_base);
-
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-
-	r8a7778_init_irq_common();
-}
-
-void __init r8a7778_init_delay(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-}
-
-#ifdef CONFIG_USE_OF
-void __init r8a7778_init_irq_dt(void)
-{
-	irqchip_init();
-	r8a7778_init_irq_common();
-}
-
 static const char *r8a7778_compat_dt[] __initdata = {
 	"renesas,r8a7778",
 	NULL,
-- 
1.7.10.4
