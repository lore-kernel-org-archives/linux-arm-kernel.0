From: kgene.kim@gmail.com (kgene.kim at gmail.com)
Date: Wed, 10 Apr 2013 00:02:49 +0900
Subject: [PATCH RESEND] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
Message-ID: <51642dab.e844440a.0ad1.ffffc13f@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

As we discussed in mailing list, non-DT for EXYNOS SoCs will not be
supported from v3.10. This patch removes regarding files for non-DT
including board files.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Recreated as per Arnd's suggestion with using -D option :-)

Thanks, Arnd.

 arch/arm/configs/exynos4_defconfig         |   68 --
 arch/arm/mach-exynos/Kconfig               |  303 +-----
 arch/arm/mach-exynos/Makefile              |   26 -
 arch/arm/mach-exynos/common.c              |    9 +-
 arch/arm/mach-exynos/dev-ahci.c            |  255 -----
 arch/arm/mach-exynos/dev-ohci.c            |   52 --
 arch/arm/mach-exynos/dma.c                 |  322 -------
 arch/arm/mach-exynos/mach-armlex4210.c     |  206 -----
 arch/arm/mach-exynos/mach-nuri.c           | 1387 ----------------------------
 arch/arm/mach-exynos/mach-origen.c         |  822 -----------------
 arch/arm/mach-exynos/mach-smdk4x12.c       |  395 --------
 arch/arm/mach-exynos/mach-smdkv310.c       |  443 ---------
 arch/arm/mach-exynos/mach-universal_c210.c | 1159 -----------------------
 arch/arm/mach-exynos/pm_domains.c          |    7 -
 arch/arm/mach-exynos/setup-fimc.c          |   44 -
 arch/arm/mach-exynos/setup-fimd0.c         |   43 -
 arch/arm/mach-exynos/setup-i2c1.c          |   23 -
 arch/arm/mach-exynos/setup-i2c2.c          |   23 -
 arch/arm/mach-exynos/setup-i2c3.c          |   23 -
 arch/arm/mach-exynos/setup-i2c4.c          |   23 -
 arch/arm/mach-exynos/setup-i2c5.c          |   23 -
 arch/arm/mach-exynos/setup-i2c6.c          |   23 -
 arch/arm/mach-exynos/setup-i2c7.c          |   23 -
 arch/arm/mach-exynos/setup-keypad.c        |   36 -
 arch/arm/mach-exynos/setup-sdhci-gpio.c    |  152 ---
 arch/arm/mach-exynos/setup-spi.c           |   45 -
 arch/arm/mach-exynos/setup-usb-phy.c       |  223 -----
 27 files changed, 3 insertions(+), 6155 deletions(-)
 delete mode 100644 arch/arm/configs/exynos4_defconfig
 delete mode 100644 arch/arm/mach-exynos/dev-ahci.c
 delete mode 100644 arch/arm/mach-exynos/dev-ohci.c
 delete mode 100644 arch/arm/mach-exynos/dma.c
 delete mode 100644 arch/arm/mach-exynos/mach-armlex4210.c
 delete mode 100644 arch/arm/mach-exynos/mach-nuri.c
 delete mode 100644 arch/arm/mach-exynos/mach-origen.c
 delete mode 100644 arch/arm/mach-exynos/mach-smdk4x12.c
 delete mode 100644 arch/arm/mach-exynos/mach-smdkv310.c
 delete mode 100644 arch/arm/mach-exynos/mach-universal_c210.c
 delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
 delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
 delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
 delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/mach-exynos/setup-spi.c
 delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c

diff --git a/arch/arm/configs/exynos4_defconfig b/arch/arm/configs/exynos4_defconfig
deleted file mode 100644
index bffe68e..0000000
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index a62d979..b93d221 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -80,314 +80,13 @@ config SOC_EXYNOS5440
 	help
 	  Enable EXYNOS5440 SoC support
 
