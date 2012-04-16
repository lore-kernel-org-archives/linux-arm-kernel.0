From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 16 Apr 2012 10:27:11 +0200
Subject: [PATCH] ARM: ux500: delete U5500 support
Message-ID: <1334564831-6063-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This platform has been obsoleted and was only available inside of
ST-Ericsson, no users of this code are left in the world. This
deletes the core U5500 support entirely in the same manner as the
obsoleted U8500 silicon was previously deleted.

The cpu_is_u5500() macros that can read out the CPU ID is left
until the next kernel cycle, this makes it possible to merge
deletion of dependent drivers without breakage.

This also has the upside of removing the mailbox driver which was
our only driver that was outside the drivers/* hiearchy, now the
machine directory only handles machines and nothing else.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Jonas Aberg <jonas.aberg@stericsson.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig                        |   25 -
 arch/arm/mach-ux500/Makefile                       |    5 -
 arch/arm/mach-ux500/board-u5500-sdi.c              |   74 ---
 arch/arm/mach-ux500/board-u5500.c                  |  162 -----
 arch/arm/mach-ux500/cache-l2x0.c                   |    4 +-
 arch/arm/mach-ux500/clock.c                        |   12 +-
 arch/arm/mach-ux500/cpu-db5500.c                   |  247 --------
 arch/arm/mach-ux500/cpu.c                          |    8 +-
 arch/arm/mach-ux500/devices-db5500.h               |   99 ----
 arch/arm/mach-ux500/dma-db5500.c                   |  137 -----
 arch/arm/mach-ux500/include/mach/db5500-regs.h     |  143 -----
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    4 -
 arch/arm/mach-ux500/include/mach/devices.h         |    1 -
 arch/arm/mach-ux500/include/mach/hardware.h        |    1 -
 .../arm/mach-ux500/include/mach/irqs-board-u5500.h |   21 -
 arch/arm/mach-ux500/include/mach/irqs-db5500.h     |  113 ----
 arch/arm/mach-ux500/include/mach/irqs.h            |    5 -
 arch/arm/mach-ux500/include/mach/mbox-db5500.h     |   88 ---
 arch/arm/mach-ux500/include/mach/setup.h           |    6 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |    7 +-
 arch/arm/mach-ux500/mbox-db5500.c                  |  565 ------------------
 arch/arm/mach-ux500/modem-irq-db5500.c             |  143 -----
 arch/arm/mach-ux500/pins-db5500.h                  |  620 --------------------
 arch/arm/mach-ux500/platsmp.c                      |    8 +-
 arch/arm/mach-ux500/ste-dma40-db5500.h             |  135 -----
 arch/arm/mach-ux500/timer.c                        |   13 +-
 drivers/clocksource/Kconfig                        |    2 +-
 27 files changed, 12 insertions(+), 2636 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-u5500-sdi.c
 delete mode 100644 arch/arm/mach-ux500/board-u5500.c
 delete mode 100644 arch/arm/mach-ux500/cpu-db5500.c
 delete mode 100644 arch/arm/mach-ux500/devices-db5500.h
 delete mode 100644 arch/arm/mach-ux500/dma-db5500.c
 delete mode 100644 arch/arm/mach-ux500/include/mach/db5500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/irqs-board-u5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/irqs-db5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/mbox-db5500.h
 delete mode 100644 arch/arm/mach-ux500/mbox-db5500.c
 delete mode 100644 arch/arm/mach-ux500/modem-irq-db5500.c
 delete mode 100644 arch/arm/mach-ux500/pins-db5500.h
 delete mode 100644 arch/arm/mach-ux500/ste-dma40-db5500.h

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index ef7099e..0e8470a 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -10,10 +10,6 @@ config UX500_SOC_COMMON
 	select ARM_ERRATA_764369
 	select CACHE_L2X0
 
-config UX500_SOC_DB5500
-	bool
-	select MFD_DB5500_PRCMU
-
 config UX500_SOC_DB8500
 	bool
 	select MFD_DB8500_PRCMU
@@ -45,15 +41,8 @@ config MACH_SNOWBALL
 	help
 	  Include support for the snowball development platform.
 
-config MACH_U5500
-	bool "U5500 Development platform"
-	select UX500_SOC_DB5500
-	help
-	  Include support for the U5500 development platform.
-
 config UX500_AUTO_PLATFORM
 	def_bool y
-	depends on !MACH_U5500
 	select MACH_MOP500
 	help
 	  At least one platform needs to be selected in order to build
@@ -74,18 +63,4 @@ config UX500_DEBUG_UART
 	  Choose the UART on which kernel low-level debug messages should be
 	  output.
 
-config U5500_MODEM_IRQ
-	bool "Modem IRQ support"
-	depends on UX500_SOC_DB5500
-	default y
-	help
-	  Add support for handling IRQ:s from modem side
-
-config U5500_MBOX
-	bool "Mailbox support"
-	depends on U5500_MODEM_IRQ
-	default y
-	help
-	  Add support for U5500 mailbox communication with modem side
-
 endif
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 465b9ec..fc7db5d 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -5,16 +5,11 @@
 obj-y				:= clock.o cpu.o devices.o devices-common.o \
 				   id.o usb.o timer.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
-obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-regulators.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o
-obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
-obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
-
diff --git a/arch/arm/mach-ux500/board-u5500-sdi.c b/arch/arm/mach-ux500/board-u5500-sdi.c
deleted file mode 100644
index 836112e..0000000
--- a/arch/arm/mach-ux500/board-u5500-sdi.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Hanumath Prasad <ulf.hansson@stericsson.com>
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/amba/mmci.h>
-#include <linux/mmc/host.h>
-
-#include <plat/pincfg.h>
-#include <plat/gpio-nomadik.h>
-#include <mach/db5500-regs.h>
-#include <plat/ste_dma40.h>
-
-#include "pins-db5500.h"
-#include "devices-db5500.h"
-#include "ste-dma40-db5500.h"
-
-static pin_cfg_t u5500_sdi_pins[] = {
-	/* SDI0 (POP eMMC) */
-	GPIO5_MC0_DAT0		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO6_MC0_DAT1		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO7_MC0_DAT2		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO8_MC0_DAT3		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO9_MC0_DAT4		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO10_MC0_DAT5		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO11_MC0_DAT6		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO12_MC0_DAT7		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO13_MC0_CMD		| PIN_DIR_INPUT | PIN_PULL_UP,
-	GPIO14_MC0_CLK		| PIN_DIR_OUTPUT | PIN_VAL_LOW,
-};
-
-#ifdef CONFIG_STE_DMA40
-struct stedma40_chan_cfg u5500_sdi0_dma_cfg_rx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = STEDMA40_PERIPH_TO_MEM,
-	.src_dev_type = DB5500_DMA_DEV24_SDMMC0_RX,
-	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
-};
-
-static struct stedma40_chan_cfg u5500_sdi0_dma_cfg_tx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = STEDMA40_MEM_TO_PERIPH,
-	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
-	.dst_dev_type = DB5500_DMA_DEV24_SDMMC0_TX,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
-};
-#endif
-
-static struct mmci_platform_data u5500_sdi0_data = {
-	.ocr_mask	= MMC_VDD_165_195,
-	.f_max		= 50000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_8_BIT_DATA |
-				MMC_CAP_MMC_HIGHSPEED,
-	.gpio_cd	= -1,
-	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &u5500_sdi0_dma_cfg_rx,
-	.dma_tx_param	= &u5500_sdi0_dma_cfg_tx,
-#endif
-};
-
-void __init u5500_sdi_init(struct device *parent)
-{
-	nmk_config_pins(u5500_sdi_pins, ARRAY_SIZE(u5500_sdi_pins));
-
-	db5500_add_sdi0(parent, &u5500_sdi0_data);
-}
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
deleted file mode 100644
index 0ff4be7..0000000
--- a/arch/arm/mach-ux500/board-u5500.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
-#include <linux/irq.h>
-#include <linux/i2c.h>
-#include <linux/mfd/abx500/ab5500.h>
-
-#include <asm/hardware/gic.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <plat/pincfg.h>
-#include <plat/i2c.h>
-#include <plat/gpio-nomadik.h>
-
-#include <mach/hardware.h>
-#include <mach/devices.h>
-#include <mach/setup.h>
-
-#include "pins-db5500.h"
-#include "devices-db5500.h"
-#include <linux/led-lm3530.h>
-
-/*
- * GPIO
- */
-
-static pin_cfg_t u5500_pins[] = {
-	/* I2C */
-	GPIO218_I2C2_SCL        | PIN_INPUT_PULLUP,
-	GPIO219_I2C2_SDA        | PIN_INPUT_PULLUP,
-
-	/* DISPLAY_ENABLE */
-	GPIO226_GPIO        | PIN_OUTPUT_LOW,
-
-	/* Backlight Enbale */
-	GPIO224_GPIO        | PIN_OUTPUT_HIGH,
-};
-/*
- * I2C
- */
-
-#define U5500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
-static struct nmk_i2c_controller u5500_i2c##id##_data = { \
-	/*				\
-	 * slave data setup time, which is	\
-	 * 250 ns,100ns,10ns which is 14,6,2	\
-	 * respectively for a 48 Mhz	\
-	 * i2c clock			\
-	 */				\
-	.slsu		= _slsu,	\
-	/* Tx FIFO threshold */		\
-	.tft		= _tft,		\
-	/* Rx FIFO threshold */		\
-	.rft		= _rft,		\
-	/* std. mode operation */	\
-	.clk_freq	= clk,		\
-	.sm		= _sm,		\
-}
-/*
- * The board uses TODO <3> i2c controllers, initialize all of
- * them with slave data setup time of 250 ns,
- * Tx & Rx FIFO threshold values as 1 and standard
- * mode of operation
- */
-
-U5500_I2C_CONTROLLER(2,	0xe, 1, 1, 400000, I2C_FREQ_MODE_FAST);
-
-static struct lm3530_platform_data u5500_als_platform_data = {
-	.mode = LM3530_BL_MODE_MANUAL,
-	.als_input_mode = LM3530_INPUT_ALS1,
-	.max_current = LM3530_FS_CURR_26mA,
-	.pwm_pol_hi = true,
-	.als_avrg_time = LM3530_ALS_AVRG_TIME_512ms,
-	.brt_ramp_law = 1,      /* Linear */
-	.brt_ramp_fall = LM3530_RAMP_TIME_8s,
-	.brt_ramp_rise = LM3530_RAMP_TIME_8s,
-	.als1_resistor_sel = LM3530_ALS_IMPD_13_53kOhm,
-	.als2_resistor_sel = LM3530_ALS_IMPD_Z,
-	.als_vmin = 730,	/* mV */
-	.als_vmax = 1020,	/* mV */
-	.brt_val = 0x7F,	/* Max brightness */
-};
-
-static struct i2c_board_info __initdata u5500_i2c2_devices[] = {
-	{
-		/* Backlight */
-		I2C_BOARD_INFO("lm3530-led", 0x36),
-		.platform_data = &u5500_als_platform_data,
-	},
-};
-
-static void __init u5500_i2c_init(struct device *parent)
-{
-	db5500_add_i2c2(parent, &u5500_i2c2_data);
-	i2c_register_board_info(2, ARRAY_AND_SIZE(u5500_i2c2_devices));
-}
-
-static struct ab5500_platform_data ab5500_plf_data = {
-	.irq = {
-		.base = 0,
-		.count = 0,
-	},
-	.init_settings = NULL,
-	.init_settings_sz = 0,
-	.pm_power_off = false,
-};
-
-static struct platform_device ab5500_device = {
-	.name = "ab5500-core",
-	.id = 0,
-	.dev = {
-		.platform_data = &ab5500_plf_data,
-	},
-	.num_resources = 0,
-};
-
-static struct platform_device *u5500_platform_devices[] __initdata = {
-	&ab5500_device,
-};
-
-static void __init u5500_uart_init(struct device *parent)
-{
-	db5500_add_uart0(parent, NULL);
-	db5500_add_uart1(parent, NULL);
-	db5500_add_uart2(parent, NULL);
-}
-
-static void __init u5500_init_machine(void)
-{
-	struct device *parent = NULL;
-	int i;
-
-	parent = u5500_init_devices();
-	nmk_config_pins(u5500_pins, ARRAY_SIZE(u5500_pins));
-
-	u5500_i2c_init(parent);
-	u5500_sdi_init(parent);
-	u5500_uart_init(parent);
-
-	for (i = 0; i < ARRAY_SIZE(u5500_platform_devices); i++)
-		u5500_platform_devices[i]->dev.parent = parent;
-
-	platform_add_devices(u5500_platform_devices,
-		ARRAY_SIZE(u5500_platform_devices));
-}
-
-MACHINE_START(U5500, "ST-Ericsson U5500 Platform")
-	.atag_offset	= 0x100,
-	.map_io		= u5500_map_io,
-	.init_irq	= ux500_init_irq,
-	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
-	.init_machine	= u5500_init_machine,
-MACHINE_END
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 677bb76..dc12394 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -38,9 +38,7 @@ static int __init ux500_l2x0_init(void)
 {
 	u32 aux_val = 0x3e000000;
 
-	if (cpu_is_u5500())
-		l2x0_base = __io_address(U5500_L2CC_BASE);
-	else if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family())
 		l2x0_base = __io_address(U8500_L2CC_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index cc87f77..063f3db 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -149,9 +149,7 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 	unsigned long mturate;
 	unsigned long retclk;
 
-	if (cpu_is_u5500())
-		addr = __io_address(U5500_PRCMU_BASE);
-	else if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family())
 		addr = __io_address(U8500_PRCMU_BASE);
 	else
 		ux500_unknown_soc();
