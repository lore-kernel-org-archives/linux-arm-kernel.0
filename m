From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 19:40:45 +0100
Subject: [PATCH 5/5] ARM: S3C24XX: remove obsolete SoC-specific restart
 functions
In-Reply-To: <3105326.uFdOVLyXH8@phil>
References: <3105326.uFdOVLyXH8@phil>
Message-ID: <1416425.GGZge5vlGZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of them got replaced by the common s3c24xx_restart, so these can
go away.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.h  |    5 -----
 arch/arm/mach-s3c24xx/s3c2410.c |   12 ------------
 arch/arm/mach-s3c24xx/s3c2412.c |   20 --------------------
 arch/arm/mach-s3c24xx/s3c2416.c |    8 --------
 arch/arm/mach-s3c24xx/s3c2443.c |    8 --------
 arch/arm/mach-s3c24xx/s3c244x.c |   11 -----------
 6 files changed, 64 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 20829a8..73be122 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -22,7 +22,6 @@ extern  int s3c2410a_init(void);
 extern void s3c2410_map_io(void);
 extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2410_init_clocks(int xtal);
-extern void s3c2410_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2410_init_irq(void);
 #else
 #define s3c2410_init_clocks NULL
@@ -38,7 +37,6 @@ extern void s3c2412_map_io(void);
 extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2412_init_clocks(int xtal);
 extern  int s3c2412_baseclk_add(void);
-extern void s3c2412_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2412_init_irq(void);
 #else
 #define s3c2412_init_clocks NULL
@@ -53,7 +51,6 @@ extern void s3c2416_map_io(void);
 extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2416_init_clocks(int xtal);
 extern  int s3c2416_baseclk_add(void);
-extern void s3c2416_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2416_init_irq(void);
 
 extern struct syscore_ops s3c2416_irq_syscore_ops;
@@ -67,7 +64,6 @@ extern struct syscore_ops s3c2416_irq_syscore_ops;
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
 extern void s3c244x_map_io(void);
 extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s3c244x_restart(enum reboot_mode mode, const char *cmd);
 #else
 #define s3c244x_init_uarts NULL
 #endif
@@ -98,7 +94,6 @@ extern void s3c2443_map_io(void);
 extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2443_init_clocks(int xtal);
 extern  int s3c2443_baseclk_add(void);
-extern void s3c2443_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2443_init_irq(void);
 #else
 #define s3c2443_init_clocks NULL
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index fef99fe..acb4cc3 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -140,15 +140,3 @@ int __init s3c2410a_init(void)
 	s3c2410_dev.bus = &s3c2410a_subsys;
 	return s3c2410_init();
 }
-
-void s3c2410_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT) {
-		soft_restart(0);
-	}
-
-	samsung_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 99bb867..d894fbc 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -130,26 +130,6 @@ static void s3c2412_idle(void)
 	cpu_do_idle();
 }
 
-void s3c2412_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	/* errata "Watch-dog/Software Reset Problem" specifies that
-	 * this reset must be done with the SYSCLK sourced from
-	 * EXTCLK instead of FOUT to avoid a glitch in the reset
-	 * mechanism.
-	 *
-	 * See the watchdog section of the S3C2412 manual for more
-	 * information on this fix.
-	 */
-
-	__raw_writel(0x00, S3C2412_CLKSRC);
-	__raw_writel(S3C2412_SWRST_RESET, S3C2412_SWRST);
-
-	mdelay(1);
-}
-
 /* s3c2412_map_io
  *
  * register the standard cpu IO areas, and any passed in from the
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index 9ef3ccf..e6112c6 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -80,14 +80,6 @@ static struct device s3c2416_dev = {
 	.bus		= &s3c2416_subsys,
 };
 
-void s3c2416_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
-}
-
 int __init s3c2416_init(void)
 {
 	printk(KERN_INFO "S3C2416: Initializing architecture\n");
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index b6c7191..2f7730d 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -60,14 +60,6 @@ static struct device s3c2443_dev = {
 	.bus		= &s3c2443_subsys,
 };
 
-void s3c2443_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
-}
-
 int __init s3c2443_init(void)
 {
 	printk("S3C2443: Initialising architecture\n");
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index c15a1b7..360c69c 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -143,14 +143,3 @@ struct syscore_ops s3c244x_pm_syscore_ops = {
 	.suspend	= s3c244x_suspend,
 	.resume		= s3c244x_resume,
 };
-
-void s3c244x_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	samsung_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
-- 
1.7.10.4
