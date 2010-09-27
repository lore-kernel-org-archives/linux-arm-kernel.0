From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:14 +0200
Subject: [PATCH 38/40] ARM: imx: reorganize nand registration to use a struct
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-38-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addiontionally make the interrupt #defines match the base address
defines MX.._NFC_BASE_ADDR.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx21.h               |    3 +-
 arch/arm/mach-imx/devices-imx27.h               |    3 +-
 arch/arm/mach-mx25/devices-imx25.h              |    3 +-
 arch/arm/mach-mx3/devices-imx31.h               |    3 +-
 arch/arm/mach-mx3/devices-imx35.h               |    3 +-
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   64 ++++++++++++++--------
 arch/arm/plat-mxc/include/mach/devices-common.h |   12 +++--
 arch/arm/plat-mxc/include/mach/mx21.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx25.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx27.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx31.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx35.h           |    2 +-
 12 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 4795d70..d189039 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -25,8 +25,9 @@ extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst;
 #define imx21_add_imx_uart2(pdata)	imx21_add_imx_uart(2, pdata)
 #define imx21_add_imx_uart3(pdata)	imx21_add_imx_uart(3, pdata)
 
+extern const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst;
 #define imx21_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
+	imx_add_mxc_nand(&imx21_mxc_nand_data, pdata)
 
 extern const struct imx_spi_imx_data imx21_cspi_data[] __initconst;
 #define imx21_add_cspi(id, pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 1765521..e11606b 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -27,8 +27,9 @@ extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst;
 #define imx27_add_imx_uart4(pdata)	imx27_add_imx_uart(4, pdata)
 #define imx27_add_imx_uart5(pdata)	imx27_add_imx_uart(5, pdata)
 
+extern const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst;
 #define imx27_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
+	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
 
 extern const struct imx_spi_imx_data imx27_cspi_data[] __initconst;
 #define imx27_add_cspi(id, pdata)	\
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 1dd9572..eab19c0 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -34,8 +34,9 @@ extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
 #define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
 #define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
 
+extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
 #define imx25_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
+	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
 
 extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
 #define imx25_add_spi_imx(id, pdata)	\
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index eea425f..de95985 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -29,8 +29,9 @@ extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
 #define imx31_add_imx_uart3(pdata)	imx31_add_imx_uart(3, pdata)
 #define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
 
+extern const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst;
 #define imx31_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
+	imx_add_mxc_nand(&imx31_mxc_nand_data, pdata)
 
 extern const struct imx_spi_imx_data imx31_cspi_data[] __initconst;
 #define imx31_add_cspi(id, pdata)	\
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index f187d35..56404de 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -32,8 +32,9 @@ extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst;
 #define imx35_add_imx_uart1(pdata)	imx35_add_imx_uart(1, pdata)
 #define imx35_add_imx_uart2(pdata)	imx35_add_imx_uart(2, pdata)
 
+extern const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst;
 #define imx35_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
+	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
 
 extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
 #define imx35_add_cspi(id, pdata)	\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index 1c28641..6d3a478 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -7,38 +7,56 @@
  * Free Software Foundation.
  */
 #include <asm/sizes.h>
