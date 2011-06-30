From: b32955@freescale.com (Huang Shijie)
Date: Thu, 30 Jun 2011 11:53:46 +0800
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <1309406028-2924-1-git-send-email-b32955@freescale.com>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
Message-ID: <1309406028-2924-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add GPMI-NFC support for imx23 and imx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    1 +
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi-nfc.c   |   90 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 +++
 arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   71 ++++++++++++++++++
 9 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
 create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 0163b6d..e190c53 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -456,6 +456,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
 	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
+	_REGISTER_CLOCK("imx23-gpmi-nfc", NULL, gpmi_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5dcc59d..0397f65 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -614,6 +614,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
+	_REGISTER_CLOCK("imx28-gpmi-nfc", NULL, gpmi_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index c6f345f..a9c495d 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -21,6 +21,10 @@ extern const struct mxs_auart_data mx23_auart_data[] __initconst;
 #define mx23_add_auart0()		mx23_add_auart(0)
 #define mx23_add_auart1()		mx23_add_auart(1)
 
+extern const struct mxs_gpmi_nfc_data mx23_gpmi_nfc_data __initconst;
+#define mx23_add_gpmi_nfc(pdata)	\
+	mxs_add_gpmi_nfc(pdata, &mx23_gpmi_nfc_data)
+
 extern const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __initconst;
 #define mx23_add_mxs_mmc(id, pdata) \
 	mxs_add_mxs_mmc(&mx23_mxs_mmc_data[id], pdata)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 79b9452..bbc8f0c 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -34,6 +34,10 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
 
+extern const struct mxs_gpmi_nfc_data mx28_gpmi_nfc_data __initconst;
+#define mx28_add_gpmi_nfc(pdata)	\
+	mxs_add_gpmi_nfc(pdata, &mx28_gpmi_nfc_data)
+
 extern const struct mxs_mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
 #define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
 
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index acf9eea..b42a14b 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -12,6 +12,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
 
+config MXS_HAVE_PLATFORM_GPMI_NFC
+	bool
+
 config MXS_HAVE_PLATFORM_MXS_I2C
 	bool
 
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 351915c..972abdc 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_GPMI_NFC) += platform-gpmi-nfc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
diff --git a/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c b/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
new file mode 100644
index 0000000..ae88672
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
@@ -0,0 +1,90 @@
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
+
+#define RES_MEM(soc, _id, _s, _n)				\
+	{							\
+		.start = soc ##_## _id ## _BASE_ADDR,		\
+		.end   = soc ##_## _id ## _BASE_ADDR + (_s) - 1,\
+		.name  = (_n),					\
+		.flags = IORESOURCE_MEM,			\
+	}
+
+#define RES_IRQ(soc, _id, _n)			\
+	{					\
+		.start = soc ##_INT_## _id,	\
+		.end   = soc ##_INT_## _id,	\
+		.name  = (_n),			\
+		.flags = IORESOURCE_IRQ,	\
+	}
+
+#define RES_DMA(soc, _i_s, _i_e, _n)		\
+	{					\
+		.start = soc ##_## _i_s,	\
+		.end   = soc ##_## _i_e,	\
+		.name  = (_n),			\
+		.flags = IORESOURCE_DMA,	\
+	}
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_gpmi_nfc_data mx23_gpmi_nfc_data __initconst = {
+	.devid = "imx23-gpmi-nfc",
+	.res = {
+		/* GPMI */
+		RES_MEM(MX23, GPMI, SZ_8K, GPMI_NFC_GPMI_REGS_ADDR_RES_NAME),
+		RES_IRQ(MX23, GPMI_ATTENTION, GPMI_NFC_GPMI_INTERRUPT_RES_NAME),
+		/* BCH */
+		RES_MEM(MX23, BCH, SZ_8K, GPMI_NFC_BCH_REGS_ADDR_RES_NAME),
+		RES_IRQ(MX23, BCH, GPMI_NFC_BCH_INTERRUPT_RES_NAME),
+		/* DMA */
+		RES_DMA(MX23, DMA_GPMI0, DMA_GPMI3,
+					GPMI_NFC_DMA_CHANNELS_RES_NAME),
+		RES_IRQ(MX23, GPMI_DMA, GPMI_NFC_DMA_INTERRUPT_RES_NAME),
+	},
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_gpmi_nfc_data mx28_gpmi_nfc_data __initconst = {
+	.devid = "imx28-gpmi-nfc",
+	.res = {
+		/* GPMI */
+		RES_MEM(MX28, GPMI, SZ_8K, GPMI_NFC_GPMI_REGS_ADDR_RES_NAME),
+		RES_IRQ(MX28, GPMI, GPMI_NFC_GPMI_INTERRUPT_RES_NAME),
+		/* BCH */
+		RES_MEM(MX28, BCH, SZ_8K, GPMI_NFC_BCH_REGS_ADDR_RES_NAME),
+		RES_IRQ(MX28, BCH, GPMI_NFC_BCH_INTERRUPT_RES_NAME),
+		/* DMA */
+		RES_DMA(MX28, DMA_GPMI0, DMA_GPMI7,
+					GPMI_NFC_DMA_CHANNELS_RES_NAME),
+		RES_IRQ(MX28, GPMI_DMA, GPMI_NFC_DMA_INTERRUPT_RES_NAME),
+	},
+};
+#endif
+
+struct platform_device *__init
+mxs_add_gpmi_nfc(const struct gpmi_nfc_platform_data *pdata,
+		const struct mxs_gpmi_nfc_data *data)
+{
+	return mxs_add_platform_device_dmamask(data->devid, -1,
+				data->res, RES_SIZE,
+				pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 812d7a8..e032120 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -66,6 +66,16 @@ struct platform_device *__init mxs_add_flexcan(
 		const struct mxs_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
 
+/* gpmi-nfc */
+#include <mach/gpmi-nfc.h>
+struct mxs_gpmi_nfc_data {
+	const char *devid;
+	const struct resource res[RES_SIZE];
+};
+struct platform_device *__init
+mxs_add_gpmi_nfc(const struct gpmi_nfc_platform_data *pdata,
+		const struct mxs_gpmi_nfc_data *data);
+
 /* i2c */
 struct mxs_mxs_i2c_data {
 	int id;
diff --git a/arch/arm/mach-mxs/include/mach/gpmi-nfc.h b/arch/arm/mach-mxs/include/mach/gpmi-nfc.h
new file mode 100644
index 0000000..eda8192
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/gpmi-nfc.h
@@ -0,0 +1,71 @@
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
+#ifndef __MACH_MXS_GPMI_NFC_H__
+#define __MACH_MXS_GPMI_NFC_H__
+
+/* The size of the resource is fixed. */
+#define RES_SIZE	6
+
+/* Resource names for the GPMI NFC driver. */
+#define GPMI_NFC_GPMI_REGS_ADDR_RES_NAME  "GPMI NFC GPMI Registers"
+#define GPMI_NFC_GPMI_INTERRUPT_RES_NAME  "GPMI NFC GPMI Interrupt"
+#define GPMI_NFC_BCH_REGS_ADDR_RES_NAME   "GPMI NFC BCH Registers"
+#define GPMI_NFC_BCH_INTERRUPT_RES_NAME   "GPMI NFC BCH Interrupt"
+#define GPMI_NFC_DMA_CHANNELS_RES_NAME    "GPMI NFC DMA Channels"
+#define GPMI_NFC_DMA_INTERRUPT_RES_NAME   "GPMI NFC DMA Interrupt"
+
+/**
+ * struct gpmi_nfc_platform_data - GPMI NFC driver platform data.
+ *
+ * This structure communicates platform-specific information to the GPMI NFC
+ * driver that can't be expressed as resources.
+ *
+ * @platform_init:           A pointer to a function the driver will call to
+ *                           initialize the platform (e.g., set up the pin mux).
+ * @platform_exit:           A pointer to a function the driver will call to
+ *                           exit the platform (e.g., free pins).
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
+struct gpmi_nfc_platform_data {
+	/* SoC hardware information. */
+	int		(*platform_init)(void);
+	void		(*platform_exit)(void);
+
+	/* NAND Flash information. */
+	unsigned int	min_prop_delay_in_ns;
+	unsigned int	max_prop_delay_in_ns;
+	unsigned int	max_chip_count;
+
+	/* Medium information. */
+	struct mtd_partition *partitions;
+	unsigned	partition_count;
+};
+#endif
-- 
1.7.0.4
