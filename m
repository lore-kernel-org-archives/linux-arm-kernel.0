From: joelf@ti.com (Joel Fernandes)
Date: Thu, 21 Nov 2013 19:56:48 -0600
Subject: [PATCH 2/8] rc: ir-rx51: Use clk API to get clock rate
In-Reply-To: <1385085414-9034-1-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
Message-ID: <1385085414-9034-3-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ir-rx51 tries to use struct clk directly, which is private. Go through to clk
API to get the rate.

Compile tested only.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/media/rc/ir-rx51.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index 31b955b..7367122 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -26,8 +26,8 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 
-#include <plat/dmtimer.h>
-#include <plat/clock.h>
+#include <linux/omap-timer.h>
+#include <linux/clk.h>
 
 #include <media/lirc.h>
 #include <media/lirc_dev.h>
@@ -209,7 +209,7 @@ static int lirc_rx51_init_port(struct lirc_rx51 *lirc_rx51)
 	}
 
 	clk_fclk = omap_dm_timer_get_fclk(lirc_rx51->pwm_timer);
-	lirc_rx51->fclk_khz = clk_fclk->rate / 1000;
+	lirc_rx51->fclk_khz = clk_get_rate(clk_fclk) / 1000;
 
 	return 0;
 
-- 
1.8.1.2
