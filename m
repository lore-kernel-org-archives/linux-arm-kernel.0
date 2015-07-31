From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 31 Jul 2015 09:37:26 -0600
Subject: [PATCH 06/10] Coresight: Add an interface for supporting ETM3/4
 Context ID tracing
In-Reply-To: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
References: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1438357050-22486-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chunyan Zhang <zhang.chunyan@linaro.org>

If PID namespace is enabled, everytime users configure the Context ID
register to trace the specific process, there needs to be a translation
between the real PID seen from the kernel and VPID seen from the
namespace in which the user's process resides .

This patch just adds the translation interface for ETMs.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 3486b9082adb..626da6948ca2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -248,4 +248,24 @@ static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, struct device_node *node) { return NULL; }
 #endif
 
+#ifdef CONFIG_PID_NS
+static inline unsigned long
+coresight_vpid_to_pid(unsigned long vpid)
+{
+	struct task_struct *task = NULL;
+	unsigned long pid = 0;
+
+	rcu_read_lock();
+	task = find_task_by_vpid(vpid);
+	if (task)
+		pid = task_pid_nr(task);
+	rcu_read_unlock();
+
+	return pid;
+}
+#else
+static inline unsigned long
+coresight_vpid_to_pid(unsigned long vpid) { return vpid; }
+#endif
+
 #endif
-- 
1.9.1
