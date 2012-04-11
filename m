From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:47 +0200
Subject: [PATCH 6/7] ARM i.MX27 pcm038: Add sdrm support
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/pcm970-baseboard.c |   78 +++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 99afbc3..17758f8 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -20,6 +20,9 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/can/platform/sja1000.h>
+#include <drm/drmP.h>
+#include <drm/sdrm_encon.h>
+#include <generated/mach-types.h>
 
 #include <asm/mach/arch.h>
 
@@ -224,8 +227,81 @@ void __init pcm970_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(pcm970_pins, ARRAY_SIZE(pcm970_pins),
 			"PCM970");
 
-	imx27_add_imx_fb(&pcm038_fb_data);
+//	imx27_add_imx_fb(&pcm038_fb_data);
 	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN);
 	imx27_add_mxc_mmc(1, &sdhc_pdata);
 	platform_device_register(&pcm970_sja1000);
 }
+
+static struct platform_device *__init imx_add_imx_drm(
+		struct imx_drm_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = MX27_LCDC_BASE_ADDR,
+			.end = MX27_LCDC_BASE_ADDR + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = MX27_INT_LCDC,
+			.end = MX27_INT_LCDC,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("imx-drm", -1,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
+
+static struct drm_display_mode pcm038_modes[] = {
+	{
+		.name = "Sharp-LQ035Q7",
+		.vrefresh = 60,
+		.clock = 5300,
+		.hdisplay = 240,
+		.hsync_start = 240 + 16,
+		.hsync_end = 240 + 16 + 7,
+		.htotal = 240 + 16 + 7 + 5,
+		.vdisplay = 320,
+		.vsync_start = 320 + 9,
+		.vsync_end = 320 + 9 + 1,
+		.vtotal = 320 + 9 + 1 + 7,
+		.type = 0x0,
+		.flags = 0x0,
+	},
+};
+
+static struct sdrm_encon_dummy_pdata pcm038_encon_data = {
+	.drm_name = "imx-drm",
+	.possible_crtcs = 0x1,
+	.possible_clones = 0x1,
+	.modes = pcm038_modes,
+	.num_modes = ARRAY_SIZE(pcm038_modes),
+};
+
+static struct imx_drm_platform_data drm_pdata = {
+	/*
+	 * - HSYNC active high
+	 * - VSYNC active high
+	 * - clk notenabled while idle
+	 * - clock not inverted
+	 * - data not inverted
+	 * - data enable low active
+	 * - enable sharp mode
+	 */
+	.pcr		= 0xf00080c0,
+	.lscr1		= 0x00120300,
+	.pwmr		= 0x00a903ff,
+};
+
+static int add_drm(void)
+{
+	if (!machine_is_pcm038())
+		return 0;
+
+	imx_add_imx_drm(&drm_pdata);
+
+	platform_device_register_data(NULL, "drm-encon-dummy", 0,
+			&pcm038_encon_data, sizeof(pcm038_encon_data));
+	return 0;
+}
+device_initcall(add_drm);
-- 
1.7.9.5
