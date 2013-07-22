From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Jul 2013 01:49:24 +0200
Subject: [PATCH v2 7/8] ARM: s3c64xx: Migrate clock handling to Common Clock
 Framework
In-Reply-To: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1374536965-3545-8-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch migrates the s3c64xx platform to use the new clock driver
using Common Clock Framework.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/mach-s3c64xx/Makefile        |  2 +-
 arch/arm/mach-s3c64xx/common.c        | 21 +++++++++++++++++----
 arch/arm/mach-s3c64xx/common.h        | 10 +++++-----
 arch/arm/mach-s3c64xx/mach-anw6410.c  |  2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c |  2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c      |  2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c |  2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c      |  2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c   | 11 ++---------
 arch/arm/mach-s3c64xx/mach-smdk6400.c |  2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c |  2 +-
 arch/arm/mach-s3c64xx/s3c6400.c       |  6 ------
 arch/arm/mach-s3c64xx/s3c6410.c       |  7 -------
 drivers/clk/samsung/Makefile          |  2 --
 15 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fa7ffca..cfa7e59 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -724,6 +724,7 @@ config ARCH_S3C64XX
 	select ARM_VIC
 	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
+	select COMMON_CLK
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
@@ -737,7 +738,6 @@ config ARCH_S3C64XX
 	select S3C_DEV_NAND
 	select S3C_GPIO_TRACK
 	select SAMSUNG_ATAGS
-	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_WDT_RESET
 	select USB_ARCH_HAS_OHCI
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 31d0c91..645a8fe 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core
 
-obj-y				+= common.o clock.o
+obj-y				+= common.o
 
 # Core support
 
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 73d79cf..7d3cb58 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/clk-provider.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/serial_core.h>
@@ -38,7 +39,6 @@
 #include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
 #include <plat/gpio-cfg.h>
@@ -50,6 +50,19 @@
 
 #include "common.h"
 
+/* External clock frequency */
+static unsigned long xtal_f = 12000000, xusbxti_f = 48000000;
+
+void __init s3c64xx_set_xtal_freq(unsigned long freq)
+{
+	xtal_f = freq;
+}
+
+void __init s3c64xx_set_xusbxti_freq(unsigned long freq)
+{
+	xusbxti_f = freq;
+}
+
 /* uart registration process */
 
 static void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
@@ -67,7 +80,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= S3C6400_CPU_ID,
 		.idmask		= S3C64XX_CPU_MASK,
 		.map_io		= s3c6400_map_io,
-		.init_clocks	= s3c6400_init_clocks,
 		.init_uarts	= s3c64xx_init_uarts,
 		.init		= s3c6400_init,
 		.name		= name_s3c6400,
@@ -75,7 +87,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= S3C6410_CPU_ID,
 		.idmask		= S3C64XX_CPU_MASK,
 		.map_io		= s3c6410_map_io,
-		.init_clocks	= s3c6410_init_clocks,
 		.init_uarts	= s3c64xx_init_uarts,
 		.init		= s3c6410_init,
 		.name		= name_s3c6410,
@@ -213,8 +224,10 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
 	/*
 	 * FIXME: there is no better place to put this at the moment
-	 * (samsung_wdt_reset_init needs clocks)
+	 * (s3c64xx_clk_init needs ioremap and must happen before init_time
+	 * samsung_wdt_reset_init needs clocks)
 	 */
+	s3c64xx_clk_init(NULL, xtal_f, xusbxti_f, soc_is_s3c6400(), S3C_VA_SYS);
 	samsung_wdt_reset_init(S3C_VA_WATCHDOG);
 
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index e8f990b..a2af0e1 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -22,18 +22,19 @@
 void s3c64xx_init_irq(u32 vic0, u32 vic1);
 void s3c64xx_init_io(struct map_desc *mach_desc, int size);
 
-void s3c64xx_register_clocks(unsigned long xtal, unsigned armclk_limit);
-void s3c64xx_setup_clocks(void);
-
 void s3c64xx_restart(enum reboot_mode mode, const char *cmd);
 void s3c64xx_init_late(void);
 
+void s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
+	unsigned long xusbxti_f, bool is_s3c6400, void __iomem *reg_base);
+void s3c64xx_set_xtal_freq(unsigned long freq);
+void s3c64xx_set_xusbxti_freq(unsigned long freq);
+
 #ifdef CONFIG_CPU_S3C6400
 
 extern  int s3c6400_init(void);
 extern void s3c6400_init_irq(void);
 extern void s3c6400_map_io(void);
-extern void s3c6400_init_clocks(int xtal);
 
 #else
 #define s3c6400_init_clocks NULL
@@ -46,7 +47,6 @@ extern void s3c6400_init_clocks(int xtal);
 extern  int s3c6410_init(void);
 extern void s3c6410_init_irq(void);
 extern void s3c6410_map_io(void);
