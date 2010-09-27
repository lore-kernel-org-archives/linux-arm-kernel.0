From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:51 +0200
Subject: [PATCH 15/40] ARM: imx: reorganize imx-i2c device registration to use
	a struct per SoC
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx1.h                |    3 +-
 arch/arm/mach-imx/devices-imx21.h               |    3 +-
 arch/arm/mach-imx/devices-imx27.h               |    9 ++-
 arch/arm/mach-mx25/devices-imx25.h              |   12 ++--
 arch/arm/mach-mx3/devices-imx31.h               |   12 ++--
 arch/arm/mach-mx3/devices-imx35.h               |   12 ++--
 arch/arm/plat-mxc/devices/platform-imx-i2c.c    |   75 ++++++++++++++++++++--
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +++-
 arch/arm/plat-mxc/include/mach/mx51.h           |    4 +-
 9 files changed, 105 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index 2861cb8..6cf0864 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -9,8 +9,9 @@
 #include <mach/mx1.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_imx_i2c_data imx1_imx_i2c_data __initconst;
 #define imx1_add_i2c_imx(pdata)		\
-	imx_add_imx_i2c(0, MX1_I2C_BASE_ADDR, SZ_4K, MX1_INT_I2C, pdata)
+	imx_add_imx_i2c(&imx1_imx_i2c_data, pdata)
 
 extern const struct imx_imx_uart_3irq_data imx1_imx_uart_data[] __initconst;
 #define imx1_add_imx_uart(id, pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 24868c3..d3d2b26 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -9,8 +9,9 @@
 #include <mach/mx21.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst;
 #define imx21_add_i2c_imx(pdata)	\
-	imx_add_imx_i2c(0, MX2x_I2C_BASE_ADDR, SZ_4K, MX2x_INT_I2C, pdata)
+	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
 
 extern const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst;
 #define imx21_add_imx_ssi(id, pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 2972e69..193dfb5 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -9,10 +9,11 @@
 #include <mach/mx27.h>
 #include <mach/devices-common.h>
 
-#define imx27_add_i2c_imx0(pdata)	\
-	imx_add_imx_i2c(0, MX27_I2C1_BASE_ADDR, SZ_4K, MX27_INT_I2C1, pdata)
-#define imx27_add_i2c_imx1(pdata)	\
-	imx_add_imx_i2c(1, MX27_I2C2_BASE_ADDR, SZ_4K, MX27_INT_I2C2, pdata)
+extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
+#define imx27_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
+#define imx27_add_i2c_imx0(pdata)	imx27_add_imx_i2c(0, pdata)
+#define imx27_add_i2c_imx1(pdata)	imx27_add_imx_i2c(1, pdata)
 
 extern const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst;
 #define imx27_add_imx_ssi(id, pdata)    \
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index bf93fac..1dd9572 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -14,12 +14,12 @@
 #define imx25_add_flexcan1(pdata)	\
 	imx_add_flexcan(1, MX25_CAN2_BASE_ADDR, SZ_16K, MX25_INT_CAN2, pdata)
 
-#define imx25_add_imx_i2c0(pdata)	\
-	imx_add_imx_i2c(0, MX25_I2C1_BASE_ADDR, SZ_16K, MX25_INT_I2C1, pdata)
-#define imx25_add_imx_i2c1(pdata)	\
-	imx_add_imx_i2c(1, MX25_I2C2_BASE_ADDR, SZ_16K, MX25_INT_I2C2, pdata)
-#define imx25_add_imx_i2c2(pdata)	\
-	imx_add_imx_i2c(2, MX25_I2C3_BASE_ADDR, SZ_16K, MX25_INT_I2C3, pdata)
+extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
+#define imx25_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
+#define imx25_add_imx_i2c0(pdata)	imx25_add_imx_i2c(0, pdata)
+#define imx25_add_imx_i2c1(pdata)	imx25_add_imx_i2c(1, pdata)
+#define imx25_add_imx_i2c2(pdata)	imx25_add_imx_i2c(2, pdata)
 
 extern const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst;
 #define imx25_add_imx_ssi(id, pdata)	\
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index b8568a1..eea425f 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -9,12 +9,12 @@
 #include <mach/mx31.h>
 #include <mach/devices-common.h>
 
-#define imx31_add_imx_i2c0(pdata)	\
-	imx_add_imx_i2c(0, MX31_I2C1_BASE_ADDR, SZ_4K, MX31_INT_I2C1, pdata)
-#define imx31_add_imx_i2c1(pdata)	\
-	imx_add_imx_i2c(1, MX31_I2C2_BASE_ADDR, SZ_4K, MX31_INT_I2C2, pdata)
-#define imx31_add_imx_i2c2(pdata)	\
-	imx_add_imx_i2c(2, MX31_I2C3_BASE_ADDR, SZ_4K, MX31_INT_I2C3, pdata)
+extern const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst;
+#define imx31_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx31_imx_i2c_data[id], pdata)
+#define imx31_add_imx_i2c0(pdata)	imx31_add_imx_i2c(0, pdata)
+#define imx31_add_imx_i2c1(pdata)	imx31_add_imx_i2c(1, pdata)
+#define imx31_add_imx_i2c2(pdata)	imx31_add_imx_i2c(2, pdata)
 
 extern const struct imx_imx_ssi_data imx31_imx_ssi_data[] __initconst;
 #define imx31_add_imx_ssi(id, pdata)    \
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 813e570..f187d35 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -14,12 +14,12 @@
 #define imx35_add_flexcan1(pdata)	\
 	imx_add_flexcan(1, MX35_CAN2_BASE_ADDR, SZ_16K, MX35_INT_CAN2, pdata)
 
