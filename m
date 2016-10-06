From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu,  6 Oct 2016 17:30:29 -0400
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
Message-ID: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit acc29fb8f792 ("debugfs: ->d_parent is never NULL or
negative") as it breaks the debugfs_remove_recursive API as show in the
callstack below.

Tested against:
c802e87 Add linux-next specific files for 20161006

Unable to handle kernel NULL pointer dereference at virtual address
000000a8
pgd = ffff800bc81c1000
[000000a8] *pgd=0000004bc83e1003, *pud=0000004bc6519003,
*pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 13 PID: 1758 Comm: tee Not tainted 4.8.0-next-20161006-00013-gd66147c
Hardware name: (null) (DT)
task: ffff800bc7fe0000 task.stack: ffff800bc645c000
PC is at down_write+0x18/0x68
LR is at debugfs_remove_recursive+0x50/0x1c0
pc : [<ffff00000889f480>] lr : [<ffff00000831c220>] pstate: 80000145

[<ffff00000889f480>] down_write+0x18/0x68
[<ffff00000831c220>] debugfs_remove_recursive+0x50/0x1c0
[<ffff00000848e0a8>] hidma_debug_uninit+0x20/0x30
[<ffff00000848c5d8>] hidma_remove+0x48/0x98
[<ffff000008511b6c>] platform_drv_remove+0x24/0x68
[<ffff00000850fac8>] __device_release_driver+0x80/0x118
[<ffff00000850fb84>] device_release_driver+0x24/0x38
[<ffff00000850e928>] unbind_store+0xe8/0x110
[<ffff00000850dd30>] drv_attr_store+0x20/0x30
[<ffff000008253a48>] sysfs_kf_write+0x48/0x58
[<ffff000008252dd8>] kernfs_fop_write+0xb0/0x1d8
[<ffff0000081dab3c>] __vfs_write+0x1c/0x110
[<ffff0000081db940>] vfs_write+0xa0/0x1b8
[<ffff0000081dcd34>] SyS_write+0x44/0xa0
[<ffff000008082ef0>] el0_svc_naked+0x24/0x28

Reverting this change seems to fix the issue.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 fs/debugfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f17fcf8..02166d6 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -621,6 +621,9 @@ void debugfs_remove(struct dentry *dentry)
 		return;
 
 	parent = dentry->d_parent;
+	if (!parent || d_really_is_negative(parent))
+		return;
+
 	inode_lock(d_inode(parent));
 	ret = __debugfs_remove(dentry, parent);
 	inode_unlock(d_inode(parent));
@@ -651,6 +654,10 @@ void debugfs_remove_recursive(struct dentry *dentry)
 	if (IS_ERR_OR_NULL(dentry))
 		return;
 
+	parent = dentry->d_parent;
+	if (!parent || d_really_is_negative(parent))
+		return;
+
 	parent = dentry;
  down:
 	inode_lock(d_inode(parent));
-- 
1.9.1
