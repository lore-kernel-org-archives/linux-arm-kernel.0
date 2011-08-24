From: b32955@freescale.com (Huang Shijie)
Date: Wed, 24 Aug 2011 15:07:22 +0800
Subject: [PATCH v8 3/4] ARM: mxs/mx23evk: add GPMI-NAND device
In-Reply-To: <1314169643-23425-1-git-send-email-b32955@freescale.com>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
Message-ID: <1314169643-23425-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the GPMI-NAND device for mx23evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4cd0231..8bf202a 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -32,6 +32,7 @@ config MACH_MX23EVK
 	select SOC_IMX23
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
+	select MXS_HAVE_PLATFORM_GPMI_NAND
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
 	help
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 3c2de33..d55ee6f 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -107,6 +107,41 @@ static const iomux_cfg_t mx23evk_pads[] __initconst = {
 		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 };
 
+/* gpmi-nand */
+static iomux_cfg_t mx23evk_gpmi_nand_pads[] = {
+	MX23_PAD_GPMI_D00__GPMI_D00 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D01__GPMI_D01 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D02__GPMI_D02 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D03__GPMI_D03 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D04__GPMI_D04 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D05__GPMI_D05 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D06__GPMI_D06 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_D07__GPMI_D07 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_CLE__GPMI_CLE | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_ALE__GPMI_ALE | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_WPN__GPMI_WPN | MXS_PAD_CTRL_12MA,
+	MX23_PAD_GPMI_WRN__GPMI_WRN | MXS_PAD_CTRL_12MA,
+	MX23_PAD_GPMI_RDN__GPMI_RDN | MXS_PAD_CTRL_12MA,
+	MX23_PAD_GPMI_RDY0__GPMI_RDY0 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_RDY1__GPMI_RDY1 | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_CE0N__GPMI_CE0N | MXS_PAD_CTRL,
+	MX23_PAD_GPMI_CE1N__GPMI_CE1N | MXS_PAD_CTRL,
+};
+
+static int mx23evk_gpmi_nand_platform_init(void)
+{
+	return mxs_iomux_setup_multiple_pads(mx23evk_gpmi_nand_pads,
+				ARRAY_SIZE(mx23evk_gpmi_nand_pads));
+}
+
+static const
+struct gpmi_nand_platform_data mx23evk_gpmi_nand_data __initconst = {
+	.platform_init		= mx23evk_gpmi_nand_platform_init,
+	.min_prop_delay_in_ns	= 5,
+	.max_prop_delay_in_ns	= 9,
+	.max_chip_count		= 1,
+};
+
 /* mxsfb (lcdif) */
 static struct fb_videomode mx23evk_video_modes[] = {
 	{
@@ -166,6 +201,7 @@ static void __init mx23evk_init(void)
 	else
 		gpio_set_value(MX23EVK_BL_ENABLE, 1);
 
+	mx23_add_gpmi_nand(&mx23evk_gpmi_nand_data);
 	mx23_add_mxsfb(&mx23evk_mxsfb_pdata);
 }
 
-- 
1.7.0.4
