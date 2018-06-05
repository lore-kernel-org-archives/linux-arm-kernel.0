From: kim.phillips@arm.com (Kim Phillips)
Date: Tue,  5 Jun 2018 16:07:01 -0500
Subject: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Message-ID: <20180605210710.22227-6-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increment the refcnt for driver modules in current use by calling
module_get in coresight_build_path and module_put in release_path.

This prevents driver modules from being unloaded when they are in use,
either in sysfs or perf mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 338f1719641c..1c941351f1d1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
 
 	node->csdev = csdev;
 	list_add(&node->link, path);
+
+	if (!try_module_get(csdev->dev.parent->driver->owner)) {
+		dev_err(&csdev->dev, "could not get coresight driver module\n");
+		return -ENODEV;
+	}
+
 	pm_runtime_get_sync(csdev->dev.parent);
 
 	return 0;
@@ -510,6 +516,9 @@ void coresight_release_path(struct list_head *path)
 		csdev = nd->csdev;
 
 		pm_runtime_put_sync(csdev->dev.parent);
+
+		module_put(csdev->dev.parent->driver->owner);
+
 		list_del(&nd->link);
 		kfree(nd);
 	}
-- 
2.17.0
