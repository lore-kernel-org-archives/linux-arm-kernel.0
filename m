From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:44 +0900
Subject: [PATCH 053/130] ARM: shmobile: ap4evb: Register pinctrl mapping for
 TSC2007
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-54-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based TSC2007 pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 0109bb3..152a5f7 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1026,10 +1026,8 @@ out:
 
 /* TouchScreen */
 #ifdef CONFIG_AP4EVB_QHD
-# define GPIO_TSC_IRQ	GPIO_FN_IRQ28_123
 # define GPIO_TSC_PORT	123
 #else /* WVGA */
-# define GPIO_TSC_IRQ	GPIO_FN_IRQ7_40
 # define GPIO_TSC_PORT	40
 #endif
 
@@ -1042,7 +1040,6 @@ static int ts_get_pendown_state(void)
 
 static int ts_init(void)
 {
-	gpio_request(GPIO_TSC_IRQ, NULL);
 	gpio_request_one(GPIO_TSC_PORT, GPIOF_IN, NULL);
 
 	return 0;
@@ -1132,6 +1129,14 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 				  "bsc_cs5a", "bsc"),
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
 				  "intc_irq6_0", "intc"),
+	/* TSC2007 */
+#ifdef CONFIG_AP4EVB_QHD
+	PIN_MAP_MUX_GROUP_DEFAULT("1-0048", "pfc-sh7372",
+				  "intc_irq28_0", "intc"),
+#else /* WVGA */
+	PIN_MAP_MUX_GROUP_DEFAULT("1-0048", "pfc-sh7372",
+				  "intc_irq7_0", "intc"),
+#endif
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
-- 
1.8.2.1
