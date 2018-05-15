From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 15 May 2018 11:13:37 -0600
Subject: [PATCH 3/3] coresight: Remove function coresight_vpid_to_pid()
In-Reply-To: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
References: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1526404417-32507-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we prevent users from using contextID tracing when PID namespaces
are involved there is no client for function coresight_vpid_to_pid().  As
such simply remove it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c265e0468414..e5421b83e4e6 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -267,24 +267,4 @@ static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
 
-#ifdef CONFIG_PID_NS
-static inline unsigned long
-coresight_vpid_to_pid(unsigned long vpid)
-{
-	struct task_struct *task = NULL;
-	unsigned long pid = 0;
-
-	rcu_read_lock();
-	task = find_task_by_vpid(vpid);
-	if (task)
-		pid = task_pid_nr(task);
-	rcu_read_unlock();
-
-	return pid;
-}
-#else
-static inline unsigned long
-coresight_vpid_to_pid(unsigned long vpid) { return vpid; }
-#endif
-
 #endif
-- 
2.7.4
