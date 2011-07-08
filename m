From: b32955@freescale.com (Huang Shijie)
Date: Fri, 08 Jul 2011 18:24:52 -0000
Subject: [PATCH v5 1/4] ARM: add GPMI support for imx23/imx28
In-Reply-To: <1302675881-18862-1-git-send-email-b32955@freescale.com>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
Message-ID: <1302675881-18862-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the clock and iomux initialization for GPMI in the imx23 and imx28.
and register the gpmi driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    3 +
 arch/arm/mach-mxs/clock-mx28.c                  |    3 +
 arch/arm/mach-mxs/devices-mx23.h                |    3 +
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi.c       |  134 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
 arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   65 +++++++++++
 arch/arm/mach-mxs/mach-mx23evk.c                |   37 ++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   37 ++++++
 12 files changed, 295 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
 create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4f6f174..e034666 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -22,6 +22,7 @@ config MACH_MX23EVK
 	select SOC_IMX23
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
+	select MXS_HAVE_PLATFORM_GPMI
 	select MXS_HAVE_PLATFORM_MXSFB
 	default y
 	help
@@ -35,6 +36,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
 	select MXS_HAVE_PLATFORM_FLEXCAN
+	select MXS_HAVE_PLATFORM_GPMI
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_OCOTP
 	default y
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index d133c7f..f3c9653 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -29,6 +29,7 @@
 #include <mach/mx23.h>
 #include <mach/common.h>
 #include <mach/clock.h>
+#include <mach/gpmi-nfc.h>
 
 #include "regs-clkctrl-mx23.h"
 
