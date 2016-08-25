From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Aug 2016 17:50:36 +0200
Subject: [PATCH] arm: sys_oabi-compat: Use kmalloc_array() in two functions
Message-ID: <5deba521-2dd4-cd2e-23d7-226a1a7728c3@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 17:45:23 +0200

Multiplications for the size determination of memory allocations
indicated that array data structures should be processed.
Thus use the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/kernel/sys_oabi-compat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 5f221ac..e624db9 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -285,7 +285,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 		return -EINVAL;
 	if (!access_ok(VERIFY_WRITE, events, sizeof(*events) * maxevents))
 		return -EFAULT;
-	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL);
+	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 	fs = get_fs();
@@ -323,7 +323,7 @@ asmlinkage long sys_oabi_semtimedop(int semid,
 		return -EINVAL;
 	if (!access_ok(VERIFY_READ, tsops, sizeof(*tsops) * nsops))
 		return -EFAULT;
-	sops = kmalloc(sizeof(*sops) * nsops, GFP_KERNEL);
+	sops = kmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
 	if (!sops)
 		return -ENOMEM;
 	err = 0;
-- 
2.9.3
