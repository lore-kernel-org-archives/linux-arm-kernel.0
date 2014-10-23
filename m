From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 23 Oct 2014 17:23:00 +0300
Subject: [PATCH v3 3/5] PM / clock_ops: add and enable clocks always if
 !CONFIG_PM_RUNTIME
In-Reply-To: <1414074182-25980-1-git-send-email-grygorii.strashko@ti.com>
References: <1414074182-25980-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1414074182-25980-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device's clocks need to be enabled always at probing time
if !CONFIG_PM_RUNTIME - in that way, device will become accessible
and, later, its clocks can be disabled/enabled during system
suspend/resume by using pm_clk_suspend/pm_clk_resume APIs.

But now, the clocks management code doesn't enable clocks when
clocks are being registered per-device by using pm_clk_add/_clk().
So, update pm_clk_acquire(), which is called from pm_clk_add/_clk(),
to enable clocks always if !CONFIG_PM_RUNTIME.

Also, Platform PM domains drivers will not need to add code like below
each time they need to handle the case when !CONFIG_PM_RUNTIME [1 - 3]:

       if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
               ret = pm_clk_resume(dev);
               if (ret) {
                       dev_err(dev, "pm_clk_resume failed %d\n", ret);
                       goto clk_err;
               };
       }

[1] https://lkml.org/lkml/2014/10/3/306
[2] https://lkml.org/lkml/2014/10/16/305
[3] https://lkml.org/lkml/2014/10/20/249

CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Kevin Hilman <khilman@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/power/clock_ops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index c3b44c1..87d07dc 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -68,6 +68,10 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 		ce->status = PCE_STATUS_ACQUIRED;
 		dev_dbg(dev, "Clock %s managed by runtime PM.\n", ce->con_id);
 	}
+
+	if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
+		__pm_clk_enable(dev, ce);
+	}
 }
 
 static int __pm_clk_add(struct device *dev, const char *con_id,
-- 
1.9.1
