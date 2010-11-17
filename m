From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:44 +0100
Subject: [PATCH 16/51] ARM: imx: change the way flexcan devices are registered
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Group soc specific data in a global struct instead of repeating it for each
call to imxXX_add_flexcanX.  The structs holding the actual data are placed
in .init.constdata and so don't do much harm.  Compared to the previous
approach this reduces code size to call imx_add_flexcan.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/devices-imx25.h              |    9 ++--
 arch/arm/mach-mx3/devices-imx35.h               |    9 ++--
 arch/arm/plat-mxc/devices/platform-flexcan.c    |   48 ++++++++++++++++++-----
 arch/arm/plat-mxc/include/mach/devices-common.h |   11 ++++-
 4 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 93afa10..f62ce93 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -13,10 +13,11 @@ extern const struct imx_fec_data imx25_fec_data __initconst;
 #define imx25_add_fec(pdata)	\
 	imx_add_fec(&imx25_fec_data, pdata)
 
-#define imx25_add_flexcan0(pdata)	\
-	imx_add_flexcan(0, MX25_CAN1_BASE_ADDR, SZ_16K, MX25_INT_CAN1, pdata)
-#define imx25_add_flexcan1(pdata)	\
-	imx_add_flexcan(1, MX25_CAN2_BASE_ADDR, SZ_16K, MX25_INT_CAN2, pdata)
+extern const struct imx_flexcan_data imx25_flexcan_data[] __initconst;
+#define imx25_add_flexcan(id, pdata)	\
+	imx_add_flexcan(&imx25_flexcan_data[id], pdata)
+#define imx25_add_flexcan0(pdata)	imx25_add_flexcan(0, pdata)
+#define imx25_add_flexcan1(pdata)	imx25_add_flexcan(1, pdata)
 
 extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
 #define imx25_add_imx_i2c(id, pdata)	\
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 7602cb4..a71ce68 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -13,10 +13,11 @@ extern const struct imx_fec_data imx35_fec_data __initconst;
 #define imx35_add_fec(pdata)	\
 	imx_add_fec(&imx35_fec_data, pdata)
 
-#define imx35_add_flexcan0(pdata)	\
-	imx_add_flexcan(0, MX35_CAN1_BASE_ADDR, SZ_16K, MX35_INT_CAN1, pdata)
-#define imx35_add_flexcan1(pdata)	\
-	imx_add_flexcan(1, MX35_CAN2_BASE_ADDR, SZ_16K, MX35_INT_CAN2, pdata)
+extern const struct imx_flexcan_data imx35_flexcan_data[] __initconst;
+#define imx35_add_flexcan(id, pdata)	\
+	imx_add_flexcan(&imx35_flexcan_data[id], pdata)
+#define imx35_add_flexcan0(pdata)	imx35_add_flexcan(0, pdata)
+#define imx35_add_flexcan1(pdata)	imx35_add_flexcan(1, pdata)
 
 extern const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst;
 #define imx35_add_imx_i2c(id, pdata)	\
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/plat-mxc/devices/platform-flexcan.c
index 5e97a01..5189017 100644
--- a/arch/arm/plat-mxc/devices/platform-flexcan.c
+++ b/arch/arm/plat-mxc/devices/platform-flexcan.c
@@ -5,26 +5,54 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-
+#include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-struct platform_device *__init imx_add_flexcan(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
+#define imx_flexcan_data_entry_single(soc, _id, _hwid, _size)		\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _CAN ## _hwid ## _BASE_ADDR,		\
+		.iosize = _size,					\
+		.irq = soc ## _INT_CAN ## _hwid,			\
+	}
+
+#define imx_flexcan_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = imx_flexcan_data_entry_single(soc, _id, _hwid, _size)
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_flexcan_data imx25_flexcan_data[] __initconst = {
+#define imx25_flexcan_data_entry(_id, _hwid)				\
+	imx_flexcan_data_entry(MX25, _id, _hwid, SZ_16K)
+	imx25_flexcan_data_entry(0, 1),
+	imx25_flexcan_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
+#define imx35_flexcan_data_entry(_id, _hwid)				\
+	imx_flexcan_data_entry(MX35, _id, _hwid, SZ_16K)
+	imx35_flexcan_data_entry(0, 1),
+	imx35_flexcan_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+struct platform_device *__init imx_add_flexcan(
+		const struct imx_flexcan_data *data,
 		const struct flexcan_platform_data *pdata)
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
 
-	return imx_add_platform_device("flexcan", id, res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata));
+	return imx_add_platform_device("flexcan", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index a0ac8454..830369e 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -34,9 +34,14 @@ struct platform_device *__init imx_add_fec(
 		const struct fec_platform_data *pdata);
 
 #include <linux/can/platform/flexcan.h>
-struct platform_device *__init imx_add_flexcan(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
+struct imx_flexcan_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_flexcan(
+		const struct imx_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
 
 #include <linux/gpio_keys.h>
-- 
1.7.2.3
