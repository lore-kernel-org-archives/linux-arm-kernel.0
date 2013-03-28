From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 28 Mar 2013 11:13:26 +0530
Subject: [PATCH v4 4/6] ARM: OMAP: USB: Add phy binding information
In-Reply-To: <1364449408-9510-1-git-send-email-kishon@ti.com>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
Message-ID: <1364449408-9510-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for controllers to get PHY in case of non dt boot, the phy
binding information should be added in the platform specific
initialization code using phy_bind.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3242a55..f01bc42 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/usb/musb.h>
+#include <linux/phy/phy.h>
 
 #include "omap_device.h"
 #include "soc.h"
@@ -85,8 +86,12 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
 		musb_plat.has_mailbox = true;
+		phy_bind("musb-hdrc.0.auto", 0, "omap-usb2.1.auto");
+	} else if (cpu_is_omap34xx()) {
+		phy_bind("musb-hdrc.0.auto", 0, "twl4030_usb");
+	}
 
 	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
-- 
1.7.10.4
