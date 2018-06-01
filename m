From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri,  1 Jun 2018 13:10:04 +0200
Subject: [PATCH 6/6] staging: vc04_services: no need to save the log debufs
 dentries
In-Reply-To: <20180601111004.1670-1-gregkh@linuxfoundation.org>
References: <20180601111004.1670-1-gregkh@linuxfoundation.org>
Message-ID: <20180601111004.1670-6-gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The log entry dentries are only set, never referenced, so no need to
keep them around.  Remove the pointer from struct
vchiq_debugfs_log_entry as it is not needed anymore and get rid of the
separate vchiq_debugfs_create_log_entries() function as it is only used
in one place.

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
 .../interface/vchiq_arm/vchiq_debugfs.c       | 29 +++++++------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 2b353d2d25ce..38805504d462 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -59,7 +59,6 @@ struct dentry *vchiq_dbg_clients;
 struct vchiq_debugfs_log_entry {
 	const char *name;
 	void *plevel;
-	struct dentry *dir;
 };
 
 static struct vchiq_debugfs_log_entry vchiq_debugfs_log_entries[] = {
@@ -144,23 +143,6 @@ static const struct file_operations debugfs_log_fops = {
 	.release	= single_release,
 };
 
-/* create an entry under <debugfs>/vchiq/log for each log category */
-static void vchiq_debugfs_create_log_entries(struct dentry *top)
-{
-	struct dentry *dir;
-	size_t i;
-
-	dir = debugfs_create_dir("log", vchiq_dbg_dir);
-
-	for (i = 0; i < n_log_entries; i++) {
-		dir = debugfs_create_file(vchiq_debugfs_log_entries[i].name,
-					  0644, dir,
-					  vchiq_debugfs_log_entries[i].plevel,
-					  &debugfs_log_fops);
-		vchiq_debugfs_log_entries[i].dir = dir;
-	}
-}
-
 static int debugfs_usecount_show(struct seq_file *f, void *offset)
 {
 	VCHIQ_INSTANCE_T instance = f->private;
@@ -268,10 +250,19 @@ void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
 
 void vchiq_debugfs_init(void)
 {
+	struct dentry *dir;
+	int i;
+
 	vchiq_dbg_dir = debugfs_create_dir("vchiq", NULL);
 	vchiq_dbg_clients = debugfs_create_dir("clients", vchiq_dbg_dir);
 
-	vchiq_debugfs_create_log_entries(vchiq_dbg_dir);
+	/* create an entry under <debugfs>/vchiq/log for each log category */
+	dir = debugfs_create_dir("log", vchiq_dbg_dir);
+
+	for (i = 0; i < n_log_entries; i++)
+		debugfs_create_file(vchiq_debugfs_log_entries[i].name, 0644,
+				    dir, vchiq_debugfs_log_entries[i].plevel,
+				    &debugfs_log_fops);
 }
 
 /* remove all the debugfs entries */
-- 
2.17.1
