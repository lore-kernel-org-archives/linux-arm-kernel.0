From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:12:40 +0100
Subject: [PATCH v2 02/10] ARM: S3C24XX: create dedicated irq init functions
 for s3c2440 and s3c2442
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091812.40543.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2440 and s3c2442 need separate init functions, as the s3c2440 contains
even more differing irqs that will be moved in the following patch.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.h         |    2 +
 arch/arm/mach-s3c24xx/irq.c            |   45 ++++++++++++++++---------------
 arch/arm/mach-s3c24xx/mach-anubis.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c  |    2 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c  |    2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c    |    7 +----
 arch/arm/mach-s3c24xx/mach-smdk2440.c  |    2 +-
 11 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 8a2b413..362a8cd 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -73,6 +73,7 @@ extern void s3c244x_restart(char mode, const char *cmd);
 #ifdef CONFIG_CPU_S3C2440
 extern  int s3c2440_init(void);
 extern void s3c2440_map_io(void);
+extern void s3c2440_init_irq(void);
 #else
 #define s3c2440_init NULL
 #define s3c2440_map_io NULL
@@ -81,6 +82,7 @@ extern void s3c2440_map_io(void);
 #ifdef CONFIG_CPU_S3C2442
 extern  int s3c2442_init(void);
 extern void s3c2442_map_io(void);
+extern void s3c2442_init_irq(void);
 #else
 #define s3c2442_init NULL
 #define s3c2442_map_io NULL
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 95f971f..c544e00 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -785,10 +785,13 @@ static struct irq_chip s3c_irq_cam = {
 	.irq_ack	= s3c_irq_cam_ack,
 };
 
-static int s3c244x_irq_add(struct device *dev, struct subsys_interface *sif)
+#ifdef CONFIG_CPU_S3C2440
+void __init s3c2440_init_irq(void)
 {
 	unsigned int irqno;
 
+	s3c24xx_init_irq();
+
 	irq_set_chip_and_handler(IRQ_NFCON, &s3c_irq_level_chip,
 				 handle_level_irq);
 	set_irq_flags(IRQ_NFCON, IRQF_VALID);
@@ -804,36 +807,34 @@ static int s3c244x_irq_add(struct device *dev, struct subsys_interface *sif)
 					 handle_level_irq);
 		set_irq_flags(irqno, IRQF_VALID);
 	}
-
-	return 0;
 }
+#endif
 
-static struct subsys_interface s3c2440_irq_interface = {
-	.name		= "s3c2440_irq",
-	.subsys		= &s3c2440_subsys,
-	.add_dev	= s3c244x_irq_add,
-};
-
-static int s3c2440_irq_init(void)
+#ifdef CONFIG_CPU_S3C2442
+void __init s3c2442_init_irq(void)
 {
-	return subsys_interface_register(&s3c2440_irq_interface);
-}
+	unsigned int irqno;
 
-arch_initcall(s3c2440_irq_init);
+	s3c24xx_init_irq();
 
-static struct subsys_interface s3c2442_irq_interface = {
-	.name		= "s3c2442_irq",
-	.subsys		= &s3c2442_subsys,
-	.add_dev	= s3c244x_irq_add,
-};
+	irq_set_chip_and_handler(IRQ_NFCON, &s3c_irq_level_chip,
+				 handle_level_irq);
+	set_irq_flags(IRQ_NFCON, IRQF_VALID);
 
+	/* add chained handler for camera */
 
-static int s3c2442_irq_init(void)
-{
-	return subsys_interface_register(&s3c2442_irq_interface);
+	irq_set_chip_and_handler(IRQ_CAM, &s3c_irq_level_chip,
+				 handle_level_irq);
+	irq_set_chained_handler(IRQ_CAM, s3c_irq_demux_cam);
+
+	for (irqno = IRQ_S3C2440_CAM_C; irqno <= IRQ_S3C2440_CAM_P; irqno++) {
+		irq_set_chip_and_handler(irqno, &s3c_irq_cam,
+					 handle_level_irq);
+		set_irq_flags(irqno, IRQF_VALID);
+	}
 }
+#endif
 
-arch_initcall(s3c2442_irq_init);
 #endif
 
 #ifdef CONFIG_CPU_S3C2443
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 24f1a04..c1fb6c3 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -445,7 +445,7 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.atag_offset	= 0x100,
 	.map_io		= anubis_map_io,
 	.init_machine	= anubis_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 2bf6c8c..6dfeeb7 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -211,7 +211,7 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.atag_offset	= 0x100,
 	.map_io		= at2440evb_map_io,
 	.init_machine	= at2440evb_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 84a750d..13d8d07 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -589,7 +589,7 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	/* Maintainer: Nelson Castillo <arhuaco@freaks-unidos.net> */
 	.atag_offset	= 0x100,
 	.map_io		= gta02_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2442_init_irq,
 	.init_machine	= gta02_machine_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 29f106c..a83db46 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -688,7 +688,7 @@ MACHINE_START(MINI2440, "MINI2440")
 	.atag_offset	= 0x100,
 	.map_io		= mini2440_map_io,
 	.init_machine	= mini2440_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 5c826d1..01f4354 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -152,7 +152,7 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.atag_offset	= 0x100,
 	.map_io		= nexcoder_map_io,
 	.init_machine	= nexcoder_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index ef3a7b0..de78fbb 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -425,7 +425,7 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
 	.atag_offset	= 0x100,
 	.map_io		= osiris_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.init_machine	= osiris_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 64b52a9..44ca018 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -812,7 +812,7 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.atag_offset = 0x100,
 	.map_io = rx1950_map_io,
 	.reserve	= rx1950_reserve,
-	.init_irq = s3c24xx_init_irq,
+	.init_irq	= s3c2442_init_irq,
 	.init_machine = rx1950_init_machine,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 0a3c964..3bc6231 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -190,11 +190,6 @@ static void __init rx3715_reserve(void)
 	memblock_reserve(0x30081000, 0x1000);
 }
 
-static void __init rx3715_init_irq(void)
-{
-	s3c24xx_init_irq();
-}
-
 static void __init rx3715_init_machine(void)
 {
 #ifdef CONFIG_PM_H1940
@@ -212,7 +207,7 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.atag_offset	= 0x100,
 	.map_io		= rx3715_map_io,
 	.reserve	= rx3715_reserve,
-	.init_irq	= rx3715_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.init_machine	= rx3715_init_machine,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c244x_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 3f13e85..90be6d0 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -178,7 +178,7 @@ MACHINE_START(S3C2440, "SMDK2440")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
 
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2440_init_irq,
 	.map_io		= smdk2440_map_io,
 	.init_machine	= smdk2440_machine_init,
 	.init_time	= samsung_timer_init,
-- 
1.7.2.3
