From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:27:00 +0900
Subject: [PATCH 129/130] ARM: shmobile: lager: Initialize pinmux
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-130-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Initialize r8a7790 pinmuxing and register mappings for the two debug
serial ports.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f587187..6114edd 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -21,15 +21,30 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static const struct pinctrl_map lager_pinctrl_map[] = {
+	/* SCIF0 (CN19: DEBUG SERIAL0) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
+				  "scif0_data", "scif0"),
+	/* SCIF1 (CN20: DEBUG SERIAL1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
+				  "scif1_data", "scif1"),
+};
+
 static void __init lager_add_standard_devices(void)
 {
 	r8a7790_clock_init();
+
+	pinctrl_register_mappings(lager_pinctrl_map,
+				  ARRAY_SIZE(lager_pinctrl_map));
+	r8a7790_pinmux_init();
+
 	r8a7790_add_standard_devices();
 }
 
-- 
1.8.2.1
