From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 26 Feb 2013 23:58:55 +0100
Subject: [PATCH 3/5] ARM: S3C24XX: move s3c24xx_init_irq to s3c2410_init_irq
In-Reply-To: <201302262357.24544.heiko@sntech.de>
References: <201302262357.24544.heiko@sntech.de>
Message-ID: <201302262358.56015.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c24xx_init_irq function that was the base for all irq inits
is now only used to initialize the real s3c2410 irqs.

Therefore rename it and also move its declaration from plat/cpu.h
to common.h

The eint declaration is used by the vast majority of the SoCs and
gets therefore placed outside any ifdefs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.h           |    1 +
 arch/arm/mach-s3c24xx/irq.c              |   69 ++++++++++++++---------------
 arch/arm/mach-s3c24xx/mach-amlm5900.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-bast.c        |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c       |    7 +---
 arch/arm/mach-s3c24xx/mach-n30.c         |    4 +-
 arch/arm/mach-s3c24xx/mach-otom.c        |    2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c      |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c  |    2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c      |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h |    1 -
 12 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index abefeb3..307c371 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -21,6 +21,7 @@ extern void s3c2410_map_io(void);
 extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2410_init_clocks(int xtal);
 extern void s3c2410_restart(char mode, const char *cmd);
+extern void s3c2410_init_irq(void);
 #else
 #define s3c2410_init_clocks NULL
 #define s3c2410_init_uarts NULL
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index a6a7554..ee47654 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -509,12 +509,35 @@ err:
 	return ERR_PTR(ret);
 }
 
-/* s3c24xx_init_irq
- *
- * Initialise S3C2410 IRQ system
-*/
+static struct s3c_irq_data init_eint[32] = {
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT4 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT5 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT6 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT7 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT8 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT9 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT10 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT11 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT12 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT13 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT14 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT15 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT16 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT17 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT18 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT19 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT20 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT21 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT22 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT23 */
+};
 
-static struct s3c_irq_data init_base[32] = {
+#ifdef CONFIG_CPU_S3C2410
+static struct s3c_irq_data init_s3c2410base[32] = {
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT2 */
@@ -549,34 +572,7 @@ static struct s3c_irq_data init_base[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
 };
 
-static struct s3c_irq_data init_eint[32] = {
-	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
-	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
-	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
-	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT4 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT5 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT6 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT7 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT8 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT9 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT10 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT11 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT12 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT13 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT14 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT15 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT16 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT17 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT18 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT19 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT20 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT21 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT22 */
-	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT23 */
-};
-
-static struct s3c_irq_data init_subint[32] = {
+static struct s3c_irq_data init_s3c2410subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-ERR */
@@ -590,7 +586,7 @@ static struct s3c_irq_data init_subint[32] = {
 	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
 };
 
-void __init s3c24xx_init_irq(void)
+void __init s3c2410_init_irq(void)
 {
 	struct s3c_irq_intc *main_intc;
 
@@ -598,15 +594,16 @@ void __init s3c24xx_init_irq(void)
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_base[0], NULL, 0x4a000000);
+	main_intc = s3c24xx_init_intc(NULL, &init_s3c2410base[0], NULL, 0x4a000000);
 	if (IS_ERR(main_intc)) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_s3c2410subint[0], main_intc, 0x4a000018);
 	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
 }
+#endif
 
 #ifdef CONFIG_CPU_S3C2412
 static struct s3c_irq_data init_s3c2412base[32] = {
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 40d59de..dc720ad 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -238,7 +238,7 @@ static void __init amlm5900_init(void)
 MACHINE_START(AML_M5900, "AML_M5900")
 	.atag_offset	= 0x100,
 	.map_io		= amlm5900_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_machine	= amlm5900_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 8089156..82ed39e 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -605,7 +605,7 @@ MACHINE_START(BAST, "Simtec-BAST")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
 	.atag_offset	= 0x100,
 	.map_io		= bast_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_machine	= bast_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 0872971..c0c24e9 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -667,11 +667,6 @@ static void __init h1940_reserve(void)
 	memblock_reserve(0x30081000, 0x1000);
 }
 
-static void __init h1940_init_irq(void)
-{
-	s3c24xx_init_irq();
-}
-
 static void __init h1940_init(void)
 {
 	u32 tmp;
@@ -740,7 +735,7 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.atag_offset	= 0x100,
 	.map_io		= h1940_map_io,
 	.reserve	= h1940_reserve,
-	.init_irq	= h1940_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_machine	= h1940_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 55f52a5..c19e6a5 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -592,7 +592,7 @@ MACHINE_START(N30, "Acer-N30")
 	.atag_offset	= 0x100,
 	.init_time	= samsung_timer_init,
 	.init_machine	= n30_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
 	.restart	= s3c2410_restart,
 MACHINE_END
@@ -603,7 +603,7 @@ MACHINE_START(N35, "Acer-N35")
 	.atag_offset	= 0x100,
 	.init_time	= samsung_timer_init,
 	.init_machine	= n30_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index ebbd840..1491c6d 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -116,7 +116,7 @@ MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	.atag_offset	= 0x100,
 	.map_io		= otom11_map_io,
 	.init_machine	= otom11_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 18e1c5f..ef29d6a 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -343,7 +343,7 @@ static void __init qt2410_machine_init(void)
 MACHINE_START(QT2410, "QT2410")
 	.atag_offset	= 0x100,
 	.map_io		= qt2410_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_machine	= qt2410_machine_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index d0fa44f..048553d 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -116,7 +116,7 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
 	/* Maintainer: Jonas Dietsche */
 	.atag_offset	= 0x100,
 	.map_io		= smdk2410_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_machine	= smdk2410_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 5ad39d0..d67c14d 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -149,7 +149,7 @@ static void __init tct_hammer_init(void)
 MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
 	.atag_offset	= 0x100,
 	.map_io		= tct_hammer_map_io,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_machine	= tct_hammer_init,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 0e2a215..c1cdd8c 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -355,7 +355,7 @@ MACHINE_START(VR1000, "Thorcom-VR1000")
 	.atag_offset	= 0x100,
 	.map_io		= vr1000_map_io,
 	.init_machine	= vr1000_init,
-	.init_irq	= s3c24xx_init_irq,
+	.init_irq	= s3c2410_init_irq,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 0f6c47a..989fefe 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -183,7 +183,6 @@ extern void s3c_init_cpu(unsigned long idcode,
 
 /* core initialisation functions */
 
-extern void s3c24xx_init_irq(void);
 extern void s5p_init_irq(u32 *vic, u32 num_vic);
 
 extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
-- 
1.7.2.3
