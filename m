From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:24 +0200
Subject: [PATCH 06/16] ARM: imx: change the way spi-imx devices are registered
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Group soc specific data in a global struct instead of repeating it for
each call to imxXX_add_spi_imxX.  The structs holding the actual data
are placed in .init.constdata and so don't do much harm.  Compared to
the previous approach this reduces code size to call imx_add_spi_imx.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx21.h               |    9 ++-
 arch/arm/mach-imx/devices-imx27.h               |   12 ++--
 arch/arm/mach-mx25/devices-imx25.h              |   12 ++--
 arch/arm/mach-mx3/devices-imx31.h               |   12 ++--
 arch/arm/mach-mx3/devices-imx35.h               |    9 ++-
 arch/arm/plat-mxc/devices/platform-spi_imx.c    |   76 ++++++++++++++++++++---
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +++-
 7 files changed, 103 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 42788e9..2b45d33 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -24,7 +24,8 @@
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
 
-#define imx21_add_spi_imx0(pdata)	\
-	imx_add_spi_imx(0, MX21_CSPI1_BASE_ADDR, SZ_4K, MX21_INT_CSPI1, pdata)
-#define imx21_add_spi_imx1(pdata)	\
-	imx_add_spi_imx(1, MX21_CSPI2_BASE_ADDR, SZ_4K, MX21_INT_CSPI2, pdata)
+extern const struct imx_spi_imx_data imx21_cspi_data[] __initconst;
+#define imx21_add_cspi(id, pdata)	\
+	imx_add_spi_imx(&imx21_cspi_data[id], pdata)
+#define imx21_add_spi_imx0(pdata)	imx21_add_cspi(0, pdata)
+#define imx21_add_spi_imx1(pdata)	imx21_add_cspi(1, pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 65e7bb7..04bfcf0 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -30,9 +30,9 @@
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
 
-#define imx27_add_spi_imx0(pdata)	\
-	imx_add_spi_imx(0, MX27_CSPI1_BASE_ADDR, SZ_4K, MX27_INT_CSPI1, pdata)
-#define imx27_add_spi_imx1(pdata)	\
-	imx_add_spi_imx(1, MX27_CSPI2_BASE_ADDR, SZ_4K, MX27_INT_CSPI2, pdata)
-#define imx27_add_spi_imx2(pdata)	\
-	imx_add_spi_imx(2, MX27_CSPI3_BASE_ADDR, SZ_4K, MX27_INT_CSPI3, pdata)
+extern const struct imx_spi_imx_data imx27_cspi_data[] __initconst;
+#define imx27_add_cspi(id, pdata)	\
+	imx_add_spi_imx(&imx27_cspi_data[id], pdata)
+#define imx27_add_spi_imx0(pdata)	imx27_add_cspi(0, pdata)
+#define imx27_add_spi_imx1(pdata)	imx27_add_cspi(1, pdata)
+#define imx27_add_spi_imx2(pdata)	imx27_add_cspi(2, pdata)
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index d86a7c3..34a7061 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -35,9 +35,9 @@
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
 
-#define imx25_add_spi_imx0(pdata)	\
-	imx_add_spi_imx(0, MX25_CSPI1_BASE_ADDR, SZ_16K, MX25_INT_CSPI1, pdata)
-#define imx25_add_spi_imx1(pdata)	\
-	imx_add_spi_imx(1, MX25_CSPI2_BASE_ADDR, SZ_16K, MX25_INT_CSPI2, pdata)
-#define imx25_add_spi_imx2(pdata)	\
-	imx_add_spi_imx(2, MX25_CSPI3_BASE_ADDR, SZ_16K, MX25_INT_CSPI3, pdata)
+extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
+#define imx25_add_spi_imx(id, pdata)	\
+	imx_add_spi_imx(&imx25_spi_imx_data[id], pdata)
+#define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
+#define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
+#define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 3b1a44a..7b4d022 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -30,9 +30,9 @@
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
 
