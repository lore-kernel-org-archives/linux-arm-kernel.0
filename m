From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:19:06 +0100
Subject: [PATCH v2 09/10] ARM: S3C24XX: modify s3c2412 irq init to initialize
 all irqs
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091819.06304.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Combines the two independent init steps for the irqs into one.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.h        |    1 +
 arch/arm/mach-s3c24xx/irq.c           |   19 +++----------------
 arch/arm/mach-s3c24xx/mach-jive.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c |    6 +++---
 arch/arm/mach-s3c24xx/mach-vstms.c    |    2 +-
 5 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 362a8cd..abefeb3 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -36,6 +36,7 @@ extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2412_init_clocks(int xtal);
 extern  int s3c2412_baseclk_add(void);
 extern void s3c2412_restart(char mode, const char *cmd);
+extern void s3c2412_init_irq(void);
 #else
 #define s3c2412_init_clocks NULL
 #define s3c2412_init_uarts NULL
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 905cb21..bf1e964 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -745,10 +745,12 @@ static struct irq_chip s3c2412_irq_cfsdi = {
 	.irq_unmask	= s3c2412_irq_cfsdi_unmask,
 };
 
-static int s3c2412_irq_add(struct device *dev, struct subsys_interface *sif)
+void s3c2412_init_irq(void)
 {
 	unsigned int irqno;
 
+	s3c24xx_init_irq();
+
 	for (irqno = IRQ_EINT0; irqno <= IRQ_EINT3; irqno++) {
 		irq_set_chip_and_handler(irqno, &s3c2412_irq_eint0t4,
 					 handle_edge_irq);
@@ -764,22 +766,7 @@ static int s3c2412_irq_add(struct device *dev, struct subsys_interface *sif)
 					 handle_level_irq);
 		set_irq_flags(irqno, IRQF_VALID);
 	}
-
-	return 0;
 }
-
-static struct subsys_interface s3c2412_irq_interface = {
-	.name		= "s3c2412_irq",
-	.subsys		= &s3c2412_subsys,
-	.add_dev	= s3c2412_irq_add,
-};
-
-static int s3c2412_irq_init(void)
-{
-	return subsys_interface_register(&s3c2412_irq_interface);
-}
-
-arch_initcall(s3c2412_irq_init);
 #endif
 
 #ifdef CONFIG_CPU_S3C2416
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 0c8c733..0d06c53 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -660,7 +660,7 @@ MACHINE_START(JIVE, "JIVE")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
 
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2412_init_irq,
 	.map_io		= jive_map_io,
 	.init_machine	= jive_machine_init,
 	.init_time	= samsung_timer_init,
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index d5ef86d..9b3f814 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -131,7 +131,7 @@ MACHINE_START(S3C2413, "S3C2413")
 	.atag_offset	= 0x100,
 
 	.fixup		= smdk2413_fixup,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2412_init_irq,
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
@@ -143,7 +143,7 @@ MACHINE_START(SMDK2412, "SMDK2412")
 	.atag_offset	= 0x100,
 
 	.fixup		= smdk2413_fixup,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2412_init_irq,
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
@@ -155,7 +155,7 @@ MACHINE_START(SMDK2413, "SMDK2413")
 	.atag_offset	= 0x100,
 
 	.fixup		= smdk2413_fixup,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2412_init_irq,
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index 622a1ed..b665884 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -158,7 +158,7 @@ MACHINE_START(VSTMS, "VSTMS")
 	.atag_offset	= 0x100,
 
 	.fixup		= vstms_fixup,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2412_init_irq,
 	.init_machine	= vstms_init,
 	.map_io		= vstms_map_io,
 	.init_time	= samsung_timer_init,
-- 
1.7.2.3
