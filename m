From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Nov 2016 11:17:03 -0800
Subject: [PATCH 06/14] ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Message-ID: <20161111191711.5079-7-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are moving to device tree based booting, and this should be
done using pinctrl-single instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -22,8 +22,6 @@
 
 #include "gpmc.h"
 
-#include "mux.h"
-
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
@@ -226,25 +224,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 	}
 	tusb_device.dev.platform_data = data;
 
-	/* REVISIT let the driver know what DMA channels work */
-	if (!dmachan)
-		tusb_device.dev.dma_mask = NULL;
-	else {
-		/* assume OMAP 2420 ES2.0 and later */
-		if (dmachan & (1 << 0))
-			omap_mux_init_signal("sys_ndmareq0", 0);
-		if (dmachan & (1 << 1))
-			omap_mux_init_signal("sys_ndmareq1", 0);
-		if (dmachan & (1 << 2))
-			omap_mux_init_signal("sys_ndmareq2", 0);
-		if (dmachan & (1 << 3))
-			omap_mux_init_signal("sys_ndmareq3", 0);
-		if (dmachan & (1 << 4))
-			omap_mux_init_signal("sys_ndmareq4", 0);
-		if (dmachan & (1 << 5))
-			omap_mux_init_signal("sys_ndmareq5", 0);
-	}
-
 	/* so far so good ... register the device */
 	status = platform_device_register(&tusb_device);
 	if (status < 0) {
-- 
2.10.2
