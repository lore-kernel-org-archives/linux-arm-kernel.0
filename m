From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 14:47:45 +0200
Subject: [PATCH] staging/lustre/lvfs: fix building without CONFIG_PROC_FS
Message-ID: <2146246.DTeNN9Vm3N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "staging/lustre/lvfs: remove the lvfs layer" moved some code around
that was previously only built when CONFIG_PROC_FS was set, which now
causes an invalid access to the obd_memory variable:

ERROR: "obd_memory" [drivers/staging/lustre/lustre/obdclass/obdclass.ko] undefined!

This fixes it by using adding a compile-time check around the access.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: fdedd94509fd ("staging/lustre/lvfs: remove the lvfs layer")
Cc: James Simmons <uja.ornl@gmail.com>
Cc: Mikhail Pershin <mike.pershin@intel.com>
Cc: John L. Hammond <john.hammond@intel.com>
Cc: Jian Yu <jian.yu@intel.com>
Cc: Bob Glossman <bob.glossman@intel.com>
Cc: Oleg Drokin <oleg.drokin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/lustre/lustre/obdclass/class_obd.c b/drivers/staging/lustre/lustre/obdclass/class_obd.c
index 8b8d338e41e8..7265ecbc6f9d 100644
--- a/drivers/staging/lustre/lustre/obdclass/class_obd.c
+++ b/drivers/staging/lustre/lustre/obdclass/class_obd.c
@@ -534,20 +534,23 @@ static int __init init_obdclass(void)
 	spin_lock_init(&obd_types_lock);
 	obd_zombie_impexp_init();
 
-	obd_memory = lprocfs_alloc_stats(OBD_STATS_NUM,
-					 LPROCFS_STATS_FLAG_NONE |
-					 LPROCFS_STATS_FLAG_IRQ_SAFE);
-	if (obd_memory == NULL) {
-		CERROR("kmalloc of 'obd_memory' failed\n");
-		return -ENOMEM;
-	}
-
-	lprocfs_counter_init(obd_memory, OBD_MEMORY_STAT,
-			     LPROCFS_CNTR_AVGMINMAX,
-			     "memused", "bytes");
-	lprocfs_counter_init(obd_memory, OBD_MEMORY_PAGES_STAT,
-			     LPROCFS_CNTR_AVGMINMAX,
-			     "pagesused", "pages");
+	if (IS_ENABLED(CONFIG_PROC_FS)) {
+		obd_memory = lprocfs_alloc_stats(OBD_STATS_NUM,
+						 LPROCFS_STATS_FLAG_NONE |
+						 LPROCFS_STATS_FLAG_IRQ_SAFE);
+
+		if (obd_memory == NULL) {
+			CERROR("kmalloc of 'obd_memory' failed\n");
+			return -ENOMEM;
+		}
+
+		lprocfs_counter_init(obd_memory, OBD_MEMORY_STAT,
+				     LPROCFS_CNTR_AVGMINMAX,
+				     "memused", "bytes");
+		lprocfs_counter_init(obd_memory, OBD_MEMORY_PAGES_STAT,
+				     LPROCFS_CNTR_AVGMINMAX,
+				     "pagesused", "pages");
+	}
 
 	err = obd_init_checks();
 	if (err == -EOVERFLOW)
