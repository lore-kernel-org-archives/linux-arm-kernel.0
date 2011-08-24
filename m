From: b32955@freescale.com (Huang Shijie)
Date: Wed, 24 Aug 2011 15:07:20 +0800
Subject: [PATCH v8 1/4] ARM: mxs: add GPMI-NAND support for imx23/imx28
In-Reply-To: <1314169643-23425-1-git-send-email-b32955@freescale.com>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
Message-ID: <1314169643-23425-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add GPMI-NAND support for imx23 and imx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    1 +
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi-nand.c  |  109 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 ++
 include/linux/mtd/gpmi-nand.h                   |   68 ++++++++++++++
 9 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nand.c
 create mode 100644 include/linux/mtd/gpmi-nand.h

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 0163b6d..4300ce5 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -456,6 +456,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
 	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
+	_REGISTER_CLOCK("imx23-gpmi-nand", NULL, gpmi_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5dcc59d..dc2052c 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -614,6 +614,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
+	_REGISTER_CLOCK("imx28-gpmi-nand", NULL, gpmi_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index c6f345f..ee8c525 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -21,6 +21,10 @@ extern const struct mxs_auart_data mx23_auart_data[] __initconst;
 #define mx23_add_auart0()		mx23_add_auart(0)
 #define mx23_add_auart1()		mx23_add_auart(1)
 
+extern const struct mxs_gpmi_nand_data mx23_gpmi_nand_data __initconst;
+#define mx23_add_gpmi_nand(pdata)	\
+	mxs_add_gpmi_nand(pdata, &mx23_gpmi_nand_data)
+
 extern const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __initconst;
 #define mx23_add_mxs_mmc(id, pdata) \
 	mxs_add_mxs_mmc(&mx23_mxs_mmc_data[id], pdata)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 79b9452..2953f0d 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -34,6 +34,10 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
 
+extern const struct mxs_gpmi_nand_data mx28_gpmi_nand_data __initconst;
+#define mx28_add_gpmi_nand(pdata)	\
+	mxs_add_gpmi_nand(pdata, &mx28_gpmi_nand_data)
+
 extern const struct mxs_mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
 #define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
 
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index acf9eea..a3bca3c 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -12,6 +12,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
 
+config MXS_HAVE_PLATFORM_GPMI_NAND
+	bool
+
 config MXS_HAVE_PLATFORM_MXS_I2C
 	bool
 
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 351915c..7d26eb1 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_GPMI_NAND) += platform-gpmi-nand.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
diff --git a/arch/arm/mach-mxs/devices/platform-gpmi-nand.c b/arch/arm/mach-mxs/devices/platform-gpmi-nand.c
new file mode 100644
index 0000000..a8b74dc
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-gpmi-nand.c
@@ -0,0 +1,109 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include <asm/sizes.h>
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+#include <linux/dma-mapping.h>
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_gpmi_nand_data mx23_gpmi_nand_data __initconst = {
+	.devid = "imx23-gpmi-nand",
+	.res = {
+		{	/* GPMI */
+			.start = MX23_GPMI_BASE_ADDR,
+			.end   = MX23_GPMI_BASE_ADDR + SZ_8K - 1,
+			.name  = GPMI_NAND_GPMI_REGS_ADDR_RES_NAME,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = MX23_INT_GPMI_ATTENTION,
+			.end   = MX23_INT_GPMI_ATTENTION,
+			.name  = GPMI_NAND_GPMI_INTERRUPT_RES_NAME,
+			.flags = IORESOURCE_IRQ,
+		}, {	/* BCH */
+			.start = MX23_BCH_BASE_ADDR,
+			.end   = MX23_BCH_BASE_ADDR + SZ_8K - 1,
+			.name  = GPMI_NAND_BCH_REGS_ADDR_RES_NAME,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = MX23_INT_BCH,
+			.end   = MX23_INT_BCH,
+			.name  = GPMI_NAND_BCH_INTERRUPT_RES_NAME,
+			.flags = IORESOURCE_IRQ,
+		}, {	/* DMA */
+			.start	= MX23_DMA_GPMI0,
+			.end	= MX23_DMA_GPMI3,
+			.name  = GPMI_NAND_DMA_CHANNELS_RES_NAME,
+			.flags = IORESOURCE_DMA,
+		}, {
+			.start = MX23_INT_GPMI_DMA,
+			.end   = MX23_INT_GPMI_DMA,
+			.name  = GPMI_NAND_DMA_INTERRUPT_RES_NAME,
+			.flags = IORESOURCE_IRQ,
+		},
+	},
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_gpmi_nand_data mx28_gpmi_nand_data __initconst = {
+	.devid = "imx28-gpmi-nand",
+	.res = {
+		{	/* GPMI */
+			.start = MX28_GPMI_BASE_ADDR,
+			.end   = MX28_GPMI_BASE_ADDR + SZ_8K - 1,
+			.name  = GPMI_NAND_GPMI_REGS_ADDR_RES_NAME,
+			.flags = IORESOURCE_MEM,
+		 }, {
+			.start = MX28_INT_GPMI,
+			.end   = MX28_INT_GPMI,
+			.name  = GPMI_NAND_GPMI_INTERRUPT_RES_NAME,
+			.flags = IORESOURCE_IRQ,
+		}, {	/* BCH */
+			.start = MX28_BCH_BASE_ADDR,
+			.end   = MX28_BCH_BASE_ADDR + SZ_8K - 1,
+			.name  = GPMI_NAND_BCH_REGS_ADDR_RES_NAME,
+			.flags = IORESOURCE_MEM,
+		 }, {
+			.start = MX28_INT_BCH,
+			.end   = MX28_INT_BCH,
+			.name  = GPMI_NAND_BCH_INTERRUPT_RES_NAME,
+			.flags = IORESOURCE_IRQ,
+		 }, {	/* DMA */
+			.start	= MX28_DMA_GPMI0,
+			.end	= MX28_DMA_GPMI7,
+			.name	= GPMI_NAND_DMA_CHANNELS_RES_NAME,
+			.flags	= IORESOURCE_DMA,
+		 }, {
+			.start = MX28_INT_GPMI_DMA,
+			.end   = MX28_INT_GPMI_DMA,
+			.name  = GPMI_NAND_DMA_INTERRUPT_RES_NAME,
+			.flags = IORESOURCE_IRQ,
+		},
+	},
+};
+#endif
+
+struct platform_device *__init
+mxs_add_gpmi_nand(const struct gpmi_nand_platform_data *pdata,
+		const struct mxs_gpmi_nand_data *data)
+{
+	return mxs_add_platform_device_dmamask(data->devid, -1,
+				data->res, GPMI_NAND_RES_SIZE,
+				pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 812d7a8..ce71c89 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -66,6 +66,16 @@ struct platform_device *__init mxs_add_flexcan(
 		const struct mxs_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
 
+/* gpmi-nand */
+#include <linux/mtd/gpmi-nand.h>
+struct mxs_gpmi_nand_data {
+	const char *devid;
+	const struct resource res[GPMI_NAND_RES_SIZE];
+};
+struct platform_device *__init
+mxs_add_gpmi_nand(const struct gpmi_nand_platform_data *pdata,
+		const struct mxs_gpmi_nand_data *data);
+
 /* i2c */
 struct mxs_mxs_i2c_data {
 	int id;
diff --git a/include/linux/mtd/gpmi-nand.h b/include/linux/mtd/gpmi-nand.h
new file mode 100644
index 0000000..69b6dbf
--- /dev/null
+++ b/include/linux/mtd/gpmi-nand.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef __MACH_MXS_GPMI_NAND_H__
+#define __MACH_MXS_GPMI_NAND_H__
+
+/* The size of the resources is fixed. */
+#define GPMI_NAND_RES_SIZE	6
+
+/* Resource names for the GPMI NAND driver. */
+#define GPMI_NAND_GPMI_REGS_ADDR_RES_NAME  "GPMI NAND GPMI Registers"
+#define GPMI_NAND_GPMI_INTERRUPT_RES_NAME  "GPMI NAND GPMI Interrupt"
+#define GPMI_NAND_BCH_REGS_ADDR_RES_NAME   "GPMI NAND BCH Registers"
+#define GPMI_NAND_BCH_INTERRUPT_RES_NAME   "GPMI NAND BCH Interrupt"
+#define GPMI_NAND_DMA_CHANNELS_RES_NAME    "GPMI NAND DMA Channels"
+#define GPMI_NAND_DMA_INTERRUPT_RES_NAME   "GPMI NAND DMA Interrupt"
+
+/**
+ * struct gpmi_nand_platform_data - GPMI NAND driver platform data.
+ *
+ * This structure communicates platform-specific information to the GPMI NAND
+ * driver that can't be expressed as resources.
+ *
+ * @platform_init:           A pointer to a function the driver will call to
+ *                           initialize the platform (e.g., set up the pin mux).
+ * @min_prop_delay_in_ns:    Minimum propagation delay of GPMI signals to and
+ *                           from the NAND Flash device, in nanoseconds.
+ * @max_prop_delay_in_ns:    Maximum propagation delay of GPMI signals to and
+ *                           from the NAND Flash device, in nanoseconds.
+ * @max_chip_count:          The maximum number of chips for which the driver
+ *                           should configure the hardware. This value most
+ *                           likely reflects the number of pins that are
+ *                           connected to a NAND Flash device. If this is
+ *                           greater than the SoC hardware can support, the
+ *                           driver will print a message and fail to initialize.
+ * @partitions:              An optional pointer to an array of partition
+ *                           descriptions.
+ * @partition_count:         The number of elements in the partitions array.
+ */
+struct gpmi_nand_platform_data {
+	/* SoC hardware information. */
+	int		(*platform_init)(void);
+
+	/* NAND Flash information. */
+	unsigned int	min_prop_delay_in_ns;
+	unsigned int	max_prop_delay_in_ns;
+	unsigned int	max_chip_count;
+
+	/* Medium information. */
+	struct		mtd_partition *partitions;
+	unsigned	partition_count;
+};
+#endif
-- 
1.7.0.4
