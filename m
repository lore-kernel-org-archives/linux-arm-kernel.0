From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:57:00 +0100
Subject: [PATCH 10/11] ARM: nomadik: delete old board files
Message-ID: <1357599420-7651-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Device Tree support on Nomadik can do everything the old board
files could do, so delete the old board files and make the nomadik
select CONFIG_OF.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                      |   2 +
 arch/arm/mach-nomadik/Kconfig         |  10 +-
 arch/arm/mach-nomadik/Makefile        |   6 -
 arch/arm/mach-nomadik/board-nhk8815.c | 328 ----------------------------------
 arch/arm/mach-nomadik/cpu-8815.c      | 112 +-----------
 arch/arm/mach-nomadik/cpu-8815.h      |   5 -
 arch/arm/mach-nomadik/i2c-8815nhk.c   |  82 ---------
 7 files changed, 6 insertions(+), 539 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/board-nhk8815.c
 delete mode 100644 arch/arm/mach-nomadik/cpu-8815.h
 delete mode 100644 arch/arm/mach-nomadik/i2c-8815nhk.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f95ba14..7eede4d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -900,10 +900,12 @@ config ARCH_NOMADIK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
+	select CLKSRC_NOMADIK_MTU
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_CACHE_L2X0
+	select OF
 	select PINCTRL
 	select PINCTRL_STN8815
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 706dc57..82226a5 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -4,19 +4,13 @@ menu "Nomadik boards"
 
 config MACH_NOMADIK_8815NHK
 	bool "ST 8815 Nomadik Hardware Kit (evaluation board)"
-	select CLKSRC_NOMADIK_MTU
 	select NOMADIK_8815
+	select I2C
+	select I2C_ALGOBIT
 
 endmenu
 
 config NOMADIK_8815
 	bool
 
-config I2C_BITBANG_8815NHK
-	tristate "Driver for bit-bang busses found on the 8815 NHK"
-	depends on I2C && MACH_NOMADIK_8815NHK
-	depends on PINCTRL_NOMADIK
-	default y
-	select I2C_ALGOBIT
-
 endif
diff --git a/arch/arm/mach-nomadik/Makefile b/arch/arm/mach-nomadik/Makefile
index a42c9a3..1071c3b 100644
--- a/arch/arm/mach-nomadik/Makefile
+++ b/arch/arm/mach-nomadik/Makefile
@@ -9,9 +9,3 @@
 
 # Cpu revision
 obj-$(CONFIG_NOMADIK_8815) += cpu-8815.o
