From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Jun 2010 15:07:23 +0300
Subject: [PATCH 14/16] omap: mux: Mux 2430 USB0HS_STP in board-2430.c
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Message-ID: <20100630120723.2637.54397.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new mux functions for that. There are no other known 2430 boards
that need this mux.

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    4 +++-
 drivers/usb/musb/omap2430.c         |    4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 281aa13..71bf509 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -31,7 +31,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <plat/mux.h>
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
@@ -238,7 +237,10 @@ static void __init omap_2430sdp_init(void)
 	omap_serial_init();
 	omap2_hsmmc_init(mmc);
 	omap2_usbfs_init(&sdp2430_usb_config);
+
+	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
 	usb_musb_init(&musb_board_data);
+
 	board_smc91x_init();
 
 	/* Turn off secondary LCD backlight */
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e06d65e..5f04d3f 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -194,10 +194,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 	u32 l;
 	struct omap_musb_board_data *data = board_data;
 
-#if defined(CONFIG_ARCH_OMAP2430)
-	omap_cfg_reg(AE5_2430_USB0HS_STP);
-#endif
-
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
