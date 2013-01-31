From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:23:56 +0900
Subject: [PATCH 3/9] ARM: shmobile: armadillo800eva: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   48 +++++++++---------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5f179e1..efd6a36 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1000,16 +1000,12 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_LCD0_DISP,		NULL);
 	gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
-	gpio_request(GPIO_PORT61, NULL); /* LCDDON */
-	gpio_direction_output(GPIO_PORT61, 1);
-
-	gpio_request(GPIO_PORT202, NULL); /* LCD0_LED_CONT */
-	gpio_direction_output(GPIO_PORT202, 0);
+	gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
+	gpio_request_one(GPIO_PORT202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
 	/* Touchscreen */
 	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
-	gpio_request(GPIO_PORT166,	NULL); /* TP_RST_B */
-	gpio_direction_output(GPIO_PORT166, 1);
+	gpio_request_one(GPIO_PORT166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
 	gpio_request(GPIO_FN_ET_CRS,		NULL);
@@ -1032,12 +1028,10 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
 	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
 
-	gpio_request(GPIO_PORT18, NULL); /* PHY_RST */
-	gpio_direction_output(GPIO_PORT18, 1);
+	gpio_request_one(GPIO_PORT18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
 	/* USB */
-	gpio_request(GPIO_PORT159, NULL); /* USB_DEVICE_MODE */
-	gpio_direction_input(GPIO_PORT159);
+	gpio_request_one(GPIO_PORT159, GPIOF_IN, NULL); /* USB_DEVICE_MODE */
 
 	if (gpio_get_value(GPIO_PORT159)) {
 		/* USB Host */
@@ -1051,8 +1045,7 @@ static void __init eva_init(void)
 		 * and select GPIO_PORT209 here
 		 */
 		gpio_request(GPIO_FN_IRQ7_PORT209, NULL);
-		gpio_request(GPIO_PORT209, NULL);
-		gpio_direction_input(GPIO_PORT209);
+		gpio_request_one(GPIO_PORT209, GPIOF_IN, NULL);
 
 		platform_device_register(&usbhsf_device);
 		usb = &usbhsf_device;
@@ -1067,12 +1060,9 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_SDHI0_D3, NULL);
 	gpio_request(GPIO_FN_SDHI0_WP, NULL);
 
-	gpio_request(GPIO_PORT17, NULL);	/* SDHI0_18/33_B */
-	gpio_request(GPIO_PORT74, NULL);	/* SDHI0_PON */
-	gpio_request(GPIO_PORT75, NULL);	/* SDSLOT1_PON */
-	gpio_direction_output(GPIO_PORT17, 0);
-	gpio_direction_output(GPIO_PORT74, 1);
-	gpio_direction_output(GPIO_PORT75, 1);
+	gpio_request_one(GPIO_PORT17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
+	gpio_request_one(GPIO_PORT74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
+	gpio_request_one(GPIO_PORT75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
 
 	/* we can use GPIO_FN_IRQ31_PORT167 here for SDHI0 CD irq */
 
@@ -1109,12 +1099,10 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_VIO_CKO,		NULL);
 
 	/* CON1/CON15 Camera */
-	gpio_request(GPIO_PORT173, NULL); /* STANDBY */
-	gpio_request(GPIO_PORT172, NULL); /* RST */
-	gpio_request(GPIO_PORT158, NULL); /* CAM_PON */
-	gpio_direction_output(GPIO_PORT173, 0);
-	gpio_direction_output(GPIO_PORT172, 1);
-	gpio_direction_output(GPIO_PORT158, 0); /* see mt9t111_power() */
+	gpio_request_one(GPIO_PORT173, GPIOF_OUT_INIT_LOW, NULL);  /* STANDBY */
+	gpio_request_one(GPIO_PORT172, GPIOF_OUT_INIT_HIGH, NULL); /* RST */
+	/* see mt9t111_power() */
+	gpio_request_one(GPIO_PORT158, GPIOF_OUT_INIT_LOW, NULL);  /* CAM_PON */
 
 	/* FSI-WM8978 */
 	gpio_request(GPIO_FN_FSIAIBT,		NULL);
@@ -1141,15 +1129,13 @@ static void __init eva_init(void)
 	 * DBGMD/LCDC0/FSIA MUX
 	 * DBGMD_SELECT_B should be set after setting PFC Function.
 	 */
-	gpio_request(GPIO_PORT176, NULL);
-	gpio_direction_output(GPIO_PORT176, 1);
+	gpio_request_one(GPIO_PORT176, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/*
 	 * We can switch CON8/CON14 by SW1.5,
 	 * but it needs after DBGMD_SELECT_B
 	 */
-	gpio_request(GPIO_PORT6, NULL);
-	gpio_direction_input(GPIO_PORT6);
+	gpio_request_one(GPIO_PORT6, GPIOF_IN, NULL);
 	if (gpio_get_value(GPIO_PORT6)) {
 		/* CON14 enable */
 	} else {
@@ -1163,8 +1149,8 @@ static void __init eva_init(void)
 		gpio_request(GPIO_FN_SDHI1_CD,	NULL);
 		gpio_request(GPIO_FN_SDHI1_WP,	NULL);
 
-		gpio_request(GPIO_PORT16, NULL); /* SDSLOT2_PON */
-		gpio_direction_output(GPIO_PORT16, 1);
+		/* SDSLOT2_PON */
+		gpio_request_one(GPIO_PORT16, GPIOF_OUT_INIT_HIGH, NULL);
 
 		platform_device_register(&sdhi1_device);
 	}
-- 
1.7.10.4
