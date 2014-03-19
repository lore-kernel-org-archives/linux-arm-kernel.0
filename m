From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:48 +0100
Subject: [PATCH 51/62] ARM: samsung: allow serial driver to be disabled
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-52-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_SERIAL_SAMSUNG is disabled, we run into build errors
with some samsung platforms. This adds a couple of #ifdef
statements to hopefully deal with this more gracefully.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/irq-pm.c | 12 +++++++++---
 arch/arm/mach-s5p64x0/irq-pm.c |  6 ++++++
 arch/arm/plat-samsung/init.c   |  4 ++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/irq-pm.c b/arch/arm/mach-s3c64xx/irq-pm.c
index a61247b..ae4ea76 100644
--- a/arch/arm/mach-s3c64xx/irq-pm.c
+++ b/arch/arm/mach-s3c64xx/irq-pm.c
@@ -55,7 +55,13 @@ static struct irq_grp_save {
 	u32	mask;
 } eint_grp_save[5];
 
-static u32 irq_uart_mask[CONFIG_SERIAL_SAMSUNG_UARTS];
+#ifndef CONFIG_SERIAL_SAMSUNG_UARTS
+#define SERIAL_SAMSUNG_UARTS 0
+#else
+#define	SERIAL_SAMSUNG_UARTS CONFIG_SERIAL_SAMSUNG_UARTS
+#endif
+
+static u32 irq_uart_mask[SERIAL_SAMSUNG_UARTS];
 
 static int s3c64xx_irq_pm_suspend(void)
 {
@@ -66,7 +72,7 @@ static int s3c64xx_irq_pm_suspend(void)
 
 	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
 
-	for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)
+	for (i = 0; i < SERIAL_SAMSUNG_UARTS; i++)
 		irq_uart_mask[i] = __raw_readl(S3C_VA_UARTx(i) + S3C64XX_UINTM);
 
 	for (i = 0; i < ARRAY_SIZE(eint_grp_save); i++, grp++) {
@@ -87,7 +93,7 @@ static void s3c64xx_irq_pm_resume(void)
 
 	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
 
-	for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)
+	for (i = 0; i < SERIAL_SAMSUNG_UARTS; i++)
 		__raw_writel(irq_uart_mask[i], S3C_VA_UARTx(i) + S3C64XX_UINTM);
 
 	for (i = 0; i < ARRAY_SIZE(eint_grp_save); i++, grp++) {
diff --git a/arch/arm/mach-s5p64x0/irq-pm.c b/arch/arm/mach-s5p64x0/irq-pm.c
index 1c83d28..2ed921e 100644
--- a/arch/arm/mach-s5p64x0/irq-pm.c
+++ b/arch/arm/mach-s5p64x0/irq-pm.c
@@ -34,7 +34,9 @@ static struct irq_grp_save {
 	u32	mask;
 } eint_grp_save[4];
 
+#ifdef CONFIG_SERIAL_SAMSUNG
 static u32 irq_uart_mask[CONFIG_SERIAL_SAMSUNG_UARTS];
+#endif
 
 static int s5p64x0_irq_pm_suspend(void)
 {
@@ -45,8 +47,10 @@ static int s5p64x0_irq_pm_suspend(void)
 
 	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
 
+#ifdef CONFIG_SERIAL_SAMSUNG
 	for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)
 		irq_uart_mask[i] = __raw_readl(S3C_VA_UARTx(i) + S3C64XX_UINTM);
+#endif
 
 	for (i = 0; i < ARRAY_SIZE(eint_grp_save); i++, grp++) {
 		grp->con = __raw_readl(S5P64X0_EINT12CON + (i * 4));
@@ -66,8 +70,10 @@ static void s5p64x0_irq_pm_resume(void)
 
 	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
 
+#ifdef CONFIG_SERIAL_SAMSUNG
 	for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)
 		__raw_writel(irq_uart_mask[i], S3C_VA_UARTx(i) + S3C64XX_UINTM);
+#endif
 
 	for (i = 0; i < ARRAY_SIZE(eint_grp_save); i++, grp++) {
 		__raw_writel(grp->con, S5P64X0_EINT12CON + (i * 4));
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 0ffc84a..c32df1f 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -96,7 +96,9 @@ void __init s3c24xx_init_clocks(int xtal)
 #if IS_ENABLED(CONFIG_SAMSUNG_ATAGS)
 static int nr_uarts __initdata = 0;
 
+#ifdef CONFIG_SERIAL_SAMSUNG_UARTS
 static struct s3c2410_uartcfg uart_cfgs[CONFIG_SERIAL_SAMSUNG_UARTS];
+#endif
 
 /* s3c24xx_init_uartdevs
  *
@@ -111,6 +113,7 @@ void __init s3c24xx_init_uartdevs(char *name,
 				  struct s3c24xx_uart_resources *res,
 				  struct s3c2410_uartcfg *cfg, int no)
 {
+#ifdef CONFIG_SERIAL_SAMSUNG_UARTS
 	struct platform_device *platdev;
 	struct s3c2410_uartcfg *cfgptr = uart_cfgs;
 	struct s3c24xx_uart_resources *resp;
@@ -133,6 +136,7 @@ void __init s3c24xx_init_uartdevs(char *name,
 	}
 
 	nr_uarts = no;
+#endif
 }
 
 void __init s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-- 
1.8.3.2
