From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri,  1 Jun 2018 13:10:00 +0200
Subject: [PATCH 2/6] staging: vc04_services: remove odd vchiq_debugfs_top()
 wrapper
In-Reply-To: <20180601111004.1670-1-gregkh@linuxfoundation.org>
References: <20180601111004.1670-1-gregkh@linuxfoundation.org>
Message-ID: <20180601111004.1670-2-gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vchiq_debugfs_top() is only a wrapper around a pointer to a dentry, so
just use the dentry directly instead, making it a static variable
instead of part of a static structure.

This also removes the pointless BUG_ON() when checking that dentry as no
one should ever care if debugfs is working or not, and the kernel should
really not panic over something as trivial as that.

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
 .../interface/vchiq_arm/vchiq_debugfs.c       | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 103fec955e2c..8b46256a97fc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -53,9 +53,6 @@
 
 /* Top-level debug info */
 struct vchiq_debugfs_info {
-	/* Global 'vchiq' debugfs entry used by all instances */
-	struct dentry *vchiq_cfg_dir;
-
 	/* one entry per client process */
 	struct dentry *clients;
 
@@ -65,6 +62,9 @@ struct vchiq_debugfs_info {
 
 static struct vchiq_debugfs_info debugfs_info;
 
+/* Global 'vchiq' debugfs entry used by all instances */
+struct dentry *vchiq_dbg_dir;
+
 /* Log category debugfs entries */
 struct vchiq_debugfs_log_entry {
 	const char *name;
@@ -82,7 +82,6 @@ static struct vchiq_debugfs_log_entry vchiq_debugfs_log_entries[] = {
 static int n_log_entries = ARRAY_SIZE(vchiq_debugfs_log_entries);
 
 static struct dentry *vchiq_clients_top(void);
-static struct dentry *vchiq_debugfs_top(void);
 
 static int debugfs_log_show(struct seq_file *f, void *offset)
 {
@@ -163,7 +162,7 @@ static void vchiq_debugfs_create_log_entries(struct dentry *top)
 	struct dentry *dir;
 	size_t i;
 
-	dir = debugfs_create_dir("log", vchiq_debugfs_top());
+	dir = debugfs_create_dir("log", vchiq_dbg_dir);
 	debugfs_info.log_categories = dir;
 
 	for (i = 0; i < n_log_entries; i++) {
@@ -286,17 +285,16 @@ void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
 
 void vchiq_debugfs_init(void)
 {
-	debugfs_info.vchiq_cfg_dir = debugfs_create_dir("vchiq", NULL);
-	debugfs_info.clients = debugfs_create_dir("clients",
-				vchiq_debugfs_top());
+	vchiq_dbg_dir = debugfs_create_dir("vchiq", NULL);
+	debugfs_info.clients = debugfs_create_dir("clients", vchiq_dbg_dir);
 
-	vchiq_debugfs_create_log_entries(vchiq_debugfs_top());
+	vchiq_debugfs_create_log_entries(vchiq_dbg_dir);
 }
 
 /* remove all the debugfs entries */
 void vchiq_debugfs_deinit(void)
 {
-	debugfs_remove_recursive(vchiq_debugfs_top());
+	debugfs_remove_recursive(vchiq_dbg_dir);
 }
 
 static struct dentry *vchiq_clients_top(void)
@@ -304,12 +302,6 @@ static struct dentry *vchiq_clients_top(void)
 	return debugfs_info.clients;
 }
 
-static struct dentry *vchiq_debugfs_top(void)
-{
-	BUG_ON(debugfs_info.vchiq_cfg_dir == NULL);
-	return debugfs_info.vchiq_cfg_dir;
-}
-
 #else /* CONFIG_DEBUG_FS */
 
 void vchiq_debugfs_init(void)
-- 
2.17.1