-config EXYNOS_DEV_DMA
-	bool
-	help
-	  Compile in amba device definitions for DMA controller
-
-config EXYNOS4_DEV_AHCI
-	bool
-	help
-	  Compile in platform device definitions for AHCI
-
-config EXYNOS4_SETUP_FIMD0
-	bool
-	help
-	  Common setup code for FIMD0.
-
-config EXYNOS4_DEV_USB_OHCI
-	bool
-	help
-	  Compile in platform device definition for USB OHCI
-
-config EXYNOS4_SETUP_I2C1
-	bool
-	help
-	  Common setup code for i2c bus 1.
-
-config EXYNOS4_SETUP_I2C2
-	bool
-	help
-	  Common setup code for i2c bus 2.
-
-config EXYNOS4_SETUP_I2C3
-	bool
-	help
-	  Common setup code for i2c bus 3.
-
-config EXYNOS4_SETUP_I2C4
-	bool
-	help
-	  Common setup code for i2c bus 4.
-
-config EXYNOS4_SETUP_I2C5
-	bool
-	help
-	  Common setup code for i2c bus 5.
-
-config EXYNOS4_SETUP_I2C6
-	bool
-	help
-	  Common setup code for i2c bus 6.
-
-config EXYNOS4_SETUP_I2C7
-	bool
-	help
-	  Common setup code for i2c bus 7.
-
-config EXYNOS4_SETUP_KEYPAD
-	bool
-	help
-	  Common setup code for keypad.
-
-config EXYNOS4_SETUP_SDHCI
-	bool
-	select EXYNOS4_SETUP_SDHCI_GPIO
-	help
-	  Internal helper functions for EXYNOS4 based SDHCI systems.
-
-config EXYNOS4_SETUP_SDHCI_GPIO
-	bool
-	help
-	  Common setup code for SDHCI gpio.
-
-config EXYNOS4_SETUP_FIMC
-	bool
-	help
-	  Common setup code for the camera interfaces.
-
-config EXYNOS4_SETUP_USB_PHY
-	bool
-	help
-	  Common setup code for USB PHY controller
-
-config EXYNOS_SETUP_SPI
-	bool
-	help
-	  Common setup code for SPI GPIO configurations.
-
 # machine support
 
-if ARCH_EXYNOS4
-
-comment "EXYNOS4210 Boards"
-
-config MACH_SMDKC210
-	bool "SMDKC210"
-	select MACH_SMDKV310
-	help
-	  Machine support for Samsung SMDKC210
-
-config MACH_SMDKV310
-	bool "SMDKV310"
-	select CPU_EXYNOS4210
-	select EXYNOS4_DEV_AHCI
-	select EXYNOS4_DEV_USB_OHCI
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_KEYPAD
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_SYSMMU
-	select S3C24XX_PWM
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S3C_DEV_I2C1
-	select S3C_DEV_RTC
-	select S3C_DEV_USB_HSOTG
-	select S3C_DEV_WDT
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
-	select S5P_DEV_FIMC3
-	select S5P_DEV_FIMD0
-	select S5P_DEV_G2D
-	select S5P_DEV_I2C_HDMIPHY
-	select S5P_DEV_JPEG
-	select S5P_DEV_MFC
-	select S5P_DEV_TV
-	select S5P_DEV_USB_EHCI
-	select SAMSUNG_DEV_BACKLIGHT
-	select SAMSUNG_DEV_KEYPAD
-	select SAMSUNG_DEV_PWM
-	help
-	  Machine support for Samsung SMDKV310
-
-config MACH_ARMLEX4210
-	bool "ARMLEX4210"
-	select CPU_EXYNOS4210
-	select EXYNOS4_DEV_AHCI
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS_DEV_DMA
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S3C_DEV_RTC
-	select S3C_DEV_WDT
-	help
-	  Machine support for Samsung ARMLEX4210 based on EXYNOS4210
-
-config MACH_UNIVERSAL_C210
-	bool "Mobile UNIVERSAL_C210 Board"
-	select CLKSRC_MMIO
-	select CPU_EXYNOS4210
-	select EXYNOS4_SETUP_FIMC
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_I2C3
-	select EXYNOS4_SETUP_I2C5
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_SYSMMU
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S3C_DEV_I2C1
-	select S3C_DEV_I2C3
-	select S3C_DEV_I2C5
-	select S3C_DEV_USB_HSOTG
-	select S5P_DEV_CSIS0
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
-	select S5P_DEV_FIMC3
-	select S5P_DEV_FIMD0
-	select S5P_DEV_G2D
-	select S5P_DEV_I2C_HDMIPHY
-	select S5P_DEV_JPEG
-	select S5P_DEV_MFC
-	select S5P_DEV_ONENAND
-	select S5P_DEV_TV
-	select S5P_GPIO_INT
-	select S5P_SETUP_MIPIPHY
-	select SAMSUNG_HRT
-	help
-	  Machine support for Samsung Mobile Universal S5PC210 Reference
-	  Board.
-
-config MACH_NURI
-	bool "Mobile NURI Board"
-	select CPU_EXYNOS4210
-	select EXYNOS4_SETUP_FIMC
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_I2C3
-	select EXYNOS4_SETUP_I2C5
-	select EXYNOS4_SETUP_I2C6
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select EXYNOS_DEV_DMA
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S3C_DEV_I2C1
-	select S3C_DEV_I2C3
-	select S3C_DEV_I2C5
-	select S3C_DEV_I2C6
-	select S3C_DEV_RTC
-	select S3C_DEV_USB_HSOTG
-	select S3C_DEV_WDT
-	select S5P_DEV_CSIS0
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
-	select S5P_DEV_FIMC3
-	select S5P_DEV_FIMD0
-	select S5P_DEV_G2D
-	select S5P_DEV_JPEG
-	select S5P_DEV_MFC
-	select S5P_DEV_USB_EHCI
-	select S5P_GPIO_INT
-	select S5P_SETUP_MIPIPHY
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_PWM
-	help
-	  Machine support for Samsung Mobile NURI Board.
-
-config MACH_ORIGEN
-	bool "ORIGEN"
-	select CPU_EXYNOS4210
-	select EXYNOS4_DEV_USB_OHCI
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_SYSMMU
-	select S3C24XX_PWM
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_RTC
-	select S3C_DEV_USB_HSOTG
-	select S3C_DEV_WDT
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
-	select S5P_DEV_FIMC3
-	select S5P_DEV_FIMD0
-	select S5P_DEV_G2D
-	select S5P_DEV_I2C_HDMIPHY
-	select S5P_DEV_JPEG
-	select S5P_DEV_MFC
-	select S5P_DEV_TV
-	select S5P_DEV_USB_EHCI
-	select SAMSUNG_DEV_BACKLIGHT
-	select SAMSUNG_DEV_PWM
-	help
-	  Machine support for ORIGEN based on Samsung EXYNOS4210
-
-comment "EXYNOS4212 Boards"
-
-config MACH_SMDK4212
-	bool "SMDK4212"
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_I2C3
-	select EXYNOS4_SETUP_I2C7
-	select EXYNOS4_SETUP_KEYPAD
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_SYSMMU
-	select S3C24XX_PWM
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S3C_DEV_I2C1
-	select S3C_DEV_I2C3
-	select S3C_DEV_I2C7
-	select S3C_DEV_RTC
-	select S3C_DEV_USB_HSOTG
-	select S3C_DEV_WDT
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
-	select S5P_DEV_FIMC3
-	select S5P_DEV_FIMD0
-	select S5P_DEV_MFC
-	select SAMSUNG_DEV_BACKLIGHT
-	select SAMSUNG_DEV_KEYPAD
-	select SAMSUNG_DEV_PWM
-	select SOC_EXYNOS4212
-	help
-	  Machine support for Samsung SMDK4212
-
-comment "EXYNOS4412 Boards"
-
-config MACH_SMDK4412
-	bool "SMDK4412"
-	select MACH_SMDK4212
-	select SOC_EXYNOS4412
-	help
-	  Machine support for Samsung SMDK4412
-endif
-
 comment "Flattened Device Tree based board for EXYNOS SoCs"
 
 config MACH_EXYNOS4_DT
 	bool "Samsung Exynos4 Machine using device tree"
