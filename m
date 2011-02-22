From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Feb 2011 16:49:19 +0800
Subject: [PATCH v4] ARM: mxs/mx23evk: add mmc device
In-Reply-To: <1298284979-14853-6-git-send-email-shawn.guo@freescale.com>
References: <1298284979-14853-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <1298364559-19876-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c |   47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index cd2fbdf..f47fae3 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -19,6 +19,7 @@ config MACH_MX23EVK
 	bool "Support MX23EVK Platform"
 	select SOC_IMX23
 	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_MMC
 	default y
 	help
 	  Include support for MX23EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index aa06400..d690fa0 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -26,17 +26,64 @@
 
 #include "devices-mx23.h"
 
+#define MX23EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(1, 30)
+#define MX23EVK_MMC0_SLOT_POWER		MXS_GPIO_NR(1, 29)
+
 static const iomux_cfg_t mx23evk_pads[] __initconst = {
 	/* duart */
 	MX23_PAD_PWM0__DUART_RX | MXS_PAD_4MA,
 	MX23_PAD_PWM1__DUART_TX | MXS_PAD_4MA,
+
+	/* mmc */
+	MX23_PAD_SSP1_DATA0__SSP1_DATA0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA1__SSP1_DATA1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA2__SSP1_DATA2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA3__SSP1_DATA3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D08__SSP1_DATA4 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D09__SSP1_DATA5 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D10__SSP1_DATA6 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D11__SSP1_DATA7 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_CMD__SSP1_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DETECT__SSP1_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_SSP1_SCK__SSP1_SCK |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* write protect */
+	MX23_PAD_PWM4__GPIO_1_30 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX23_PAD_PWM3__GPIO_1_29 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+};
+
+static struct mxs_mmc_platform_data mx23evk_mmc_pdata __initdata = {
+	.wp_gpio = MX23EVK_MMC0_WRITE_PROTECT,
+	.flags = SLOTF_8_BIT_CAPABLE,
 };
 
 static void __init mx23evk_init(void)
 {
+	int ret;
+
 	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
 
 	mx23_add_duart();
+
+	/* power on mmc slot by writing 0 to the gpio */
+	ret = gpio_request_one(MX23EVK_MMC0_SLOT_POWER, GPIOF_DIR_OUT,
+			       "mmc0-slot-power");
+	if (ret)
+		pr_warn("failed to request gpio mmc0-slot-power: %d\n", ret);
+	mx23_add_mmc(0, &mx23evk_mmc_pdata);
 }
 
 static void __init mx23evk_timer_init(void)
-- 
1.7.1