-#define imx35_add_imx_i2c0(pdata)	\
-	imx_add_imx_i2c(0, MX35_I2C1_BASE_ADDR, SZ_4K, MX35_INT_I2C1, pdata)
-#define imx35_add_imx_i2c1(pdata)	\
-	imx_add_imx_i2c(1, MX35_I2C2_BASE_ADDR, SZ_4K, MX35_INT_I2C2, pdata)
-#define imx35_add_imx_i2c2(pdata)	\
-	imx_add_imx_i2c(2, MX35_I2C3_BASE_ADDR, SZ_4K, MX35_INT_I2C3, pdata)
+extern const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst;
+#define imx35_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx35_imx_i2c_data[id], pdata)
+#define imx35_add_imx_i2c0(pdata)	imx35_add_imx_i2c(0, pdata)
+#define imx35_add_imx_i2c1(pdata)	imx35_add_imx_i2c(1, pdata)
+#define imx35_add_imx_i2c2(pdata)	imx35_add_imx_i2c(2, pdata)
 
 extern const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst;
 #define imx35_add_imx_ssi(id, pdata)    \
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index d0af9f7..ab9670b 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -6,24 +6,85 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
+#include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-struct platform_device *__init imx_add_imx_i2c(int id,
-		resource_size_t iobase, resource_size_t iosize, int irq,
+#define imx_imx_i2c_data_entry_single(soc, _id, _hwid, _size)		\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _I2C ## _hwid ## _BASE_ADDR,		\
+		.iosize = _size,					\
+		.irq = soc ## _INT_I2C ## _hwid,			\
+	}
+
+#define imx_imx_i2c_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = imx_imx_i2c_data_entry_single(soc, _id, _hwid, _size)
+
+#ifdef CONFIG_SOC_IMX1
+const struct imx_imx_i2c_data imx1_imx_i2c_data __initconst =
+	imx_imx_i2c_data_entry_single(MX1, 0, , SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX1 */
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst =
+	imx_imx_i2c_data_entry_single(MX21, 0, , SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst = {
+#define imx25_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX25, _id, _hwid, SZ_16K)
+	imx25_imx_i2c_data_entry(0, 1),
+	imx25_imx_i2c_data_entry(1, 2),
+	imx25_imx_i2c_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst = {
+#define imx27_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX27, _id, _hwid, SZ_4K)
+	imx27_imx_i2c_data_entry(0, 1),
+	imx27_imx_i2c_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+#ifdef CONFIG_ARCH_MX31
+const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst = {
+#define imx31_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX31, _id, _hwid, SZ_4K)
+	imx31_imx_i2c_data_entry(0, 1),
+	imx31_imx_i2c_data_entry(1, 2),
+	imx31_imx_i2c_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_ARCH_MX31 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
+#define imx35_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX35, _id, _hwid, SZ_4K)
+	imx35_imx_i2c_data_entry(0, 1),
+	imx35_imx_i2c_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+struct platform_device *__init imx_add_imx_i2c(
+		const struct imx_imx_i2c_data *data,
 		const struct imxi2c_platform_data *pdata)
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
 
-	return imx_add_platform_device("imx-i2c", id, res, ARRAY_SIZE(res),
+	return imx_add_platform_device("imx-i2c", data->id,
+			res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 84bfe44..490fe7c 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -21,8 +21,14 @@ struct platform_device *__init imx_add_flexcan(int id,
 		const struct flexcan_platform_data *pdata);
 
 #include <mach/i2c.h>
-struct platform_device *__init imx_add_imx_i2c(int id,
-		resource_size_t iobase, resource_size_t iosize, int irq,
+struct imx_imx_i2c_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_imx_i2c(
+		const struct imx_imx_i2c_data *data,
 		const struct imxi2c_platform_data *pdata);
 
 #include <mach/ssi.h>
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index f602650..b919235 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -341,8 +341,8 @@
 #define MX51_MXC_INT_WDOG2		59
 #define MX51_MXC_INT_KPP		60
 #define MX51_MXC_INT_PWM1		61
-#define MX51_MXC_INT_I2C1		62
-#define MX51_MXC_INT_I2C2		63
+#define MX51_INT_I2C1			62
+#define MX51_INT_I2C2			63
 #define MX51_MXC_INT_HS_I2C		64
 #define MX51_MXC_INT_RESV65		65
 #define MX51_MXC_INT_RESV66		66
-- 
1.7.2.3
