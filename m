From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri,  1 Jun 2018 13:10:01 +0200
Subject: [PATCH 3/6] staging: vc04_services: move client dbg directory into
 static variable
In-Reply-To: <20180601111004.1670-1-gregkh@linuxfoundation.org>
References: <20180601111004.1670-1-gregkh@linuxfoundation.org>
Message-ID: <20180601111004.1670-3-gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This does not need to be part of a wrapper function, or in a structure,
just properly reference it directly as a single variable.

The whole variable will be going away soon anyway, this is just a step
toward that direction.

Suggested-by: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Keerthi Reddy <keerthigd4990@gmail.com>
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../interface/vchiq_arm/vchiq_debugfs.c        | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 8b46256a97fc..12ed560c95a7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -53,17 +53,15 @@
 
 /* Top-level debug info */
 struct vchiq_debugfs_info {
-	/* one entry per client process */
-	struct dentry *clients;
-
 	/* log categories */
 	struct dentry *log_categories;
 };
 
 static struct vchiq_debugfs_info debugfs_info;
 
-/* Global 'vchiq' debugfs entry used by all instances */
+/* Global 'vchiq' debugfs and clients entry used by all instances */
 struct dentry *vchiq_dbg_dir;
+struct dentry *vchiq_dbg_clients;
 
 /* Log category debugfs entries */
 struct vchiq_debugfs_log_entry {
@@ -81,8 +79,6 @@ static struct vchiq_debugfs_log_entry vchiq_debugfs_log_entries[] = {
 };
 static int n_log_entries = ARRAY_SIZE(vchiq_debugfs_log_entries);
 
-static struct dentry *vchiq_clients_top(void);
-
 static int debugfs_log_show(struct seq_file *f, void *offset)
 {
 	int *levp = f->private;
@@ -262,12 +258,11 @@ void vchiq_debugfs_add_instance(VCHIQ_INSTANCE_T instance)
 {
 	char pidstr[16];
 	struct dentry *top;
-	struct dentry *clients = vchiq_clients_top();
 
 	snprintf(pidstr, sizeof(pidstr), "%d",
 		 vchiq_instance_get_pid(instance));
 
-	top = debugfs_create_dir(pidstr, clients);
+	top = debugfs_create_dir(pidstr, vchiq_dbg_clients);
 
 	debugfs_create_file("use_count", 0444, top, instance,
 			    &debugfs_usecount_fops);
@@ -286,7 +281,7 @@ void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
 void vchiq_debugfs_init(void)
 {
 	vchiq_dbg_dir = debugfs_create_dir("vchiq", NULL);
-	debugfs_info.clients = debugfs_create_dir("clients", vchiq_dbg_dir);
+	vchiq_dbg_clients = debugfs_create_dir("clients", vchiq_dbg_dir);
 
 	vchiq_debugfs_create_log_entries(vchiq_dbg_dir);
 }
@@ -297,11 +292,6 @@ void vchiq_debugfs_deinit(void)
 	debugfs_remove_recursive(vchiq_dbg_dir);
 }
 
-static struct dentry *vchiq_clients_top(void)
-{
-	return debugfs_info.clients;
-}
-
 #else /* CONFIG_DEBUG_FS */
 
 void vchiq_debugfs_init(void)
-- 
2.17.1
