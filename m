From: b32955@freescale.com (Huang Shijie)
Date: Mon, 25 Apr 2011 18:20:26 +0800
Subject: [PATCH V3 3/3] ARM: mxs: add GPMI device for imx28
In-Reply-To: <1303726826-31660-1-git-send-email-b32955@freescale.com>
References: <1303726826-31660-1-git-send-email-b32955@freescale.com>
Message-ID: <1303726826-31660-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi device for imx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c                |    1 +
 arch/arm/mach-mxs/devices-mx28.h              |    4 +++
 arch/arm/mach-mxs/devices/platform-gpmi-nfc.c |   19 +++++++++++++
 arch/arm/mach-mxs/mach-mx28evk.c              |   37 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5e489a2..9dbd2d5 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -609,6 +609,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
+	_REGISTER_CLOCK("imx28-gpmi-nfc", NULL, gpmi_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 9d08555..816bd47 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -34,6 +34,10 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
 
+extern const struct mxs_gpmi_nfc_data mx28_gpmi_nfc_data __initconst;
+#define mx28_add_gpmi_nfc(pdata)	\
+	mxs_add_gpmi_nfc(pdata, &mx28_gpmi_nfc_data)
+
 extern const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
 #define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
 
diff --git a/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c b/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
index 5a68370..ae88672 100644
--- a/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
+++ b/arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
@@ -17,6 +17,7 @@
  */
 #include <asm/sizes.h>
 #include <mach/mx23.h>
+#include <mach/mx28.h>
 #include <mach/devices-common.h>
 
 #define RES_MEM(soc, _id, _s, _n)				\
@@ -61,6 +62,24 @@ const struct mxs_gpmi_nfc_data mx23_gpmi_nfc_data __initconst = {
 };
 #endif
 
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_gpmi_nfc_data mx28_gpmi_nfc_data __initconst = {
+	.devid = "imx28-gpmi-nfc",
+	.res = {
+		/* GPMI */
+		RES_MEM(MX28, GPMI, SZ_8K, GPMI_NFC_GPMI_REGS_ADDR_RES_NAME),
+		RES_IRQ(MX28, GPMI, GPMI_NFC_GPMI_INTERRUPT_RES_NAME),
+		/* BCH */
+		RES_MEM(MX28, BCH, SZ_8K, GPMI_NFC_BCH_REGS_ADDR_RES_NAME),
+		RES_IRQ(MX28, BCH, GPMI_NFC_BCH_INTERRUPT_RES_NAME),
+		/* DMA */
+		RES_DMA(MX28, DMA_GPMI0, DMA_GPMI7,
+					GPMI_NFC_DMA_CHANNELS_RES_NAME),
+		RES_IRQ(MX28, GPMI_DMA, GPMI_NFC_DMA_INTERRUPT_RES_NAME),
+	},
+};
+#endif
+
 struct platform_device *__init
 mxs_add_gpmi_nfc(const struct gpmi_nfc_platform_data *pdata,
 		const struct mxs_gpmi_nfc_data *data)
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 08002d0..0a1aab5 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -232,6 +232,42 @@ static const struct flexcan_platform_data
 	}
 };
 
+/* gpmi-nfc */
+#define MXS_PAD_GPMI_NFC	(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
+static iomux_cfg_t mx28evk_gpmi_nfc_pads[] = {
+	MX28_PAD_GPMI_D00__GPMI_D0 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D01__GPMI_D1 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D02__GPMI_D2 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D03__GPMI_D3 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D04__GPMI_D4 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D05__GPMI_D5 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D06__GPMI_D6 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_D07__GPMI_D7 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_ALE__GPMI_ALE | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_CLE__GPMI_CLE | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_CE0N__GPMI_CE0N | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_CE1N__GPMI_CE1N | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_RDY0__GPMI_READY0 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_RDY1__GPMI_READY1 | MXS_PAD_CTRL,
+	MX28_PAD_GPMI_RDN__GPMI_RDN | MXS_PAD_GPMI_NFC,
+	MX28_PAD_GPMI_WRN__GPMI_WRN | MXS_PAD_GPMI_NFC,
+	MX28_PAD_GPMI_RESETN__GPMI_RESETN | MXS_PAD_GPMI_NFC,
+};
+
+static int mx28evk_gpmi_nfc_platform_init(void)
+{
+	return mxs_iomux_setup_multiple_pads(mx28evk_gpmi_nfc_pads,
+				ARRAY_SIZE(mx28evk_gpmi_nfc_pads));
+}
+
+static const struct gpmi_nfc_platform_data
+mx28evk_gpmi_nfc_data __initconst = {
+	.platform_init		= mx28evk_gpmi_nfc_platform_init,
+	.min_prop_delay_in_ns	= 5,
+	.max_prop_delay_in_ns	= 9,
+	.max_chip_count		= 1,
+};
+
 /* mxsfb (lcdif) */
 static struct fb_videomode mx28evk_video_modes[] = {
 	{
@@ -296,6 +332,7 @@ static void __init mx28evk_init(void)
 	else
 		gpio_set_value(MX28EVK_BL_ENABLE, 1);
 
+	mx28_add_gpmi_nfc(&mx28evk_gpmi_nfc_data);
 	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 }
 
-- 
1.7.0.4
