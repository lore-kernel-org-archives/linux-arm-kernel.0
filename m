From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:58 +0900
Subject: [PATCH 067/130] ARM: shmobile: armadillo800eva: Register pinctrl
 mapping for INTC
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-68-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based INTC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index b85b288..8d8b362 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1065,6 +1065,12 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "sdhi0_ctrl", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
 				  "sdhi0_wp", "sdhi0"),
+	/* ST1232 */
+	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-r8a7740",
+				  "intc_irq10", "intc"),
+	/* USBHS */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7740",
+				  "intc_irq7_1", "intc"),
 };
 
 static void __init eva_clock_init(void)
@@ -1130,7 +1136,7 @@ static void __init eva_init(void)
 	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
 	/* Touchscreen */
-	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
+	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
 	gpio_request(GPIO_FN_ET_CRS,		NULL);
@@ -1163,13 +1169,11 @@ static void __init eva_init(void)
 	} else {
 		/* USB Func */
 		/*
-		 * A1 chip has 2 IRQ7 pin and it was controled by MSEL register.
-		 * OTOH, usbhs interrupt needs its value (HI/LOW) to decide
-		 * USB connection/disconnection (usbhsf_get_vbus()).
-		 * This means we needs to select GPIO_FN_IRQ7_PORT209 first,
-		 * and select GPIO 209 here
+		 * The USBHS interrupt handlers needs to read the IRQ pin value
+		 * (HI/LOW) to diffentiate USB connection and disconnection
+		 * events (usbhsf_get_vbus()). We thus need to select both the
+		 * intc_irq7_1 pin group and GPIO 209 here.
 		 */
-		gpio_request(GPIO_FN_IRQ7_PORT209, NULL);
 		gpio_request_one(209, GPIOF_IN, NULL);
 
 		platform_device_register(&usbhsf_device);
-- 
1.8.2.1
