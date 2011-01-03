From: iban@fqingenieria.es (FQ | Iban Cerro)
Date: Mon, 3 Jan 2011 10:11:14 +0100 (CET)
Subject: [PATCH 03/04] ARM i.MX25 Add SIM Device
Message-ID: <40784.212.121.242.58.1294045874.squirrel@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds SIM device to MX25 platform

Signed-off-by: Iban Cerro Galvez <iban@fqingenieria.es>
---
 arch/arm/mach-imx/devices-imx25.h               |    7 +++
 arch/arm/plat-mxc/devices/Kconfig               |    4 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_sim.c    |   51
+++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   11 +++++
 arch/arm/plat-mxc/include/mach/iomux-mx25.h     |   12 +++++
 arch/arm/plat-mxc/include/mach/mx25.h           |    9 ++++
 7 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_sim.c

diff --git a/arch/arm/mach-imx/devices-imx25.h
b/arch/arm/mach-imx/devices-imx25.h
index bde33ca..dd33c6c 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -85,3 +85,10 @@ extern const struct imx_spi_imx_data imx25_cspi_data[]
__initconst;
 #define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
 #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
 #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
+
+extern const struct imx_mxc_sim_data imx25_mxc_sim_data[] __initconst;
+#define imx25_add_mxc_sim(id, pdata)	\
+		imx_add_mxc_sim(&imx25_mxc_sim_data[id], pdata)
+#define imx25_add_mxc_sim0(pdata)	imx25_add_mxc_sim(0, pdata)
+#define imx25_add_mxc_sim1(pdata)	imx25_add_mxc_sim(1, pdata)
+
diff --git a/arch/arm/plat-mxc/devices/Kconfig
b/arch/arm/plat-mxc/devices/Kconfig
index 2537166..708f19c 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -71,3 +71,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX

 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
+
+config IMX_HAVE_PLATFORM_MXC_SIM
+	bool
+	default y if ARCH_MX25
\ No newline at end of file
diff --git a/arch/arm/plat-mxc/devices/Makefile
b/arch/arm/plat-mxc/devices/Makefile
index 75cd2ec..c8da5d3 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) +=
platform-mxc_rnga.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) +=
platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_SIM) +=  platform-mxc_sim.o
\ No newline at end of file
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_sim.c
b/arch/arm/plat-mxc/devices/platform-mxc_sim.c
new file mode 100644
index 0000000..51d6679
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_sim.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_mxc_sim_data_entry_single(soc, _id, _hwid, _size)			\
+	{								\
+		.id = _id,     \
+		.iobase = soc ## _SIM ## _hwid ## _BASE_ADDR,			\
+		.iosize = _size,	\
+		.irq = soc ## _INT_SIM ## _hwid,	\
+	}
+
+#define imx_mxc_sim_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = imx_mxc_sim_data_entry_single(soc, _id, _hwid, _size)
+
+
+#ifdef CONFIG_SOC_IMX25
+const struct imx_mxc_sim_data imx25_mxc_sim_data[] __initconst = {
+#define imx25_mxc_sim_data_entry(_id, _hwid)  \
+		imx_mxc_sim_data_entry(MX25, _id, _hwid, SZ_16K)
+		imx25_mxc_sim_data_entry(0, 1),
+		imx25_mxc_sim_data_entry(1, 2),
+};
+
+#endif /* ifdef CONFIG_SOC_IMX25  */
+
+
+struct platform_device *__init imx_add_mxc_sim(
+		const struct imx_mxc_sim_data *data,
+		const struct mxc_sim_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+	return imx_add_platform_device("mxc_sim", data->id,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
+
+
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h
b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..92b83f0 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -264,3 +264,14 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
+
+#include <mach/mxc_sim.h>
+struct imx_mxc_sim_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	int irq;
+};
+struct platform_device *__init imx_add_mxc_sim(
+		const struct imx_mxc_sim_data *data,
+		const struct mxc_sim_platform_data *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index d7f52c9..ecd6b16 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -262,40 +262,52 @@
 #define MX25_PAD_CSI_D2__CSI_D2		IOMUX_PAD(0x318, 0x120, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D2__UART5_RXD_MUX	IOMUX_PAD(0x318, 0x120, 0x11,
0x578, 1, NO_PAD_CTRL)
 #define MX25_PAD_CSI_D2__GPIO_1_27	IOMUX_PAD(0x318, 0x120, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D2__SIM1_CLK0	IOMUX_PAD(0x318, 0x120, 0x04, 0, 0,
NO_PAD_CTRL)

 #define MX25_PAD_CSI_D3__CSI_D3		IOMUX_PAD(0x31c, 0x124, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D3__GPIO_1_28	IOMUX_PAD(0x31c, 0x124, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D3__SIM1_RST0  IOMUX_PAD(0x31c, 0x124, 0x04, 0, 0,
NO_PAD_CTRL)

 #define MX25_PAD_CSI_D4__CSI_D4		IOMUX_PAD(0x320, 0x128, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D4__UART5_RTS	IOMUX_PAD(0x320, 0x128, 0x11, 0x574,
1, NO_PAD_CTRL)
 #define MX25_PAD_CSI_D4__GPIO_1_29	IOMUX_PAD(0x320, 0x128, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D4__SIM1_VEN0	IOMUX_PAD(0x320, 0x128, 0x04, 0, 0,
