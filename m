From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:06 +0900
Subject: [PATCH 075/130] ARM: shmobile: bonito: Register pinctrl mapping for
 SCIF
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-76-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bonito.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index b111c13..b6620662 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -369,6 +369,12 @@ static void __init bonito_map_io(void)
 #define VCCQ1CR		IOMEM(0xE6058140)
 #define VCCQ1LCDCR	IOMEM(0xE6058186)
 
+static const struct pinctrl_map scifa5_pinctrl_map[] = {
+	/* SCIFA5 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.5", "pfc-r8a7740",
+				  "scifa5_data_2", "scifa5"),
+};
+
 static void __init bonito_init(void)
 {
 	u16 val;
@@ -423,8 +429,8 @@ static void __init bonito_init(void)
 		if (BIT_OFF(bsw2, 1) &&	/* S38.3 = ON */
 		    BIT_OFF(bsw3, 9) &&	/* S39.6 = ON */
 		    BIT_OFF(bsw4, 4)) {	/* S43.1 = ON */
-			gpio_request(GPIO_FN_SCIFA5_TXD_PORT91,	NULL);
-			gpio_request(GPIO_FN_SCIFA5_RXD_PORT92,	NULL);
+			pinctrl_register_mappings(scifa5_pinctrl_map,
+						  ARRAY_SIZE(scifa5_pinctrl_map));
 		}
 
 		/*
-- 
1.8.2.1
