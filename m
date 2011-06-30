From: b32955@freescale.com (Huang Shijie)
Date: Thu, 30 Jun 2011 11:53:48 +0800
Subject: [PATCH v5 3/3] ARM: mxs/mx28evk: add GPMI-NFC device
In-Reply-To: <1309406028-2924-1-git-send-email-b32955@freescale.com>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
Message-ID: <1309406028-2924-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add GPMI-NFC device for mx28evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index f55bcfe..a5b753a 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -47,6 +47,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
 	select MXS_HAVE_PLATFORM_FLEXCAN
+	select MXS_HAVE_PLATFORM_GPMI_NFC
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_OCOTP
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eaaf6ff..74d0868 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -314,6 +314,42 @@ static const struct flexcan_platform_data
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
@@ -390,6 +426,7 @@ static void __init mx28evk_init(void)
 	else
 		gpio_set_value(MX28EVK_BL_ENABLE, 1);
 
+	mx28_add_gpmi_nfc(&mx28evk_gpmi_nfc_data);
 	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 
 	/* power on mmc slot by writing 0 to the gpio */
-- 
1.7.0.4
