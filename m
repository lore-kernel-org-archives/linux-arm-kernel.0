From: tony@atomide.com (Tony Lindgren)
Date: Wed,  8 Aug 2018 01:07:06 -0700
Subject: [PATCH 4/4] bus: ti-sysc: Fix no_console_suspend handling
In-Reply-To: <20180808080706.100389-1-tony@atomide.com>
References: <20180808080706.100389-1-tony@atomide.com>
Message-ID: <20180808080706.100389-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no_console_suspend is set, we should keep console enabled during suspend.
Lets fix this by only producing a warning if we can't idle hardware during
suspend.

Fixes: ef55f8215a78 ("bus: ti-sysc: Improve suspend and resume handling")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1255,10 +1255,10 @@ static int sysc_child_suspend_noirq(struct device *dev)
 	if (!pm_runtime_status_suspended(dev)) {
 		error = pm_generic_runtime_suspend(dev);
 		if (error) {
-			dev_err(dev, "%s error at %i: %i\n",
-				__func__, __LINE__, error);
+			dev_warn(dev, "%s busy at %i: %i\n",
+				 __func__, __LINE__, error);
 
-			return error;
+			return 0;
 		}
 
 		error = sysc_runtime_suspend(ddata->dev);
-- 
2.17.1