@@ -442,6 +443,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
 	/* for amba-pl011 driver */
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
+	_REGISTER_CLOCK(GPMI_NFC_DRIVER_MX23, NULL, gpmi_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
@@ -533,6 +535,7 @@ int __init mx23_clocks_init(void)
 	clk_enable(&xbus_clk);
 	clk_enable(&emi_clk);
 	clk_enable(&uart_clk);
+	clk_enable(&gpmi_clk);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5e489a2..7868d42 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -29,6 +29,7 @@
 #include <mach/mx28.h>
 #include <mach/common.h>
 #include <mach/clock.h>
+#include <mach/gpmi-nfc.h>
 
 #include "regs-clkctrl-mx28.h"
 
@@ -607,6 +608,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
 	/* for amba-pl011 driver */
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
+	_REGISTER_CLOCK(GPMI_NFC_DRIVER_MX28, NULL, gpmi_clk)
 	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
@@ -749,6 +751,7 @@ int __init mx28_clocks_init(void)
 	clk_enable(&xbus_clk);
 	clk_enable(&emi_clk);
 	clk_enable(&uart_clk);
+	clk_enable(&gpmi_clk);
 
 	clk_set_parent(&lcdif_clk, &ref_pix_clk);
 
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index c7e14f4..349fb1d 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -16,6 +16,9 @@ extern const struct amba_device mx23_duart_device __initconst;
 #define mx23_add_duart() \
 	mxs_add_duart(&mx23_duart_device)
 
+extern const struct gpmi_nfc_platform_data gpmi_platform_data_imx23 __initconst;
+#define mx23_add_gpmi() mxs_add_gpmi(&gpmi_platform_data_imx23)
+
 extern const struct mxs_auart_data mx23_auart_data[] __initconst;
 #define mx23_add_auart(id)	mxs_add_auart(&mx23_auart_data[id])
 #define mx23_add_auart0()		mx23_add_auart(0)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 9d08555..ed6427b 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -16,6 +16,9 @@ extern const struct amba_device mx28_duart_device __initconst;
 #define mx28_add_duart() \
 	mxs_add_duart(&mx28_duart_device)
 
+extern const struct gpmi_nfc_platform_data gpmi_platform_data_imx28 __initconst;
+#define	mx28_add_gpmi()	mxs_add_gpmi(&gpmi_platform_data_imx28)
+
 extern const struct mxs_auart_data mx28_auart_data[] __initconst;
 #define mx28_add_auart(id)	mxs_add_auart(&mx28_auart_data[id])
 #define mx28_add_auart0()		mx28_add_auart(0)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 1451ad0..81e99ce 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -5,6 +5,9 @@ config MXS_HAVE_AMBA_DUART
 config MXS_HAVE_PLATFORM_AUART
 	bool
 
+config MXS_HAVE_PLATFORM_GPMI
+	bool
+
 config MXS_HAVE_PLATFORM_FEC
 	bool
 
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 0d9bea3..8a7c2c8 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_GPMI) += platform-gpmi.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
diff --git a/arch/arm/mach-mxs/devices/platform-gpmi.c b/arch/arm/mach-mxs/devices/platform-gpmi.c
new file mode 100644
index 0000000..74ebe22
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-gpmi.c
@@ -0,0 +1,134 @@
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
+#include <mach/gpmi-nfc.h>
+#include <mach/devices-common.h>
+
+#ifdef CONFIG_SOC_IMX23
+const struct gpmi_nfc_platform_data  gpmi_platform_data_imx23 __initconst = {
+	.min_prop_delay_in_ns	= 5,
+	.max_prop_delay_in_ns	= 9,
+	.max_chip_count		= 1,
+};
+
+const struct resource res_imx23[] __initconst = {
+	{	/* GPMI */
+		.start = MX23_GPMI_BASE_ADDR,
+		.end   = MX23_GPMI_BASE_ADDR + SZ_8K - 1,
+		.name  = GPMI_NFC_GPMI_REGS_ADDR_RES_NAME,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = MX23_INT_GPMI_ATTENTION,
+		.end   = MX23_INT_GPMI_ATTENTION,
+		.name  = GPMI_NFC_GPMI_INTERRUPT_RES_NAME,
+		.flags = IORESOURCE_IRQ,
+	}, {	/* BCH */
+		.start = MX23_BCH_BASE_ADDR,
+		.end   = MX23_BCH_BASE_ADDR + SZ_8K - 1,
+		.name  = GPMI_NFC_BCH_REGS_ADDR_RES_NAME,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = MX23_INT_BCH,
+		.end   = MX23_INT_BCH,
+		.name  = GPMI_NFC_BCH_INTERRUPT_RES_NAME,
+		.flags = IORESOURCE_IRQ,
+	}, {	/* DMA */
+		.start	= MX23_DMA_GPMI0,
+		.end	= MX23_DMA_GPMI3,
+		.name  = GPMI_NFC_DMA_CHANNELS_RES_NAME,
+		.flags = IORESOURCE_DMA,
+	}, {
+		.start = MX23_INT_GPMI_DMA,
+		.end   = MX23_INT_GPMI_DMA,
+		.name  = GPMI_NFC_DMA_INTERRUPT_RES_NAME,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct gpmi_nfc_platform_data  gpmi_platform_data_imx28 __initconst = {
+	.min_prop_delay_in_ns	= 5,
+	.max_prop_delay_in_ns	= 9,
+	.max_chip_count		= 1,
+};
+
+const struct resource res_imx28[] __initconst = {
+	{	/* GPMI */
+		.start = MX28_GPMI_BASE_ADDR,
+		.end   = MX28_GPMI_BASE_ADDR + SZ_8K - 1,
+		.name  = GPMI_NFC_GPMI_REGS_ADDR_RES_NAME,
+		.flags = IORESOURCE_MEM,
+	 }, {
+		.start = MX28_INT_GPMI,
+		.end   = MX28_INT_GPMI,
+		.name  = GPMI_NFC_GPMI_INTERRUPT_RES_NAME,
+		.flags = IORESOURCE_IRQ,
+	}, {	/* BCH */
+		.start = MX28_BCH_BASE_ADDR,
+		.end   = MX28_BCH_BASE_ADDR + SZ_8K - 1,
+		.name  = GPMI_NFC_BCH_REGS_ADDR_RES_NAME,
+		.flags = IORESOURCE_MEM,
+	 }, {
+		.start = MX28_INT_BCH,
+		.end   = MX28_INT_BCH,
+		.name  = GPMI_NFC_BCH_INTERRUPT_RES_NAME,
+		.flags = IORESOURCE_IRQ,
+	 }, {	/* DMA */
+		.start	= MX28_DMA_GPMI0,
+		.end	= MX28_DMA_GPMI7,
+		.name	= GPMI_NFC_DMA_CHANNELS_RES_NAME,
+		.flags	= IORESOURCE_DMA,
+	 }, {
+		.start = MX28_INT_GPMI_DMA,
+		.end   = MX28_INT_GPMI_DMA,
+		.name  = GPMI_NFC_DMA_INTERRUPT_RES_NAME,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+#endif
+
+struct platform_device *__init
+mxs_add_gpmi(const struct gpmi_nfc_platform_data *data)
+{
+	const struct resource *res;
+	int res_size;
+	const char *name = NULL;
+
+#ifdef CONFIG_SOC_IMX23
+	if (cpu_is_mx23()) {
+		res_size = ARRAY_SIZE(res_imx23);
+		res = res_imx23;
+		name = GPMI_NFC_DRIVER_MX23;
+	}
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+	if (cpu_is_mx28()) {
+		res_size = ARRAY_SIZE(res_imx28);
+		res = res_imx28;
+		name = GPMI_NFC_DRIVER_MX28;
+	}
+#endif
+
+	return mxs_add_platform_device_dmamask(name, -1,
+				res, res_size,
+				data, sizeof(*data), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 71f2448..1f05503 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -30,6 +30,10 @@ int __init mxs_add_amba_device(const struct amba_device *dev);
 /* duart */
 int __init mxs_add_duart(const struct amba_device *dev);
 
+/* GPMI */
+#include <mach/gpmi-nfc.h>
+struct platform_device *__init mxs_add_gpmi(
+				const struct gpmi_nfc_platform_data *data);
 /* auart */
 struct mxs_auart_data {
 	int id;
diff --git a/arch/arm/mach-mxs/include/mach/gpmi-nfc.h b/arch/arm/mach-mxs/include/mach/gpmi-nfc.h
new file mode 100644
index 0000000..cf8e8c3
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/gpmi-nfc.h
@@ -0,0 +1,65 @@
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
+#ifndef __INCLUDE_LINUX_DEVICE_H
+#define __INCLUDE_LINUX_DEVICE_H
+
+#define GPMI_NFC_DRIVER_NAME	"gpmi-nfc"
+#define GPMI_NFC_DRIVER_MX23	"gpmi-nfc-mx23"
+#define GPMI_NFC_DRIVER_MX28	"gpmi-nfc-mx28"
+#define GPMI_NFC_DRIVER_MX50	"gpmi-nfc-mx508"
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
+	/* NAND Flash information. */
+	unsigned int          min_prop_delay_in_ns;
+	unsigned int          max_prop_delay_in_ns;
+	unsigned int          max_chip_count;
+
+	/* soc */
+	struct mtd_partition  *partitions;
+	unsigned              partition_count;
+};
+#endif
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index a66994f..db715f9 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -34,6 +34,42 @@ static const iomux_cfg_t mx23evk_pads[] __initconst = {
 	MX23_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
 	MX23_PAD_PWM1__DUART_TX | MXS_PAD_CTRL,
 
+	/* gpmi */
+	MX23_PAD_GPMI_D00__GPMI_D00 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D01__GPMI_D01 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D02__GPMI_D02 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D03__GPMI_D03 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D04__GPMI_D04 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D05__GPMI_D05 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D06__GPMI_D06 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_D07__GPMI_D07 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_CLE__GPMI_CLE |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_ALE__GPMI_ALE |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_WPN__GPMI_WPN |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_WRN__GPMI_WRN |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_RDN__GPMI_RDN |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_RDY0__GPMI_RDY0 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_RDY1__GPMI_RDY1 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_CE0N__GPMI_CE0N |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_GPMI_CE1N__GPMI_CE1N |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
 	/* auart */
 	MX23_PAD_AUART1_RX__AUART1_RX | MXS_PAD_CTRL,
 	MX23_PAD_AUART1_TX__AUART1_TX | MXS_PAD_CTRL,
@@ -108,6 +144,7 @@ static void __init mx23evk_init(void)
 	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
 
 	mx23_add_duart();
+	mx23_add_gpmi();
 	mx23_add_auart0();
 
 	ret = gpio_request_one(MX23EVK_LCD_ENABLE, GPIOF_DIR_OUT, "lcd-enable");
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 08002d0..cf8ddcb 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -39,6 +39,42 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	MX28_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
 	MX28_PAD_PWM1__DUART_TX | MXS_PAD_CTRL,
 
+	/* gpmi */
+	MX28_PAD_GPMI_D00__GPMI_D0 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D01__GPMI_D1 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D02__GPMI_D2 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D03__GPMI_D3 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D04__GPMI_D4 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D05__GPMI_D5 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D06__GPMI_D6 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D07__GPMI_D7 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_CE0N__GPMI_CE0N |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_CE1N__GPMI_CE1N |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_RDY0__GPMI_READY0 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_RDY1__GPMI_READY1 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_RDN__GPMI_RDN |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_WRN__GPMI_WRN |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_ALE__GPMI_ALE |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_CLE__GPMI_CLE |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_RESETN__GPMI_RESETN |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
 	/* auart0 */
 	MX28_PAD_AUART0_RX__AUART0_RX | MXS_PAD_CTRL,
 	MX28_PAD_AUART0_TX__AUART0_TX | MXS_PAD_CTRL,
@@ -265,6 +301,7 @@ static void __init mx28evk_init(void)
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
+	mx28_add_gpmi();
 	mx28_add_auart0();
 	mx28_add_auart3();
 
-- 
1.7.0.4



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
