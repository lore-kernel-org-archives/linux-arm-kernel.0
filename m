From: ccross@android.com (Colin Cross)
Date: Tue, 20 Dec 2011 16:09:06 -0800
Subject: [PATCH 2/3] cpuidle: fix error handling in __cpuidle_register_device
In-Reply-To: <1324426147-16735-1-git-send-email-ccross@android.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
Message-ID: <1324426147-16735-3-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the error handling in __cpuidle_register_device to include
the missing list_del.  Move it to a label, which will simplify
the error handling when coupled states are added.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/cpuidle/cpuidle.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 1486b3c..ea00a16 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -318,13 +318,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
-	if ((ret = cpuidle_add_sysfs(sys_dev))) {
-		module_put(cpuidle_driver->owner);
-		return ret;
-	}
+	ret = cpuidle_add_sysfs(sys_dev);
+	if (ret)
+		goto err_sysfs;
 
 	dev->registered = 1;
 	return 0;
+
+err_sysfs:
+	module_put(cpuidle_driver->owner);
+	list_del(&dev->device_list);
+	per_cpu(cpuidle_devices, dev->cpu) = NULL;
+	return ret;
 }
 
 /**
-- 
1.7.4.1
