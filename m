From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 19 Nov 2010 17:06:29 -0200
Subject: [PATCH 2/2] ARM: mx5: dynamically allocate imx2-wdt devices
In-Reply-To: <1290193589-17633-1-git-send-email-fabio.estevam@freescale.com>
References: <1290193589-17633-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1290193589-17633-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/devices-imx51.h             |    5 +++++
 arch/arm/mach-mx5/devices.c                   |   15 ---------------
 arch/arm/mach-mx5/devices.h                   |    1 -
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c |    5 +++++
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 8c50cb5..dbf070e 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -42,3 +42,8 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 extern const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst;
 #define imx51_add_esdhc(id, pdata)	\
 	imx_add_esdhc(&imx51_esdhc_data[id], pdata)
+
+extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data __initconst;
+#define imx51_add_imx2_wdt(pdata)	\
+	imx_add_imx2_wdt(&imx51_imx2_wdt_data)
+
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 4c7be87..620d0ac 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -97,21 +97,6 @@ struct platform_device mxc_usbh1_device = {
 	},
 };
 
-static struct resource mxc_wdt_resources[] = {
-	{
-		.start = MX51_WDOG_BASE_ADDR,
-		.end = MX51_WDOG_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_wdt = {
-	.name = "imx2-wdt",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
-	.resource = mxc_wdt_resources,
-};
-
 static struct resource mxc_kpp_resources[] = {
 	{
 		.start = MX51_MXC_INT_KPP,
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index af1d07c..ccb7cdc 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -1,6 +1,5 @@
 extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbdr_udc_device;
-extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_hsi2c_device;
 extern struct platform_device mxc_keypad_device;
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index e64d474..c8e2d55 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -41,6 +41,11 @@ const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst =
 	imx_imx2_wdt_data_entry_single(MX35, SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX51
+const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst =
+	imx_imx2_wdt_data_entry_single(MX51, SZ_16K);
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 struct platform_device *__init imx_add_imx2_wdt(
 		const struct imx_imx2_wdt_data *data)
 {
-- 
1.6.0.4