-#define imx31_add_spi_imx0(pdata)	\
-	imx_add_spi_imx(0, MX31_CSPI1_BASE_ADDR, SZ_4K, MX31_INT_CSPI1, pdata)
-#define imx31_add_spi_imx1(pdata)	\
-	imx_add_spi_imx(1, MX31_CSPI2_BASE_ADDR, SZ_4K, MX31_INT_CSPI2, pdata)
-#define imx31_add_spi_imx2(pdata)	\
-	imx_add_spi_imx(2, MX31_CSPI3_BASE_ADDR, SZ_4K, MX31_INT_CSPI3, pdata)
+extern const struct imx_spi_imx_data imx31_cspi_data[] __initconst;
+#define imx31_add_cspi(id, pdata)	\
+	imx_add_spi_imx(&imx31_cspi_data[id], pdata)
+#define imx31_add_spi_imx0(pdata)	imx31_add_cspi(0, pdata)
+#define imx31_add_spi_imx1(pdata)	imx31_add_cspi(1, pdata)
+#define imx31_add_spi_imx2(pdata)	imx31_add_cspi(2, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index f6a431a..af0bc1f 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -31,7 +31,8 @@
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
 
-#define imx35_add_spi_imx0(pdata)	\
-	imx_add_spi_imx(0, MX35_CSPI1_BASE_ADDR, SZ_4K, MX35_INT_CSPI1, pdata)
-#define imx35_add_spi_imx1(pdata)	\
-	imx_add_spi_imx(1, MX35_CSPI2_BASE_ADDR, SZ_4K, MX35_INT_CSPI2, pdata)
+extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
+#define imx35_add_cspi(id, pdata)	\
+	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
+#define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
+#define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 2831a6d..412a81f 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -6,25 +6,83 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <asm/sizes.h>
+#include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-struct platform_device *__init imx_add_spi_imx(int id,
-		resource_size_t iobase, resource_size_t iosize, int irq,
+#define imx_spi_imx_data_entry_single(soc, type, _devid, _id, hwid, _size) \
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _ ## type ## hwid ## _BASE_ADDR,	\
+		.iosize = _size,					\
+		.irq = soc ## _INT_ ## type ## hwid,			\
+	}
+
+#define imx_spi_imx_data_entry(soc, type, devid, id, hwid, size)	\
+	[id] = imx_spi_imx_data_entry_single(soc, type, devid, id, hwid, size)
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
+#define imx21_cspi_data_entry(_id, _hwid)                            \
+	imx_spi_imx_data_entry(MX21, CSPI, "imx21-cspi", _id, _hwid, SZ_4K)
+	imx21_cspi_data_entry(0, 1),
+	imx21_cspi_data_entry(1, 2),
+#endif
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_spi_imx_data imx25_cspi_data[] __initconst = {
+#define imx25_cspi_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX25, CSPI, "imx25-cspi", _id, _hwid, SZ_16K)
+	imx25_cspi_data_entry(0, 1),
+	imx25_cspi_data_entry(1, 2),
+	imx25_cspi_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_spi_imx_data imx27_cspi_data[] __initconst = {
+#define imx27_cspi_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX27, CSPI, "imx27-cspi", _id, _hwid, SZ_4K)
+	imx27_cspi_data_entry(0, 1),
+	imx27_cspi_data_entry(1, 2),
+	imx27_cspi_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+#ifdef CONFIG_ARCH_MX31
+const struct imx_spi_imx_data imx31_cspi_data[] __initconst = {
+#define imx31_cspi_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX31, CSPI, "imx31-cspi", _id, _hwid, SZ_4K)
+	imx31_cspi_data_entry(0, 1),
+	imx31_cspi_data_entry(1, 2),
+	imx31_cspi_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_ARCH_MX31 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
+#define imx35_cspi_data_entry(_id, _hwid)                           \
+	imx_spi_imx_data_entry(MX35, CSPI, "imx35-cspi", _id, _hwid, SZ_4K)
+	imx35_cspi_data_entry(0, 1),
+	imx35_cspi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+struct platform_device *__init imx_add_spi_imx(
+		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata)
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
 
-	return imx_add_platform_device("spi_imx", id, res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata));
+	return imx_add_platform_device("spi_imx", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index c5f68c5..abe12c29 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -55,6 +55,12 @@ struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
 		int irq, const struct mxc_nand_platform_data *pdata);
 
 #include <mach/spi.h>
-struct platform_device *__init imx_add_spi_imx(int id,
-		resource_size_t iobase, resource_size_t iosize, int irq,
+struct imx_spi_imx_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	int irq;
+};
+struct platform_device *__init imx_add_spi_imx(
+		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
-- 
1.7.2.3