@@ -705,14 +703,6 @@ late_initcall(clk_init_smp_twd_cpufreq);
 
 int __init clk_init(void)
 {
-	if (cpu_is_u5500()) {
-		/* Clock tree for U5500 not implemented yet */
-		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
-		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
-		clk_uartclk.rate = 36360000;
-		clk_sdmmcclk.rate = 99900000;
-	}
-
 	clkdev_add_table(u8500_clks, ARRAY_SIZE(u8500_clks));
 	clkdev_add(&clk_smp_twd_lookup);
 
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
deleted file mode 100644
index bca47f3..0000000
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-
-#include <asm/mach/map.h>
-#include <asm/pmu.h>
-
-#include <plat/gpio-nomadik.h>
-
-#include <mach/hardware.h>
-#include <mach/devices.h>
-#include <mach/setup.h>
-#include <mach/irqs.h>
-#include <mach/usb.h>
-
-#include "devices-db5500.h"
-#include "ste-dma40-db5500.h"
-
-static struct map_desc u5500_uart_io_desc[] __initdata = {
-	__IO_DEV_DESC(U5500_UART0_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_UART2_BASE, SZ_4K),
-};
-
-static struct map_desc u5500_io_desc[] __initdata = {
-	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
-	__IO_DEV_DESC(U5500_SCU_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_GIC_DIST_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_MTU0_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_BACKUPRAM0_BASE, SZ_8K),
-
-	__IO_DEV_DESC(U5500_GPIO0_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_GPIO1_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_GPIO2_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_GPIO3_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_GPIO4_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_PRCMU_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_PRCMU_TCDM_BASE, SZ_4K),
-};
-
-static struct resource mbox0_resources[] = {
-	{
-		.name = "mbox_peer",
-		.start = U5500_MBOX0_PEER_START,
-		.end = U5500_MBOX0_PEER_END,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name = "mbox_local",
-		.start = U5500_MBOX0_LOCAL_START,
-		.end = U5500_MBOX0_LOCAL_END,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name = "mbox_irq",
-		.start = MBOX_PAIR0_VIRT_IRQ,
-		.end = MBOX_PAIR0_VIRT_IRQ,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct resource mbox1_resources[] = {
-	{
-		.name = "mbox_peer",
-		.start = U5500_MBOX1_PEER_START,
-		.end = U5500_MBOX1_PEER_END,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name = "mbox_local",
-		.start = U5500_MBOX1_LOCAL_START,
-		.end = U5500_MBOX1_LOCAL_END,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name = "mbox_irq",
-		.start = MBOX_PAIR1_VIRT_IRQ,
-		.end = MBOX_PAIR1_VIRT_IRQ,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct resource mbox2_resources[] = {
-	{
-		.name = "mbox_peer",
-		.start = U5500_MBOX2_PEER_START,
-		.end = U5500_MBOX2_PEER_END,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name = "mbox_local",
-		.start = U5500_MBOX2_LOCAL_START,
-		.end = U5500_MBOX2_LOCAL_END,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name = "mbox_irq",
-		.start = MBOX_PAIR2_VIRT_IRQ,
-		.end = MBOX_PAIR2_VIRT_IRQ,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device mbox0_device = {
-	.id = 0,
-	.name = "mbox",
-	.resource = mbox0_resources,
-	.num_resources = ARRAY_SIZE(mbox0_resources),
-};
-
-static struct platform_device mbox1_device = {
-	.id = 1,
-	.name = "mbox",
-	.resource = mbox1_resources,
-	.num_resources = ARRAY_SIZE(mbox1_resources),
-};
-
-static struct platform_device mbox2_device = {
-	.id = 2,
-	.name = "mbox",
-	.resource = mbox2_resources,
-	.num_resources = ARRAY_SIZE(mbox2_resources),
-};
-
-static struct platform_device *db5500_platform_devs[] __initdata = {
-	&mbox0_device,
-	&mbox1_device,
-	&mbox2_device,
-};
-
-static resource_size_t __initdata db5500_gpio_base[] = {
-	U5500_GPIOBANK0_BASE,
-	U5500_GPIOBANK1_BASE,
-	U5500_GPIOBANK2_BASE,
-	U5500_GPIOBANK3_BASE,
-	U5500_GPIOBANK4_BASE,
-	U5500_GPIOBANK5_BASE,
-	U5500_GPIOBANK6_BASE,
-	U5500_GPIOBANK7_BASE,
-};
-
-static void __init db5500_add_gpios(struct device *parent)
-{
-	struct nmk_gpio_platform_data pdata = {
-		/* No custom data yet */
-	};
-
-	dbx500_add_gpios(parent, ARRAY_AND_SIZE(db5500_gpio_base),
-			 IRQ_DB5500_GPIO0, &pdata);
-}
-
-void __init u5500_map_io(void)
-{
-	/*
-	 * Map the UARTs early so that the DEBUG_LL stuff continues to work.
-	 */
-	iotable_init(u5500_uart_io_desc, ARRAY_SIZE(u5500_uart_io_desc));
-
-	ux500_map_io();
-
-	iotable_init(u5500_io_desc, ARRAY_SIZE(u5500_io_desc));
-
-	_PRCMU_BASE = __io_address(U5500_PRCMU_BASE);
-}
-
-static void __init db5500_pmu_init(void)
-{
-	struct resource res[] = {
-		[0] = {
-			.start		= IRQ_DB5500_PMU0,
-			.end		= IRQ_DB5500_PMU0,
-			.flags		= IORESOURCE_IRQ,
-		},
-		[1] = {
-			.start		= IRQ_DB5500_PMU1,
-			.end		= IRQ_DB5500_PMU1,
-			.flags		= IORESOURCE_IRQ,
-		},
-	};
-
-	platform_device_register_simple("arm-pmu", ARM_PMU_DEVICE_CPU,
-					res, ARRAY_SIZE(res));
-}
-
-static int usb_db5500_rx_dma_cfg[] = {
-	DB5500_DMA_DEV4_USB_OTG_IEP_1_9,
-	DB5500_DMA_DEV5_USB_OTG_IEP_2_10,
-	DB5500_DMA_DEV6_USB_OTG_IEP_3_11,
-	DB5500_DMA_DEV20_USB_OTG_IEP_4_12,
-	DB5500_DMA_DEV21_USB_OTG_IEP_5_13,
-	DB5500_DMA_DEV22_USB_OTG_IEP_6_14,
-	DB5500_DMA_DEV23_USB_OTG_IEP_7_15,
-	DB5500_DMA_DEV38_USB_OTG_IEP_8
-};
-
-static int usb_db5500_tx_dma_cfg[] = {
-	DB5500_DMA_DEV4_USB_OTG_OEP_1_9,
-	DB5500_DMA_DEV5_USB_OTG_OEP_2_10,
-	DB5500_DMA_DEV6_USB_OTG_OEP_3_11,
-	DB5500_DMA_DEV20_USB_OTG_OEP_4_12,
-	DB5500_DMA_DEV21_USB_OTG_OEP_5_13,
-	DB5500_DMA_DEV22_USB_OTG_OEP_6_14,
-	DB5500_DMA_DEV23_USB_OTG_OEP_7_15,
-	DB5500_DMA_DEV38_USB_OTG_OEP_8
-};
-
-static const char *db5500_read_soc_id(void)
-{
-	return kasprintf(GFP_KERNEL, "u5500 currently unsupported\n");
-}
-
-static struct device * __init db5500_soc_device_init(void)
-{
-	const char *soc_id = db5500_read_soc_id();
-
-	return ux500_soc_device_init(soc_id);
-}
-
-struct device * __init u5500_init_devices(void)
-{
-	struct device *parent;
-	int i;
-
-	parent = db5500_soc_device_init();
-
-	db5500_add_gpios(parent);
-	db5500_pmu_init();
-	db5500_dma_init(parent);
-	db5500_add_rtc(parent);
-	db5500_add_usb(parent, usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
-
-	for (i = 0; i < ARRAY_SIZE(db5500_platform_devs); i++)
-		db5500_platform_devs[i]->dev.parent = parent;
-
-	platform_add_devices(db5500_platform_devs,
-			     ARRAY_SIZE(db5500_platform_devs));
-
-	return parent;
-}
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 857e481..0982279 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/mfd/db8500-prcmu.h>
-#include <linux/mfd/db5500-prcmu.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 #include <linux/sys_soc.h>
 #include <linux/err.h>
@@ -40,10 +39,7 @@ void __init ux500_init_irq(void)
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
-	if (cpu_is_u5500()) {
-		dist_base = __io_address(U5500_GIC_DIST_BASE);
-		cpu_base = __io_address(U5500_GIC_CPU_BASE);
-	} else if (cpu_is_u8500_family()) {
+	if (cpu_is_u8500_family()) {
 		dist_base = __io_address(U8500_GIC_DIST_BASE);
 		cpu_base = __io_address(U8500_GIC_CPU_BASE);
 	} else
@@ -60,8 +56,6 @@ void __init ux500_init_irq(void)
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
-	if (cpu_is_u5500())
-		db5500_prcmu_early_init();
 	if (cpu_is_u8500_family())
 		db8500_prcmu_early_init();
 	clk_init();
diff --git a/arch/arm/mach-ux500/devices-db5500.h b/arch/arm/mach-ux500/devices-db5500.h
deleted file mode 100644
index e709555..0000000
--- a/arch/arm/mach-ux500/devices-db5500.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-#ifndef __DEVICES_DB5500_H
-#define __DEVICES_DB5500_H
-
-#include "devices-common.h"
-
-#define db5500_add_i2c1(parent, pdata) \
-	dbx500_add_i2c(parent, 1, U5500_I2C1_BASE, IRQ_DB5500_I2C1, pdata)
-#define db5500_add_i2c2(parent, pdata) \
-	dbx500_add_i2c(parent, 2, U5500_I2C2_BASE, IRQ_DB5500_I2C2, pdata)
-#define db5500_add_i2c3(parent, pdata) \
-	dbx500_add_i2c(parent, 3, U5500_I2C3_BASE, IRQ_DB5500_I2C3, pdata)
-
-#define db5500_add_msp0_spi(parent, pdata) \
-	dbx500_add_msp_spi(parent, "msp0", U5500_MSP0_BASE, \
-			   IRQ_DB5500_MSP0, pdata)
-#define db5500_add_msp1_spi(parent, pdata) \
-	dbx500_add_msp_spi(parent, "msp1", U5500_MSP1_BASE, \
-			   IRQ_DB5500_MSP1, pdata)
-#define db5500_add_msp2_spi(parent, pdata) \
-	dbx500_add_msp_spi(parent, "msp2", U5500_MSP2_BASE, \
-			   IRQ_DB5500_MSP2, pdata)
-
-#define db5500_add_msp0_spi(parent, pdata) \
-	dbx500_add_msp_spi(parent, "msp0", U5500_MSP0_BASE, \
-			  IRQ_DB5500_MSP0, pdata)
-#define db5500_add_msp1_spi(parent, pdata) \
-	dbx500_add_msp_spi(parent, "msp1", U5500_MSP1_BASE, \
-			  IRQ_DB5500_MSP1, pdata)
-#define db5500_add_msp2_spi(parent, pdata) \
-	dbx500_add_msp_spi(parent, "msp2", U5500_MSP2_BASE, \
-			  IRQ_DB5500_MSP2, pdata)
-
-#define db5500_add_rtc(parent) \
-	dbx500_add_rtc(parent, U5500_RTC_BASE, IRQ_DB5500_RTC);
-
-#define db5500_add_usb(parent, rx_cfg, tx_cfg) \
-	ux500_add_usb(parent, U5500_USBOTG_BASE, \
-		      IRQ_DB5500_USBOTG, rx_cfg, tx_cfg)
-
-#define db5500_add_sdi0(parent, pdata) \
-	dbx500_add_sdi(parent, "sdi0", U5500_SDI0_BASE, \
-		       IRQ_DB5500_SDMMC0, pdata,	\
-		       0x10480180)
-#define db5500_add_sdi1(parent, pdata) \
-	dbx500_add_sdi(parent, "sdi1", U5500_SDI1_BASE, \
-		       IRQ_DB5500_SDMMC1, pdata,	\
-		       0x10480180)
-#define db5500_add_sdi2(parent, pdata) \
-	dbx500_add_sdi(parent, "sdi2", U5500_SDI2_BASE, \
-		       IRQ_DB5500_SDMMC2, pdata		\
-		       0x10480180)
-#define db5500_add_sdi3(parent, pdata) \
-	dbx500_add_sdi(parent, "sdi3", U5500_SDI3_BASE, \
-		       IRQ_DB5500_SDMMC3, pdata		\
-		       0x10480180)
-#define db5500_add_sdi4(parent, pdata) \
-	dbx500_add_sdi(parent, "sdi4", U5500_SDI4_BASE, \
-		       IRQ_DB5500_SDMMC4, pdata		\
-		       0x10480180)
-
-/* This one has a bad peripheral ID in the U5500 silicon */
-#define db5500_add_spi0(parent, pdata) \
-	dbx500_add_spi(parent, "spi0", U5500_SPI0_BASE, \
-		       IRQ_DB5500_SPI0, pdata,		\
-		       0x10080023)
-#define db5500_add_spi1(parent, pdata) \
-	dbx500_add_spi(parent, "spi1", U5500_SPI1_BASE, \
-		       IRQ_DB5500_SPI1, pdata,		\
-		       0x10080023)
-#define db5500_add_spi2(parent, pdata) \
-	dbx500_add_spi(parent, "spi2", U5500_SPI2_BASE, \
-		       IRQ_DB5500_SPI2, pdata		\
-		       0x10080023)
-#define db5500_add_spi3(parent, pdata) \
-	dbx500_add_spi(parent, "spi3", U5500_SPI3_BASE, \
-		       IRQ_DB5500_SPI3, pdata		\
-		       0x10080023)
-
-#define db5500_add_uart0(parent, plat) \
-	dbx500_add_uart(parent, "uart0", U5500_UART0_BASE, \
-			IRQ_DB5500_UART0, plat)
-#define db5500_add_uart1(parent, plat) \
-	dbx500_add_uart(parent, "uart1", U5500_UART1_BASE, \
-			IRQ_DB5500_UART1, plat)
-#define db5500_add_uart2(parent, plat) \
-	dbx500_add_uart(parent, "uart2", U5500_UART2_BASE, \
-			IRQ_DB5500_UART2, plat)
-#define db5500_add_uart3(parent, plat) \
-	dbx500_add_uart(parent, "uart3", U5500_UART3_BASE, \
-			IRQ_DB5500_UART3, plat)
-
-#endif
diff --git a/arch/arm/mach-ux500/dma-db5500.c b/arch/arm/mach-ux500/dma-db5500.c
deleted file mode 100644
index 41e9470..0000000
--- a/arch/arm/mach-ux500/dma-db5500.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Per Forlin <per.forlin@stericsson.com> for ST-Ericsson
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com> for ST-Ericsson
- * Author: Rabin Vincent <rabinv.vincent@stericsson.com> for ST-Ericsson
- *
- * License terms: GNU General Public License (GPL), version 2
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <plat/ste_dma40.h>
-#include <mach/setup.h>
-#include <mach/hardware.h>
-
-#include "ste-dma40-db5500.h"
-
-static struct resource dma40_resources[] = {
-	[0] = {
-		.start = U5500_DMA_BASE,
-		.end   = U5500_DMA_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-		.name  = "base",
-	},
-	[1] = {
-		.start = U5500_DMA_LCPA_BASE,
-		.end   = U5500_DMA_LCPA_BASE + 2 * SZ_1K - 1,
-		.flags = IORESOURCE_MEM,
-		.name  = "lcpa",
-	},
-	[2] = {
-		.start = IRQ_DB5500_DMA,
-		.end   = IRQ_DB5500_DMA,
-		.flags = IORESOURCE_IRQ
-	}
-};
-
-/* Default configuration for physical memcpy */
-static struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
-	.mode = STEDMA40_MODE_PHYSICAL,
-	.dir = STEDMA40_MEM_TO_MEM,
-
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.src_info.psize = STEDMA40_PSIZE_PHY_1,
-	.src_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
-
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.psize = STEDMA40_PSIZE_PHY_1,
-	.dst_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
-};
-
-/* Default configuration for logical memcpy */
-static struct stedma40_chan_cfg dma40_memcpy_conf_log = {
-	.dir = STEDMA40_MEM_TO_MEM,
-
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.src_info.psize = STEDMA40_PSIZE_LOG_1,
-	.src_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
-
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.psize = STEDMA40_PSIZE_LOG_1,
-	.dst_info.flow_ctrl = STEDMA40_NO_FLOW_CTRL,
-};
-
-/*
- * Mapping between soruce event lines and physical device address This was
- * created assuming that the event line is tied to a device and therefore the
- * address is constant, however this is not true for at least USB, and the
- * values are just placeholders for USB.  This table is preserved and used for
- * now.
- */
-static const dma_addr_t dma40_rx_map[DB5500_DMA_NR_DEV] = {
-	[DB5500_DMA_DEV24_SDMMC0_RX] = -1,
-	[DB5500_DMA_DEV38_USB_OTG_IEP_8] = -1,
-	[DB5500_DMA_DEV23_USB_OTG_IEP_7_15] = -1,
-	[DB5500_DMA_DEV22_USB_OTG_IEP_6_14] = -1,
-	[DB5500_DMA_DEV21_USB_OTG_IEP_5_13] = -1,
-	[DB5500_DMA_DEV20_USB_OTG_IEP_4_12] = -1,
-	[DB5500_DMA_DEV6_USB_OTG_IEP_3_11] = -1,
-	[DB5500_DMA_DEV5_USB_OTG_IEP_2_10] = -1,
-	[DB5500_DMA_DEV4_USB_OTG_IEP_1_9] = -1,
-};
-
-/* Mapping between destination event lines and physical device address */
-static const dma_addr_t dma40_tx_map[DB5500_DMA_NR_DEV] = {
-	[DB5500_DMA_DEV24_SDMMC0_TX] = -1,
-	[DB5500_DMA_DEV38_USB_OTG_OEP_8] = -1,
-	[DB5500_DMA_DEV23_USB_OTG_OEP_7_15] = -1,
-	[DB5500_DMA_DEV22_USB_OTG_OEP_6_14] = -1,
-	[DB5500_DMA_DEV21_USB_OTG_OEP_5_13] = -1,
-	[DB5500_DMA_DEV20_USB_OTG_OEP_4_12] = -1,
-	[DB5500_DMA_DEV6_USB_OTG_OEP_3_11] = -1,
-	[DB5500_DMA_DEV5_USB_OTG_OEP_2_10] = -1,
-	[DB5500_DMA_DEV4_USB_OTG_OEP_1_9] = -1,
-};
-
-static int dma40_memcpy_event[] = {
-	DB5500_DMA_MEMCPY_TX_1,
-	DB5500_DMA_MEMCPY_TX_2,
-	DB5500_DMA_MEMCPY_TX_3,
-	DB5500_DMA_MEMCPY_TX_4,
-	DB5500_DMA_MEMCPY_TX_5,
-};
-
-static struct stedma40_platform_data dma40_plat_data = {
-	.dev_len		= ARRAY_SIZE(dma40_rx_map),
-	.dev_rx			= dma40_rx_map,
-	.dev_tx			= dma40_tx_map,
-	.memcpy			= dma40_memcpy_event,
-	.memcpy_len		= ARRAY_SIZE(dma40_memcpy_event),
-	.memcpy_conf_phy	= &dma40_memcpy_conf_phy,
-	.memcpy_conf_log	= &dma40_memcpy_conf_log,
-	.disabled_channels	= {-1},
-};
-
-static struct platform_device dma40_device = {
-	.dev = {
-		.platform_data = &dma40_plat_data,
-	},
-	.name		= "dma40",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(dma40_resources),
-	.resource	= dma40_resources
-};
-
-void __init db5500_dma_init(struct device *parent)
-{
-	int ret;
-
-	dma40_device.dev.parent = parent;
-	ret = platform_device_register(&dma40_device);
-	if (ret)
-		dev_err(&dma40_device.dev, "unable to register device: %d\n", ret);
-
-}
diff --git a/arch/arm/mach-ux500/include/mach/db5500-regs.h b/arch/arm/mach-ux500/include/mach/db5500-regs.h
deleted file mode 100644
index 8e714bc..0000000
--- a/arch/arm/mach-ux500/include/mach/db5500-regs.h
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __MACH_DB5500_REGS_H
-#define __MACH_DB5500_REGS_H
-
-#define U5500_PER1_BASE		0xA0020000
-#define U5500_PER2_BASE		0xA0010000
-#define U5500_PER3_BASE		0x80140000
-#define U5500_PER4_BASE		0x80150000
-#define U5500_PER5_BASE		0x80100000
-#define U5500_PER6_BASE		0x80120000
-
-#define U5500_GIC_DIST_BASE	0xA0411000
-#define U5500_GIC_CPU_BASE	0xA0410100
-#define U5500_DMA_BASE		0x90030000
-#define U5500_STM_BASE		0x90020000
-#define U5500_STM_REG_BASE	(U5500_STM_BASE + 0xF000)
-#define U5500_MCDE_BASE		0xA0400000
-#define U5500_MODEM_BASE	0xB0000000
-#define U5500_L2CC_BASE		0xA0412000
-#define U5500_SCU_BASE		0xA0410000
-#define U5500_DSI1_BASE		0xA0401000
-#define U5500_DSI2_BASE		0xA0402000
-#define U5500_SIA_BASE		0xA0100000
-#define U5500_SVA_BASE		0x80200000
-#define U5500_HSEM_BASE		0xA0000000
-#define U5500_NAND0_BASE	0x60000000
-#define U5500_NAND1_BASE	0x70000000
-#define U5500_TWD_BASE		0xa0410600
-#define U5500_ICN_BASE		0xA0040000
-#define U5500_B2R2_BASE		0xa0200000
-#define U5500_BOOT_ROM_BASE	0x90000000
-
-#define U5500_FSMC_BASE		(U5500_PER1_BASE + 0x0000)
-#define U5500_SDI0_BASE		(U5500_PER1_BASE + 0x1000)
-#define U5500_SDI2_BASE		(U5500_PER1_BASE + 0x2000)
-#define U5500_UART0_BASE	(U5500_PER1_BASE + 0x3000)
-#define U5500_I2C1_BASE		(U5500_PER1_BASE + 0x4000)
-#define U5500_MSP0_BASE		(U5500_PER1_BASE + 0x5000)
-#define U5500_GPIO0_BASE	(U5500_PER1_BASE + 0xE000)
-#define U5500_CLKRST1_BASE	(U5500_PER1_BASE + 0xF000)
-
-#define U5500_USBOTG_BASE	(U5500_PER2_BASE + 0x0000)
-#define U5500_GPIO1_BASE	(U5500_PER2_BASE + 0xE000)
-#define U5500_CLKRST2_BASE	(U5500_PER2_BASE + 0xF000)
-
-#define U5500_KEYPAD_BASE	(U5500_PER3_BASE + 0x0000)
-#define U5500_PWM_BASE		(U5500_PER3_BASE + 0x1000)
-#define U5500_GPIO3_BASE	(U5500_PER3_BASE + 0xE000)
-#define U5500_CLKRST3_BASE	(U5500_PER3_BASE + 0xF000)
-
-#define U5500_BACKUPRAM0_BASE	(U5500_PER4_BASE + 0x0000)
-#define U5500_BACKUPRAM1_BASE	(U5500_PER4_BASE + 0x1000)
-#define U5500_RTT0_BASE		(U5500_PER4_BASE + 0x2000)
-#define U5500_RTT1_BASE		(U5500_PER4_BASE + 0x3000)
-#define U5500_RTC_BASE		(U5500_PER4_BASE + 0x4000)
-#define U5500_SCR_BASE		(U5500_PER4_BASE + 0x5000)
-#define U5500_DMC_BASE		(U5500_PER4_BASE + 0x6000)
-#define U5500_PRCMU_BASE	(U5500_PER4_BASE + 0x7000)
-#define U5500_PRCMU_TIMER_3_BASE (U5500_PER4_BASE + 0x07338)
-#define U5500_PRCMU_TIMER_4_BASE (U5500_PER4_BASE + 0x07450)
-#define U5500_MSP1_BASE		(U5500_PER4_BASE + 0x9000)
-#define U5500_GPIO2_BASE	(U5500_PER4_BASE + 0xA000)
-#define U5500_MTIMER_BASE	(U5500_PER4_BASE + 0xC000)
-#define U5500_CDETECT_BASE	(U5500_PER4_BASE + 0xF000)
-#define U5500_PRCMU_TCDM_BASE	(U5500_PER4_BASE + 0x18000)
-#define U5500_PRCMU_TCPM_BASE	(U5500_PER4_BASE + 0x10000)
-#define U5500_TPIU_BASE		(U5500_PER4_BASE + 0x50000)
-
-#define U5500_SPI0_BASE		(U5500_PER5_BASE + 0x0000)
-#define U5500_SPI1_BASE		(U5500_PER5_BASE + 0x1000)
-#define U5500_SPI2_BASE		(U5500_PER5_BASE + 0x2000)
-#define U5500_SPI3_BASE		(U5500_PER5_BASE + 0x3000)
-#define U5500_UART1_BASE	(U5500_PER5_BASE + 0x4000)
-#define U5500_UART2_BASE	(U5500_PER5_BASE + 0x5000)
-#define U5500_UART3_BASE	(U5500_PER5_BASE + 0x6000)
-#define U5500_SDI1_BASE		(U5500_PER5_BASE + 0x7000)
-#define U5500_SDI3_BASE		(U5500_PER5_BASE + 0x8000)
-#define U5500_SDI4_BASE		(U5500_PER5_BASE + 0x9000)
-#define U5500_I2C2_BASE		(U5500_PER5_BASE + 0xA000)
-#define U5500_I2C3_BASE		(U5500_PER5_BASE + 0xB000)
-#define U5500_MSP2_BASE		(U5500_PER5_BASE + 0xC000)
-#define U5500_IRDA_BASE		(U5500_PER5_BASE + 0xD000)
-#define U5500_IRRC_BASE		(U5500_PER5_BASE + 0x10000)
-#define U5500_GPIO4_BASE	(U5500_PER5_BASE + 0x1E000)
-#define U5500_CLKRST5_BASE	(U5500_PER5_BASE + 0x1F000)
-
-#define U5500_RNG_BASE		(U5500_PER6_BASE + 0x0000)
-#define U5500_HASH0_BASE	(U5500_PER6_BASE + 0x1000)
-#define U5500_HASH1_BASE	(U5500_PER6_BASE + 0x2000)
-#define U5500_PKA_BASE		(U5500_PER6_BASE + 0x4000)
-#define U5500_PKAM_BASE		(U5500_PER6_BASE + 0x5100)
-#define U5500_MTU0_BASE		(U5500_PER6_BASE + 0x6000)
-#define U5500_MTU1_BASE		(U5500_PER6_BASE + 0x7000)
-#define U5500_CR_BASE		(U5500_PER6_BASE + 0x8000)
-#define U5500_CRYP0_BASE	(U5500_PER6_BASE + 0xA000)
-#define U5500_CRYP1_BASE	(U5500_PER6_BASE + 0xB000)
-#define U5500_CLKRST6_BASE	(U5500_PER6_BASE + 0xF000)
-
-#define U5500_GPIOBANK0_BASE	U5500_GPIO0_BASE
-#define U5500_GPIOBANK1_BASE	(U5500_GPIO0_BASE + 0x80)
-#define U5500_GPIOBANK2_BASE	U5500_GPIO1_BASE
-#define U5500_GPIOBANK3_BASE	U5500_GPIO2_BASE
-#define U5500_GPIOBANK4_BASE	U5500_GPIO3_BASE
-#define U5500_GPIOBANK5_BASE	U5500_GPIO4_BASE
-#define U5500_GPIOBANK6_BASE	(U5500_GPIO4_BASE + 0x80)
-#define U5500_GPIOBANK7_BASE	(U5500_GPIO4_BASE + 0x100)
-
-#define U5500_MBOX_BASE		(U5500_MODEM_BASE + 0xFFD1000)
-#define U5500_MBOX0_PEER_START	(U5500_MBOX_BASE + 0x40)
-#define U5500_MBOX0_PEER_END	(U5500_MBOX_BASE + 0x5F)
-#define U5500_MBOX0_LOCAL_START	(U5500_MBOX_BASE + 0x60)
-#define U5500_MBOX0_LOCAL_END	(U5500_MBOX_BASE + 0x7F)
-#define U5500_MBOX1_PEER_START	(U5500_MBOX_BASE + 0x80)
-#define U5500_MBOX1_PEER_END	(U5500_MBOX_BASE + 0x9F)
-#define U5500_MBOX1_LOCAL_START	(U5500_MBOX_BASE + 0xA0)
-#define U5500_MBOX1_LOCAL_END	(U5500_MBOX_BASE + 0xBF)
-#define U5500_MBOX2_PEER_START	(U5500_MBOX_BASE + 0x00)
-#define U5500_MBOX2_PEER_END	(U5500_MBOX_BASE + 0x1F)
-#define U5500_MBOX2_LOCAL_START	(U5500_MBOX_BASE + 0x20)
-#define U5500_MBOX2_LOCAL_END	(U5500_MBOX_BASE + 0x3F)
-
-#define U5500_ACCCON_BASE_SEC	(0xBFFF0000)
-#define U5500_ACCCON_BASE		(0xBFFF1000)
-#define U5500_ACCCON_CPUVEC_RESET_ADDR_OFFSET (0x00000020)
-#define U5500_ACCCON_ACC_CPU_CTRL_OFFSET (0x000000BC)
-#define U5500_INTCON_MBOX1_INT_RESET_ADDR	(0xBFFD31A4)
-
-#define U5500_ESRAM_BASE	        0x40000000
-#define U5500_ESRAM_DMA_LCPA_OFFSET	0x10000
-#define U5500_DMA_LCPA_BASE    (U5500_ESRAM_BASE + U5500_ESRAM_DMA_LCPA_OFFSET)
-
-#define U5500_MCDE_SIZE		0x1000
-#define U5500_DSI_LINK_SIZE	0x1000
-#define U5500_DSI_LINK_COUNT	0x2
-#define U5500_DSI_LINK1_BASE	(U5500_MCDE_BASE + U5500_MCDE_SIZE)
-#define U5500_DSI_LINK2_BASE	(U5500_DSI_LINK1_BASE + U5500_DSI_LINK_SIZE)
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index 8d74d92..6703522 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -20,10 +20,6 @@
  * built, so that there's some hint during the build that something is wrong.
  */
 
-#ifdef CONFIG_UX500_SOC_DB5500
-#define __UX500_UART(n)	U5500_UART##n##_BASE
-#endif
-
 #ifdef CONFIG_UX500_SOC_DB8500
 #define __UX500_UART(n)	U8500_UART##n##_BASE
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 5f6cb71..9b5eb69 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -10,7 +10,6 @@
 struct platform_device;
 struct amba_device;
 
-extern struct platform_device u5500_gpio_devs[];
 extern struct platform_device u8500_gpio_devs[];
 
 extern struct amba_device ux500_pl031_device;
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 8361657..808c1d6 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -31,7 +31,6 @@
 #define io_p2v(n)		__io_address(n)
 
 #include <mach/db8500-regs.h>
-#include <mach/db5500-regs.h>
 
 #define MSP_TX_RX_REG_OFFSET	0
 
diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-u5500.h b/arch/arm/mach-ux500/include/mach/irqs-board-u5500.h
deleted file mode 100644
index 29d972c..0000000
--- a/arch/arm/mach-ux500/include/mach/irqs-board-u5500.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __MACH_IRQS_BOARD_U5500_H
-#define __MACH_IRQS_BOARD_U5500_H
-
-#define AB5500_NR_IRQS		5
-#define IRQ_AB5500_BASE		IRQ_BOARD_START
-#define IRQ_AB5500_END		(IRQ_AB5500_BASE + AB5500_NR_IRQS)
-
-#define U5500_IRQ_END		IRQ_AB5500_END
-
-#if IRQ_BOARD_END < U5500_IRQ_END
-#undef IRQ_BOARD_END
-#define IRQ_BOARD_END		U5500_IRQ_END
-#endif
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs-db5500.h b/arch/arm/mach-ux500/include/mach/irqs-db5500.h
deleted file mode 100644
index 7723977..0000000
--- a/arch/arm/mach-ux500/include/mach/irqs-db5500.h
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com>
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __MACH_IRQS_DB5500_H
-#define __MACH_IRQS_DB5500_H
-
-#define IRQ_DB5500_MTU0			(IRQ_SHPI_START + 4)
-#define IRQ_DB5500_SPI2			(IRQ_SHPI_START + 6)
-#define IRQ_DB5500_PMU0			(IRQ_SHPI_START + 7)
-#define IRQ_DB5500_SPI0			(IRQ_SHPI_START + 8)
-#define IRQ_DB5500_RTT			(IRQ_SHPI_START + 9)
-#define IRQ_DB5500_PKA			(IRQ_SHPI_START + 10)
-#define IRQ_DB5500_UART0		(IRQ_SHPI_START + 11)
-#define IRQ_DB5500_I2C3			(IRQ_SHPI_START + 12)
-#define IRQ_DB5500_L2CC			(IRQ_SHPI_START + 13)
-#define IRQ_DB5500_MSP0			(IRQ_SHPI_START + 14)
-#define IRQ_DB5500_CRYP1		(IRQ_SHPI_START + 15)
-#define IRQ_DB5500_PMU1			(IRQ_SHPI_START + 16)
-#define IRQ_DB5500_MTU1			(IRQ_SHPI_START + 17)
-#define IRQ_DB5500_RTC			(IRQ_SHPI_START + 18)
-#define IRQ_DB5500_UART1		(IRQ_SHPI_START + 19)
-#define IRQ_DB5500_USB_WAKEUP		(IRQ_SHPI_START + 20)
-#define IRQ_DB5500_I2C0			(IRQ_SHPI_START + 21)
-#define IRQ_DB5500_I2C1			(IRQ_SHPI_START + 22)
-#define IRQ_DB5500_USBOTG		(IRQ_SHPI_START + 23)
-#define IRQ_DB5500_DMA_SECURE		(IRQ_SHPI_START + 24)
-#define IRQ_DB5500_DMA			(IRQ_SHPI_START + 25)
-#define IRQ_DB5500_UART2		(IRQ_SHPI_START + 26)
-#define IRQ_DB5500_ICN_PMU1		(IRQ_SHPI_START + 27)
-#define IRQ_DB5500_ICN_PMU2		(IRQ_SHPI_START + 28)
-#define IRQ_DB5500_UART3		(IRQ_SHPI_START + 29)
-#define IRQ_DB5500_SPI3			(IRQ_SHPI_START + 30)
-#define IRQ_DB5500_SDMMC4		(IRQ_SHPI_START + 31)
-#define IRQ_DB5500_IRRC			(IRQ_SHPI_START + 33)
-#define IRQ_DB5500_IRDA_FT		(IRQ_SHPI_START + 34)
-#define IRQ_DB5500_IRDA_SD		(IRQ_SHPI_START + 35)
-#define IRQ_DB5500_IRDA_FI		(IRQ_SHPI_START + 36)
-#define IRQ_DB5500_IRDA_FD		(IRQ_SHPI_START + 37)
-#define IRQ_DB5500_FSMC_CODEREADY	(IRQ_SHPI_START + 38)
-#define IRQ_DB5500_FSMC_NANDWAIT	(IRQ_SHPI_START + 39)
-#define IRQ_DB5500_AB5500		(IRQ_SHPI_START + 40)
-#define IRQ_DB5500_SDMMC2		(IRQ_SHPI_START + 41)
-#define IRQ_DB5500_SIA			(IRQ_SHPI_START + 42)
-#define IRQ_DB5500_SIA2			(IRQ_SHPI_START + 43)
-#define IRQ_DB5500_HVA			(IRQ_SHPI_START + 44)
-#define IRQ_DB5500_HVA2			(IRQ_SHPI_START + 45)
-#define IRQ_DB5500_PRCMU0		(IRQ_SHPI_START + 46)
-#define IRQ_DB5500_PRCMU1		(IRQ_SHPI_START + 47)
-#define IRQ_DB5500_DISP			(IRQ_SHPI_START + 48)
-#define IRQ_DB5500_SDMMC1		(IRQ_SHPI_START + 50)
-#define IRQ_DB5500_MSP1			(IRQ_SHPI_START + 52)
-#define IRQ_DB5500_KBD			(IRQ_SHPI_START + 53)
-#define IRQ_DB5500_I2C2			(IRQ_SHPI_START + 55)
-#define IRQ_DB5500_B2R2			(IRQ_SHPI_START + 56)
-#define IRQ_DB5500_CRYP0		(IRQ_SHPI_START + 57)
-#define IRQ_DB5500_SDMMC3		(IRQ_SHPI_START + 59)
-#define IRQ_DB5500_SDMMC0		(IRQ_SHPI_START + 60)
-#define IRQ_DB5500_HSEM			(IRQ_SHPI_START + 61)
-#define IRQ_DB5500_SBAG			(IRQ_SHPI_START + 63)
-#define IRQ_DB5500_MODEM		(IRQ_SHPI_START + 65)
-#define IRQ_DB5500_SPI1			(IRQ_SHPI_START + 96)
-#define IRQ_DB5500_MSP2			(IRQ_SHPI_START + 98)
-#define IRQ_DB5500_SRPTIMER		(IRQ_SHPI_START + 101)
-#define IRQ_DB5500_CTI0			(IRQ_SHPI_START + 108)
-#define IRQ_DB5500_CTI1			(IRQ_SHPI_START + 109)
-#define IRQ_DB5500_ICN_ERR		(IRQ_SHPI_START + 110)
-#define IRQ_DB5500_MALI_PPMMU		(IRQ_SHPI_START + 112)
-#define IRQ_DB5500_MALI_PP		(IRQ_SHPI_START + 113)
-#define IRQ_DB5500_MALI_GPMMU		(IRQ_SHPI_START + 114)
-#define IRQ_DB5500_MALI_GP		(IRQ_SHPI_START + 115)
-#define IRQ_DB5500_MALI			(IRQ_SHPI_START + 116)
-#define IRQ_DB5500_PRCMU_SEM		(IRQ_SHPI_START + 118)
-#define IRQ_DB5500_GPIO0		(IRQ_SHPI_START + 119)
-#define IRQ_DB5500_GPIO1		(IRQ_SHPI_START + 120)
-#define IRQ_DB5500_GPIO2		(IRQ_SHPI_START + 121)
-#define IRQ_DB5500_GPIO3		(IRQ_SHPI_START + 122)
-#define IRQ_DB5500_GPIO4		(IRQ_SHPI_START + 123)
-#define IRQ_DB5500_GPIO5		(IRQ_SHPI_START + 124)
-#define IRQ_DB5500_GPIO6		(IRQ_SHPI_START + 125)
-#define IRQ_DB5500_GPIO7		(IRQ_SHPI_START + 126)
-
-#ifdef CONFIG_UX500_SOC_DB5500
-
-/*
- * After the GPIO ones we reserve a range of IRQ:s in which virtual
- * IRQ:s representing modem IRQ:s can be allocated
- */
-#define IRQ_MODEM_EVENTS_BASE	IRQ_SOC_START
-#define IRQ_MODEM_EVENTS_NBR	72
-#define IRQ_MODEM_EVENTS_END	(IRQ_MODEM_EVENTS_BASE + IRQ_MODEM_EVENTS_NBR)
-
-/* List of virtual IRQ:s that are allocated from the range above */
-#define MBOX_PAIR0_VIRT_IRQ	(IRQ_MODEM_EVENTS_BASE + 43)
-#define MBOX_PAIR1_VIRT_IRQ	(IRQ_MODEM_EVENTS_BASE + 45)
-#define MBOX_PAIR2_VIRT_IRQ	(IRQ_MODEM_EVENTS_BASE + 41)
-
-/*
- * We may have several SoCs, but only one will run at a
- * time, so the one with most IRQs will bump this ahead,
- * but the IRQ_SOC_START remains the same for either SoC.
- */
-#if IRQ_SOC_END < IRQ_MODEM_EVENTS_END
-#undef IRQ_SOC_END
-#define IRQ_SOC_END		IRQ_MODEM_EVENTS_END
-#endif
-
-#endif /* CONFIG_UX500_SOC_DB5500 */
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 7da9ec5..e892854 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -36,7 +36,6 @@
 /* This will be overridden by SoC-specific irq headers */
 #define IRQ_SOC_END		IRQ_SOC_START
 
-#include <mach/irqs-db5500.h>
 #include <mach/irqs-db8500.h>
 
 #define IRQ_BOARD_START		IRQ_SOC_END
@@ -47,10 +46,6 @@
 #include <mach/irqs-board-mop500.h>
 #endif
 
-#ifdef CONFIG_MACH_U5500
-#include <mach/irqs-board-u5500.h>
-#endif
-
 #define NR_IRQS			IRQ_BOARD_END
 
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-ux500/include/mach/mbox-db5500.h b/arch/arm/mach-ux500/include/mach/mbox-db5500.h
deleted file mode 100644
index 7f9da4d..0000000
--- a/arch/arm/mach-ux500/include/mach/mbox-db5500.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
- * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-#ifndef __INC_STE_MBOX_H
-#define __INC_STE_MBOX_H
-
-#define MBOX_BUF_SIZE 16
-#define MBOX_NAME_SIZE 8
-
-/**
-  * mbox_recv_cb_t - Definition of the mailbox callback.
-  * @mbox_msg:	The mailbox message.
-  * @priv:	The clients private data as specified in the call to mbox_setup.
-  *
-  * This function will be called upon reception of new mailbox messages.
-  */
-typedef void mbox_recv_cb_t (u32 mbox_msg, void *priv);
-
-/**
-  * struct mbox - Mailbox instance struct
-  * @list:		Linked list head.
-  * @pdev:		Pointer to device struct.
-  * @cb:		Callback function. Will be called
-  *			when new data is received.
-  * @client_data:	Clients private data. Will be sent back
-  *			in the callback function.
-  * @virtbase_peer:	Virtual address for outgoing mailbox.
-  * @virtbase_local:	Virtual address for incoming mailbox.
-  * @buffer:		Then internal queue for outgoing messages.
-  * @name:		Name of this mailbox.
-  * @buffer_available:	Completion variable to achieve "blocking send".
-  *			This variable will be signaled when there is
-  *			internal buffer space available.
-  * @client_blocked:	To keep track if any client is currently
-  *			blocked.
-  * @lock:		Spinlock to protect this mailbox instance.
-  * @write_index:	Index in internal buffer to write to.
-  * @read_index:	Index in internal buffer to read from.
-  * @allocated:		Indicates whether this particular mailbox
-  *			id has been allocated by someone.
-  */
-struct mbox {
-	struct list_head list;
-	struct platform_device *pdev;
-	mbox_recv_cb_t *cb;
-	void *client_data;
-	void __iomem *virtbase_peer;
-	void __iomem *virtbase_local;
-	u32 buffer[MBOX_BUF_SIZE];
-	char name[MBOX_NAME_SIZE];
-	struct completion buffer_available;
-	u8 client_blocked;
-	spinlock_t lock;
-	u8 write_index;
-	u8 read_index;
-	bool allocated;
-};
-
-/**
-  * mbox_setup - Set up a mailbox and return its instance.
-  * @mbox_id:	The ID number of the mailbox. 0 or 1 for modem CPU,
-  *		2 for modem DSP.
-  * @mbox_cb:	Pointer to the callback function to be called when a new message
-  *		is received.
-  * @priv:	Client user data which will be returned in the callback.
-  *
-  * Returns a mailbox instance to be specified in subsequent calls to mbox_send.
-  */
-struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv);
-
-/**
-  * mbox_send - Send a mailbox message.
-  * @mbox:	Mailbox instance (returned by mbox_setup)
-  * @mbox_msg:	The mailbox message to send.
-  * @block:	Specifies whether this call will block until send is possible,
-  *		or return an error if the mailbox buffer is full.
-  *
-  * Returns 0 on success or a negative error code on error. -ENOMEM indicates
-  * that the internal buffer is full and you have to try again later (or
-  * specify "block" in order to block until send is possible).
-  */
-int mbox_send(struct mbox *mbox, u32 mbox_msg, bool block);
-
-#endif /*INC_STE_MBOX_H*/
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 3dc00ff..4e369f1 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -15,18 +15,12 @@
 #include <linux/init.h>
 
 void __init ux500_map_io(void);
-extern void __init u5500_map_io(void);
 extern void __init u8500_map_io(void);
 
-extern struct device * __init u5500_init_devices(void);
 extern struct device * __init u8500_init_devices(void);
 
 extern void __init ux500_init_irq(void);
 
-extern void __init u5500_sdi_init(struct device *parent);
-
-extern void __init db5500_dma_init(struct device *parent);
-
 extern struct device *ux500_soc_device_init(const char *soc_id);
 
 struct amba_device;
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 6fb3c4b..34775ba 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -50,11 +50,8 @@ static void flush(void)
 
 static inline void arch_decomp_setup(void)
 {
-	/* Check in run time if we run on an U8500 or U5500 */
-	if (machine_is_u5500())
-		ux500_uart_base = U5500_UART0_BASE;
-	else
-		ux500_uart_base = U8500_UART2_BASE;
+	/* Use machine_is_foo() macro if you need to switch base someday */
+	ux500_uart_base = U8500_UART2_BASE;
 }
 
 #define arch_decomp_wdog() /* nothing to do here */
diff --git a/arch/arm/mach-ux500/mbox-db5500.c b/arch/arm/mach-ux500/mbox-db5500.c
deleted file mode 100644
index 2b2d51c..0000000
--- a/arch/arm/mach-ux500/mbox-db5500.c
+++ /dev/null
@@ -1,565 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
- * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-/*
- * Mailbox nomenclature:
- *
- *       APE           MODEM
- *           mbox pairX
- *   ..........................
- *   .                       .
- *   .           peer        .
- *   .     send  ----        .
- *   .      -->  |  |        .
- *   .           |  |        .
- *   .           ----        .
- *   .                       .
- *   .           local       .
- *   .     rec   ----        .
- *   .           |  | <--    .
- *   .           |  |        .
- *   .           ----        .
- *   .........................
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/completion.h>
-#include <mach/mbox-db5500.h>
-
-#define MBOX_NAME "mbox"
-
-#define MBOX_FIFO_DATA        0x000
-#define MBOX_FIFO_ADD         0x004
-#define MBOX_FIFO_REMOVE      0x008
-#define MBOX_FIFO_THRES_FREE  0x00C
-#define MBOX_FIFO_THRES_OCCUP 0x010
-#define MBOX_FIFO_STATUS      0x014
-
-#define MBOX_DISABLE_IRQ 0x4
-#define MBOX_ENABLE_IRQ  0x0
-#define MBOX_LATCH 1
-
-/* Global list of all mailboxes */
-static struct list_head mboxs = LIST_HEAD_INIT(mboxs);
-
-static struct mbox *get_mbox_with_id(u8 id)
-{
-	u8 i;
-	struct list_head *pos = &mboxs;
-	for (i = 0; i <= id; i++)
-		pos = pos->next;
-
-	return (struct mbox *) list_entry(pos, struct mbox, list);
-}
-
-int mbox_send(struct mbox *mbox, u32 mbox_msg, bool block)
-{
-	int res = 0;
-
-	spin_lock(&mbox->lock);
-
-	dev_dbg(&(mbox->pdev->dev),
-		"About to buffer 0x%X to mailbox 0x%X."
-		" ri = %d, wi = %d\n",
-		mbox_msg, (u32)mbox, mbox->read_index,
-		mbox->write_index);
-
-	/* Check if write buffer is full */
-	while (((mbox->write_index + 1) % MBOX_BUF_SIZE) == mbox->read_index) {
-		if (!block) {
-			dev_dbg(&(mbox->pdev->dev),
-			"Buffer full in non-blocking call! "
-			"Returning -ENOMEM!\n");
-			res = -ENOMEM;
-			goto exit;
-		}
-		spin_unlock(&mbox->lock);
-		dev_dbg(&(mbox->pdev->dev),
-			"Buffer full in blocking call! Sleeping...\n");
-		mbox->client_blocked = 1;
-		wait_for_completion(&mbox->buffer_available);
-		dev_dbg(&(mbox->pdev->dev),
-			"Blocking send was woken up! Trying again...\n");
-		spin_lock(&mbox->lock);
-	}
-
-	mbox->buffer[mbox->write_index] = mbox_msg;
-	mbox->write_index = (mbox->write_index + 1) % MBOX_BUF_SIZE;
-
-	/*
-	 * Indicate that we want an IRQ as soon as there is a slot
-	 * in the FIFO
-	 */
-	writel(MBOX_ENABLE_IRQ, mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-
-exit:
-	spin_unlock(&mbox->lock);
-	return res;
-}
-EXPORT_SYMBOL(mbox_send);
-
-#if defined(CONFIG_DEBUG_FS)
-/*
- * Expected input: <value> <nbr sends>
- * Example: "echo 0xdeadbeef 4 > mbox-node" sends 0xdeadbeef 4 times
- */
-static ssize_t mbox_write_fifo(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf,
-			       size_t count)
-{
-	unsigned long mbox_mess;
-	unsigned long nbr_sends;
-	unsigned long i;
-	char int_buf[16];
-	char *token;
-	char *val;
-
-	struct mbox *mbox = (struct mbox *) dev->platform_data;
-
-	strncpy((char *) &int_buf, buf, sizeof(int_buf));
-	token = (char *) &int_buf;
-
-	/* Parse message */
-	val = strsep(&token, " ");
-	if ((val == NULL) || (strict_strtoul(val, 16, &mbox_mess) != 0))
-		mbox_mess = 0xDEADBEEF;
-
-	val = strsep(&token, " ");
-	if ((val == NULL) || (strict_strtoul(val, 10, &nbr_sends) != 0))
-		nbr_sends = 1;
-
-	dev_dbg(dev, "Will write 0x%lX %ld times using data struct at 0x%X\n",
-		mbox_mess, nbr_sends, (u32) mbox);
-
-	for (i = 0; i < nbr_sends; i++)
-		mbox_send(mbox, mbox_mess, true);
-
-	return count;
-}
-
-static ssize_t mbox_read_fifo(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	int mbox_value;
-	struct mbox *mbox = (struct mbox *) dev->platform_data;
-
-	if ((readl(mbox->virtbase_local + MBOX_FIFO_STATUS) & 0x7) <= 0)
-		return sprintf(buf, "Mailbox is empty\n");
-
-	mbox_value = readl(mbox->virtbase_local + MBOX_FIFO_DATA);
-	writel(MBOX_LATCH, (mbox->virtbase_local + MBOX_FIFO_REMOVE));
-
-	return sprintf(buf, "0x%X\n", mbox_value);
-}
-
-static DEVICE_ATTR(fifo, S_IWUGO | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
-
-static int mbox_show(struct seq_file *s, void *data)
-{
-	struct list_head *pos;
-	u8 mbox_index = 0;
-
-	list_for_each(pos, &mboxs) {
-		struct mbox *m =
-			(struct mbox *) list_entry(pos, struct mbox, list);
-		if (m == NULL) {
-			seq_printf(s,
-				   "Unable to retrieve mailbox %d\n",
-				   mbox_index);
-			continue;
-		}
-
-		spin_lock(&m->lock);
-		if ((m->virtbase_peer == NULL) || (m->virtbase_local == NULL)) {
-			seq_printf(s, "MAILBOX %d not setup or corrupt\n",
-				   mbox_index);
-			spin_unlock(&m->lock);
-			continue;
-		}
-
-		seq_printf(s,
-		"===========================\n"
-		" MAILBOX %d\n"
-		" PEER MAILBOX DUMP\n"
-		"---------------------------\n"
-		"FIFO:                 0x%X (%d)\n"
-		"Free     Threshold:   0x%.2X (%d)\n"
-		"Occupied Threshold:   0x%.2X (%d)\n"
-		"Status:               0x%.2X (%d)\n"
-		"   Free spaces  (ot):    %d (%d)\n"
-		"   Occup spaces (ot):    %d (%d)\n"
-		"===========================\n"
-		" LOCAL MAILBOX DUMP\n"
-		"---------------------------\n"
-		"FIFO:                 0x%.X (%d)\n"
-		"Free     Threshold:   0x%.2X (%d)\n"
-		"Occupied Threshold:   0x%.2X (%d)\n"
-		"Status:               0x%.2X (%d)\n"
-		"   Free spaces  (ot):    %d (%d)\n"
-		"   Occup spaces (ot):    %d (%d)\n"
-		"===========================\n"
-		"write_index: %d\n"
-		"read_index : %d\n"
-		"===========================\n"
-		"\n",
-		mbox_index,
-		readl(m->virtbase_peer + MBOX_FIFO_DATA),
-		readl(m->virtbase_peer + MBOX_FIFO_DATA),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_peer + MBOX_FIFO_STATUS),
-		readl(m->virtbase_peer + MBOX_FIFO_STATUS),
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 4) & 0x7,
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 7) & 0x1,
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 0) & 0x7,
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 3) & 0x1,
-		readl(m->virtbase_local + MBOX_FIFO_DATA),
-		readl(m->virtbase_local + MBOX_FIFO_DATA),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_local + MBOX_FIFO_STATUS),
-		readl(m->virtbase_local + MBOX_FIFO_STATUS),
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 4) & 0x7,
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 7) & 0x1,
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 0) & 0x7,
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 3) & 0x1,
-		m->write_index, m->read_index);
-		mbox_index++;
-		spin_unlock(&m->lock);
-	}
-
-	return 0;
-}
-
-static int mbox_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mbox_show, NULL);
-}
-
-static const struct file_operations mbox_operations = {
-	.owner = THIS_MODULE,
-	.open = mbox_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
-
-static irqreturn_t mbox_irq(int irq, void *arg)
-{
-	u32 mbox_value;
-	int nbr_occup;
-	int nbr_free;
-	struct mbox *mbox = (struct mbox *) arg;
-
-	spin_lock(&mbox->lock);
-
-	dev_dbg(&(mbox->pdev->dev),
-		"mbox IRQ [%d] received. ri = %d, wi = %d\n",
-		irq, mbox->read_index, mbox->write_index);
-
-	/*
-	 * Check if we have any outgoing messages, and if there is space for
-	 * them in the FIFO.
-	 */
-	if (mbox->read_index != mbox->write_index) {
-		/*
-		 * Check by reading FREE for LOCAL since that indicates
-		 * OCCUP for PEER
-		 */
-		nbr_free = (readl(mbox->virtbase_local + MBOX_FIFO_STATUS)
-			    >> 4) & 0x7;
-		dev_dbg(&(mbox->pdev->dev),
-			"Status indicates %d empty spaces in the FIFO!\n",
-			nbr_free);
-
-		while ((nbr_free > 0) &&
-		       (mbox->read_index != mbox->write_index)) {
-			/* Write the message and latch it into the FIFO */
-			writel(mbox->buffer[mbox->read_index],
-			       (mbox->virtbase_peer + MBOX_FIFO_DATA));
-			writel(MBOX_LATCH,
-			       (mbox->virtbase_peer + MBOX_FIFO_ADD));
-			dev_dbg(&(mbox->pdev->dev),
-				"Wrote message 0x%X to addr 0x%X\n",
-				mbox->buffer[mbox->read_index],
-				(u32) (mbox->virtbase_peer + MBOX_FIFO_DATA));
-
-			nbr_free--;
-			mbox->read_index =
-				(mbox->read_index + 1) % MBOX_BUF_SIZE;
-		}
-
-		/*
-		 * Check if we still want IRQ:s when there is free
-		 * space to send
-		 */
-		if (mbox->read_index != mbox->write_index) {
-			dev_dbg(&(mbox->pdev->dev),
-				"Still have messages to send, but FIFO full. "
-				"Request IRQ again!\n");
-			writel(MBOX_ENABLE_IRQ,
-			       mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-		} else {
-			dev_dbg(&(mbox->pdev->dev),
-				"No more messages to send. "
-				"Do not request IRQ again!\n");
-			writel(MBOX_DISABLE_IRQ,
-			       mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-		}
-
-		/*
-		 * Check if we can signal any blocked clients that it is OK to
-		 * start buffering again
-		 */
-		if (mbox->client_blocked &&
-		    (((mbox->write_index + 1) % MBOX_BUF_SIZE)
-		     != mbox->read_index)) {
-			dev_dbg(&(mbox->pdev->dev),
-				"Waking up blocked client\n");
-			complete(&mbox->buffer_available);
-			mbox->client_blocked = 0;
-		}
-	}
-
-	/* Check if we have any incoming messages */
-	nbr_occup = readl(mbox->virtbase_local + MBOX_FIFO_STATUS) & 0x7;
-	if (nbr_occup == 0)
-		goto exit;
-
-	if (mbox->cb == NULL) {
-		dev_dbg(&(mbox->pdev->dev), "No receive callback registered, "
-			"leaving %d incoming messages in fifo!\n", nbr_occup);
-		goto exit;
-	}
-
-	/* Read and acknowledge the message */
-	mbox_value = readl(mbox->virtbase_local + MBOX_FIFO_DATA);
-	writel(MBOX_LATCH, (mbox->virtbase_local + MBOX_FIFO_REMOVE));
-
-	/* Notify consumer of new mailbox message */
-	dev_dbg(&(mbox->pdev->dev), "Calling callback for message 0x%X!\n",
-		mbox_value);
-	mbox->cb(mbox_value, mbox->client_data);
-
-exit:
-	dev_dbg(&(mbox->pdev->dev), "Exit mbox IRQ. ri = %d, wi = %d\n",
-		mbox->read_index, mbox->write_index);
-	spin_unlock(&mbox->lock);
-
-	return IRQ_HANDLED;
-}
-
-/* Setup is executed once for each mbox pair */
-struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv)
-{
-	struct resource *resource;
-	int irq;
-	int res;
-	struct mbox *mbox;
-
-	mbox = get_mbox_with_id(mbox_id);
-	if (mbox == NULL) {
-		dev_err(&(mbox->pdev->dev), "Incorrect mailbox id: %d!\n",
-			mbox_id);
-		goto exit;
-	}
-
-	/*
-	 * Check if mailbox has been allocated to someone else,
-	 * otherwise allocate it
-	 */
-	if (mbox->allocated) {
-		dev_err(&(mbox->pdev->dev), "Mailbox number %d is busy!\n",
-			mbox_id);
-		mbox = NULL;
-		goto exit;
-	}
-	mbox->allocated = true;
-
-	dev_dbg(&(mbox->pdev->dev), "Initiating mailbox number %d: 0x%X...\n",
-		mbox_id, (u32)mbox);
-
-	mbox->client_data = priv;
-	mbox->cb = mbox_cb;
-
-	/* Get addr for peer mailbox and ioremap it */
-	resource = platform_get_resource_byname(mbox->pdev,
-						IORESOURCE_MEM,
-						"mbox_peer");
-	if (resource == NULL) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to retrieve mbox peer resource\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"Resource name: %s start: 0x%X, end: 0x%X\n",
-		resource->name, resource->start, resource->end);
-	mbox->virtbase_peer = ioremap(resource->start, resource_size(resource));
-	if (!mbox->virtbase_peer) {
-		dev_err(&(mbox->pdev->dev), "Unable to ioremap peer mbox\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"ioremapped peer physical: (0x%X-0x%X) to virtual: 0x%X\n",
-		resource->start, resource->end, (u32) mbox->virtbase_peer);
-
-	/* Get addr for local mailbox and ioremap it */
-	resource = platform_get_resource_byname(mbox->pdev,
-						IORESOURCE_MEM,
-						"mbox_local");
-	if (resource == NULL) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to retrieve mbox local resource\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"Resource name: %s start: 0x%X, end: 0x%X\n",
-		resource->name, resource->start, resource->end);
-	mbox->virtbase_local = ioremap(resource->start, resource_size(resource));
-	if (!mbox->virtbase_local) {
-		dev_err(&(mbox->pdev->dev), "Unable to ioremap local mbox\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"ioremapped local physical: (0x%X-0x%X) to virtual: 0x%X\n",
-		resource->start, resource->end, (u32) mbox->virtbase_peer);
-
-	init_completion(&mbox->buffer_available);
-	mbox->client_blocked = 0;
-
-	/* Get IRQ for mailbox and allocate it */
-	irq = platform_get_irq_byname(mbox->pdev, "mbox_irq");
-	if (irq < 0) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to retrieve mbox irq resource\n");
-		mbox = NULL;
-		goto exit;
-	}
-
-	dev_dbg(&(mbox->pdev->dev), "Allocating irq %d...\n", irq);
-	res = request_irq(irq, mbox_irq, 0, mbox->name, (void *) mbox);
-	if (res < 0) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to allocate mbox irq %d\n", irq);
-		mbox = NULL;
-		goto exit;
-	}
-
-	/* Set up mailbox to not launch IRQ on free space in mailbox */
-	writel(MBOX_DISABLE_IRQ, mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-
-	/*
-	 * Set up mailbox to launch IRQ on new message if we have
-	 * a callback set. If not, do not raise IRQ, but keep message
-	 * in FIFO for manual retrieval
-	 */
-	if (mbox_cb != NULL)
-		writel(MBOX_ENABLE_IRQ,
-		       mbox->virtbase_local + MBOX_FIFO_THRES_OCCUP);
-	else
-		writel(MBOX_DISABLE_IRQ,
-		       mbox->virtbase_local + MBOX_FIFO_THRES_OCCUP);
-
-#if defined(CONFIG_DEBUG_FS)
-	res = device_create_file(&(mbox->pdev->dev), &dev_attr_fifo);
-	if (res != 0)
-		dev_warn(&(mbox->pdev->dev),
-			 "Unable to create mbox sysfs entry");
-
-	(void) debugfs_create_file("mbox", S_IFREG | S_IRUGO, NULL,
-				   NULL, &mbox_operations);
-#endif
-
-	dev_info(&(mbox->pdev->dev),
-		 "Mailbox driver with index %d initiated!\n", mbox_id);
-
-exit:
-	return mbox;
-}
-EXPORT_SYMBOL(mbox_setup);
-
-
-int __init mbox_probe(struct platform_device *pdev)
-{
-	struct mbox local_mbox;
-	struct mbox *mbox;
-	int res = 0;
-	dev_dbg(&(pdev->dev), "Probing mailbox (pdev = 0x%X)...\n", (u32) pdev);
-
-	memset(&local_mbox, 0x0, sizeof(struct mbox));
-
-	/* Associate our mbox data with the platform device */
-	res = platform_device_add_data(pdev,
-				       (void *) &local_mbox,
-				       sizeof(struct mbox));
-	if (res != 0) {
-		dev_err(&(pdev->dev),
-			"Unable to allocate driver platform data!\n");
-		goto exit;
-	}
-
-	mbox = (struct mbox *) pdev->dev.platform_data;
-	mbox->pdev = pdev;
-	mbox->write_index = 0;
-	mbox->read_index = 0;
-
-	INIT_LIST_HEAD(&(mbox->list));
-	list_add_tail(&(mbox->list), &mboxs);
-
-	sprintf(mbox->name, "%s", MBOX_NAME);
-	spin_lock_init(&mbox->lock);
-
-	dev_info(&(pdev->dev), "Mailbox driver loaded\n");
-
-exit:
-	return res;
-}
-
-static struct platform_driver mbox_driver = {
-	.driver = {
-		.name = MBOX_NAME,
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init mbox_init(void)
-{
-	return platform_driver_probe(&mbox_driver, mbox_probe);
-}
-
-module_init(mbox_init);
-
-void __exit mbox_exit(void)
-{
-	platform_driver_unregister(&mbox_driver);
-}
-
-module_exit(mbox_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MBOX driver");
diff --git a/arch/arm/mach-ux500/modem-irq-db5500.c b/arch/arm/mach-ux500/modem-irq-db5500.c
deleted file mode 100644
index 6b86416..0000000
--- a/arch/arm/mach-ux500/modem-irq-db5500.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
- * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#include <mach/id.h>
-
-#define MODEM_INTCON_BASE_ADDR 0xBFFD3000
-#define MODEM_INTCON_SIZE 0xFFF
-
-#define DEST_IRQ41_OFFSET 0x2A4
-#define DEST_IRQ43_OFFSET 0x2AC
-#define DEST_IRQ45_OFFSET 0x2B4
-
-#define PRIO_IRQ41_OFFSET 0x6A4
-#define PRIO_IRQ43_OFFSET 0x6AC
-#define PRIO_IRQ45_OFFSET 0x6B4
-
-#define ALLOW_IRQ_OFFSET 0x104
-
-#define MODEM_INTCON_CPU_NBR 0x1
-#define MODEM_INTCON_PRIO_HIGH 0x0
-
-#define MODEM_INTCON_ALLOW_IRQ41 0x0200
-#define MODEM_INTCON_ALLOW_IRQ43 0x0800
-#define MODEM_INTCON_ALLOW_IRQ45 0x2000
-
-#define MODEM_IRQ_REG_OFFSET 0x4
-
-struct modem_irq {
-	void __iomem *modem_intcon_base;
-};
-
-
-static void setup_modem_intcon(void __iomem *modem_intcon_base)
-{
-	/* IC_DESTINATION_BASE_ARRAY - Which CPU to receive the IRQ */
-	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ41_OFFSET);
-	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ43_OFFSET);
-	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ45_OFFSET);
-
-	/* IC_PRIORITY_BASE_ARRAY - IRQ priority in modem IRQ controller */
-	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ41_OFFSET);
-	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ43_OFFSET);
-	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ45_OFFSET);
-
-	/* IC_ALLOW_ARRAY - IRQ enable */
-	writel(MODEM_INTCON_ALLOW_IRQ41 |
-		   MODEM_INTCON_ALLOW_IRQ43 |
-		   MODEM_INTCON_ALLOW_IRQ45,
-		   modem_intcon_base + ALLOW_IRQ_OFFSET);
-}
-
-static irqreturn_t modem_cpu_irq_handler(int irq, void *data)
-{
-	int real_irq;
-	int virt_irq;
-	struct modem_irq *mi = (struct modem_irq *)data;
-
-	/* Read modem side IRQ number from modem IRQ controller */
-	real_irq = readl(mi->modem_intcon_base + MODEM_IRQ_REG_OFFSET) & 0xFF;
-	virt_irq = IRQ_MODEM_EVENTS_BASE + real_irq;
-
-	pr_debug("modem_irq: Worker read addr 0x%X and got value 0x%X "
-		 "which will be 0x%X (%d) which translates to "
-		 "virtual IRQ 0x%X (%d)!\n",
-		   (u32)mi->modem_intcon_base + MODEM_IRQ_REG_OFFSET,
-		   real_irq,
-		   real_irq & 0xFF,
-		   real_irq & 0xFF,
-		   virt_irq,
-		   virt_irq);
-
-	if (virt_irq != 0)
-		generic_handle_irq(virt_irq);
-
-	pr_debug("modem_irq: Done handling virtual IRQ %d!\n", virt_irq);
-
-	return IRQ_HANDLED;
-}
-
-static void create_virtual_irq(int irq, struct irq_chip *modem_irq_chip)
-{
-	irq_set_chip_and_handler(irq, modem_irq_chip, handle_simple_irq);
-	set_irq_flags(irq, IRQF_VALID);
-
-	pr_debug("modem_irq: Created virtual IRQ %d\n", irq);
-}
-
-static int modem_irq_init(void)
-{
-	int err;
-	static struct irq_chip  modem_irq_chip;
-	struct modem_irq *mi;
-
-	if (!cpu_is_u5500())
-		return -ENODEV;
-
-	pr_info("modem_irq: Set up IRQ handler for incoming modem IRQ %d\n",
-		   IRQ_DB5500_MODEM);
-
-	mi = kmalloc(sizeof(struct modem_irq), GFP_KERNEL);
-	if (!mi) {
-		pr_err("modem_irq: Could not allocate device\n");
-		return -ENOMEM;
-	}
-
-	mi->modem_intcon_base =
-		ioremap(MODEM_INTCON_BASE_ADDR, MODEM_INTCON_SIZE);
-	pr_debug("modem_irq: ioremapped modem_intcon_base from "
-		 "phy 0x%x to virt 0x%x\n", MODEM_INTCON_BASE_ADDR,
-		 (u32)mi->modem_intcon_base);
-
-	setup_modem_intcon(mi->modem_intcon_base);
-
-	modem_irq_chip = dummy_irq_chip;
-	modem_irq_chip.name = "modem_irq";
-
-	/* Create the virtual IRQ:s needed */
-	create_virtual_irq(MBOX_PAIR0_VIRT_IRQ, &modem_irq_chip);
-	create_virtual_irq(MBOX_PAIR1_VIRT_IRQ, &modem_irq_chip);
-	create_virtual_irq(MBOX_PAIR2_VIRT_IRQ, &modem_irq_chip);
-
-	err = request_threaded_irq(IRQ_DB5500_MODEM, NULL,
-				   modem_cpu_irq_handler, IRQF_ONESHOT,
-				   "modem_irq", mi);
-	if (err)
-		pr_err("modem_irq: Could not register IRQ %d\n",
-		       IRQ_DB5500_MODEM);
-
-	return 0;
-}
-
-arch_initcall(modem_irq_init);
diff --git a/arch/arm/mach-ux500/pins-db5500.h b/arch/arm/mach-ux500/pins-db5500.h
deleted file mode 100644
index bf50c21..0000000
--- a/arch/arm/mach-ux500/pins-db5500.h
+++ /dev/null
@@ -1,620 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License, version 2
- * Author: Rabin Vincent <rabin.vincent@stericsson.com>
- */
-
-#ifndef __MACH_DB5500_PINS_H
-#define __MACH_DB5500_PINS_H
-
-#define GPIO0_GPIO		PIN_CFG(0, GPIO)
-#define GPIO0_SM_CS3n		PIN_CFG(0, ALT_A)
-
-#define GPIO1_GPIO		PIN_CFG(1, GPIO)
-#define GPIO1_SM_A3		PIN_CFG(1, ALT_A)
-
-#define GPIO2_GPIO		PIN_CFG(2, GPIO)
-#define GPIO2_SM_A4		PIN_CFG(2, ALT_A)
-#define GPIO2_SM_AVD		PIN_CFG(2, ALT_B)
-
-#define GPIO3_GPIO		PIN_CFG(3, GPIO)
-#define GPIO3_I2C1_SCL		PIN_CFG(3, ALT_A)
-
-#define GPIO4_GPIO		PIN_CFG(4, GPIO)
-#define GPIO4_I2C1_SDA		PIN_CFG(4, ALT_A)
-
-#define GPIO5_GPIO		PIN_CFG(5, GPIO)
-#define GPIO5_MC0_DAT0		PIN_CFG(5, ALT_A)
-#define GPIO5_SM_ADQ8		PIN_CFG(5, ALT_B)
-
-#define GPIO6_GPIO		PIN_CFG(6, GPIO)
-#define GPIO6_MC0_DAT1		PIN_CFG(6, ALT_A)
-#define GPIO6_SM_ADQ0		PIN_CFG(6, ALT_B)
-
-#define GPIO7_GPIO		PIN_CFG(7, GPIO)
-#define GPIO7_MC0_DAT2		PIN_CFG(7, ALT_A)
-#define GPIO7_SM_ADQ9		PIN_CFG(7, ALT_B)
-
-#define GPIO8_GPIO		PIN_CFG(8, GPIO)
-#define GPIO8_MC0_DAT3		PIN_CFG(8, ALT_A)
-#define GPIO8_SM_ADQ1		PIN_CFG(8, ALT_B)
-
-#define GPIO9_GPIO		PIN_CFG(9, GPIO)
-#define GPIO9_MC0_DAT4		PIN_CFG(9, ALT_A)
-#define GPIO9_SM_ADQ10		PIN_CFG(9, ALT_B)
-
-#define GPIO10_GPIO		PIN_CFG(10, GPIO)
-#define GPIO10_MC0_DAT5		PIN_CFG(10, ALT_A)
-#define GPIO10_SM_ADQ2		PIN_CFG(10, ALT_B)
-
-#define GPIO11_GPIO		PIN_CFG(11, GPIO)
-#define GPIO11_MC0_DAT6		PIN_CFG(11, ALT_A)
-#define GPIO11_SM_ADQ11		PIN_CFG(11, ALT_B)
-
-#define GPIO12_GPIO		PIN_CFG(12, GPIO)
-#define GPIO12_MC0_DAT7		PIN_CFG(12, ALT_A)
-#define GPIO12_SM_ADQ3		PIN_CFG(12, ALT_B)
-
-#define GPIO13_GPIO		PIN_CFG(13, GPIO)
-#define GPIO13_MC0_CMD		PIN_CFG(13, ALT_A)
-#define GPIO13_SM_BUSY0n	PIN_CFG(13, ALT_B)
-#define GPIO13_SM_WAIT0n	PIN_CFG(13, ALT_C)
-
-#define GPIO14_GPIO		PIN_CFG(14, GPIO)
-#define GPIO14_MC0_CLK		PIN_CFG(14, ALT_A)
-#define GPIO14_SM_CS1n		PIN_CFG(14, ALT_B)
-#define GPIO14_SM_CKO		PIN_CFG(14, ALT_C)
-
-#define GPIO15_GPIO		PIN_CFG(15, GPIO)
-#define GPIO15_SM_A5		PIN_CFG(15, ALT_A)
-#define GPIO15_SM_CLE		PIN_CFG(15, ALT_B)
-
-#define GPIO16_GPIO		PIN_CFG(16, GPIO)
-#define GPIO16_MC2_CMD		PIN_CFG(16, ALT_A)
-#define GPIO16_SM_OEn		PIN_CFG(16, ALT_B)
-
-#define GPIO17_GPIO		PIN_CFG(17, GPIO)
-#define GPIO17_MC2_CLK		PIN_CFG(17, ALT_A)
-#define GPIO17_SM_WEn		PIN_CFG(17, ALT_B)
-
-#define GPIO18_GPIO		PIN_CFG(18, GPIO)
-#define GPIO18_SM_A6		PIN_CFG(18, ALT_A)
-#define GPIO18_SM_ALE		PIN_CFG(18, ALT_B)
-#define GPIO18_SM_AVDn		PIN_CFG(18, ALT_C)
-
-#define GPIO19_GPIO		PIN_CFG(19, GPIO)
-#define GPIO19_MC2_DAT1		PIN_CFG(19, ALT_A)
-#define GPIO19_SM_ADQ4		PIN_CFG(19, ALT_B)
-
-#define GPIO20_GPIO		PIN_CFG(20, GPIO)
-#define GPIO20_MC2_DAT3		PIN_CFG(20, ALT_A)
-#define GPIO20_SM_ADQ5		PIN_CFG(20, ALT_B)
-
-#define GPIO21_GPIO		PIN_CFG(21, GPIO)
-#define GPIO21_MC2_DAT5		PIN_CFG(21, ALT_A)
-#define GPIO21_SM_ADQ6		PIN_CFG(21, ALT_B)
-
-#define GPIO22_GPIO		PIN_CFG(22, GPIO)
-#define GPIO22_MC2_DAT7		PIN_CFG(22, ALT_A)
-#define GPIO22_SM_ADQ7		PIN_CFG(22, ALT_B)
-
-#define GPIO23_GPIO		PIN_CFG(23, GPIO)
-#define GPIO23_MC2_DAT0		PIN_CFG(23, ALT_A)
-#define GPIO23_SM_ADQ12		PIN_CFG(23, ALT_B)
-#define GPIO23_MC0_DAT1		PIN_CFG(23, ALT_C)
-
-#define GPIO24_GPIO		PIN_CFG(24, GPIO)
-#define GPIO24_MC2_DAT2		PIN_CFG(24, ALT_A)
-#define GPIO24_SM_ADQ13		PIN_CFG(24, ALT_B)
-#define GPIO24_MC0_DAT3		PIN_CFG(24, ALT_C)
-
-#define GPIO25_GPIO		PIN_CFG(25, GPIO)
-#define GPIO25_MC2_DAT4		PIN_CFG(25, ALT_A)
-#define GPIO25_SM_ADQ14		PIN_CFG(25, ALT_B)
-#define GPIO25_MC0_CMD		PIN_CFG(25, ALT_C)
-
-#define GPIO26_GPIO		PIN_CFG(26, GPIO)
-#define GPIO26_MC2_DAT6		PIN_CFG(26, ALT_A)
-#define GPIO26_SM_ADQ15		PIN_CFG(26, ALT_B)
-
-#define GPIO27_GPIO		PIN_CFG(27, GPIO)
-#define GPIO27_SM_CS0n		PIN_CFG(27, ALT_A)
-#define GPIO27_SM_PS0n		PIN_CFG(27, ALT_B)
-
-#define GPIO28_GPIO		PIN_CFG(28, GPIO)
-#define GPIO28_U0_TXD		PIN_CFG(28, ALT_A)
-#define GPIO28_SM_A0		PIN_CFG(28, ALT_B)
-
-#define GPIO29_GPIO		PIN_CFG(29, GPIO)
-#define GPIO29_U0_RXD		PIN_CFG(29, ALT_A)
-#define GPIO29_SM_A1		PIN_CFG(29, ALT_B)
-#define GPIO29_PWM_0		PIN_CFG(29, ALT_C)
-
-#define GPIO30_GPIO		PIN_CFG(30, GPIO)
-#define GPIO30_MC0_DAT5		PIN_CFG(30, ALT_A)
-#define GPIO30_SM_A2		PIN_CFG(30, ALT_B)
-#define GPIO30_PWM_1		PIN_CFG(30, ALT_C)
-
-#define GPIO31_GPIO		PIN_CFG(31, GPIO)
-#define GPIO31_MC0_DAT7		PIN_CFG(31, ALT_A)
-#define GPIO31_SM_CS2n		PIN_CFG(31, ALT_B)
-#define GPIO31_PWM_2		PIN_CFG(31, ALT_C)
-
-#define GPIO32_GPIO		PIN_CFG(32, GPIO)
-#define GPIO32_MSP0_TCK		PIN_CFG(32, ALT_A)
-#define GPIO32_ACCI2S0_SCK	PIN_CFG(32, ALT_B)
-
-#define GPIO33_GPIO		PIN_CFG(33, GPIO)
-#define GPIO33_MSP0_TFS		PIN_CFG(33, ALT_A)
-#define GPIO33_ACCI2S0_WS	PIN_CFG(33, ALT_B)
-
-#define GPIO34_GPIO		PIN_CFG(34, GPIO)
-#define GPIO34_MSP0_TXD		PIN_CFG(34, ALT_A)
-#define GPIO34_ACCI2S0_DLD	PIN_CFG(34, ALT_B)
-
-#define GPIO35_GPIO		PIN_CFG(35, GPIO)
-#define GPIO35_MSP0_RXD		PIN_CFG(35, ALT_A)
-#define GPIO35_ACCI2S0_ULD	PIN_CFG(35, ALT_B)
-
-#define GPIO64_GPIO		PIN_CFG(64, GPIO)
-#define GPIO64_USB_DAT0		PIN_CFG(64, ALT_A)
-#define GPIO64_U0_TXD		PIN_CFG(64, ALT_B)
-
-#define GPIO65_GPIO		PIN_CFG(65, GPIO)
-#define GPIO65_USB_DAT1		PIN_CFG(65, ALT_A)
-#define GPIO65_U0_RXD		PIN_CFG(65, ALT_B)
-
-#define GPIO66_GPIO		PIN_CFG(66, GPIO)
-#define GPIO66_USB_DAT2		PIN_CFG(66, ALT_A)
-
-#define GPIO67_GPIO		PIN_CFG(67, GPIO)
-#define GPIO67_USB_DAT3		PIN_CFG(67, ALT_A)
-
-#define GPIO68_GPIO		PIN_CFG(68, GPIO)
-#define GPIO68_USB_DAT4		PIN_CFG(68, ALT_A)
-
-#define GPIO69_GPIO		PIN_CFG(69, GPIO)
-#define GPIO69_USB_DAT5		PIN_CFG(69, ALT_A)
-
-#define GPIO70_GPIO		PIN_CFG(70, GPIO)
-#define GPIO70_USB_DAT6		PIN_CFG(70, ALT_A)
-
-#define GPIO71_GPIO		PIN_CFG(71, GPIO)
-#define GPIO71_USB_DAT7		PIN_CFG(71, ALT_A)
-
-#define GPIO72_GPIO		PIN_CFG(72, GPIO)
-#define GPIO72_USB_STP		PIN_CFG(72, ALT_A)
-
-#define GPIO73_GPIO		PIN_CFG(73, GPIO)
-#define GPIO73_USB_DIR		PIN_CFG(73, ALT_A)
-
-#define GPIO74_GPIO		PIN_CFG(74, GPIO)
-#define GPIO74_USB_NXT		PIN_CFG(74, ALT_A)
-
-#define GPIO75_GPIO		PIN_CFG(75, GPIO)
-#define GPIO75_USB_XCLK		PIN_CFG(75, ALT_A)
-
-#define GPIO76_GPIO		PIN_CFG(76, GPIO)
-
-#define GPIO77_GPIO		PIN_CFG(77, GPIO)
-#define GPIO77_ACCTX_ON		PIN_CFG(77, ALT_A)
-
-#define GPIO78_GPIO		PIN_CFG(78, GPIO)
-#define GPIO78_IRQn		PIN_CFG(78, ALT_A)
-
-#define GPIO79_GPIO		PIN_CFG(79, GPIO)
-#define GPIO79_ACCSIM_Clk	PIN_CFG(79, ALT_A)
-
-#define GPIO80_GPIO		PIN_CFG(80, GPIO)
-#define GPIO80_ACCSIM_Da	PIN_CFG(80, ALT_A)
-
-#define GPIO81_GPIO		PIN_CFG(81, GPIO)
-#define GPIO81_ACCSIM_Reset	PIN_CFG(81, ALT_A)
-
-#define GPIO82_GPIO		PIN_CFG(82, GPIO)
-#define GPIO82_ACCSIM_DDir	PIN_CFG(82, ALT_A)
-
-#define GPIO96_GPIO		PIN_CFG(96, GPIO)
-#define GPIO96_MSP1_TCK		PIN_CFG(96, ALT_A)
-#define GPIO96_PRCMU_DEBUG3	PIN_CFG(96, ALT_B)
-#define GPIO96_PRCMU_DEBUG7	PIN_CFG(96, ALT_C)
-
-#define GPIO97_GPIO		PIN_CFG(97, GPIO)
-#define GPIO97_MSP1_TFS		PIN_CFG(97, ALT_A)
-#define GPIO97_PRCMU_DEBUG2	PIN_CFG(97, ALT_B)
-#define GPIO97_PRCMU_DEBUG6	PIN_CFG(97, ALT_C)
-
-#define GPIO98_GPIO		PIN_CFG(98, GPIO)
-#define GPIO98_MSP1_TXD		PIN_CFG(98, ALT_A)
-#define GPIO98_PRCMU_DEBUG1	PIN_CFG(98, ALT_B)
-#define GPIO98_PRCMU_DEBUG5	PIN_CFG(98, ALT_C)
-
-#define GPIO99_GPIO		PIN_CFG(99, GPIO)
-#define GPIO99_MSP1_RXD		PIN_CFG(99, ALT_A)
-#define GPIO99_PRCMU_DEBUG0	PIN_CFG(99, ALT_B)
-#define GPIO99_PRCMU_DEBUG4	PIN_CFG(99, ALT_C)
-
-#define GPIO100_GPIO		PIN_CFG(100, GPIO)
-#define GPIO100_I2C0_SCL	PIN_CFG(100, ALT_A)
-
-#define GPIO101_GPIO		PIN_CFG(101, GPIO)
-#define GPIO101_I2C0_SDA	PIN_CFG(101, ALT_A)
-
-#define GPIO128_GPIO		PIN_CFG(128, GPIO)
-#define GPIO128_KP_I0		PIN_CFG(128, ALT_A)
-#define GPIO128_BUSMON_D0	PIN_CFG(128, ALT_B)
-
-#define GPIO129_GPIO		PIN_CFG(129, GPIO)
-#define GPIO129_KP_O0		PIN_CFG(129, ALT_A)
-#define GPIO129_BUSMON_D1	PIN_CFG(129, ALT_B)
-
-#define GPIO130_GPIO		PIN_CFG(130, GPIO)
-#define GPIO130_KP_I1		PIN_CFG(130, ALT_A)
-#define GPIO130_BUSMON_D2	PIN_CFG(130, ALT_B)
-
-#define GPIO131_GPIO		PIN_CFG(131, GPIO)
-#define GPIO131_KP_O1		PIN_CFG(131, ALT_A)
-#define GPIO131_BUSMON_D3	PIN_CFG(131, ALT_B)
-
-#define GPIO132_GPIO		PIN_CFG(132, GPIO)
-#define GPIO132_KP_I2		PIN_CFG(132, ALT_A)
-#define GPIO132_ETM_D15		PIN_CFG(132, ALT_B)
-#define GPIO132_STMAPE_CLK	PIN_CFG(132, ALT_C)
-
-#define GPIO133_GPIO		PIN_CFG(133, GPIO)
-#define GPIO133_KP_O2		PIN_CFG(133, ALT_A)
-#define GPIO133_ETM_D14		PIN_CFG(133, ALT_B)
-#define GPIO133_U0_RXD		PIN_CFG(133, ALT_C)
-
-#define GPIO134_GPIO		PIN_CFG(134, GPIO)
-#define GPIO134_KP_I3		PIN_CFG(134, ALT_A)
-#define GPIO134_ETM_D13		PIN_CFG(134, ALT_B)
-#define GPIO134_STMAPE_DAT0	PIN_CFG(134, ALT_C)
-
-#define GPIO135_GPIO		PIN_CFG(135, GPIO)
-#define GPIO135_KP_O3		PIN_CFG(135, ALT_A)
-#define GPIO135_ETM_D12		PIN_CFG(135, ALT_B)
-#define GPIO135_STMAPE_DAT1	PIN_CFG(135, ALT_C)
-
-#define GPIO136_GPIO		PIN_CFG(136, GPIO)
-#define GPIO136_KP_I4		PIN_CFG(136, ALT_A)
-#define GPIO136_ETM_D11		PIN_CFG(136, ALT_B)
-#define GPIO136_STMAPE_DAT2	PIN_CFG(136, ALT_C)
-
-#define GPIO137_GPIO		PIN_CFG(137, GPIO)
-#define GPIO137_KP_O4		PIN_CFG(137, ALT_A)
-#define GPIO137_ETM_D10		PIN_CFG(137, ALT_B)
-#define GPIO137_STMAPE_DAT3	PIN_CFG(137, ALT_C)
-
-#define GPIO138_GPIO		PIN_CFG(138, GPIO)
-#define GPIO138_KP_I5		PIN_CFG(138, ALT_A)
-#define GPIO138_ETM_D9		PIN_CFG(138, ALT_B)
-#define GPIO138_U0_TXD		PIN_CFG(138, ALT_C)
-
-#define GPIO139_GPIO		PIN_CFG(139, GPIO)
-#define GPIO139_KP_O5		PIN_CFG(139, ALT_A)
-#define GPIO139_ETM_D8		PIN_CFG(139, ALT_B)
-#define GPIO139_BUSMON_D11	PIN_CFG(139, ALT_C)
-
-#define GPIO140_GPIO		PIN_CFG(140, GPIO)
-#define GPIO140_KP_I6		PIN_CFG(140, ALT_A)
-#define GPIO140_ETM_D7		PIN_CFG(140, ALT_B)
-#define GPIO140_STMAPE_CLK	PIN_CFG(140, ALT_C)
-
-#define GPIO141_GPIO		PIN_CFG(141, GPIO)
-#define GPIO141_KP_O6		PIN_CFG(141, ALT_A)
-#define GPIO141_ETM_D6		PIN_CFG(141, ALT_B)
-#define GPIO141_U0_RXD		PIN_CFG(141, ALT_C)
-
-#define GPIO142_GPIO		PIN_CFG(142, GPIO)
-#define GPIO142_KP_I7		PIN_CFG(142, ALT_A)
-#define GPIO142_ETM_D5		PIN_CFG(142, ALT_B)
-#define GPIO142_STMAPE_DAT0	PIN_CFG(142, ALT_C)
-
-#define GPIO143_GPIO		PIN_CFG(143, GPIO)
-#define GPIO143_KP_O7		PIN_CFG(143, ALT_A)
-#define GPIO143_ETM_D4		PIN_CFG(143, ALT_B)
-#define GPIO143_STMAPE_DAT1	PIN_CFG(143, ALT_C)
-
-#define GPIO144_GPIO		PIN_CFG(144, GPIO)
-#define GPIO144_I2C3_SCL	PIN_CFG(144, ALT_A)
-#define GPIO144_ETM_D3		PIN_CFG(144, ALT_B)
-#define GPIO144_STMAPE_DAT2	PIN_CFG(144, ALT_C)
-
-#define GPIO145_GPIO		PIN_CFG(145, GPIO)
-#define GPIO145_I2C3_SDA	PIN_CFG(145, ALT_A)
-#define GPIO145_ETM_D2		PIN_CFG(145, ALT_B)
-#define GPIO145_STMAPE_DAT3	PIN_CFG(145, ALT_C)
-
-#define GPIO146_GPIO		PIN_CFG(146, GPIO)
-#define GPIO146_PWM_0		PIN_CFG(146, ALT_A)
-#define GPIO146_ETM_D1		PIN_CFG(146, ALT_B)
-
-#define GPIO147_GPIO		PIN_CFG(147, GPIO)
-#define GPIO147_PWM_1		PIN_CFG(147, ALT_A)
-#define GPIO147_ETM_D0		PIN_CFG(147, ALT_B)
-
-#define GPIO148_GPIO		PIN_CFG(148, GPIO)
-#define GPIO148_PWM_2		PIN_CFG(148, ALT_A)
-#define GPIO148_ETM_CLK		PIN_CFG(148, ALT_B)
-
-#define GPIO160_GPIO		PIN_CFG(160, GPIO)
-#define GPIO160_CLKOUT_REQn	PIN_CFG(160, ALT_A)
-
-#define GPIO161_GPIO		PIN_CFG(161, GPIO)
-#define GPIO161_CLKOUT_0	PIN_CFG(161, ALT_A)
-
-#define GPIO162_GPIO		PIN_CFG(162, GPIO)
-#define GPIO162_CLKOUT_1	PIN_CFG(162, ALT_A)
-
-#define GPIO163_GPIO		PIN_CFG(163, GPIO)
-
-#define GPIO164_GPIO		PIN_CFG(164, GPIO)
-#define GPIO164_GPS_START	PIN_CFG(164, ALT_A)
-
-#define GPIO165_GPIO		PIN_CFG(165, GPIO)
-#define GPIO165_SPI1_CS2n	PIN_CFG(165, ALT_A)
-#define GPIO165_U3_RXD		PIN_CFG(165, ALT_B)
-#define GPIO165_BUSMON_D20	PIN_CFG(165, ALT_C)
-
-#define GPIO166_GPIO		PIN_CFG(166, GPIO)
-#define GPIO166_SPI1_CS1n	PIN_CFG(166, ALT_A)
-#define GPIO166_U3_TXD		PIN_CFG(166, ALT_B)
-#define GPIO166_BUSMON_D21	PIN_CFG(166, ALT_C)
-
-#define GPIO167_GPIO		PIN_CFG(167, GPIO)
-#define GPIO167_SPI1_CS0n	PIN_CFG(167, ALT_A)
-#define GPIO167_U3_RTSn		PIN_CFG(167, ALT_B)
-#define GPIO167_BUSMON_D22	PIN_CFG(167, ALT_C)
-
-#define GPIO168_GPIO		PIN_CFG(168, GPIO)
-#define GPIO168_SPI1_RXD	PIN_CFG(168, ALT_A)
-#define GPIO168_U3_CTSn		PIN_CFG(168, ALT_B)
-#define GPIO168_BUSMON_D23	PIN_CFG(168, ALT_C)
-
-#define GPIO169_GPIO		PIN_CFG(169, GPIO)
-#define GPIO169_SPI1_TXD	PIN_CFG(169, ALT_A)
-#define GPIO169_DDR_RC		PIN_CFG(169, ALT_B)
-#define GPIO169_BUSMON_D24	PIN_CFG(169, ALT_C)
-
-#define GPIO170_GPIO		PIN_CFG(170, GPIO)
-#define GPIO170_SPI1_CLK	PIN_CFG(170, ALT_A)
-
-#define GPIO171_GPIO		PIN_CFG(171, GPIO)
-#define GPIO171_MC3_DAT0	PIN_CFG(171, ALT_A)
-#define GPIO171_SPI3_RXD	PIN_CFG(171, ALT_B)
-#define GPIO171_BUSMON_D25	PIN_CFG(171, ALT_C)
-
-#define GPIO172_GPIO		PIN_CFG(172, GPIO)
-#define GPIO172_MC3_DAT1	PIN_CFG(172, ALT_A)
-#define GPIO172_SPI3_CS1n	PIN_CFG(172, ALT_B)
-#define GPIO172_BUSMON_D26	PIN_CFG(172, ALT_C)
-
-#define GPIO173_GPIO		PIN_CFG(173, GPIO)
-#define GPIO173_MC3_DAT2	PIN_CFG(173, ALT_A)
-#define GPIO173_SPI3_CS2n	PIN_CFG(173, ALT_B)
-#define GPIO173_BUSMON_D27	PIN_CFG(173, ALT_C)
-
-#define GPIO174_GPIO		PIN_CFG(174, GPIO)
-#define GPIO174_MC3_DAT3	PIN_CFG(174, ALT_A)
-#define GPIO174_SPI3_CS0n	PIN_CFG(174, ALT_B)
-#define GPIO174_BUSMON_D28	PIN_CFG(174, ALT_C)
-
-#define GPIO175_GPIO		PIN_CFG(175, GPIO)
-#define GPIO175_MC3_CMD		PIN_CFG(175, ALT_A)
-#define GPIO175_SPI3_TXD	PIN_CFG(175, ALT_B)
-#define GPIO175_BUSMON_D29	PIN_CFG(175, ALT_C)
-
-#define GPIO176_GPIO		PIN_CFG(176, GPIO)
-#define GPIO176_MC3_CLK		PIN_CFG(176, ALT_A)
-#define GPIO176_SPI3_CLK	PIN_CFG(176, ALT_B)
-
-#define GPIO177_GPIO		PIN_CFG(177, GPIO)
-#define GPIO177_U2_RXD		PIN_CFG(177, ALT_A)
-#define GPIO177_I2C3_SCL	PIN_CFG(177, ALT_B)
-#define GPIO177_BUSMON_D30	PIN_CFG(177, ALT_C)
-
-#define GPIO178_GPIO		PIN_CFG(178, GPIO)
-#define GPIO178_U2_TXD		PIN_CFG(178, ALT_A)
-#define GPIO178_I2C3_SDA	PIN_CFG(178, ALT_B)
-#define GPIO178_BUSMON_D31	PIN_CFG(178, ALT_C)
-
-#define GPIO179_GPIO		PIN_CFG(179, GPIO)
-#define GPIO179_U2_CTSn		PIN_CFG(179, ALT_A)
-#define GPIO179_U3_RXD		PIN_CFG(179, ALT_B)
-#define GPIO179_BUSMON_D32	PIN_CFG(179, ALT_C)
-
-#define GPIO180_GPIO		PIN_CFG(180, GPIO)
-#define GPIO180_U2_RTSn		PIN_CFG(180, ALT_A)
-#define GPIO180_U3_TXD		PIN_CFG(180, ALT_B)
-#define GPIO180_BUSMON_D33	PIN_CFG(180, ALT_C)
-
-#define GPIO185_GPIO		PIN_CFG(185, GPIO)
-#define GPIO185_SPI3_CS2n	PIN_CFG(185, ALT_A)
-#define GPIO185_MC4_DAT0	PIN_CFG(185, ALT_B)
-
-#define GPIO186_GPIO		PIN_CFG(186, GPIO)
-#define GPIO186_SPI3_CS1n	PIN_CFG(186, ALT_A)
-#define GPIO186_MC4_DAT1	PIN_CFG(186, ALT_B)
-
-#define GPIO187_GPIO		PIN_CFG(187, GPIO)
-#define GPIO187_SPI3_CS0n	PIN_CFG(187, ALT_A)
-#define GPIO187_MC4_DAT2	PIN_CFG(187, ALT_B)
-
-#define GPIO188_GPIO		PIN_CFG(188, GPIO)
-#define GPIO188_SPI3_RXD	PIN_CFG(188, ALT_A)
-#define GPIO188_MC4_DAT3	PIN_CFG(188, ALT_B)
-
-#define GPIO189_GPIO		PIN_CFG(189, GPIO)
-#define GPIO189_SPI3_TXD	PIN_CFG(189, ALT_A)
-#define GPIO189_MC4_CMD		PIN_CFG(189, ALT_B)
-
-#define GPIO190_GPIO		PIN_CFG(190, GPIO)
-#define GPIO190_SPI3_CLK	PIN_CFG(190, ALT_A)
-#define GPIO190_MC4_CLK		PIN_CFG(190, ALT_B)
-
-#define GPIO191_GPIO		PIN_CFG(191, GPIO)
-#define GPIO191_MC1_DAT0	PIN_CFG(191, ALT_A)
-#define GPIO191_MC4_DAT4	PIN_CFG(191, ALT_B)
-#define GPIO191_STMAPE_DAT0	PIN_CFG(191, ALT_C)
-
-#define GPIO192_GPIO		PIN_CFG(192, GPIO)
-#define GPIO192_MC1_DAT1	PIN_CFG(192, ALT_A)
-#define GPIO192_MC4_DAT5	PIN_CFG(192, ALT_B)
-#define GPIO192_STMAPE_DAT1	PIN_CFG(192, ALT_C)
-
-#define GPIO193_GPIO		PIN_CFG(193, GPIO)
-#define GPIO193_MC1_DAT2	PIN_CFG(193, ALT_A)
-#define GPIO193_MC4_DAT6	PIN_CFG(193, ALT_B)
-#define GPIO193_STMAPE_DAT2	PIN_CFG(193, ALT_C)
-
-#define GPIO194_GPIO		PIN_CFG(194, GPIO)
-#define GPIO194_MC1_DAT3	PIN_CFG(194, ALT_A)
-#define GPIO194_MC4_DAT7	PIN_CFG(194, ALT_B)
-#define GPIO194_STMAPE_DAT3	PIN_CFG(194, ALT_C)
-
-#define GPIO195_GPIO		PIN_CFG(195, GPIO)
-#define GPIO195_MC1_CLK		PIN_CFG(195, ALT_A)
-#define GPIO195_STMAPE_CLK	PIN_CFG(195, ALT_B)
-#define GPIO195_BUSMON_CLK	PIN_CFG(195, ALT_C)
-
-#define GPIO196_GPIO		PIN_CFG(196, GPIO)
-#define GPIO196_MC1_CMD		PIN_CFG(196, ALT_A)
-#define GPIO196_U0_RXD		PIN_CFG(196, ALT_B)
-#define GPIO196_BUSMON_D38	PIN_CFG(196, ALT_C)
-
-#define GPIO197_GPIO		PIN_CFG(197, GPIO)
-#define GPIO197_MC1_CMDDIR	PIN_CFG(197, ALT_A)
-#define GPIO197_BUSMON_D39	PIN_CFG(197, ALT_B)
-
-#define GPIO198_GPIO		PIN_CFG(198, GPIO)
-#define GPIO198_MC1_FBCLK	PIN_CFG(198, ALT_A)
-
-#define GPIO199_GPIO		PIN_CFG(199, GPIO)
-#define GPIO199_MC1_DAT0DIR	PIN_CFG(199, ALT_A)
-#define GPIO199_BUSMON_D40	PIN_CFG(199, ALT_B)
-
-#define GPIO200_GPIO		PIN_CFG(200, GPIO)
-#define GPIO200_U1_TXD		PIN_CFG(200, ALT_A)
-#define GPIO200_ACCU0_RTSn	PIN_CFG(200, ALT_B)
-
-#define GPIO201_GPIO		PIN_CFG(201, GPIO)
-#define GPIO201_U1_RXD		PIN_CFG(201, ALT_A)
-#define GPIO201_ACCU0_CTSn	PIN_CFG(201, ALT_B)
-
-#define GPIO202_GPIO		PIN_CFG(202, GPIO)
-#define GPIO202_U1_CTSn		PIN_CFG(202, ALT_A)
-#define GPIO202_ACCU0_RXD	PIN_CFG(202, ALT_B)
-
-#define GPIO203_GPIO		PIN_CFG(203, GPIO)
-#define GPIO203_U1_RTSn		PIN_CFG(203, ALT_A)
-#define GPIO203_ACCU0_TXD	PIN_CFG(203, ALT_B)
-
-#define GPIO204_GPIO		PIN_CFG(204, GPIO)
-#define GPIO204_SPI0_CS2n	PIN_CFG(204, ALT_A)
-#define GPIO204_ACCGPIO_000	PIN_CFG(204, ALT_B)
-#define GPIO204_LCD_VSI1	PIN_CFG(204, ALT_C)
-
-#define GPIO205_GPIO		PIN_CFG(205, GPIO)
-#define GPIO205_SPI0_CS1n	PIN_CFG(205, ALT_A)
-#define GPIO205_ACCGPIO_001	PIN_CFG(205, ALT_B)
-#define GPIO205_LCD_D3		PIN_CFG(205, ALT_C)
-
-#define GPIO206_GPIO		PIN_CFG(206, GPIO)
-#define GPIO206_SPI0_CS0n	PIN_CFG(206, ALT_A)
-#define GPIO206_ACCGPIO_002	PIN_CFG(206, ALT_B)
-#define GPIO206_LCD_D2		PIN_CFG(206, ALT_C)
-
-#define GPIO207_GPIO		PIN_CFG(207, GPIO)
-#define GPIO207_SPI0_RXD	PIN_CFG(207, ALT_A)
-#define GPIO207_ACCGPIO_003	PIN_CFG(207, ALT_B)
-#define GPIO207_LCD_D1		PIN_CFG(207, ALT_C)
-
-#define GPIO208_GPIO		PIN_CFG(208, GPIO)
-#define GPIO208_SPI0_TXD	PIN_CFG(208, ALT_A)
-#define GPIO208_ACCGPIO_004	PIN_CFG(208, ALT_B)
-#define GPIO208_LCD_D0		PIN_CFG(208, ALT_C)
-
-#define GPIO209_GPIO		PIN_CFG(209, GPIO)
-#define GPIO209_SPI0_CLK	PIN_CFG(209, ALT_A)
-#define GPIO209_ACCGPIO_005	PIN_CFG(209, ALT_B)
-#define GPIO209_LCD_CLK		PIN_CFG(209, ALT_C)
-
-#define GPIO210_GPIO		PIN_CFG(210, GPIO)
-#define GPIO210_LCD_VSO		PIN_CFG(210, ALT_A)
-#define GPIO210_PRCMU_PWRCTRL1	PIN_CFG(210, ALT_B)
-
-#define GPIO211_GPIO		PIN_CFG(211, GPIO)
-#define GPIO211_LCD_VSI0	PIN_CFG(211, ALT_A)
-#define GPIO211_PRCMU_PWRCTRL2	PIN_CFG(211, ALT_B)
-
-#define GPIO212_GPIO		PIN_CFG(212, GPIO)
-#define GPIO212_SPI2_CS2n	PIN_CFG(212, ALT_A)
-#define GPIO212_LCD_HSO		PIN_CFG(212, ALT_B)
-
-#define GPIO213_GPIO		PIN_CFG(213, GPIO)
-#define GPIO213_SPI2_CS1n	PIN_CFG(213, ALT_A)
-#define GPIO213_LCD_DE		PIN_CFG(213, ALT_B)
-#define GPIO213_BUSMON_D16	PIN_CFG(213, ALT_C)
-
-#define GPIO214_GPIO		PIN_CFG(214, GPIO)
-#define GPIO214_SPI2_CS0n	PIN_CFG(214, ALT_A)
-#define GPIO214_LCD_D7		PIN_CFG(214, ALT_B)
-#define GPIO214_BUSMON_D17	PIN_CFG(214, ALT_C)
-
-#define GPIO215_GPIO		PIN_CFG(215, GPIO)
-#define GPIO215_SPI2_RXD	PIN_CFG(215, ALT_A)
-#define GPIO215_LCD_D6		PIN_CFG(215, ALT_B)
-#define GPIO215_BUSMON_D18	PIN_CFG(215, ALT_C)
-
-#define GPIO216_GPIO		PIN_CFG(216, GPIO)
-#define GPIO216_SPI2_CLK	PIN_CFG(216, ALT_A)
-#define GPIO216_LCD_D5		PIN_CFG(216, ALT_B)
-
-#define GPIO217_GPIO		PIN_CFG(217, GPIO)
-#define GPIO217_SPI2_TXD	PIN_CFG(217, ALT_A)
-#define GPIO217_LCD_D4		PIN_CFG(217, ALT_B)
-#define GPIO217_BUSMON_D19	PIN_CFG(217, ALT_C)
-
-#define GPIO218_GPIO		PIN_CFG(218, GPIO)
-#define GPIO218_I2C2_SCL	PIN_CFG(218, ALT_A)
-#define GPIO218_LCD_VSO		PIN_CFG(218, ALT_B)
-
-#define GPIO219_GPIO		PIN_CFG(219, GPIO)
-#define GPIO219_I2C2_SDA	PIN_CFG(219, ALT_A)
-#define GPIO219_LCD_D3		PIN_CFG(219, ALT_B)
-
-#define GPIO220_GPIO		PIN_CFG(220, GPIO)
-#define GPIO220_MSP2_TCK	PIN_CFG(220, ALT_A)
-#define GPIO220_LCD_D2		PIN_CFG(220, ALT_B)
-
-#define GPIO221_GPIO		PIN_CFG(221, GPIO)
-#define GPIO221_MSP2_TFS	PIN_CFG(221, ALT_A)
-#define GPIO221_LCD_D1		PIN_CFG(221, ALT_B)
-
-#define GPIO222_GPIO		PIN_CFG(222, GPIO)
-#define GPIO222_MSP2_TXD	PIN_CFG(222, ALT_A)
-#define GPIO222_LCD_D0		PIN_CFG(222, ALT_B)
-
-#define GPIO223_GPIO		PIN_CFG(223, GPIO)
-#define GPIO223_MSP2_RXD	PIN_CFG(223, ALT_A)
-#define GPIO223_LCD_CLK		PIN_CFG(223, ALT_B)
-
-#define GPIO224_GPIO		PIN_CFG(224, GPIO)
-#define GPIO224_PRCMU_PWRCTRL0	PIN_CFG(224, ALT_A)
-#define GPIO224_LCD_VSI1	PIN_CFG(224, ALT_B)
-
-#define GPIO225_GPIO		PIN_CFG(225, GPIO)
-#define GPIO225_PRCMU_PWRCTRL1	PIN_CFG(225, ALT_A)
-#define GPIO225_IRDA_RXD	PIN_CFG(225, ALT_B)
-
-#define GPIO226_GPIO		PIN_CFG(226, GPIO)
-#define GPIO226_PRCMU_PWRCTRL2	PIN_CFG(226, ALT_A)
-#define GPIO226_IRRC_DAT	PIN_CFG(226, ALT_B)
-
-#define GPIO227_GPIO		PIN_CFG(227, GPIO)
-#define GPIO227_IRRC_DAT	PIN_CFG(227, ALT_A)
-#define GPIO227_IRDA_TXD	PIN_CFG(227, ALT_B)
-
-#endif
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index f499a07..da1d5ad 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -48,9 +48,7 @@ static void write_pen_release(int val)
 
 static void __iomem *scu_base_addr(void)
 {
-	if (cpu_is_u5500())
-		return __io_address(U5500_SCU_BASE);
-	else if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family())
 		return __io_address(U8500_SCU_BASE);
 	else
 		ux500_unknown_soc();
