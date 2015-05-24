From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 25 May 2015 01:01:32 +0900
Subject: [RFC PATCH 1/2] kernel/fork.c: add a function to calculate page
 address from thread_info
Message-ID: <1432483292-23109-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A current implementation assumes thread_info address is always correctly
calculated via virt_to_page. It restricts a different approach, such as
thread_info allocation from vmalloc space.

This patch, thus, introduces an independent function to calculate page
address from thread_info one.

Suggested-by: Sungjinn Chung <barami97@gmail.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 kernel/fork.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 03c1eaa..6300bbd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -212,9 +212,14 @@ struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
+struct page * __weak arch_thread_info_to_page(struct thread_info *ti)
+{
+	return virt_to_page(ti);
+}
+
 static void account_kernel_stack(struct thread_info *ti, int account)
 {
-	struct zone *zone = page_zone(virt_to_page(ti));
+	struct zone *zone = page_zone(arch_thread_info_to_page(ti));
 
 	mod_zone_page_state(zone, NR_KERNEL_STACK, account);
 }
-- 
1.9.1
