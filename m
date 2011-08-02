From: tony.lin@freescale.com (Tony Lin)
Date: Tue, 2 Aug 2011 16:39:43 +0800
Subject: [PATCH v4 4/7] ARM: mxs: enable usb phy power supply
In-Reply-To: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1312274386-6833-5-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

configure usb1 phy power enable gpio and enable usb1 phy power

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/mach-mxs/mach-mx28evk.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eaaf6ff..680d6e4 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
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
@@ -405,6 +408,10 @@ static void __init mx28evk_init(void)
 		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
 	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
 
+	ret = gpio_request_one(MX28EVK_USB1_PWR_EN, GPIOF_OUT_INIT_HIGH,
+			       "usb1-power-en");
+	if (ret)
+		pr_warn("failed to request gpio usb1-power-en %d\n", ret);
 	gpio_led_register_device(0, &mx28evk_led_data);
 }
 
-- 
1.7.0.4
