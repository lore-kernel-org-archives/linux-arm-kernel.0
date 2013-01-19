From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 19 Jan 2013 04:07:44 +0100
Subject: [PATCH v3 5/9] ARM: S3C24XX: modify s3c2416 irq init to initialize
 all irqs
In-Reply-To: <201301190403.50317.heiko@sntech.de>
References: <201301190403.50317.heiko@sntech.de>
Message-ID: <201301190407.44867.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the irq init used s3c24xx_init_irq and an additional
arch_initcall to add the cpu specific irqs.

To be able to simplyfy the irq init later, create a new function
s3c416_init_irq, which then calls s3c24xx_init_irq but also adds
the cpu specific irqs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/mach-smdk2416.c        |    2 +-
 arch/arm/plat-s3c24xx/irq.c                  |   22 ++++------------------
 arch/arm/plat-samsung/include/plat/s3c2416.h |    1 +
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index 7de4120..2abb66f 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -250,7 +250,7 @@ MACHINE_START(SMDK2416, "SMDK2416")
 	/* Maintainer: Yauhen Kharuzhy <jekhor@gmail.com> */
 	.atag_offset	= 0x100,
 
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2416_init_irq,
 	.map_io		= smdk2416_map_io,
 	.init_machine	= smdk2416_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 137dc16..fe6d278 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -874,10 +874,11 @@ static void s3c2416_irq_add_second(void)
 	}
 }
 
-static int s3c2416_irq_add(struct device *dev,
-				  struct subsys_interface *sif)
+void __init s3c2416_init_irq(void)
 {
-	printk(KERN_INFO "S3C2416: IRQ Support\n");
+	pr_info("S3C2416: IRQ Support\n");
+
+	s3c24xx_init_irq();
 
 	s3c2416_add_sub(IRQ_LCD, s3c2416_irq_demux_lcd, &s3c2416_irq_lcd,
 			IRQ_S3C2443_LCD2, IRQ_S3C2443_LCD4);
@@ -894,21 +895,6 @@ static int s3c2416_irq_add(struct device *dev,
 			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
 
 	s3c2416_irq_add_second();
-
-	return 0;
 }
 
-static struct subsys_interface s3c2416_irq_interface = {
-	.name		= "s3c2416_irq",
-	.subsys		= &s3c2416_subsys,
-	.add_dev	= s3c2416_irq_add,
-};
-
-static int __init s3c2416_irq_init(void)
-{
-	return subsys_interface_register(&s3c2416_irq_interface);
-}
-
-arch_initcall(s3c2416_irq_init);
-
 #endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2416.h b/arch/arm/plat-samsung/include/plat/s3c2416.h
index 7178e33..f27399a 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2416.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2416.h
@@ -25,6 +25,7 @@ extern  int s3c2416_baseclk_add(void);
 
 extern void s3c2416_restart(char mode, const char *cmd);
 
+extern void s3c2416_init_irq(void);
 extern struct syscore_ops s3c2416_irq_syscore_ops;
 
 #else
-- 
1.7.2.3
