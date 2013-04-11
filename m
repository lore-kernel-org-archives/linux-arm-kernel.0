From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 23:37:25 +0200
Subject: [PATCH v3 10/10] ARM: exynos: enable multiplatform support
In-Reply-To: <1365716245-99231-1-git-send-email-arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
Message-ID: <1365716245-99231-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to enable the exynos platform as part of a
multiplatform kernel, in addition to keeping the single-platform
exynos support.

The multiplatform variant has a number of limitations at the moment:

* It only supports DT-enabled machines. This is not a problem in
  the long run, as non-DT machines for exynos are going away.
  The main problem here is that the gpio code and the exynos_eint
  irqchip are not multiplatform capable but still required for
  ATAGS based boot.
* The watchdog driver is still missing a conversion.
* sparsemem and memory_holes are currently not supported in
  multiplatform.

The the multiplatform aware ARCH_EXYNOS Kconfig symbol is disabled
for now, as dependent patches are still pending in other
subsystem trees. We will enable it once everything comes together.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                        |  9 +--------
 arch/arm/configs/exynos4_defconfig      |  2 +-
 arch/arm/mach-exynos/Kconfig            | 26 ++++++++++++++++++++++----
 arch/arm/mach-exynos/Makefile           |  5 +++--
 arch/arm/mach-exynos/common.c           |  6 ++++++
 arch/arm/plat-samsung/Kconfig           |  7 ++++++-
 arch/arm/plat-samsung/Makefile          |  8 ++++++--
 arch/arm/plat-samsung/include/plat/pm.h |  5 +++++
 drivers/gpio/Makefile                   |  2 +-
 9 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13b7394..b375a94 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -853,18 +853,11 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_EXYNOS
+config ARCH_EXYNOS_SINGLE
 	bool "Samsung EXYNOS"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SPARSEMEM_ENABLE
-	select CLKDEV_LOOKUP
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
diff --git a/arch/arm/configs/exynos4_defconfig b/arch/arm/configs/exynos4_defconfig
index bffe68e..ae90a0f 100644
--- a/arch/arm/configs/exynos4_defconfig
+++ b/arch/arm/configs/exynos4_defconfig
@@ -4,7 +4,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_EXYNOS_SINGLE=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDKC210=y
 CONFIG_MACH_ARMLEX4210=y
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 33e2336..e4ee875 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -7,6 +7,21 @@
 
 # Configuration options for the EXYNOS4
 
+config ARCH_EXYNOS
+	# TODO: make this visible after all drivers are converted
+	bool "Samsung EXYNOS" if ARCH_MULTI_V7 && BROKEN
+	default ARCH_EXYNOS_SINGLE
+	select ARCH_HAS_CPUFREQ
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C_RTC if RTC_CLASS
+	help
+	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
+
 if ARCH_EXYNOS
 
 menu "SAMSUNG EXYNOS SoCs Support"
@@ -19,6 +34,9 @@ config ARCH_EXYNOS4
 	help
 	  Samsung EXYNOS4 SoCs based systems
 
+config ARCH_EXYNOS4_SINGLE
+	def_bool ARCH_EXYNOS4 && ARCH_EXYNOS_SINGLE
+
 config ARCH_EXYNOS5
 	bool "SAMSUNG EXYNOS5"
 	select HAVE_SMP
@@ -35,7 +53,7 @@ config CPU_EXYNOS4210
 	select PM_GENERIC_DOMAINS
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS4210 CPU support
 
@@ -45,7 +63,7 @@ config SOC_EXYNOS4212
 	depends on ARCH_EXYNOS4
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS4212 SoC support
 
@@ -53,7 +71,7 @@ config SOC_EXYNOS4412
 	bool "SAMSUNG EXYNOS4412"
 	default y
 	depends on ARCH_EXYNOS4
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS4412 SoC support
 
@@ -64,7 +82,7 @@ config SOC_EXYNOS5250
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
 	select S5P_DEV_MFC
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS5250 SoC support
 
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 435757e..57e9124 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -4,6 +4,7 @@
 #		http://www.samsung.com/
 #
 # Licensed under GPLv2
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
 
 obj-y				:=
 obj-m				:=
@@ -48,12 +49,12 @@ obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 # device support
 
 obj-y					+= dev-uart.o
-obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
+obj-$(CONFIG_ARCH_EXYNOS4_SINGLE)	+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS_DEV_DMA)		+= dma.o
 obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 
-obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
+obj-$(CONFIG_ARCH_EXYNOS_SINGLE)	+= setup-i2c0.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index d63d399..83bd3f0 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -368,6 +368,9 @@ static void __init exynos4_map_io(void)
 	else
 		iotable_init(exynos4_iodesc1, ARRAY_SIZE(exynos4_iodesc1));
 
+	if (!IS_ENABLED(CONFIG_EXYNOS_ATAGS))
+		return
+
 	/* initialize device information early */
 	exynos4_default_sdhci0();
 	exynos4_default_sdhci1();
@@ -570,6 +573,8 @@ static void __init exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
 }
 
+
+#ifdef CONFIG_EXYNOS_ATAGS
 static void __iomem *exynos_eint_base;
 
 static DEFINE_SPINLOCK(eint_lock);
@@ -875,3 +880,4 @@ static int __init exynos_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(exynos_init_irq_eint);
+#endif
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index a9d5216..8aae681 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -13,6 +13,10 @@ config PLAT_SAMSUNG
 	help
 	  Base platform code for all Samsung SoC based systems
 
+config PLAT_SAMSUNG_SINGLE
+	def_bool PLAT_SAMSUNG && !ARCH_MULTIPLATFORM
+	
+
 config PLAT_S5P
 	bool
 	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
@@ -23,7 +27,7 @@ config PLAT_S5P
 	select GIC_NON_BANKED if ARCH_EXYNOS4
 	select NO_IOPORT
 	select PLAT_SAMSUNG
-	select S3C_GPIO_TRACK
+	select S3C_GPIO_TRACK if PLAT_SAMSUNG_SINGLE
 	select S5P_GPIO_DRVSTR
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
@@ -178,6 +182,7 @@ config S5P_DEV_UART
 
 config S3C_ADC
 	bool "ADC common driver support"
+	depends on PLAT_SAMSUNG_SINGLE
 	help
 	  Core support for the ADC block found in the Samsung SoC systems
 	  for drivers such as the touchscreen and hwmon to use to share
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 3a7c64d..cf684b2 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -4,6 +4,9 @@
 #
 # Licensed under GPLv2
 
+ccflags-$(CONFIG_ARCH_MULTI_V7) += -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARCH_EXYNOS)	+= -I$(srctree)/arch/arm/mach-exynos/include
+
 obj-y				:=
 obj-m				:=
 obj-n				:= dummy.o
@@ -34,7 +37,7 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 
 obj-y				+= platformdata.o
 
-obj-y				+= devs.o
+obj-$(CONFIG_PLAT_SAMSUNG_SINGLE)	+= devs.o
 obj-y				+= dev-uart.o
 obj-$(CONFIG_S5P_DEV_MFC)	+= s5p-dev-mfc.o
 obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
@@ -51,9 +54,10 @@ obj-$(CONFIG_S3C_DMA)		+= dma.o s3c-dma-ops.o
 obj-$(CONFIG_SAMSUNG_DMADEV)	+= dma-ops.o
 
 # PM support
-
 obj-$(CONFIG_PM)		+= pm.o
+ifdef CONFIG_PLAT_SAMSUNG_SINGLE
 obj-$(CONFIG_PM)		+= pm-gpio.o
+endif
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index f6fcade..266a4e3 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -166,6 +166,7 @@ extern void s3c_pm_check_store(void);
  */
 extern void s3c_pm_configure_extint(void);
 
+#ifdef CONFIG_PLAT_SAMSUNG_SINGLE
 /**
  * samsung_pm_restore_gpios() - restore the state of the gpios after sleep.
  *
@@ -181,6 +182,10 @@ extern void samsung_pm_restore_gpios(void);
  * Save the GPIO states for resotration on resume. See samsung_pm_restore_gpios().
  */
 extern void samsung_pm_save_gpios(void);
+#else
+#define samsung_pm_restore_gpios()	do { } while(0)
+#define samsung_pm_save_gpios()		do { } while(0)
+#endif
 
 extern void s3c_pm_save_core(void);
 extern void s3c_pm_restore_core(void);
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 22e07bc..6c16050 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
 obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
-obj-$(CONFIG_PLAT_SAMSUNG)	+= gpio-samsung.o
+obj-$(CONFIG_PLAT_SAMSUNG_SINGLE)	+= gpio-samsung.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
-- 
1.8.1.2
