From: tony.lin@freescale.com (Tony Lin)
Date: Mon, 25 Jul 2011 15:01:20 +0800
Subject: [PATCH v2 2/6] ARM: mxs: enable usb1 phy power supply
In-Reply-To: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311577284-11506-3-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

configure usb1 phy power enable gpio and enable usb1 phy power

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/mach-mxs/mach-mx28evk.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eaaf6ff..9901547 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -34,6 +34,7 @@
 #define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
 #define MX28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 30)
 #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
+#define MX28EVK_USB1_PWR_EN	MXS_GPIO_NR(3, 8)
 
 #define MX28EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(2, 12)
 #define MX28EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(0, 28)
@@ -183,6 +184,8 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 
 	/* led */
 	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
+	/* usb1 */
+	MX28_PAD_AUART2_RX__GPIO_3_8 | MXS_PAD_CTRL,
 };
 
 /* led */
@@ -405,6 +408,11 @@ static void __init mx28evk_init(void)
 		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
 	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
 
+	ret = gpio_request_one(MX28EVK_USB1_PWR_EN, GPIOF_OUT_INIT_HIGH,
+			       "usb1-power-en");
+	if (ret)
+		pr_warn("failed to request gpio usb1-power-en %d\n", ret);
+
 	gpio_led_register_device(0, &mx28evk_led_data);
 }
 
-- 
1.7.0.4