-
-# Specific board support
-obj-$(CONFIG_MACH_NOMADIK_8815NHK) += board-nhk8815.o
-
-# Nomadik extra devices
-obj-$(CONFIG_I2C_BITBANG_8815NHK) += i2c-8815nhk.o
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
deleted file mode 100644
index 4bc5a97..0000000
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ /dev/null
@@ -1,328 +0,0 @@
-/*
- *  linux/arch/arm/mach-nomadik/board-8815nhk.c
- *
- *  Copyright (C) STMicroelectronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- *
- *  NHK15 board specifc driver definition
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/mmci.h>
-#include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/fsmc.h>
-#include <linux/mtd/onenand.h>
-#include <linux/mtd/partitions.h>
-#include <linux/i2c.h>
-#include <linux/io.h>
-#include <linux/platform_data/clocksource-nomadik-mtu.h>
-#include <asm/hardware/vic.h>
-#include <asm/sizes.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
-#include <asm/mach/time.h>
-#include <mach/irqs.h>
-
-#include "cpu-8815.h"
-
-/* Initial value for SRC control register: all timers use MXTAL/8 source */
-#define SRC_CR_INIT_MASK	0x00007fff
-#define SRC_CR_INIT_VAL		0x2aaa8000
-
-#define ALE_OFF 0x1000000
-#define CLE_OFF 0x800000
-
-/* These addresses span 16MB, so use three individual pages */
-static struct resource nhk8815_nand_resources[] = {
-	{
-		.name = "nand_data",
-		.start = 0x40000000,
-		.end = 0x40000000 + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.name = "nand_addr",
-		.start = 0x40000000 + ALE_OFF,
-		.end = 0x40000000 +ALE_OFF + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.name = "nand_cmd",
-		.start = 0x40000000 + CLE_OFF,
-		.end = 0x40000000 + CLE_OFF + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.name  = "fsmc_regs",
-		.start = NOMADIK_FSMC_BASE,
-		.end   = NOMADIK_FSMC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-/*
- * These partitions are the same as those used in the 2.6.20 release
- * shipped by the vendor; the first two partitions are mandated
- * by the boot ROM, and the bootloader area is somehow oversized...
- */
-static struct mtd_partition nhk8815_partitions[] = {
-	{
-		.name	= "X-Loader(NAND)",
-		.offset = 0,
-		.size	= SZ_256K,
-	}, {
-		.name	= "MemInit(NAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= SZ_256K,
-	}, {
-		.name	= "BootLoader(NAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= SZ_2M,
-	}, {
-		.name	= "Kernel zImage(NAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= 3 * SZ_1M,
-	}, {
-		.name	= "Root Filesystem(NAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= 22 * SZ_1M,
-	}, {
-		.name	= "User Filesystem(NAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= MTDPART_SIZ_FULL,
-	}
-};
-
-static struct fsmc_nand_timings nhk8815_nand_timings = {
-	.thiz	= 0,
-	.thold	= 0x10,
-	.twait	= 0x0A,
-	.tset	= 0,
-};
-
-static struct fsmc_nand_platform_data nhk8815_nand_platform_data = {
-	.nand_timings = &nhk8815_nand_timings,
-	.partitions = nhk8815_partitions,
-	.nr_partitions = ARRAY_SIZE(nhk8815_partitions),
-	.width = FSMC_NAND_BW8,
-};
-
-static struct platform_device nhk8815_nand_device = {
-	.name = "fsmc-nand",
-	.id = -1,
-	.resource = nhk8815_nand_resources,
-	.num_resources = ARRAY_SIZE(nhk8815_nand_resources),
-	.dev = {
-		.platform_data = &nhk8815_nand_platform_data,
-	},
-};
-
-/* These are the partitions for the OneNand device, different from above */
-static struct mtd_partition nhk8815_onenand_partitions[] = {
-	{
-		.name	= "X-Loader(OneNAND)",
-		.offset = 0,
-		.size	= SZ_256K,
-	}, {
-		.name	= "MemInit(OneNAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= SZ_256K,
-	}, {
-		.name	= "BootLoader(OneNAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= SZ_2M-SZ_256K,
-	}, {
-		.name	= "SysImage(OneNAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= 4 * SZ_1M,
-	}, {
-		.name	= "Root Filesystem(OneNAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= 22 * SZ_1M,
-	}, {
-		.name	= "User Filesystem(OneNAND)",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= MTDPART_SIZ_FULL,
-	}
-};
-
-static struct onenand_platform_data nhk8815_onenand_data = {
-	.parts		= nhk8815_onenand_partitions,
-	.nr_parts	= ARRAY_SIZE(nhk8815_onenand_partitions),
-};
-
-static struct resource nhk8815_onenand_resource[] = {
-	{
-		.start		= 0x30000000,
-		.end		= 0x30000000 + SZ_128K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device nhk8815_onenand_device = {
-	.name		= "onenand-flash",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &nhk8815_onenand_data,
-	},
-	.resource	= nhk8815_onenand_resource,
-	.num_resources	= ARRAY_SIZE(nhk8815_onenand_resource),
-};
-
-/* bus control reg. and bus timing reg. for CS0..CS3 */
-#define FSMC_BCR(x)	(NOMADIK_FSMC_VA + (x << 3))
-#define FSMC_BTR(x)	(NOMADIK_FSMC_VA + (x << 3) + 0x04)
-
-static void __init nhk8815_onenand_init(void)
-{
-#ifdef CONFIG_MTD_ONENAND
-       /* Set up SMCS0 for OneNand */
-	writel(0x000030db, FSMC_BCR(0));
-	writel(0x02100551, FSMC_BTR(0));
-#endif
-}
-
-static struct mmci_platform_data mmcsd_plat_data = {
-	.ocr_mask = MMC_VDD_29_30,
-	.f_max = 48000000,
-	.gpio_wp = -1,
-	.gpio_cd = 111,
-	.cd_invert = true,
-	.capabilities = MMC_CAP_MMC_HIGHSPEED |
-	MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA,
-};
-
-static int __init nhk8815_mmcsd_init(void)
-{
-	int ret;
-
-	/* For e.g. devicetree boot */
-	if (!machine_is_nomadik())
-		return 0;
-
-	ret = gpio_request(112, "card detect bias");
-	if (ret)
-		return ret;
-	gpio_direction_output(112, 0);
-	amba_apb_device_add(NULL, "mmci", NOMADIK_SDI_BASE, SZ_4K, IRQ_SDMMC, 0, &mmcsd_plat_data, 0x10180180);
-	return 0;
-}
-module_init(nhk8815_mmcsd_init);
-
-static struct resource nhk8815_eth_resources[] = {
-	{
-		.name = "smc91x-regs",
-		.start = 0x34000000 + 0x300,
-		.end = 0x34000000 + SZ_64K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = NOMADIK_GPIO_TO_IRQ(115),
-		.end = NOMADIK_GPIO_TO_IRQ(115),
-		.flags = IORESOURCE_IRQ | IRQF_TRIGGER_RISING,
-	}
-};
-
-static struct platform_device nhk8815_eth_device = {
-	.name = "smc91x",
-	.resource = nhk8815_eth_resources,
-	.num_resources = ARRAY_SIZE(nhk8815_eth_resources),
-};
-
-static int __init nhk8815_eth_init(void)
-{
-	int gpio_nr = 115; /* hardwired in the board */
-	int err;
-
-	if (!machine_is_nomadik())
-		return 0;
-	err = gpio_request(gpio_nr, "eth_irq");
-	if (!err) err = gpio_direction_input(gpio_nr);
-	if (err)
-		pr_err("Error %i in %s\n", err, __func__);
-	return err;
-}
-device_initcall(nhk8815_eth_init);
-
-static struct platform_device *nhk8815_platform_devices[] __initdata = {
-	&nhk8815_nand_device,
-	&nhk8815_onenand_device,
-	&nhk8815_eth_device,
-	/* will add more devices */
-};
-
-static void __init nomadik_timer_init(void)
-{
-	u32 src_cr;
-
-	/* Configure timer sources in "system reset controller" ctrl reg */
-	src_cr = readl(io_p2v(NOMADIK_SRC_BASE));
-	src_cr &= SRC_CR_INIT_MASK;
-	src_cr |= SRC_CR_INIT_VAL;
-	writel(src_cr, io_p2v(NOMADIK_SRC_BASE));
-
-	nmdk_timer_init(io_p2v(NOMADIK_MTU0_BASE), IRQ_MTU0);
-}
-
-static struct sys_timer nomadik_timer = {
-	.init	= nomadik_timer_init,
-};
-
-static struct i2c_board_info __initdata nhk8815_i2c0_devices[] = {
-	{
-		I2C_BOARD_INFO("stw4811", 0x2d),
-	},
-};
-
-static struct i2c_board_info __initdata nhk8815_i2c1_devices[] = {
-	{
-		I2C_BOARD_INFO("camera", 0x10),
-	},
-	{
-		I2C_BOARD_INFO("stw5095", 0x1a),
-	},
-	{
-		I2C_BOARD_INFO("lis3lv02dl", 0x1d),
-	},
-};
-
-static struct i2c_board_info __initdata nhk8815_i2c2_devices[] = {
-	{
-		I2C_BOARD_INFO("stw4811-usb", 0x2d),
-	},
-};
-
-static void __init nhk8815_platform_init(void)
-{
-	cpu8815_platform_init();
-	nhk8815_onenand_init();
-	platform_add_devices(nhk8815_platform_devices,
-			     ARRAY_SIZE(nhk8815_platform_devices));
-
-	amba_apb_device_add(NULL, "uart0", NOMADIK_UART0_BASE, SZ_4K, IRQ_UART0, 0, NULL, 0);
-	amba_apb_device_add(NULL, "uart1", NOMADIK_UART1_BASE, SZ_4K, IRQ_UART1, 0, NULL, 0);
-
-	i2c_register_board_info(0, nhk8815_i2c0_devices,
-				ARRAY_SIZE(nhk8815_i2c0_devices));
-	i2c_register_board_info(1, nhk8815_i2c1_devices,
-				ARRAY_SIZE(nhk8815_i2c1_devices));
-	i2c_register_board_info(2, nhk8815_i2c2_devices,
-				ARRAY_SIZE(nhk8815_i2c2_devices));
-}
-
-MACHINE_START(NOMADIK, "NHK8815")
-	/* Maintainer: ST MicroElectronics */
-	.atag_offset	= 0x100,
-	.map_io		= cpu8815_map_io,
-	.init_irq	= cpu8815_init_irq,
-	.handle_irq	= vic_handle_irq,
-	.timer		= &nomadik_timer,
-	.init_machine	= nhk8815_platform_init,
-	.restart	= cpu8815_restart,
-MACHINE_END
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 3078c1c..b661b90 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -48,53 +48,6 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
-#include "cpu-8815.h"
-
-/* The 8815 has 4 GPIO blocks, let's register them immediately */
-static resource_size_t __initdata cpu8815_gpio_base[] = {
-	NOMADIK_GPIO0_BASE,
-	NOMADIK_GPIO1_BASE,
-	NOMADIK_GPIO2_BASE,
-	NOMADIK_GPIO3_BASE,
-};
-
-static struct platform_device *
-cpu8815_add_gpio(int id, resource_size_t addr, int irq,
-		 struct nmk_gpio_platform_data *pdata)
-{
-	struct resource resources[] = {
-		{
-			.start	= addr,
-			.end	= addr + 127,
-			.flags	= IORESOURCE_MEM,
-		},
-		{
-			.start	= irq,
-			.end	= irq,
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-
-	return platform_device_register_resndata(NULL, "gpio", id,
-				resources, ARRAY_SIZE(resources),
-				pdata, sizeof(*pdata));
-}
-
-void cpu8815_add_gpios(resource_size_t *base, int num, int irq,
-		       struct nmk_gpio_platform_data *pdata)
-{
-	int first = 0;
-	int i;
-
-	for (i = 0; i < num; i++, first += 32, irq++) {
-		pdata->first_gpio = first;
-		pdata->first_irq = NOMADIK_GPIO_TO_IRQ(first);
-		pdata->num_gpio = 32;
-
-		cpu8815_add_gpio(i, base[i], irq, pdata);
-	}
-}
-
 static unsigned long out_low[] = { PIN_OUTPUT_LOW };
 static unsigned long out_high[] = { PIN_OUTPUT_HIGH };
 static unsigned long in_nopull[] = { PIN_INPUT_NOPULL };
@@ -137,38 +90,6 @@ static struct pinctrl_map __initdata nhk8815_pinmap[] = {
 	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO74_C20", in_pullup),
 };
 
-static inline void
-cpu8815_add_pinctrl(struct device *parent, const char *name)
-{
-	struct platform_device_info pdevinfo = {
-		.parent = parent,
-		.name = name,
-		.id = -1,
-	};
-
-	pinctrl_register_mappings(nhk8815_pinmap, ARRAY_SIZE(nhk8815_pinmap));
-	platform_device_register_full(&pdevinfo);
-}
-
-static int __init cpu8815_init(void)
-{
-	struct nmk_gpio_platform_data pdata = {
-		/* No custom data yet */
-	};
-
-	/* For e.g. device tree boots */
-	if (!machine_is_nomadik())
-		return 0;
-
-	cpu8815_add_gpios(cpu8815_gpio_base, ARRAY_SIZE(cpu8815_gpio_base),
-			  IRQ_GPIO0, &pdata);
-	cpu8815_add_pinctrl(NULL, "pinctrl-stn8815");
-	amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
-	amba_apb_device_add(NULL, "rtc-pl031", NOMADIK_RTC_BASE, SZ_4K, IRQ_RTC_RTT, 0, NULL, 0);
-	return 0;
-}
-arch_initcall(cpu8815_init);
-
 /* All SoC devices live in the same area (see hardware.h) */
 static struct map_desc nomadik_io_desc[] __initdata = {
 	{
@@ -180,37 +101,12 @@ static struct map_desc nomadik_io_desc[] __initdata = {
 	/* static ram and secured ram may be added later */
 };
 
-void __init cpu8815_map_io(void)
+static void __init cpu8815_map_io(void)
 {
 	iotable_init(nomadik_io_desc, ARRAY_SIZE(nomadik_io_desc));
 }
 
-void __init cpu8815_init_irq(void)
-{
-	/* This modified VIC cell has two register blocks, at 0 and 0x20 */
-	vic_init(io_p2v(NOMADIK_IC_BASE + 0x00), IRQ_VIC_START +  0, ~0, 0);
-	vic_init(io_p2v(NOMADIK_IC_BASE + 0x20), IRQ_VIC_START + 32, ~0, 0);
-
-	/*
-	 * Init clocks here so that they are available for system timer
-	 * initialization.
-	 */
-	nomadik_clk_init();
-}
-
-/*
- * This function is called from the board init ("init_machine").
- */
- void __init cpu8815_platform_init(void)
-{
-#ifdef CONFIG_CACHE_L2X0
-	/* At full speed latency must be >=2, so 0x249 in low bits */
-	l2x0_init(io_p2v(NOMADIK_L2CC_BASE), 0x00730249, 0xfe000fff);
-#endif
-	 return;
-}
-
-void cpu8815_restart(char mode, const char *cmd)
+static void cpu8815_restart(char mode, const char *cmd)
 {
 	void __iomem *src_rstsr = io_p2v(NOMADIK_SRC_BASE + 0x18);
 
@@ -220,8 +116,6 @@ void cpu8815_restart(char mode, const char *cmd)
 	writel(1, src_rstsr);
 }
 
-#ifdef CONFIG_OF
-
 /* Lookup table for finding a DT node that represents the vic instance */
 static const struct of_device_id cpu8815_vic_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-vic", .data = vic_of_init, },
@@ -407,5 +301,3 @@ DT_MACHINE_START(NOMADIK_DT, "ST-Ericsson Nomadik 8815")
 	.restart	= cpu8815_restart,
 	.dt_compat      = cpu8815_board_compat,
 MACHINE_END
-
-#endif
diff --git a/arch/arm/mach-nomadik/cpu-8815.h b/arch/arm/mach-nomadik/cpu-8815.h
deleted file mode 100644
index d6c7830..0000000
--- a/arch/arm/mach-nomadik/cpu-8815.h
+++ /dev/null
@@ -1,5 +0,0 @@
-extern void cpu8815_map_io(void);
-extern void cpu8815_platform_init(void);
-extern void cpu8815_init_irq(void);
-extern void cpu8815_restart(char, const char *);
-extern struct sys_timer cpu8815_timer;
diff --git a/arch/arm/mach-nomadik/i2c-8815nhk.c b/arch/arm/mach-nomadik/i2c-8815nhk.c
deleted file mode 100644
index 299ff5a..0000000
--- a/arch/arm/mach-nomadik/i2c-8815nhk.c
+++ /dev/null
@@ -1,82 +0,0 @@
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <linux/i2c-gpio.h>
-#include <linux/platform_device.h>
-#include <asm/mach-types.h>
-
-/*
- * There are two busses in the 8815NHK.
- * They could, in theory, be driven by the hardware component, but we
- * use bit-bang through GPIO by now, to keep things simple
- */
-
-/* I2C0 connected to the STw4811 power management chip */
-static struct i2c_gpio_platform_data nhk8815_i2c_data0 = {
-	/* keep defaults for timeouts; pins are push-pull bidirectional */
-	.scl_pin = 62,
-	.sda_pin = 63,
-};
-
-/* I2C1 connected to various sensors */
-static struct i2c_gpio_platform_data nhk8815_i2c_data1 = {
-	/* keep defaults for timeouts; pins are push-pull bidirectional */
-	.scl_pin = 53,
-	.sda_pin = 54,
-};
-
-/* I2C2 connected to the USB portions of the STw4811 only */
-static struct i2c_gpio_platform_data nhk8815_i2c_data2 = {
-	/* keep defaults for timeouts; pins are push-pull bidirectional */
-	.scl_pin = 73,
-	.sda_pin = 74,
-};
-
-static struct platform_device nhk8815_i2c_dev0 = {
-	.name	= "i2c-gpio",
-	.id	= 0,
-	.dev	= {
-		.platform_data = &nhk8815_i2c_data0,
-	},
-};
-
-static struct platform_device nhk8815_i2c_dev1 = {
-	.name	= "i2c-gpio",
-	.id	= 1,
-	.dev	= {
-		.platform_data = &nhk8815_i2c_data1,
-	},
-};
-
-static struct platform_device nhk8815_i2c_dev2 = {
-	.name	= "i2c-gpio",
-	.id	= 2,
-	.dev	= {
-		.platform_data = &nhk8815_i2c_data2,
-	},
-};
-
-static int __init nhk8815_i2c_init(void)
-{
-	/* For e.g. devicetree boot */
-	if (!machine_is_nomadik())
-		return 0;
-
-	platform_device_register(&nhk8815_i2c_dev0);
-	platform_device_register(&nhk8815_i2c_dev1);
-	platform_device_register(&nhk8815_i2c_dev2);
-
-	return 0;
-}
-
-static void __exit nhk8815_i2c_exit(void)
-{
-	platform_device_unregister(&nhk8815_i2c_dev0);
-	platform_device_unregister(&nhk8815_i2c_dev1);
-	platform_device_unregister(&nhk8815_i2c_dev2);
-	return;
-}
-
-module_init(nhk8815_i2c_init);
-module_exit(nhk8815_i2c_exit);
-- 
1.7.11.7
