From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:04 -0700
Subject: [PATCH 02/10] ux500: Adding new board files for snowball.
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Makefile         |    2 +
 arch/arm/mach-ux500/board-snowball.c |  262 ++++++++++++++++++++++++++++++++++
 2 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-snowball.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index b549a8f..60c26c6 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o
+obj-$(CONFIG_MACH_U8500_SNOWBALL) += board-snowball.o \
+				board-mop500-regulators.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-snowball.c b/arch/arm/mach-ux500/board-snowball.c
new file mode 100644
index 0000000..620f132
--- /dev/null
+++ b/arch/arm/mach-ux500/board-snowball.c
@@ -0,0 +1,262 @@
+/*
+ * Copyright (C) 2010-2011 ST-Ericsson
+ *
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>, based on
+ *         the work of Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/pl022.h>
+#include <linux/amba/serial.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/ab8500.h>
+#include <linux/input.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <plat/i2c.h>
+#include <plat/ste_dma40.h>
+
+#include <mach/hardware.h>
+#include <mach/setup.h>
+#include <mach/devices.h>
+#include <mach/irqs.h>
+
+#include "ste-dma40-db8500.h"
+#include "devices-db8500.h"
+#include "board-mop500.h"
+#include "board-mop500-regulators.h"
+
+static struct ab8500_platform_data ab8500_platdata = {
+	.irq_base	= MOP500_AB8500_IRQ_BASE,
+	.regulator	= ab8500_regulators,
+	.num_regulator	= ARRAY_SIZE(ab8500_regulators),
+};
+
+static struct resource ab8500_resources[] = {
+	[0] = {
+		.start	= IRQ_DB8500_AB8500,
+		.end	= IRQ_DB8500_AB8500,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
+struct platform_device ab8500_device_snowball = {
+	.name = "ab8500-i2c",
+	.id = 0,
+	.dev = {
+		.platform_data = &ab8500_platdata,
+	},
+	.num_resources = 1,
+	.resource = ab8500_resources,
+};
+
+static struct i2c_board_info mop500_i2c0_devices[] = {};
+static struct i2c_board_info mop500_i2c2_devices[] = {};
+
+#define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
+static struct nmk_i2c_controller u8500_i2c##id##_data = { \
+	/*				\
+	 * slave data setup time, which is	\
+	 * 250 ns,100ns,10ns which is 14,6,2	\
+	 * respectively for a 48 Mhz	\
+	 * i2c clock			\
+	 */				\
+	.slsu		= _slsu,	\
+	/* Tx FIFO threshold */		\
+	.tft		= _tft,		\
+	/* Rx FIFO threshold */		\
+	.rft		= _rft,		\
+	/* std. mode operation */	\
+	.clk_freq	= clk,		\
+	.sm		= _sm,		\
+}
+
+/*
+ * The board uses 4 i2c controllers, initialize all of
+ * them with slave data setup time of 250 ns,
+ * Tx & Rx FIFO threshold values as 1 and standard
+ * mode of operation
+ */
+U8500_I2C_CONTROLLER(0, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(1, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(2,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(3,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+
+static void __init mop500_i2c_init(void)
+{
+	db8500_add_i2c0(&u8500_i2c0_data);
+	db8500_add_i2c1(&u8500_i2c1_data);
+	db8500_add_i2c2(&u8500_i2c2_data);
+	db8500_add_i2c3(&u8500_i2c3_data);
+}
+
+/* add any platform devices here - TODO */
+static struct platform_device *platform_devs[] __initdata = {};
+
+#ifdef CONFIG_STE_DMA40
+static struct stedma40_chan_cfg ssp0_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV8_SSP0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg ssp0_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV8_SSP0_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+#endif
+
+static struct pl022_ssp_controller ssp0_platform_data = {
+	.bus_id = 0,
+#ifdef CONFIG_STE_DMA40
+	.enable_dma = 1,
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &ssp0_dma_cfg_rx,
+	.dma_tx_param = &ssp0_dma_cfg_tx,
+#else
+	.enable_dma = 0,
+#endif
+	/* on this platform, gpio 31,142,144,214 &
+	 * 224 are connected as chip selects
+	 */
+	.num_chipselect = 5,
+};
+
+static void __init mop500_spi_init(void)
+{
+	db8500_add_ssp0(&ssp0_platform_data);
+}
+
+#ifdef CONFIG_STE_DMA40
+static struct stedma40_chan_cfg uart0_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV13_UART0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart0_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV13_UART0_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart1_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV12_UART1_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart1_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV12_UART1_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart2_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV11_UART2_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart2_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV11_UART2_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+#endif
+
+static struct amba_pl011_data uart0_plat = {
+#ifdef CONFIG_STE_DMA40
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &uart0_dma_cfg_rx,
+	.dma_tx_param = &uart0_dma_cfg_tx,
+#endif
+};
+
+static struct amba_pl011_data uart1_plat = {
+#ifdef CONFIG_STE_DMA40
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &uart1_dma_cfg_rx,
+	.dma_tx_param = &uart1_dma_cfg_tx,
+#endif
+};
+
+static struct amba_pl011_data uart2_plat = {
+#ifdef CONFIG_STE_DMA40
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &uart2_dma_cfg_rx,
+	.dma_tx_param = &uart2_dma_cfg_tx,
+#endif
+};
+
+static void __init mop500_uart_init(void)
+{
+	db8500_add_uart0(&uart0_plat);
+	db8500_add_uart1(&uart1_plat);
+	db8500_add_uart2(&uart2_plat);
+}
+
+static void __init mop500_init_machine(void)
+{
+	u8500_init_devices();
+
+	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+
+	mop500_i2c_init();
+	mop500_spi_init();
+	mop500_uart_init();
+
+	platform_device_register(&ab8500_device_snowball);
+
+	i2c_register_board_info(0, mop500_i2c0_devices,
+				ARRAY_SIZE(mop500_i2c0_devices));
+	i2c_register_board_info(2, mop500_i2c2_devices,
+				ARRAY_SIZE(mop500_i2c2_devices));
+}
+
+MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
+	.boot_params	= 0x100,
+	.map_io		= u8500_map_io,
+	.init_irq	= ux500_init_irq,
+	/* we re-use nomadik timer here */
+	.timer		= &ux500_timer,
+	.init_machine	= mop500_init_machine,
+MACHINE_END
-- 
1.7.1
