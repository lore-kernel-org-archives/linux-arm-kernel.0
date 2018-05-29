From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 May 2018 16:29:38 +0200
Subject: [PATCH 04/13] staging: vc04_services: no need to check debugfs return
 values
In-Reply-To: <20180529142947.3250-1-gregkh@linuxfoundation.org>
References: <20180529142947.3250-1-gregkh@linuxfoundation.org>
Message-ID: <20180529142947.3250-4-gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Clean up the vchiq_arm code by not caring about the value of debugfs
calls.  This ends up removing a number of lines of code that are not
needed.

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Keerthi Reddy <keerthigd4990@gmail.com>
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 13 +---
 .../interface/vchiq_arm/vchiq_debugfs.c       | 72 +++----------------
 .../interface/vchiq_arm/vchiq_debugfs.h       |  4 +-
 3 files changed, 15 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index aaa264f3b598..bc05c69383b8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2018,7 +2018,6 @@ vchiq_open(struct inode *inode, struct file *file)
 	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
 	switch (dev) {
 	case VCHIQ_MINOR: {
-		int ret;
 		VCHIQ_STATE_T *state = vchiq_get_state();
 		VCHIQ_INSTANCE_T instance;
 
@@ -2035,11 +2034,7 @@ vchiq_open(struct inode *inode, struct file *file)
 		instance->state = state;
 		instance->pid = current->tgid;
 
-		ret = vchiq_debugfs_add_instance(instance);
-		if (ret != 0) {
-			kfree(instance);
-			return ret;
-		}
+		vchiq_debugfs_add_instance(instance);
 
 		sema_init(&instance->insert_event, 0);
 		sema_init(&instance->remove_event, 0);
@@ -3630,9 +3625,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto failed_device_create;
 
 	/* create debugfs entries */
-	err = vchiq_debugfs_init();
-	if (err != 0)
-		goto failed_debugfs_init;
+	vchiq_debugfs_init();
 
 	vchiq_log_info(vchiq_arm_log_level,
 		"vchiq: initialised - version %d (min %d), device %d.%d",
@@ -3645,8 +3638,6 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	return 0;
 
-failed_debugfs_init:
-	device_destroy(vchiq_class, vchiq_devid);
 failed_device_create:
 	class_destroy(vchiq_class);
 failed_class_create:
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 766b4fe5f32c..103fec955e2c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -158,15 +158,12 @@ static const struct file_operations debugfs_log_fops = {
 };
 
 /* create an entry under <debugfs>/vchiq/log for each log category */
-static int vchiq_debugfs_create_log_entries(struct dentry *top)
+static void vchiq_debugfs_create_log_entries(struct dentry *top)
 {
 	struct dentry *dir;
 	size_t i;
-	int ret = 0;
 
 	dir = debugfs_create_dir("log", vchiq_debugfs_top());
-	if (!dir)
-		return -ENOMEM;
 	debugfs_info.log_categories = dir;
 
 	for (i = 0; i < n_log_entries; i++) {
@@ -177,14 +174,8 @@ static int vchiq_debugfs_create_log_entries(struct dentry *top)
 					  debugfs_info.log_categories,
 					  levp,
 					  &debugfs_log_fops);
-		if (!dir) {
-			ret = -ENOMEM;
-			break;
-		}
-
 		vchiq_debugfs_log_entries[i].dir = dir;
 	}
-	return ret;
 }
 
 static int debugfs_usecount_show(struct seq_file *f, void *offset)
@@ -268,43 +259,22 @@ static const struct file_operations debugfs_trace_fops = {
 };
 
 /* add an instance (process) to the debugfs entries */
-int vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance)
+void vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance)
 {
 	char pidstr[16];
-	struct dentry *top, *use_count, *trace;
+	struct dentry *top;
 	struct dentry *clients = vchiq_clients_top();
 
 	snprintf(pidstr, sizeof(pidstr), "%d",
 		 vchiq_instance_get_pid(instance));
 
 	top = debugfs_create_dir(pidstr, clients);
-	if (!top)
-		goto fail_top;
-
-	use_count = debugfs_create_file("use_count",
-					0444, top,
-					instance,
-					&debugfs_usecount_fops);
-	if (!use_count)
-		goto fail_use_count;
-
-	trace = debugfs_create_file("trace",
-				    0644, top,
-				    instance,
-				    &debugfs_trace_fops);
-	if (!trace)
-		goto fail_trace;
-
-	vchiq_instance_get_debugfs_node(instance)->dentry = top;
 
-	return 0;
+	debugfs_create_file("use_count", 0444, top, instance,
+			    &debugfs_usecount_fops);
+	debugfs_create_file("trace", 0644, top, instance, &debugfs_trace_fops);
 
-fail_trace:
-	debugfs_remove(use_count);
-fail_use_count:
-	debugfs_remove(top);
-fail_top:
-	return -ENOMEM;
+	vchiq_instance_get_debugfs_node(instance)->dentry = top;
 }
 
 void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
@@ -314,31 +284,13 @@ void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
 	debugfs_remove_recursive(node->dentry);
 }
 
-int vchiq_debugfs_init(void)
+void vchiq_debugfs_init(void)
 {
-	BUG_ON(debugfs_info.vchiq_cfg_dir != NULL);
-
 	debugfs_info.vchiq_cfg_dir = debugfs_create_dir("vchiq", NULL);
-	if (debugfs_info.vchiq_cfg_dir == NULL)
-		goto fail;
-
 	debugfs_info.clients = debugfs_create_dir("clients",
 				vchiq_debugfs_top());
-	if (!debugfs_info.clients)
-		goto fail;
 
-	if (vchiq_debugfs_create_log_entries(vchiq_debugfs_top()) != 0)
-		goto fail;
-
-	return 0;
-
-fail:
-	vchiq_debugfs_deinit();
-	vchiq_log_error(vchiq_arm_log_level,
-		"%s: failed to create debugfs directory",
-		__func__);
-
-	return -ENOMEM;
+	vchiq_debugfs_create_log_entries(vchiq_debugfs_top());
 }
 
 /* remove all the debugfs entries */
@@ -360,18 +312,16 @@ static struct dentry *vchiq_debugfs_top(void)
 
 #else /* CONFIG_DEBUG_FS */
 
-int vchiq_debugfs_init(void)
+void vchiq_debugfs_init(void)
 {
-	return 0;
 }
 
 void vchiq_debugfs_deinit(void)
 {
 }
 
-int vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance)
+void vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance)
 {
-	return 0;
 }
 
 void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
index 1d95e3d70621..3af6397ada19 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
@@ -40,11 +40,11 @@ typedef struct vchiq_debugfs_node_struct {
     struct dentry *dentry;
 } VCHIQ_DEBUGFS_NODE_T;
 
-int vchiq_debugfs_init(void);
+void vchiq_debugfs_init(void);
 
 void vchiq_debugfs_deinit(void);
 
-int vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance);
+void vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance);
 
 void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance);
 
-- 
2.17.0