+	default y
 	depends on ARCH_EXYNOS4
 	select ARM_AMBA
 	select CLKSRC_OF
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index b09b027..9811f87 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -32,16 +32,6 @@ AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
 
 # machine support
 
-obj-$(CONFIG_MACH_SMDKC210)		+= mach-smdkv310.o
-obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
-obj-$(CONFIG_MACH_ARMLEX4210)		+= mach-armlex4210.o
-obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
-obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
-obj-$(CONFIG_MACH_ORIGEN)		+= mach-origen.o
-
-obj-$(CONFIG_MACH_SMDK4212)		+= mach-smdk4x12.o
-obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
-
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 
@@ -49,21 +39,5 @@ obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 
 obj-y					+= dev-uart.o
 obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
-obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
-obj-$(CONFIG_EXYNOS_DEV_DMA)		+= dma.o
-obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 
 obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
-obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
-obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C2)	+= setup-i2c2.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C3)	+= setup-i2c3.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C4)	+= setup-i2c4.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C5)	+= setup-i2c5.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C6)	+= setup-i2c6.o
-obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
-obj-$(CONFIG_EXYNOS4_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
-obj-$(CONFIG_EXYNOS4_SETUP_USB_PHY)	+= setup-usb-phy.o
-obj-$(CONFIG_EXYNOS_SETUP_SPI)		+= setup-spi.o
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index a8570bf..d5c36fd 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -357,7 +357,7 @@ void __init exynos_init_io(struct map_desc *mach_desc, int size)
 {
 	struct map_desc *iodesc = exynos_iodesc;
 	int iodesc_sz = ARRAY_SIZE(exynos_iodesc);
-#if defined(CONFIG_OF) && defined(CONFIG_ARCH_EXYNOS5)
+#if defined(CONFIG_ARCH_EXYNOS5)
 	unsigned long root = of_get_flat_dt_root();
 
 	/* initialize the io descriptors we need for initialization */
@@ -437,10 +437,8 @@ static void __init exynos5440_map_io(void)
 void __init exynos_init_time(void)
 {
 	if (of_have_populated_dt()) {
-#ifdef CONFIG_OF
 		of_clk_init(NULL);
 		clocksource_of_init();
-#endif
 	} else {
 		/* todo: remove after migrating legacy E4 platforms to dt */
 #ifdef CONFIG_ARCH_EXYNOS4
@@ -459,10 +457,8 @@ void __init exynos4_init_irq(void)
 
 	if (!of_have_populated_dt())
 		gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset, NULL);
-#ifdef CONFIG_OF
 	else
 		irqchip_init();
-#endif
 
 	if (!of_have_populated_dt())
 		combiner_init(S5P_VA_COMBINER_BASE, NULL);
@@ -479,9 +475,8 @@ void __init exynos4_init_irq(void)
 
 void __init exynos5_init_irq(void)
 {
-#ifdef CONFIG_OF
 	irqchip_init();
-#endif
+
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
 	 * Theses parameters should be NULL and 0 because EXYNOS4
diff --git a/arch/arm/mach-exynos/dev-ahci.c b/arch/arm/mach-exynos/dev-ahci.c
deleted file mode 100644
index ce1aad3..0000000
diff --git a/arch/arm/mach-exynos/dev-ohci.c b/arch/arm/mach-exynos/dev-ohci.c
deleted file mode 100644
index d5bc129..0000000
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
deleted file mode 100644
index 87e07d6..0000000
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
deleted file mode 100644
index 2c23b65..0000000
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
deleted file mode 100644
index 0c10852..0000000
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
deleted file mode 100644
index f662345..0000000
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
deleted file mode 100644
index 184faa3..0000000
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
deleted file mode 100644
index ee815a7..0000000
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
deleted file mode 100644
index 72f08fd..0000000
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 9f1351d..beb946d 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -84,7 +84,6 @@ static struct exynos_pm_domain PD = {			\
 	},						\
 }
 
-#ifdef CONFIG_OF
 static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
 					 struct device *dev)
 {
@@ -193,12 +192,6 @@ static __init int exynos_pm_dt_parse_domains(void)
 
 	return 0;
 }
-#else
-static __init int exynos_pm_dt_parse_domains(void)
-{
-	return 0;
-}
-#endif /* CONFIG_OF */
 
 static __init __maybe_unused void exynos_pm_add_dev_to_genpd(struct platform_device *pdev,
 						struct exynos_pm_domain *pd)
diff --git a/arch/arm/mach-exynos/setup-fimc.c b/arch/arm/mach-exynos/setup-fimc.c
deleted file mode 100644
index 6a45078..0000000
diff --git a/arch/arm/mach-exynos/setup-fimd0.c b/arch/arm/mach-exynos/setup-fimd0.c
deleted file mode 100644
index 5665bb4..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c1.c b/arch/arm/mach-exynos/setup-i2c1.c
deleted file mode 100644
index 8d2279c..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c2.c b/arch/arm/mach-exynos/setup-i2c2.c
deleted file mode 100644
index 0ed62fc..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c3.c b/arch/arm/mach-exynos/setup-i2c3.c
deleted file mode 100644
index 7787fd2..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c4.c b/arch/arm/mach-exynos/setup-i2c4.c
deleted file mode 100644
index edc847f..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c5.c b/arch/arm/mach-exynos/setup-i2c5.c
deleted file mode 100644
index d88af7f..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c6.c b/arch/arm/mach-exynos/setup-i2c6.c
deleted file mode 100644
index c590286..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c7.c b/arch/arm/mach-exynos/setup-i2c7.c
deleted file mode 100644
index 1bba755..0000000
diff --git a/arch/arm/mach-exynos/setup-keypad.c b/arch/arm/mach-exynos/setup-keypad.c
deleted file mode 100644
index 7862bfb..0000000
diff --git a/arch/arm/mach-exynos/setup-sdhci-gpio.c b/arch/arm/mach-exynos/setup-sdhci-gpio.c
deleted file mode 100644
index e8d08bf..0000000
diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
deleted file mode 100644
index 4999829..0000000
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
deleted file mode 100644
index b81cc56..0000000
-- 
1.8.2.1.339.g52a3e01
