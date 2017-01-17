From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 17 Jan 2017 16:44:56 +0530
Subject: [RFC PATCH] initramfs: finish fput() before accessing any binary from
 initramfs
Message-ID: <20170117111456.2269-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 4a9d4b024a31 ("switch fput to task_work_add") implements a
schedule_work() for completing fput(), but did not guarantee calling
__fput() after unpacking initramfs. Because of this, there is a
possibility that during boot a driver can see ETXTBSY when it tries
to load a binary from initramfs as fput() is still pending on that
binary. This patch makes sure that fput() is completed after unpacking
initramfs.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---

- Reproduced on TI K2HK EVM. K2HK Queue Manager subsystem driver[1] tries
to load a firmware from initramfs during boot. Sometimes loading of this
firmware fails with error ETXTBSY. Digging a bit more observed that
deny_write_access() is returning ETXTBSY as inode->i_writecount is > 0
for that file. This is because Unpacking initramfs does a
get_write_access(from open) but hasn't done put_write_access(from fput)
as it hasn't been scheduled yet.

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/ti/knav_qmss_queue.c

 init/initramfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index b32ad7d97ac9..c42c69b48a4b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -18,6 +18,7 @@
 #include <linux/dirent.h>
 #include <linux/syscalls.h>
 #include <linux/utime.h>
+#include <linux/file.h>
 
 static ssize_t __init xwrite(int fd, const char *p, size_t count)
 {
@@ -652,6 +653,7 @@ static int __init populate_rootfs(void)
 		 * us a chance to load before device_initcalls.
 		 */
 		load_default_modules();
+		flush_delayed_fput();
 	}
 	return 0;
 }
-- 
2.11.0
