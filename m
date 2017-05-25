From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 25 May 2017 14:51:46 +0100
Subject: [PATCH v2] mm/migrate: Fix ref-count handling when
 !hugepage_migration_supported()
Message-ID: <20170525135146.32011-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On failing to migrate a page, soft_offline_huge_page() performs the
necessary update to the hugepage ref-count. When
!hugepage_migration_supported() , unmap_and_move_hugepage() also
decrements the page ref-count for the hugepage. The combined behaviour
leaves the ref-count in an inconsistent state.

This leads to soft lockups when running the overcommitted hugepage test
from mce-tests suite.

Soft offlining pfn 0x83ed600 at process virtual address 0x400000000000
soft offline: 0x83ed600: migration failed 1, type
1fffc00000008008 (uptodate|head)
INFO: rcu_preempt detected stalls on CPUs/tasks:
 Tasks blocked on level-0 rcu_node (CPUs 0-7): P2715
  (detected by 7, t=5254 jiffies, g=963, c=962, q=321)
  thugetlb_overco R  running task        0  2715   2685 0x00000008
  Call trace:
  [<ffff000008089f90>] dump_backtrace+0x0/0x268
  [<ffff00000808a2d4>] show_stack+0x24/0x30
  [<ffff000008100d34>] sched_show_task+0x134/0x180
  [<ffff0000081c90fc>] rcu_print_detail_task_stall_rnp+0x54/0x7c
  [<ffff00000813cfd4>] rcu_check_callbacks+0xa74/0xb08
  [<ffff000008143a3c>] update_process_times+0x34/0x60
  [<ffff0000081550e8>] tick_sched_handle.isra.7+0x38/0x70
  [<ffff00000815516c>] tick_sched_timer+0x4c/0x98
  [<ffff0000081442e0>] __hrtimer_run_queues+0xc0/0x300
  [<ffff000008144fa4>] hrtimer_interrupt+0xac/0x228
  [<ffff0000089a56d4>] arch_timer_handler_phys+0x3c/0x50
  [<ffff00000812f1bc>] handle_percpu_devid_irq+0x8c/0x290
  [<ffff0000081297fc>] generic_handle_irq+0x34/0x50
  [<ffff000008129f00>] __handle_domain_irq+0x68/0xc0
  [<ffff0000080816b4>] gic_handle_irq+0x5c/0xb0

Address this by changing the putback_active_hugepage() in
soft_offline_huge_page() to putback_movable_pages().

Reported-by: Manoj Iyer <manoj.iyer@canonical.com>
Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: <stable@kernel.org>  # v3.14+
--

Changes since v1:
* Added stable tag

* Updated patch to use putback_movable_pages() in
  soft_offline_huge_page() in place of dropping
  putback_active_hugepage() when hugepage migration is not enabled.

This patch was tested on v4.12-rc2 with the series to enable memory
corruption handling[0].

[0] https://www.spinics.net/lists/arm-kernel/msg581657.html
---
 mm/memory-failure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 44a6a33af219..89f9924777fa 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1603,7 +1603,8 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		 * only one hugepage pointed to by hpage, so we need not
 		 * run through the pagelist here.
 		 */
-		putback_active_hugepage(hpage);
+		if (!list_empty(&pagelist))
+			putback_movable_pages(&pagelist);
 		if (ret > 0)
 			ret = -EIO;
 	} else {
-- 
2.11.0
