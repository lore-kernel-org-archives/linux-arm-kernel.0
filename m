From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 12 Apr 2013 11:41:30 +0200
Subject: [PATCH] PM / Runtime: Asyncronous idle|suspend parent devices at
 removal
Message-ID: <1365759690-23687-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

For irq safe devices return the runtime reference for the parent
by using the asyncronous runtime PM API. Thus we don't have to
wait for it to become idle|suspended. Instead we can move on and
handle the next device in queue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1244930..ef13ad08 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1400,5 +1400,5 @@ void pm_runtime_remove(struct device *dev)
 	if (dev->power.runtime_status == RPM_ACTIVE)
 		pm_runtime_set_suspended(dev);
 	if (dev->power.irq_safe && dev->parent)
-		pm_runtime_put_sync(dev->parent);
+		pm_runtime_put(dev->parent);
 }
-- 
1.7.10
