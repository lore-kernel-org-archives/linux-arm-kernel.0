From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 14:31:07 +0200
Subject: [PATCH v2 1/3] imx-esdhc: update devices registration
In-Reply-To: <1286886237-29014-1-git-send-email-eric@eukrea.com>
References: <1286886237-29014-1-git-send-email-eric@eukrea.com>
Message-ID: <1286886667-29584-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on i.MX25 and i.MX35 and i.MX51

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : remove SSI3 fixes which leaked in previous patch

 arch/arm/mach-mx25/devices-imx25.h              |    9 ++--
 arch/arm/mach-mx3/devices-imx35.h               |   12 ++--
 arch/arm/mach-mx5/devices-imx51.h               |   11 +---
 arch/arm/plat-mxc/devices/platform-esdhc.c      |   58 +++++++++++++++++++---
 arch/arm/plat-mxc/include/mach/devices-common.h |   12 ++++-
 arch/arm/plat-mxc/include/mach/mx25.h           |    4 +-
 arch/arm/plat-mxc/include/mach/mx35.h           |    6 +-
 arch/arm/plat-mxc/include/mach/mx51.h           |    8 ++--
 8 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 733aaee..4e7b280 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -49,7 +49,8 @@ extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
 #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
 #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
 
-#define imx25_add_esdhc0(pdata)	\
-	imx_add_esdhc(0, MX25_ESDHC1_BASE_ADDR, SZ_16K, MX25_INT_MMC_SDHC1, pdata)
-#define imx25_add_esdhc1(pdata)	\
-	imx_add_esdhc(1, MX25_ESDHC2_BASE_ADDR, SZ_16K, MX25_INT_MMC_SDHC2, pdata)
+extern const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst;
+#define imx25_add_esdhc(id, pdata)	\
+	imx_add_esdhc(&imx25_esdhc_data[id], pdata)
+#define imx25_add_esdhc0(pdata)		imx25_add_esdhc(0, pdata)
+#define imx25_add_esdhc1(pdata)		imx25_add_esdhc(1, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 509b346..e4ef168 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -46,9 +46,9 @@ extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
 #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
 #define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
 
-#define imx35_add_esdhc0(pdata)	\
-	imx_add_esdhc(0, MX35_ESDHC1_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC1, pdata)
-#define imx35_add_esdhc1(pdata)	\
-	imx_add_esdhc(1, MX35_ESDHC2_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC2, pdata)
-#define imx35_add_esdhc2(pdata)	\
-	imx_add_esdhc(2, MX35_ESDHC3_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC3, pdata)
+extern const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst;
+#define imx35_add_esdhc(id, pdata)	\
+	imx_add_esdhc(&imx35_esdhc_data[id], pdata)
+#define imx35_add_esdhc0(pdata)		imx35_add_esdhc(0, pdata)
+#define imx35_add_esdhc1(pdata)		imx35_add_esdhc(1, pdata)
+#define imx35_add_esdhc2(pdata)		imx35_add_esdhc(2, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 547432d..5cc910e 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -37,11 +37,6 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 #define imx51_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
 
