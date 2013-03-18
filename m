From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:12 +0900
Subject: [PATCH 076/142] ARM: shmobile: ag5evm: Register pinctrl mappings for
 SCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-77-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index a4ac46a..5b8dcdc 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -550,6 +551,14 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 	&sdhi1_device,
 };
 
+static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	/* SCIFA2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
+				  "scifa2_data_0", "scifa2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
+				  "scifa2_ctrl_0", "scifa2"),
+};
+
 static void __init ag5evm_init(void)
 {
 	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
@@ -558,14 +567,10 @@ static void __init ag5evm_init(void)
 				     ARRAY_SIZE(fixed2v8_power_consumers), 3300000);
 	regulator_register_fixed(3, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(ag5evm_pinctrl_map,
+				  ARRAY_SIZE(ag5evm_pinctrl_map));
 	sh73a0_pinmux_init();
 
-	/* enable SCIFA2 */
-	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
-	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
-
 	/* enable KEYSC */
 	gpio_request(GPIO_FN_KEYIN0_PU, NULL);
 	gpio_request(GPIO_FN_KEYIN1_PU, NULL);
-- 
1.7.10.4
