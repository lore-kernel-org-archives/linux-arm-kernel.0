From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Jun 2013 19:41:06 +0400
Subject: [PATCH] ARM: imx: Add RTC support for i.MX27
Message-ID: <1371310866-6136-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support using i.MX27 On-Chip RTC from board files.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/devices-imx27.h            |  4 ++++
 arch/arm/mach-imx/devices/devices-common.h   |  1 +
 arch/arm/mach-imx/devices/platform-mxc_rtc.c | 14 ++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 1309625..7d1aac2 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -73,6 +73,10 @@ extern const struct imx_mxc_nand_data imx27_mxc_nand_data;
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_rtc_data imx27_mxc_rtc_data;
+#define imx27_add_mxc_rtc()	\
+	imx_add_mxc_rtc(&imx27_mxc_rtc_data)
+
 extern const struct imx_mxc_w1_data imx27_mxc_w1_data;
 #define imx27_add_mxc_w1()	\
 	imx_add_mxc_w1(&imx27_mxc_w1_data)
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 453e20b..32c49c6 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -305,6 +305,7 @@ struct platform_device *__init imx_add_mxc_pwm(
 struct imx_mxc_rtc_data {
 	const char *devid;
 	resource_size_t iobase;
+	resource_size_t iosize;
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_mxc_rtc(
diff --git a/arch/arm/mach-imx/devices/platform-mxc_rtc.c b/arch/arm/mach-imx/devices/platform-mxc_rtc.c
index c7fffaa..385fe4e 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_rtc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_rtc.c
@@ -9,21 +9,27 @@
 #include "../hardware.h"
 #include "devices-common.h"
 
-#define imx_mxc_rtc_data_entry_single(soc, _devid)			\
+#define imx_mxc_rtc_data_entry_single(soc, _devid, _size)		\
 	{								\
 		.devid = _devid,					\
 		.iobase = soc ## _RTC_BASE_ADDR,			\
+		.iosize = _size,					\
 		.irq = soc ## _INT_RTC,					\
 	}
 
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mxc_rtc_data imx27_mxc_rtc_data __initconst =
+	imx_mxc_rtc_data_entry_single(MX27, "imx21-rtc", SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
 #ifdef CONFIG_SOC_IMX31
 const struct imx_mxc_rtc_data imx31_mxc_rtc_data __initconst =
-	imx_mxc_rtc_data_entry_single(MX31, "imx21-rtc");
+	imx_mxc_rtc_data_entry_single(MX31, "imx21-rtc", SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_mxc_rtc_data imx35_mxc_rtc_data __initconst =
-	imx_mxc_rtc_data_entry_single(MX35, "imx21-rtc");
+	imx_mxc_rtc_data_entry_single(MX35, "imx21-rtc", SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_mxc_rtc(
@@ -32,7 +38,7 @@ struct platform_device *__init imx_add_mxc_rtc(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_16K - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
-- 
1.8.1.5
