From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 1 Feb 2017 19:35:40 +0530
Subject: [PATCH v3] initramfs: finish fput() before accessing any binary from
 initramfs
Message-ID: <20170201140540.22051-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 4a9d4b024a31 ("switch fput to task_work_add") implements a
schedule_work() for completing fput(), but did not guarantee calling
__fput() after unpacking initramfs. Because of this, there is a
possibility that during boot a driver can see ETXTBSY when it tries
to load a binary from initramfs as fput() is still pending on that
binary. This patch makes sure that fput() is completed after unpacking
initramfs and removes the call to flush_delayed_fput() in kernel_init()
which happens very late after unpacking initramfs.

Reported-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Link to v2: https://patchwork.kernel.org/patch/9534061/
Changes since v2:
- Dropped calling flush_delayed_fput() in kernel_init() as pointed
 out by Al Viro.

 init/initramfs.c | 2 ++
 init/main.c      | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b32ad7d97ac9..981f286c1d16 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -18,6 +18,7 @@
 #include <linux/dirent.h>
 #include <linux/syscalls.h>
 #include <linux/utime.h>
+#include <linux/file.h>
 
 static ssize_t __init xwrite(int fd, const char *p, size_t count)
 {
@@ -647,6 +648,7 @@ static int __init populate_rootfs(void)
 			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 		free_initrd();
 #endif
+		flush_delayed_fput();
 		/*
 		 * Try loading default modules from initramfs.  This gives
 		 * us a chance to load before device_initcalls.
diff --git a/init/main.c b/init/main.c
index b0c9d6facef9..a8325cc2ad42 100644
--- a/init/main.c
+++ b/init/main.c
@@ -70,7 +70,6 @@
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
-#include <linux/file.h>
 #include <linux/ptrace.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
@@ -961,8 +960,6 @@ static int __ref kernel_init(void *unused)
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
-	flush_delayed_fput();
-
 	rcu_end_inkernel_boot();
 
 	if (ramdisk_execute_command) {
-- 
2.11.0
