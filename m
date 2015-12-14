From: huawei.libin@huawei.com (Li Bin)
Date: Mon, 14 Dec 2015 20:49:36 +0800
Subject: [RFC PATCH 1/3] livepatch: allow arch specific implementation
In-Reply-To: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1450097378-3780-2-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow klp_enable_func/klp_disable_func be specific implementation
for different arch.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 kernel/livepatch/core.c |   45 +++++++++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index db545cb..0a8cf96 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -350,15 +350,10 @@ unlock:
 	rcu_read_unlock();
 }
 
-static void klp_disable_func(struct klp_func *func)
+void __weak arch_klp_disable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
 
-	if (WARN_ON(func->state != KLP_ENABLED))
-		return;
-	if (WARN_ON(!func->old_addr))
-		return;
-
 	ops = klp_find_ops(func->old_addr);
 	if (WARN_ON(!ops))
 		return;
@@ -373,21 +368,23 @@ static void klp_disable_func(struct klp_func *func)
 	} else {
 		list_del_rcu(&func->stack_node);
 	}
+}
+static void klp_disable_func(struct klp_func *func)
+{
+	if (WARN_ON(func->state != KLP_ENABLED))
+		return;
+	if (WARN_ON(!func->old_addr))
+		return;
 
+	arch_klp_disable_func(func);
 	func->state = KLP_DISABLED;
 }
 
-static int klp_enable_func(struct klp_func *func)
+int __weak arch_klp_enable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
 	int ret;
 
-	if (WARN_ON(!func->old_addr))
-		return -EINVAL;
-
-	if (WARN_ON(func->state != KLP_DISABLED))
-		return -EINVAL;
-
 	ops = klp_find_ops(func->old_addr);
 	if (!ops) {
 		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
@@ -424,10 +421,7 @@ static int klp_enable_func(struct klp_func *func)
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 	}
 
-	func->state = KLP_ENABLED;
-
 	return 0;
-
 err:
 	list_del_rcu(&func->stack_node);
 	list_del(&ops->node);
@@ -435,6 +429,25 @@ err:
 	return ret;
 }
 
+static int klp_enable_func(struct klp_func *func)
+{
+	int ret;
+
+	if (WARN_ON(!func->old_addr))
+		return -EINVAL;
+
+	if (WARN_ON(func->state != KLP_DISABLED))
+		return -EINVAL;
+
+	ret = arch_klp_enable_func(func);
+	if (ret)
+		return ret;
+
+	func->state = KLP_ENABLED;
+
+	return 0;
+}
+
 static void klp_disable_object(struct klp_object *obj)
 {
 	struct klp_func *func;
-- 
1.7.1
