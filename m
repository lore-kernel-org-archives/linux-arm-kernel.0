From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:15 +0200
Subject: [PATCH 39/40] ARM: mx5: dynamically register mxc-nand device
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-39-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/devices-imx51.h               |    4 ++++
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   23 ++++++++++++++++++++++-
 arch/arm/plat-mxc/include/mach/devices-common.h |    7 +++++++
 arch/arm/plat-mxc/include/mach/mx51.h           |    2 +-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 782b45b..41d93c3 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -21,6 +21,10 @@ extern const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst;
 #define imx51_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx51_imx_uart_data[id], pdata)
 
+extern const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst;
+#define imx51_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand(&imx51_mxc_nand_data, pdata)
+
 extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
 #define imx51_add_cspi(pdata)	\
 	imx_add_spi_imx(&imx51_cspi_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index 6d3a478..3fdcc32e 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -17,6 +17,15 @@
 		.irq = soc ## _INT_NFC					\
 	}
 
+#define imx_mxc_nandv3_data_entry_single(soc, _size)			\
+	{								\
+		.id = -1,						\
+		.iobase = soc ## _NFC_BASE_ADDR,			\
+		.iosize = _size,					\
+		.axibase = soc ## _NFC_AXI_BASE_ADDR,			\
+		.irq = soc ## _INT_NFC					\
+	}
+
 #ifdef CONFIG_SOC_IMX21
 const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX21, SZ_4K);
@@ -42,12 +51,22 @@ const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX35, SZ_8K);
 #endif
 
+#ifdef CONFIG_ARCH_MX51
+const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst =
+	imx_mxc_nandv3_data_entry_single(MX51, SZ_16K);
+#endif
+
 struct platform_device *__init imx_add_mxc_nand(
 		const struct imx_mxc_nand_data *data,
 		const struct mxc_nand_platform_data *pdata)
 {
+	/* AXI has to come first, that's how the mxc_nand driver expect it */
 	struct resource res[] = {
 		{
+			.start = data->axibase,
+			.end = data->axibase + SZ_16K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
 			.start = data->iobase,
 			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
@@ -57,6 +76,8 @@ struct platform_device *__init imx_add_mxc_nand(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-	return imx_add_platform_device("mxc_nand", 0, res, ARRAY_SIZE(res),
+	return imx_add_platform_device("mxc_nand", data->id,
+			res + !data->axibase,
+			ARRAY_SIZE(res) - !data->axibase,
 			pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 371336e..f87aa1a 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -71,8 +71,15 @@ struct platform_device *__init imx_add_imx_uart_1irq(
 
 #include <mach/mxc_nand.h>
 struct imx_mxc_nand_data {
+	/*
+	 * id is traditionally 0, but -1 is more appropriate.  We use -1 for new
+	 * machines but don't change existing devices as the nand device usually
+	 * appears in the kernel command line to pass its partitioning.
+	 */
+	int id;
 	resource_size_t iobase;
 	resource_size_t iosize;
+	resource_size_t axibase;
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_mxc_nand(
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index b47d65b..c99eeab 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -287,7 +287,7 @@
 #define MX51_MXC_INT_RESV5		5
 #define MX51_MXC_INT_SDMA		6
 #define MX51_MXC_INT_IOMUX		7
-#define MX51_MXC_INT_NFC		8
+#define MX51_INT_NFC			8
 #define MX51_MXC_INT_VPU		9
 #define MX51_MXC_INT_IPU_ERR		10
 #define MX51_MXC_INT_IPU_SYN		11
-- 
1.7.2.3
