From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Wed, 14 Nov 2018 13:49:21 +0530
Subject: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Message-ID: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

syzbot reported a kernel crash with delayed_uprobe_remove():
  https://lkml.org/lkml/2018/11/1/1244

Backtrace mentioned in the link points to a race between process
exit and uprobe_unregister(). Fix it by locking delayed_uprobe_lock
before calling delayed_uprobe_remove() from put_uprobe().

Reported-by: syzbot+cb1fb754b771caca0a88 at syzkaller.appspotmail.com
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96fb51f3994f..e527c4753d4f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
 		 * gets called, we don't get a chance to remove uprobe from
 		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
 		 */
+		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
+		mutex_unlock(&delayed_uprobe_lock);
 		kfree(uprobe);
 	}
 }
-- 
2.19.1
