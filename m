From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:07 +0900
Subject: [PATCH 076/130] ARM: shmobile: bonito: Register pinctrl mapping for
 INTC
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-77-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based INTC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bonito.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index b6620662..5076f4d 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -369,6 +369,17 @@ static void __init bonito_map_io(void)
 #define VCCQ1CR		IOMEM(0xE6058140)
 #define VCCQ1LCDCR	IOMEM(0xE6058186)
 
+/*
+ * HACK: The FPGA mappings should be associated with the FPGA device, but we
+ * don't have one at the moment. Associate them with the PFC device to make
+ * sure they will be applied.
+ */
+static const struct pinctrl_map fpga_pinctrl_map[] = {
+	/* FPGA */
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "intc_irq10", "intc"),
+};
+
 static const struct pinctrl_map scifa5_pinctrl_map[] = {
 	/* SCIFA5 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.5", "pfc-r8a7740",
@@ -381,6 +392,8 @@ static void __init bonito_init(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(fpga_pinctrl_map,
+				  ARRAY_SIZE(fpga_pinctrl_map));
 	r8a7740_pinmux_init();
 	bonito_fpga_init();
 
@@ -412,7 +425,6 @@ static void __init bonito_init(void)
 		gpio_request(GPIO_FN_CS5B,		NULL);
 		gpio_request(GPIO_FN_CS6A,		NULL);
 		gpio_request(GPIO_FN_CS5A_PORT105,	NULL);
-		gpio_request(GPIO_FN_IRQ10,		NULL);
 
 		val = bonito_fpga_read(BVERR);
 		pr_info("bonito version: cpu %02x, base %02x\n",
-- 
1.8.2.1
