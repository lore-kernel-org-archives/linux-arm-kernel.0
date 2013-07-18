From: gsi@denx.de (Gerhard Sittig)
Date: Thu, 18 Jul 2013 19:00:44 +0200
Subject: [PATCH v2 13/24] clk: mpc512x: remove now obsolete clkdev registration
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
Message-ID: <1374166855-7280-14-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after the peripheral drivers for UART and SPI mode (both using the PSC
controller) got converted to device tree based clock lookups, the
platform clock driver need no longer provide the "psc%d_mclk" name which
depends on the PSC index number -- remove the clk_register_clkdev() call

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 6627957..b822469 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -529,17 +528,6 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry)
 				entry->name_mclk,
 				entry->name_mux1, 1, 1);
 	}
-
-	/*
-	 * without this "clock device" registration, "simple" lookups in
-	 * the SPI master initialization and serial port setup will fail
-	 *
-	 * those drivers need to get adjusted to lookup their required
-	 * clocks from device tree specs, and device tree nodes need to
-	 * provide the clock specs, before this clkdev registration
-	 * becomes obsolete
-	 */
-	clk_register_clkdev(clks[clks_idx_pub], entry->name_mclk, NULL);
 }
 
 static void mpc512x_clk_setup_mclks(struct mclk_setup_data *table, size_t count)
-- 
1.7.10.4
