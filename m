From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri,  1 Jun 2018 13:10:02 +0200
Subject: [PATCH 4/6] staging: vc04_services: remove struct vchiq_debugfs_info
In-Reply-To: <20180601111004.1670-1-gregkh@linuxfoundation.org>
References: <20180601111004.1670-1-gregkh@linuxfoundation.org>
Message-ID: <20180601111004.1670-4-gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This structure, and the one static variable that was declared with it,
were not being used for anything.  The log_categories field was being
set, but never used again.  So just remove it entirely as it is not
needed at all.

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
 .../interface/vchiq_arm/vchiq_debugfs.c            | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 12ed560c95a7..f18cd56c3634 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -51,14 +51,6 @@
 #define VCHIQ_LOG_INFO_STR    "info"
 #define VCHIQ_LOG_TRACE_STR   "trace"
 
-/* Top-level debug info */
-struct vchiq_debugfs_info {
-	/* log categories */
-	struct dentry *log_categories;
-};
-
-static struct vchiq_debugfs_info debugfs_info;
-
 /* Global 'vchiq' debugfs and clients entry used by all instances */
 struct dentry *vchiq_dbg_dir;
 struct dentry *vchiq_dbg_clients;
@@ -159,16 +151,12 @@ static void vchiq_debugfs_create_log_entries(struct dentry *top)
 	size_t i;
 
 	dir = debugfs_create_dir("log", vchiq_dbg_dir);
-	debugfs_info.log_categories = dir;
 
 	for (i = 0; i < n_log_entries; i++) {
 		void *levp = (void *)vchiq_debugfs_log_entries[i].plevel;
 
 		dir = debugfs_create_file(vchiq_debugfs_log_entries[i].name,
-					  0644,
-					  debugfs_info.log_categories,
-					  levp,
-					  &debugfs_log_fops);
+					  0644, dir, levp, &debugfs_log_fops);
 		vchiq_debugfs_log_entries[i].dir = dir;
 	}
 }
-- 
2.17.1
