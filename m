From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:26:11 +0000
Subject: [PATCH RFC 05/46] imx-drm: ipu-v3: don't use clk_round_rate() before
 clk_set_rate()
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypmN-0007Dp-BK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is nonsense; clk_round_rate() is just clk_set_rate() without the
side effect of changing the hardware.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-di.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 8c7241bb435c..d766e18bfca0 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -560,9 +560,10 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	 * rate within 1% of the requested frequency, otherwise we use
 	 * the DI clock.
 	 */
-	if (sig->clkflags & IPU_DI_CLKMODE_EXT)
+	round = sig->pixelclock;
+	if (sig->clkflags & IPU_DI_CLKMODE_EXT) {
 		parent = di->clk_di;
-	else {
+	} else {
 		unsigned long rate, clkrate;
 		unsigned div, error;
 
@@ -584,6 +585,9 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 			ret = clk_set_rate(parent, sig->pixelclock);
 			if (ret)
 				dev_err(di->ipu->dev, "Setting of DI clock failed: %d\n", ret);
+
+			/* Use the integer divisor rate - avoid fractional dividers */
+			round = rate;
 		}
 	}
 
@@ -599,11 +603,12 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	 * CLKMODE_SYNC means that we want the DI to be clocked at the
 	 * same rate as the parent clock.  This is needed (eg) for LDB
 	 * which needs to be fed with the same pixel clock.
+	 *
+	 * Note: clk_set_rate(clk, clk_round_rate(clk, rate)) is the
+	 * same as clk_set_rate(clk, rate);
 	 */
 	if (sig->clkflags & IPU_DI_CLKMODE_SYNC)
 		round = clk_get_rate(parent);
-	else
-		round = clk_round_rate(di->clk_di_pixel, sig->pixelclock);
 
 	ret = clk_set_rate(di->clk_di_pixel, round);
 
-- 
1.7.4.4
