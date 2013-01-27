From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 27 Jan 2013 21:48:58 +0100
Subject: [PATCH v4 8/9] ARM: S3C24XX: modify s3c2443 irq init to initialize
 all irqs
In-Reply-To: <201301272124.18530.heiko@sntech.de>
References: <201301272124.18530.heiko@sntech.de>
Message-ID: <201301272148.59059.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the irq init used s3c24xx_init_irq and an additional
arch_initcall to add the cpu specific irqs.

To be able to simplyfy the irq init later, create a new function
s3c2443_init_irq, which then calls s3c24xx_init_irq but also adds
the cpu specific irqs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/mach-smdk2443.c        |    2 +-
 arch/arm/plat-s3c24xx/irq.c                  |   22 ++++------------------
 arch/arm/plat-samsung/include/plat/s3c2443.h |    2 ++
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index c6d1a03..8b65a54 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -140,7 +140,7 @@ MACHINE_START(SMDK2443, "SMDK2443")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
 
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2443_init_irq,
 	.map_io		= smdk2443_map_io,
 	.init_machine	= smdk2443_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 0a051eb..4cf3c13 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -935,10 +935,11 @@ static int s3c2443_add_sub(unsigned int base,
 	return 0;
 }
 
-static int s3c2443_irq_add(struct device *dev,
-				  struct subsys_interface *sif)
+void __init s3c2443_init_irq(void)
 {
-	printk("S3C2443: IRQ Support\n");
+	pr_info("S3C2443: IRQ Support\n");
+
+	s3c24xx_init_irq();
 
 	s3c2443_add_sub(IRQ_CAM, s3c2443_irq_demux_cam, &s3c2443_irq_cam,
 			IRQ_S3C2440_CAM_C, IRQ_S3C2440_CAM_P);
@@ -956,20 +957,5 @@ static int s3c2443_irq_add(struct device *dev,
 	s3c2443_add_sub(IRQ_WDT, s3c2443_irq_demux_wdtac97,
 			&s3c2443_irq_wdtac97,
 			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
-
-	return 0;
 }
-
-static struct subsys_interface s3c2443_irq_interface = {
-	.name		= "s3c2443_irq",
-	.subsys		= &s3c2443_subsys,
-	.add_dev	= s3c2443_irq_add,
-};
-
-static int __init s3c2443_irq_init(void)
-{
-	return subsys_interface_register(&s3c2443_irq_interface);
-}
-
-arch_initcall(s3c2443_irq_init);
 #endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
index a5b794f..71b88ec 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2443.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2443.h
@@ -25,6 +25,8 @@ extern void s3c2443_init_clocks(int xtal);
 extern  int s3c2443_baseclk_add(void);
 
 extern void s3c2443_restart(char mode, const char *cmd);
+
+extern void s3c2443_init_irq(void);
 #else
 #define s3c2443_init_clocks NULL
 #define s3c2443_init_uarts NULL
-- 
1.7.10.4
