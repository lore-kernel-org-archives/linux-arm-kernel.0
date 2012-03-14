From: ccross@android.com (Colin Cross)
Date: Wed, 14 Mar 2012 11:29:51 -0700
Subject: [PATCHv2 2/5] cpuidle: fix error handling in __cpuidle_register_device
In-Reply-To: <1331749794-8056-1-git-send-email-ccross@android.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
Message-ID: <1331749794-8056-3-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the error handling in __cpuidle_register_device to include
the missing list_del.  Move it to a label, which will simplify
the error handling when coupled states are added.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/cpuidle/cpuidle.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

v2:
   * fix after rename of sys_dev to cpu_dev
   * reorder error path to reverse of probe path

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 1453830..aacf2f0 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -319,13 +319,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
-	if ((ret = cpuidle_add_sysfs(cpu_dev))) {
-		module_put(cpuidle_driver->owner);
-		return ret;
-	}
+	ret = cpuidle_add_sysfs(cpu_dev);
+	if (ret)
+		goto err_sysfs;
 
 	dev->registered = 1;
 	return 0;
+
+err_sysfs:
+	list_del(&dev->device_list);
+	per_cpu(cpuidle_devices, dev->cpu) = NULL;
+	module_put(cpuidle_driver->owner);
+	return ret;
 }
 
 /**
-- 
1.7.9.2
