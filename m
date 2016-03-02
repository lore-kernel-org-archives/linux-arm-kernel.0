From: majun258@huawei.com (MaJun)
Date: Wed, 2 Mar 2016 10:47:59 +0800
Subject: [PATCH] Change the spin_lock/unlock_irq interface in
 proc_alloc_inum() function
Message-ID: <1456886879-28128-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

The spin_lock/unlock_irq interface is not safe when this function is called
at some case which need irq disabled.

For example:
	spin_lock_irqsave()
	|
	request_irq() --> proc_alloc_inum()
	|
	spin_unlock_irqrestore()

Reported-by: Fan Jinke <fanjinke1@huawei.com>
Signed-off-by: Ma Jun <majun258@huawei.com>
---
 fs/proc/generic.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index ff3ffc7..4fc1502 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -191,23 +191,24 @@ int proc_alloc_inum(unsigned int *inum)
 {
 	unsigned int i;
 	int error;
+	unsigned long flags;
 
 retry:
 	if (!ida_pre_get(&proc_inum_ida, GFP_KERNEL))
 		return -ENOMEM;
 
-	spin_lock_irq(&proc_inum_lock);
+	spin_lock_irqsave(&proc_inum_lock, flags);
 	error = ida_get_new(&proc_inum_ida, &i);
-	spin_unlock_irq(&proc_inum_lock);
+	spin_unlock_irqrestore(&proc_inum_lock, flags);
 	if (error == -EAGAIN)
 		goto retry;
 	else if (error)
 		return error;
 
 	if (i > UINT_MAX - PROC_DYNAMIC_FIRST) {
-		spin_lock_irq(&proc_inum_lock);
+		spin_lock_irqsave(&proc_inum_lock, flags);
 		ida_remove(&proc_inum_ida, i);
-		spin_unlock_irq(&proc_inum_lock);
+		spin_unlock_irqrestore(&proc_inum_lock, flags);
 		return -ENOSPC;
 	}
 	*inum = PROC_DYNAMIC_FIRST + i;
-- 
1.7.1