+#include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-static struct platform_device *__init imx_add_mxc_nand(resource_size_t iobase,
-		int irq, const struct mxc_nand_platform_data *pdata,
-		resource_size_t iosize)
+#define imx_mxc_nand_data_entry_single(soc, _size)			\
+	{								\
+		.iobase = soc ## _NFC_BASE_ADDR,			\
+		.iosize = _size,					\
+		.irq = soc ## _INT_NFC					\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst =
+	imx_mxc_nand_data_entry_single(MX21, SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst =
+	imx_mxc_nand_data_entry_single(MX25, SZ_8K);
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst =
+	imx_mxc_nand_data_entry_single(MX27, SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+#ifdef CONFIG_ARCH_MX31
+const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst =
+	imx_mxc_nand_data_entry_single(MX31, SZ_4K);
+#endif
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst =
+	imx_mxc_nand_data_entry_single(MX35, SZ_8K);
+#endif
+
+struct platform_device *__init imx_add_mxc_nand(
+		const struct imx_mxc_nand_data *data,
+		const struct mxc_nand_platform_data *pdata)
 {
-	static int id = 0;
-	
 	struct resource res[] = {
 		{
-			.start = iobase,
-			.end = iobase + iosize - 1,
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
-			.start = irq,
-			.end = irq,
+			.start = data->irq,
+			.end = data->irq,
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-
-	return imx_add_platform_device("mxc_nand", id++, res, ARRAY_SIZE(res),
+	return imx_add_platform_device("mxc_nand", 0, res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata));
 }
-
-struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
-		int irq, const struct mxc_nand_platform_data *pdata)
-{
-	return imx_add_mxc_nand(iobase, irq, pdata, SZ_4K);
-}
-
-struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
-		int irq, const struct mxc_nand_platform_data *pdata)
-{
-	return imx_add_mxc_nand(iobase, irq, pdata, SZ_8K);
-}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 32b8f36..371336e 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -70,10 +70,14 @@ struct platform_device *__init imx_add_imx_uart_1irq(
 		const struct imxuart_platform_data *pdata);
 
 #include <mach/mxc_nand.h>
-struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
-		int irq, const struct mxc_nand_platform_data *pdata);
-struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
-		int irq, const struct mxc_nand_platform_data *pdata);
+struct imx_mxc_nand_data {
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_mxc_nand(
+		const struct imx_mxc_nand_data *data,
+		const struct mxc_nand_platform_data *pdata);
 
 #include <mach/spi.h>
 struct imx_spi_imx_data {
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index ed98b9c..8bc5972 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -120,7 +120,7 @@
 #define MX21_INT_GPT1		26
 #define MX21_INT_WDOG		27
 #define MX21_INT_PCMCIA		28
-#define MX21_INT_NANDFC		29
+#define MX21_INT_NFC		29
 #define MX21_INT_BMI		30
 #define MX21_INT_CSI		31
 #define MX21_INT_DMACH0		32
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 8f809eb..a9e1095 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -69,7 +69,7 @@
 #define MX25_INT_KPP		24
 #define MX25_INT_DRYICE		25
 #define MX25_INT_UART2		32
-#define MX25_INT_NANDFC		33
+#define MX25_INT_NFC		33
 #define MX25_INT_LCDC		39
 #define MX25_INT_UART5		40
 #define MX25_INT_CAN1		43
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index a8ab2e0..2237ba2 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -167,7 +167,7 @@ static inline void mx27_setup_weimcs(size_t cs,
 #define MX27_INT_GPT1		26
 #define MX27_INT_WDOG		27
 #define MX27_INT_PCMCIA		28
-#define MX27_INT_NANDFC		29
+#define MX27_INT_NFC		29
 #define MX27_INT_ATA		30
 #define MX27_INT_CSI		31
 #define MX27_INT_DMACH0		32
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index eb8bbc7..03e2afa 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -168,7 +168,7 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MX31_INT_POWER_FAIL	30
 #define MX31_INT_CCM_DVFS	31
 #define MX31_INT_UART2		32
-#define MX31_INT_NANDFC		33
+#define MX31_INT_NFC		33
 #define MX31_INT_SDMA		34
 #define MX31_INT_USB1		35
 #define MX31_INT_USB2		36
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 867b8c0c..9f0a1ee 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -145,7 +145,7 @@
 #define MX35_INT_GPT		29
 #define MX35_INT_POWER_FAIL	30
 #define MX35_INT_UART2		32
-#define MX35_INT_NANDFC		33
+#define MX35_INT_NFC		33
 #define MX35_INT_SDMA		34
 #define MX35_INT_USBHS		35
 #define MX35_INT_USBOTG		37
-- 
1.7.2.3