-extern void s3c6410_init_clocks(int xtal);
 
 #else
 #define s3c6410_init_clocks NULL
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 35e3f54..d266dd5 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -207,7 +207,7 @@ static struct platform_device *anw6410_devices[] __initdata = {
 static void __init anw6410_map_io(void)
 {
 	s3c64xx_init_io(anw6410_iodesc, ARRAY_SIZE(anw6410_iodesc));
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(anw6410_uartcfgs, ARRAY_SIZE(anw6410_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 28889cc..4d92e4d 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -743,7 +743,7 @@ static struct s3c2410_platform_i2c i2c1_pdata = {
 static void __init crag6410_map_io(void)
 {
 	s3c64xx_init_io(NULL, 0);
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(crag6410_uartcfgs, ARRAY_SIZE(crag6410_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index f39569e..e806404 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -247,7 +247,7 @@ static struct platform_device *hmt_devices[] __initdata = {
 static void __init hmt_map_io(void)
 {
 	s3c64xx_init_io(hmt_iodesc, ARRAY_SIZE(hmt_iodesc));
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(hmt_uartcfgs, ARRAY_SIZE(hmt_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 87f406e..3cceda2 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -231,7 +231,7 @@ static void __init mini6410_map_io(void)
 	u32 tmp;
 
 	s3c64xx_init_io(NULL, 0);
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(mini6410_uartcfgs, ARRAY_SIZE(mini6410_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 7e2c390..2067b0b 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -86,7 +86,7 @@ static struct map_desc ncp_iodesc[] __initdata = {};
 static void __init ncp_map_io(void)
 {
 	s3c64xx_init_io(ncp_iodesc, ARRAY_SIZE(ncp_iodesc));
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(ncp_uartcfgs, ARRAY_SIZE(ncp_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 86d980b..0f47237 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -337,13 +337,6 @@ err:
 	return ret;
 }
 
-static int __init smartq_usb_otg_init(void)
-{
-	clk_xusbxti.rate = 12000000;
-
-	return 0;
-}
-
 static int __init smartq_wifi_init(void)
 {
 	int ret;
@@ -377,7 +370,8 @@ static struct map_desc smartq_iodesc[] __initdata = {};
 void __init smartq_map_io(void)
 {
 	s3c64xx_init_io(smartq_iodesc, ARRAY_SIZE(smartq_iodesc));
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
+	s3c64xx_set_xusbxti_freq(12000000);
 	s3c24xx_init_uarts(smartq_uartcfgs, ARRAY_SIZE(smartq_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -399,7 +393,6 @@ void __init smartq_machine_init(void)
 	WARN_ON(smartq_lcd_setup_gpio());
 	WARN_ON(smartq_power_off_init());
 	WARN_ON(smartq_usb_host_init());
-	WARN_ON(smartq_usb_otg_init());
 	WARN_ON(smartq_wifi_init());
 
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index d70c084..27381cf 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -65,7 +65,7 @@ static struct map_desc smdk6400_iodesc[] = {};
 static void __init smdk6400_map_io(void)
 {
 	s3c64xx_init_io(smdk6400_iodesc, ARRAY_SIZE(smdk6400_iodesc));
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(smdk6400_uartcfgs, ARRAY_SIZE(smdk6400_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d90b450..2a7b32c 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -634,7 +634,7 @@ static void __init smdk6410_map_io(void)
 	u32 tmp;
 
 	s3c64xx_init_io(smdk6410_iodesc, ARRAY_SIZE(smdk6410_iodesc));
-	s3c24xx_init_clocks(12000000);
+	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(smdk6410_uartcfgs, ARRAY_SIZE(smdk6410_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 4869714..331fe8e 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -58,12 +58,6 @@ void __init s3c6400_map_io(void)
 	s3c64xx_onenand1_setname("s3c6400-onenand");
 }
 
-void __init s3c6400_init_clocks(int xtal)
-{
-	s3c64xx_register_clocks(xtal, S3C6400_CLKDIV0_ARM_MASK);
-	s3c64xx_setup_clocks();
-}
-
 void __init s3c6400_init_irq(void)
 {
 	/* VIC0 does not have IRQS 5..7,
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 31c29fd..7e6fa12 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -62,13 +62,6 @@ void __init s3c6410_map_io(void)
 	s3c_cfcon_setname("s3c64xx-pata");
 }
 
-void __init s3c6410_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
-	s3c64xx_register_clocks(xtal, S3C6410_CLKDIV0_ARM_MASK);
-	s3c64xx_setup_clocks();
-}
-
 void __init s3c6410_init_irq(void)
 {
 	/* VIC0 is missing IRQ7, VIC1 is fully populated. */
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 3413380..8eb4799 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -8,6 +8,4 @@ obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
-ifdef CONFIG_COMMON_CLK
 obj-$(CONFIG_ARCH_S3C64XX)	+= clk-s3c64xx.o
-endif
-- 
1.8.3.2
