From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:02 +0100
Subject: [PATCH 34/51] ARM: mx25: dynamically allocatate imx-fb devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-34-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig                      |    2 ++
 arch/arm/mach-mx25/devices-imx25.h              |    4 ++++
 arch/arm/mach-mx25/devices.c                    |   23 -----------------------
 arch/arm/mach-mx25/devices.h                    |    1 -
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c   |    5 ++---
 arch/arm/mach-mx25/mach-mx25_3ds.c              |    5 ++---
 arch/arm/plat-mxc/devices/platform-imx-fb.c     |   14 ++++++++++----
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 8 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index baa75fe..10c0f60 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -6,6 +6,7 @@ config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -17,6 +18,7 @@ config MACH_EUKREA_CPUIMX25
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index a4980ec..d80cce0 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -27,6 +27,10 @@ extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst;
 #define imx25_add_imxdi_rtc(pdata)	\
 	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
 
+extern const struct imx_imx_fb_data imx25_imx_fb_data __initconst;
+#define imx25_add_imx_fb(pdata)	\
+	imx_add_imx_fb(&imx25_imx_fb_data, pdata)
+
 extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
 #define imx25_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 1274396..09095e0 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,29 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static struct resource mx25_fb_resources[] = {
-	{
-		.start	= MX25_LCDC_BASE_ADDR,
-		.end	= MX25_LCDC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= MX25_INT_LCDC,
-		.end	= MX25_INT_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mx25_fb_device = {
-	.name		= "imx-fb",
-	.id		= 0,
-	.resource	= mx25_fb_resources,
-	.num_resources	= ARRAY_SIZE(mx25_fb_resources),
-	.dev		= {
-		.coherent_dma_mask = 0xFFFFFFFF,
-	},
-};
-
 static struct resource mxc_wdt_resources[] = {
 	{
 		.start = MX25_WDOG_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index f37f9a2..11997e2 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,3 +1,2 @@
-extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
 extern struct platform_device mx25_csi_device;
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index e765ac5..d6058e0 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -33,7 +33,6 @@
 #include <asm/mach/arch.h>
 #include <mach/mx25.h>
 #include <mach/imx-uart.h>
-#include <mach/imxfb.h>
 #include <mach/audmux.h>
 
 #include "devices-imx25.h"
@@ -151,7 +150,7 @@ static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data eukrea_mximxsd_fb_pdata = {
+static const struct imx_fb_platform_data eukrea_mximxsd_fb_pdata __initconst = {
 	.mode		= eukrea_mximxsd_modes,
 	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
 	.pwmr		= 0x00A903FF,
@@ -273,7 +272,7 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 #endif
 
 	imx25_add_imx_uart1(&uart_pdata);
-	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
+	imx25_add_imx_fb(&eukrea_mximxsd_fb_pdata);
 	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx25_add_flexcan1(NULL);
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 0566d3c..34492aa 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -39,7 +39,6 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/mx25.h>
-#include <mach/imxfb.h>
 #include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
@@ -154,7 +153,7 @@ static struct imx_fb_videomode mx25pdk_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data mx25pdk_fb_pdata = {
+static const struct imx_fb_platform_data mx25pdk_fb_pdata __initconst = {
 	.mode		= mx25pdk_modes,
 	.num_modes	= ARRAY_SIZE(mx25pdk_modes),
 	.pwmr		= 0x00A903FF,
@@ -195,7 +194,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_mxc_ehci_hs(NULL);
 	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
 	imx25_add_imxdi_rtc(NULL);
-	mxc_register_device(&mx25_fb_device, &mx25pdk_fb_pdata);
+	imx25_add_imx_fb(&mx25pdk_fb_pdata);
 	mxc_register_device(&mxc_wdt, NULL);
 
 	mx25pdk_fec_reset();
diff --git a/arch/arm/plat-mxc/devices/platform-imx-fb.c b/arch/arm/plat-mxc/devices/platform-imx-fb.c
index 42ed3be..f228ba6 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-fb.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-fb.c
@@ -9,20 +9,26 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_imx_fb_data_entry_single(soc)				\
+#define imx_imx_fb_data_entry_single(soc, _size)			\
 	{								\
 		.iobase = soc ## _LCDC_BASE_ADDR,			\
+		.iosize = _size,					\
 		.irq = soc ## _INT_LCDC,				\
 	}
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
-	imx_imx_fb_data_entry_single(MX21);
+	imx_imx_fb_data_entry_single(MX21, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imx_fb_data imx25_imx_fb_data __initconst =
+	imx_imx_fb_data_entry_single(MX25, SZ_16K);
+#endif
+
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_fb_data imx27_imx_fb_data __initconst =
-	imx_imx_fb_data_entry_single(MX27);
+	imx_imx_fb_data_entry_single(MX27, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 struct platform_device *__init imx_add_imx_fb(
@@ -32,7 +38,7 @@ struct platform_device *__init imx_add_imx_fb(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_4K - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 4d4b28b..e28453e 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -82,6 +82,7 @@ struct platform_device *__init imx_add_imxdi_rtc(
 #include <mach/imxfb.h>
 struct imx_imx_fb_data {
 	resource_size_t iobase;
+	resource_size_t iosize;
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_imx_fb(
-- 
1.7.2.3
