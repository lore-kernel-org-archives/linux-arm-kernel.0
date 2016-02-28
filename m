From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:56 +0000
Subject: [PATCH v5 05/20] clk: bcm2835: enable clocks that have been enabled
 by firmware
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

If a clock that has been enabled by the firmware gets disabled
by a driver this may right now result in a crash of the system
as then also the corresponding PLL_dividers as well as PLLs
get disabled (if not used) - some of which are used by the
VideoCore GPU (which also runs the firmware)

This patch prepares/enables those clocks that have been
configured by the firmware.

Whenever the clock framework implements either
CLK_IS_CRITICAL or HAND_OFF this can get changed to use this
new mechanism.

For this to be completely successful it is recommended to
add all the known clock so that this can get applied to all clocks.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index c277ecb..14ff81e 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -34,6 +34,7 @@
  * generator).
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/bcm2835.h>
@@ -1457,6 +1458,7 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	struct clk_init_data init;
 	const char *parents[1 << CM_SRC_BITS];
 	size_t i;
+	struct clk *clk;
 
 	/*
 	 * Replace our "xosc" references with the oscillator's
@@ -1490,7 +1492,18 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	clock->data = data;
 	clock->hw.init = &init;
 
-	return devm_clk_register(cprman->dev, &clock->hw);
+	clk = devm_clk_register(cprman->dev, &clock->hw);
+	if (IS_ERR_OR_NULL(clk))
+		return clk;
+
+	/* enable/prepare if the clock is enabled by the firmware */
+	if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
+		dev_info(cprman->dev,
+			 "found firmware enabled clock %pC\n", clk);
+		clk_prepare_enable(clk);
+	}
+
+	return clk;
 }
 
 static int bcm2835_clk_probe(struct platform_device *pdev)
-- 
1.7.10.4