NO_PAD_CTRL)

 #define MX25_PAD_CSI_D5__CSI_D5		IOMUX_PAD(0x324, 0x12c, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D5__GPIO_1_30	IOMUX_PAD(0x324, 0x12c, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D5__SIM1_TX0	 IOMUX_PAD(0x324, 0x12c, 0x04, 0, 0,
PAD_CTL_SRE_FAST)

 #define MX25_PAD_CSI_D6__CSI_D6		IOMUX_PAD(0x328, 0x130, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D6__GPIO_1_31	IOMUX_PAD(0x328, 0x130, 0x15, 0, 0,
NO_PAD_CTRL)

 #define MX25_PAD_CSI_D7__CSI_D7		IOMUX_PAD(0x32c, 0x134, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D7__GPIO_1_6	IOMUX_PAD(0x32c, 0x134, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D7__GPIO_1_6_PD IOMUX_PAD(0x32c, 0x134, 0x15, 0, 0,
PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_DOWN)

 #define MX25_PAD_CSI_D8__CSI_D8		IOMUX_PAD(0x330, 0x138, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D8__GPIO_1_7	IOMUX_PAD(0x330, 0x138, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D8__SIM2_CLK0	IOMUX_PAD(0x330, 0x138, 0x04, 0, 0,
NO_PAD_CTRL)

 #define MX25_PAD_CSI_D9__CSI_D9		IOMUX_PAD(0x334, 0x13c, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_D9__GPIO_4_21	IOMUX_PAD(0x334, 0x13c, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_D9__SIM2_RST0	IOMUX_PAD(0x334, 0x13c, 0x04, 0, 0,
NO_PAD_CTRL)

 #define MX25_PAD_CSI_MCLK__CSI_MCLK	IOMUX_PAD(0x338, 0x140, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_MCLK__GPIO_1_8	IOMUX_PAD(0x338, 0x140, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_MCLK__SIM2_VEN0 IOMUX_PAD(0x338, 0x140, 0x04, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_MCLK__GPIO_1_8_PD IOMUX_PAD(0x338, 0x140, 0x15, 0,
0, PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_DOWN)

 #define MX25_PAD_CSI_VSYNC__CSI_VSYNC	IOMUX_PAD(0x33c, 0x144, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_VSYNC__GPIO_1_9	IOMUX_PAD(0x33c, 0x144, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_VSYNC__SIM2_TX0   IOMUX_PAD(0x33c, 0x144, 0x04, 0,
0, PAD_CTL_SRE_FAST)

 #define MX25_PAD_CSI_HSYNC__CSI_HSYNC	IOMUX_PAD(0x340, 0x148, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_CSI_HSYNC__GPIO_1_10	IOMUX_PAD(0x340, 0x148, 0x15, 0, 0,
NO_PAD_CTRL)
+#define MX25_PAD_CSI_HSYNC__GPIO_1_10_PD	IOMUX_PAD(0x340, 0x148,0x15, 0,
0, PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_DOWN)

 #define MX25_PAD_CSI_PIXCLK__CSI_PIXCLK	IOMUX_PAD(0x344, 0x14c, 0x10, 0,
0, NO_PAD_CTRL)
 #define MX25_PAD_CSI_PIXCLK__GPIO_1_11	IOMUX_PAD(0x344, 0x14c, 0x15, 0,
0, NO_PAD_CTRL)
+#define MX25_PAD_CSI_PIXCLK__GPIO_1_11_PD	IOMUX_PAD(0x344, 0x14c, 0x15,
0, 0, PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_DOWN)

 #define MX25_PAD_I2C1_CLK__I2C1_CLK	IOMUX_PAD(0x348, 0x150, 0x10, 0, 0,
NO_PAD_CTRL)
 #define MX25_PAD_I2C1_CLK__GPIO_1_12	IOMUX_PAD(0x348, 0x150, 0x15, 0, 0,
NO_PAD_CTRL)
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h
b/arch/arm/plat-mxc/include/mach/mx25.h
index 087cd7a..5ddaed0 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -37,6 +37,8 @@

 #define MX25_CSPI3_BASE_ADDR		0x50004000
 #define MX25_CSPI2_BASE_ADDR		0x50010000
+#define MX25_SIM1_BASE_ADDR		0x50024000
+#define MX25_SIM2_BASE_ADDR		0x50028000
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_SSI2_BASE_ADDR		0x50014000
 #define MX25_SSI1_BASE_ADDR		0x50034000
@@ -57,6 +59,11 @@
 #define MX25_USB_HS_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0400)
 #define MX25_CSI_BASE_ADDR		0x53ff8000

+#define MX25_CS0_BASE_ADDR		0xa0000000
+#define MX25_CS1_BASE_ADDR		0xa8000000
+#define MX25_CS2_BASE_ADDR		0xb0000000
+#define MX25_CS3_BASE_ADDR		0xb2000000
+
 #define MX25_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX25_IO_ADDRESS(x)		IOMEM(MX25_IO_P2V(x))

@@ -74,6 +81,8 @@
 #define MX25_INT_GPIO3		16
 #define MX25_INT_CSI		17
 #define MX25_INT_UART3		18
+#define MX25_INT_SIM1		20
+#define MX25_INT_SIM2		21
 #define MX25_INT_GPIO4		23
 #define MX25_INT_KPP		24
 #define MX25_INT_DRYICE		25
-- 
1.5.4.3
