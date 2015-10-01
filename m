From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Oct 2015 14:32:37 -0500
Subject: [PATCH 1/4] ARM: OMAP: dmtimer: check for fixed timers during config
In-Reply-To: <1443727960-32232-1-git-send-email-s-anna@ti.com>
References: <1443727960-32232-1-git-send-email-s-anna@ti.com>
Message-ID: <1443727960-32232-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap_dm_timer_set_source() function provides a means for client
users to configure the mux parent for a GPTimer's functional clock.
However, not all timers are configurable (Eg: Timer12 on DRA7 is fed
by an internal 32k oscillator clock, and does not have configurable
parent clocks). So, check for such cases and proceed with out throwing
an error.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/dmtimer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8ca94d379bc3..25693e722f1f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -36,6 +36,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/device.h>
@@ -504,6 +505,10 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (IS_ERR(timer->fclk))
 		return -EINVAL;
 
+	/* Check if the clock has parents if not no point checking */
+	if (!clk_hw_get_num_parents(__clk_get_hw(timer->fclk)))
+		return 0;
+
 	switch (source) {
 	case OMAP_TIMER_SRC_SYS_CLK:
 		parent_name = "timer_sys_ck";
-- 
2.6.0
