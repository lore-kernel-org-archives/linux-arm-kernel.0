From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:26:20 +0900
Subject: [PATCH 02/21] ARM: shmobile: kota2: Register pinctrl mappings for SCIF
In-Reply-To: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
References: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360725999-14514-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kota2.c |   42 +++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 2ccc860..69dd9e6 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -433,6 +434,26 @@ static struct platform_device *kota2_devices[] __initdata = {
 	&sdhi1_device,
 };
 
+static const struct pinctrl_map kota2_pinctrl_map[] = {
+	/* SCIFA2 (UART2) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
+				  "scifa2_data_0", "scifa2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
+				  "scifa2_ctrl_0", "scifa2"),
+	/* SCIFA4 (UART1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_data", "scifa4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_ctrl", "scifa4"),
+	/* SCIFB (BT) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.8", "pfc-sh73a0",
+				  "scifb_data_0", "scifb"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.8", "pfc-sh73a0",
+				  "scifb_clk_0", "scifb"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.8", "pfc-sh73a0",
+				  "scifb_ctrl_0", "scifb"),
+};
+
 static void __init kota2_init(void)
 {
 	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
@@ -441,20 +462,10 @@ static void __init kota2_init(void)
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(kota2_pinctrl_map,
+				  ARRAY_SIZE(kota2_pinctrl_map));
 	sh73a0_pinmux_init();
 
-	/* SCIFA2 (UART2) */
-	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
-	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
-
-	/* SCIFA4 (UART1) */
-	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
-	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
-
 	/* SMSC911X */
 	gpio_request(GPIO_FN_D0_NAF0, NULL);
 	gpio_request(GPIO_FN_D1_NAF1, NULL);
@@ -518,13 +529,6 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_SDHID0_1_PU, NULL);
 	gpio_request(GPIO_FN_SDHID0_0_PU, NULL);
 
-	/* SCIFB (BT) */
-	gpio_request(GPIO_FN_PORT159_SCIFB_SCK, NULL);
-	gpio_request(GPIO_FN_PORT160_SCIFB_TXD, NULL);
-	gpio_request(GPIO_FN_PORT161_SCIFB_CTS_, NULL);
-	gpio_request(GPIO_FN_PORT162_SCIFB_RXD, NULL);
-	gpio_request(GPIO_FN_PORT163_SCIFB_RTS_, NULL);
-
 	/* SDHI1 (BCM4330) */
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
 	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
-- 
1.7.10.4
