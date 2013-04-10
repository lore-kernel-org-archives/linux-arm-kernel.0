From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Apr 2013 17:00:48 +0200
Subject: [RESEND PATCH] PM / Runtime: Idle devices asynchronously after
 probe|release
Message-ID: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Putting devices into idle|suspend in a synchronous manner means we are
waiting for each device to become idle|suspended before the probe|release
is fully done.

This patch switch to use the asynchronous runtime PM API:s instead and
thus improves the parallelism since we can move on and handle the next
device in queue in an earlier phase.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index bb5645e..35fa368 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -380,7 +380,7 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 
 	pm_runtime_barrier(dev);
 	ret = really_probe(dev, drv);
-	pm_runtime_idle(dev);
+	pm_request_idle(dev);
 
 	return ret;
 }
@@ -428,7 +428,7 @@ int device_attach(struct device *dev)
 		}
 	} else {
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
-		pm_runtime_idle(dev);
+		pm_request_idle(dev);
 	}
 out_unlock:
 	device_unlock(dev);
@@ -499,7 +499,7 @@ static void __device_release_driver(struct device *dev)
 						     BUS_NOTIFY_UNBIND_DRIVER,
 						     dev);
 
-		pm_runtime_put_sync(dev);
+		pm_runtime_put(dev);
 
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
-- 
1.7.10