-#define imx51_add_esdhc0(pdata)	\
-	imx_add_esdhc(0, MX51_MMC_SDHC1_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC1, pdata)
-#define imx51_add_esdhc1(pdata)	\
-	imx_add_esdhc(1, MX51_MMC_SDHC2_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC2, pdata)
-#define imx51_add_esdhc2(pdata)	\
-	imx_add_esdhc(2, MX51_MMC_SDHC3_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC3, pdata)
-#define imx51_add_esdhc3(pdata)	\
-	imx_add_esdhc(3, MX51_MMC_SDHC4_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC4, pdata)
+extern const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst;
+#define imx51_add_esdhc(id, pdata)	\
+	imx_add_esdhc(&imx51_esdhc_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
index 68db2a2..5669045 100644
--- a/arch/arm/plat-mxc/devices/platform-esdhc.c
+++ b/arch/arm/plat-mxc/devices/platform-esdhc.c
@@ -6,26 +6,68 @@
  * Free Software Foundation.
  */
 
+#include <mach/hardware.h>
 #include <mach/devices-common.h>
 #include <mach/esdhc.h>
 
-struct platform_device *__init imx_add_esdhc(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
+#define imx_esdhc_imx_data_entry_single(soc, type, _devid, _id, hwid, _size) \
+	{								\
+		.devid = _devid,					\
+		.id = _id,						\
+		.iobase = soc ## _ ## type ## hwid ## _BASE_ADDR,	\
+		.iosize = _size,					\
+		.irq = soc ## _INT_ ## type ## hwid,			\
+	}
+
+#define imx_esdhc_imx_data_entry(soc, type, devid, id, hwid, size)	\
+	[id] = imx_esdhc_imx_data_entry_single(soc, type, devid, id, hwid, size)
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst = {
+#define imx25_esdhc_data_entry(_id, _hwid)				\
+	imx_esdhc_imx_data_entry(MX25, MMC_SDHC, "sdhci-esdhc-imx", _id, _hwid, SZ_16K)
+	imx25_esdhc_data_entry(0, 1),
+	imx25_esdhc_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
+#define imx35_esdhc_data_entry(_id, _hwid)                           \
+	imx_esdhc_imx_data_entry(MX35, MMC_SDHC, "sdhci-esdhc-imx", _id, _hwid, SZ_16K)
+	imx35_esdhc_data_entry(0, 1),
+	imx35_esdhc_data_entry(1, 2),
+	imx35_esdhc_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+#ifdef CONFIG_ARCH_MX51
+const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
+#define imx51_esdhc_data_entry(_id, _hwid)				\
+	imx_esdhc_imx_data_entry(MX51, MMC_SDHC, "sdhci-esdhc-imx", _id, _hwid, SZ_16K)
+	imx51_esdhc_data_entry(0, 1),
+	imx51_esdhc_data_entry(1, 2),
+	imx51_esdhc_data_entry(2, 3),
+	imx51_esdhc_data_entry(3, 4),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
+struct platform_device *__init imx_add_esdhc(
+		const struct imx_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata)
 {
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
 
-	return imx_add_platform_device("sdhci-esdhc-imx", id, res,
+	return imx_add_platform_device(data->devid, data->id, res,
 			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 0498978..ca1f922 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -108,7 +108,13 @@ struct platform_device *__init imx_add_spi_imx(
 		const struct spi_imx_master *pdata);
 
 #include <mach/esdhc.h>
-struct platform_device *__init imx_add_esdhc(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
+struct imx_esdhc_imx_data {
+	const char *devid;
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_esdhc(
+		const struct imx_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 153dd1b..31d9c4c 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -50,8 +50,8 @@
 #define MX25_SSI1_BASE_ADDR		0x50034000
 #define MX25_NFC_BASE_ADDR		0xbb000000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
-#define MX25_ESDHC1_BASE_ADDR		0x53fb4000
-#define MX25_ESDHC2_BASE_ADDR		0x53fb8000
+#define MX25_MMC_SDHC1_BASE_ADDR	0x53fb4000
+#define MX25_MMC_SDHC2_BASE_ADDR	0x53fb8000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
 #define MX25_KPP_BASE_ADDR		0x43fa8000
 #define MX25_OTG_BASE_ADDR		0x53ff4000
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index cb071b7..6f113fc 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -53,9 +53,9 @@
 #define MX35_GPIO3_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xa4000)
 #define MX35_SCC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xac000)
 #define MX35_RNGA_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xb0000)
-#define MX35_ESDHC1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xb4000)
-#define MX35_ESDHC2_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xb8000)
-#define MX35_ESDHC3_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xbc000)
+#define MX35_MMC_SDHC1_BASE_ADDR		(MX35_AIPS2_BASE_ADDR + 0xb4000)
+#define MX35_MMC_SDHC2_BASE_ADDR		(MX35_AIPS2_BASE_ADDR + 0xb8000)
+#define MX35_MMC_SDHC3_BASE_ADDR		(MX35_AIPS2_BASE_ADDR + 0xbc000)
 #define MX35_IPU_CTRL_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xc0000)
 #define MX35_AUDMUX_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xc4000)
 #define MX35_GPIO1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xcc000)
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index c54b5c3..7927f61 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -280,10 +280,10 @@
  */
 #define MX51_MXC_INT_BASE		0
 #define MX51_MXC_INT_RESV0		0
-#define MX51_MXC_INT_MMC_SDHC1		1
-#define MX51_MXC_INT_MMC_SDHC2		2
-#define MX51_MXC_INT_MMC_SDHC3		3
-#define MX51_MXC_INT_MMC_SDHC4		4
+#define MX51_INT_MMC_SDHC1		1
+#define MX51_INT_MMC_SDHC2		2
+#define MX51_INT_MMC_SDHC3		3
+#define MX51_INT_MMC_SDHC4		4
 #define MX51_MXC_INT_RESV5		5
 #define MX51_INT_SDMA			6
 #define MX51_MXC_INT_IOMUX		7
-- 
1.7.0.4