@@ -120,9 +118,7 @@ static void __init wakeup_secondary(void)
 {
 	void __iomem *backupram;
 
-	if (cpu_is_u5500())
-		backupram = __io_address(U5500_BACKUPRAM0_BASE);
-	else if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family())
 		backupram = __io_address(U8500_BACKUPRAM0_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/ste-dma40-db5500.h b/arch/arm/mach-ux500/ste-dma40-db5500.h
deleted file mode 100644
index cb2110c..0000000
--- a/arch/arm/mach-ux500/ste-dma40-db5500.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- *
- * DB5500-SoC-specific configuration for DMA40
- */
-
-#ifndef STE_DMA40_DB5500_H
-#define STE_DMA40_DB5500_H
-
-#define DB5500_DMA_NR_DEV 64
-
-enum dma_src_dev_type {
-	DB5500_DMA_DEV0_SPI0_RX = 0,
-	DB5500_DMA_DEV1_SPI1_RX = 1,
-	DB5500_DMA_DEV2_SPI2_RX = 2,
-	DB5500_DMA_DEV3_SPI3_RX = 3,
-	DB5500_DMA_DEV4_USB_OTG_IEP_1_9 = 4,
-	DB5500_DMA_DEV5_USB_OTG_IEP_2_10 = 5,
-	DB5500_DMA_DEV6_USB_OTG_IEP_3_11 = 6,
-	DB5500_DMA_DEV7_IRDA_RFS = 7,
-	DB5500_DMA_DEV8_IRDA_FIFO_RX = 8,
-	DB5500_DMA_DEV9_MSP0_RX = 9,
-	DB5500_DMA_DEV10_MSP1_RX = 10,
-	DB5500_DMA_DEV11_MSP2_RX = 11,
-	DB5500_DMA_DEV12_UART0_RX = 12,
-	DB5500_DMA_DEV13_UART1_RX = 13,
-	DB5500_DMA_DEV14_UART2_RX = 14,
-	DB5500_DMA_DEV15_UART3_RX = 15,
-	DB5500_DMA_DEV16_USB_OTG_IEP_8 = 16,
-	DB5500_DMA_DEV17_USB_OTG_IEP_1_9 = 17,
-	DB5500_DMA_DEV18_USB_OTG_IEP_2_10 = 18,
-	DB5500_DMA_DEV19_USB_OTG_IEP_3_11 = 19,
-	DB5500_DMA_DEV20_USB_OTG_IEP_4_12 = 20,
-	DB5500_DMA_DEV21_USB_OTG_IEP_5_13 = 21,
-	DB5500_DMA_DEV22_USB_OTG_IEP_6_14 = 22,
-	DB5500_DMA_DEV23_USB_OTG_IEP_7_15 = 23,
-	DB5500_DMA_DEV24_SDMMC0_RX = 24,
-	DB5500_DMA_DEV25_SDMMC1_RX = 25,
-	DB5500_DMA_DEV26_SDMMC2_RX = 26,
-	DB5500_DMA_DEV27_SDMMC3_RX = 27,
-	DB5500_DMA_DEV28_SDMMC4_RX = 28,
-	/* 29 - 32 not used */
-	DB5500_DMA_DEV33_SDMMC0_RX = 33,
-	DB5500_DMA_DEV34_SDMMC1_RX = 34,
-	DB5500_DMA_DEV35_SDMMC2_RX = 35,
-	DB5500_DMA_DEV36_SDMMC3_RX = 36,
-	DB5500_DMA_DEV37_SDMMC4_RX = 37,
-	DB5500_DMA_DEV38_USB_OTG_IEP_8 = 38,
-	DB5500_DMA_DEV39_USB_OTG_IEP_1_9 = 39,
-	DB5500_DMA_DEV40_USB_OTG_IEP_2_10 = 40,
-	DB5500_DMA_DEV41_USB_OTG_IEP_3_11 = 41,
-	DB5500_DMA_DEV42_USB_OTG_IEP_4_12 = 42,
-	DB5500_DMA_DEV43_USB_OTG_IEP_5_13 = 43,
-	DB5500_DMA_DEV44_USB_OTG_IEP_6_14 = 44,
-	DB5500_DMA_DEV45_USB_OTG_IEP_7_15 = 45,
-	/* 46 not used */
-	DB5500_DMA_DEV47_MCDE_RX = 47,
-	DB5500_DMA_DEV48_CRYPTO1_RX = 48,
-	/* 49, 50 not used */
-	DB5500_DMA_DEV49_I2C1_RX = 51,
-	DB5500_DMA_DEV50_I2C3_RX = 52,
-	DB5500_DMA_DEV51_I2C2_RX = 53,
-	/* 54 - 60 not used */
-	DB5500_DMA_DEV61_CRYPTO0_RX = 61,
-	/* 62, 63 not used */
-};
-
-enum dma_dest_dev_type {
-	DB5500_DMA_DEV0_SPI0_TX = 0,
-	DB5500_DMA_DEV1_SPI1_TX = 1,
-	DB5500_DMA_DEV2_SPI2_TX = 2,
-	DB5500_DMA_DEV3_SPI3_TX = 3,
-	DB5500_DMA_DEV4_USB_OTG_OEP_1_9 = 4,
-	DB5500_DMA_DEV5_USB_OTG_OEP_2_10 = 5,
-	DB5500_DMA_DEV6_USB_OTG_OEP_3_11 = 6,
-	DB5500_DMA_DEV7_IRRC_TX = 7,
-	DB5500_DMA_DEV8_IRDA_FIFO_TX = 8,
-	DB5500_DMA_DEV9_MSP0_TX = 9,
-	DB5500_DMA_DEV10_MSP1_TX = 10,
-	DB5500_DMA_DEV11_MSP2_TX = 11,
-	DB5500_DMA_DEV12_UART0_TX = 12,
-	DB5500_DMA_DEV13_UART1_TX = 13,
-	DB5500_DMA_DEV14_UART2_TX = 14,
-	DB5500_DMA_DEV15_UART3_TX = 15,
-	DB5500_DMA_DEV16_USB_OTG_OEP_8 = 16,
-	DB5500_DMA_DEV17_USB_OTG_OEP_1_9 = 17,
-	DB5500_DMA_DEV18_USB_OTG_OEP_2_10 = 18,
-	DB5500_DMA_DEV19_USB_OTG_OEP_3_11 = 19,
-	DB5500_DMA_DEV20_USB_OTG_OEP_4_12 = 20,
-	DB5500_DMA_DEV21_USB_OTG_OEP_5_13 = 21,
-	DB5500_DMA_DEV22_USB_OTG_OEP_6_14 = 22,
-	DB5500_DMA_DEV23_USB_OTG_OEP_7_15 = 23,
-	DB5500_DMA_DEV24_SDMMC0_TX = 24,
-	DB5500_DMA_DEV25_SDMMC1_TX = 25,
-	DB5500_DMA_DEV26_SDMMC2_TX = 26,
-	DB5500_DMA_DEV27_SDMMC3_TX = 27,
-	DB5500_DMA_DEV28_SDMMC4_TX = 28,
-	/* 29 - 31 not used */
-	DB5500_DMA_DEV32_FSMC_TX = 32,
-	DB5500_DMA_DEV33_SDMMC0_TX = 33,
-	DB5500_DMA_DEV34_SDMMC1_TX = 34,
-	DB5500_DMA_DEV35_SDMMC2_TX = 35,
-	DB5500_DMA_DEV36_SDMMC3_TX = 36,
-	DB5500_DMA_DEV37_SDMMC4_TX = 37,
-	DB5500_DMA_DEV38_USB_OTG_OEP_8 = 38,
-	DB5500_DMA_DEV39_USB_OTG_OEP_1_9 = 39,
-	DB5500_DMA_DEV40_USB_OTG_OEP_2_10 = 40,
-	DB5500_DMA_DEV41_USB_OTG_OEP_3_11 = 41,
-	DB5500_DMA_DEV42_USB_OTG_OEP_4_12 = 42,
-	DB5500_DMA_DEV43_USB_OTG_OEP_5_13 = 43,
-	DB5500_DMA_DEV44_USB_OTG_OEP_6_14 = 44,
-	DB5500_DMA_DEV45_USB_OTG_OEP_7_15 = 45,
-	/* 46 not used */
-	DB5500_DMA_DEV47_STM_TX = 47,
-	DB5500_DMA_DEV48_CRYPTO1_TX = 48,
-	DB5500_DMA_DEV49_CRYPTO1_TX_HASH1_TX = 49,
-	DB5500_DMA_DEV50_HASH1_TX = 50,
-	DB5500_DMA_DEV51_I2C1_TX = 51,
-	DB5500_DMA_DEV52_I2C3_TX = 52,
-	DB5500_DMA_DEV53_I2C2_TX = 53,
-	/* 54, 55 not used */
-	DB5500_DMA_MEMCPY_TX_1 = 56,
-	DB5500_DMA_MEMCPY_TX_2 = 57,
-	DB5500_DMA_MEMCPY_TX_3 = 58,
-	DB5500_DMA_MEMCPY_TX_4 = 59,
-	DB5500_DMA_MEMCPY_TX_5 = 60,
-	DB5500_DMA_DEV61_CRYPTO0_TX = 61,
-	DB5500_DMA_DEV62_CRYPTO0_TX_HASH0_TX = 62,
-	DB5500_DMA_DEV63_HASH0_TX = 63,
-};
-
-#endif
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 3bfbfdf..e263076 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -18,8 +18,6 @@
 #include <mach/irqs.h>
 
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(u5500_twd_local_timer,
-			      U5500_TWD_BASE, IRQ_LOCALTIMER);
 static DEFINE_TWD_LOCAL_TIMER(u8500_twd_local_timer,
 			      U8500_TWD_BASE, IRQ_LOCALTIMER);
 
@@ -28,8 +26,8 @@ static void __init ux500_twd_init(void)
 	struct twd_local_timer *twd_local_timer;
 	int err;
 
-	twd_local_timer = cpu_is_u5500() ? &u5500_twd_local_timer :
-					   &u8500_twd_local_timer;
+	/* Use this to switch local timer base if changed in new ASICs */
+	twd_local_timer = &u8500_twd_local_timer;
 
 	if (of_have_populated_dt())
 		twd_local_timer_of_register();
@@ -48,10 +46,7 @@ static void __init ux500_timer_init(void)
 	void __iomem *mtu_timer_base;
 	void __iomem *prcmu_timer_base;
 
-	if (cpu_is_u5500()) {
-		mtu_timer_base = __io_address(U5500_MTU0_BASE);
-		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
-	} else if (cpu_is_u8500_family()) {
+	if (cpu_is_u8500_family()) {
 		mtu_timer_base = __io_address(U8500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
 	} else {
@@ -70,7 +65,7 @@ static void __init ux500_timer_init(void)
 	 * depending on delay which is not yet calibrated. RTC-RTT is in the
 	 * always-on powerdomain and is used as clockevent instead of twd when
 	 * sleeping.
-	 * The PRCMU timer 4(3 for DB5500) register a clocksource and
+	 * The PRCMU timer 4 register a clocksource and
 	 * sched_clock with higher rating then MTU since is always-on.
 	 *
 	 */
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5138927..99c6b20 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -18,7 +18,7 @@ config DW_APB_TIMER
 
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer"
-	depends on UX500_SOC_DB5500 || UX500_SOC_DB8500
+	depends on UX500_SOC_DB8500
 	default y
 	help
 	  Use the always on PRCMU Timer as clocksource
-- 
1.7.9.2
