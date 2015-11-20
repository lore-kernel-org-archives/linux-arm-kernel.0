From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 18:26:07 +0100
Subject: [PATCH] remoteproc: avoid stack overflow in debugfs file
Message-ID: <10169860.4GdufNCNz1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent gcc versions warn about reading from a negative offset of
an on-stack array:

drivers/remoteproc/remoteproc_debugfs.c: In function 'rproc_recovery_write':
drivers/remoteproc/remoteproc_debugfs.c:167:9: warning: 'buf[4294967295u]' may be used uninitialized in this function [-Wmaybe-uninitialized]

I don't see anything in sys_write() that prevents us from
being called with a zero 'count' argument, so we should
add an extra check in rproc_recovery_write() to prevent the
access and avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2e37abb89a2e ("remoteproc: create a 'recovery' debugfs entry")

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 9d30809bb407..916af5096f57 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -156,7 +156,7 @@ rproc_recovery_write(struct file *filp, const char __user *user_buf,
 	char buf[10];
 	int ret;
 
-	if (count > sizeof(buf))
+	if (count < 1 || count > sizeof(buf))
 		return count;
 
 	ret = copy_from_user(buf, user_buf, count);
