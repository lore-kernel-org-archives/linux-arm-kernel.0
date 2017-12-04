From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Mon,  4 Dec 2017 21:53:26 +0530
Subject: [RFC PATCH] arm64: deactivate saved ttbr when mm is deactivated
Message-ID: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A case is observed where a wrong physical address is read,
resulting in a bus error and that happens soon after TTBR0 is
set to the saved ttbr by uaccess_ttbr0_enable. This is always
seen to happen in the exit path of the task.

exception
__arch_copy_from_user
__copy_from_user
probe_kernel_read
get_freepointer_safe
slab_alloc_node
slab_alloc
kmem_cache_alloc
kmem_cache_zalloc
fill_pool
__debug_object_init
debug_object_init
rcuhead_fixup_activate
debug_object_fixup
debug_object_activate
debug_rcu_head_queue
__call_rcu
ep_remove
eventpoll_release_file
__fput
____fput
task_work_run
do_exit

The mm has been released and the pgd is freed, but probe_kernel_read
invoked from slub results in call to __arch_copy_from_user. At the
entry to __arch_copy_from_user, when SW PAN is enabled, this results
in stale value being set to ttbr0. May be a speculative fetch aftwerwards
is resulting in invalid physical address access.

Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
---

I have not tested this patch to see if it fixes the problem.
Sending it early for comments.

 arch/arm64/include/asm/mmu_context.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3257895a..48a3f04 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -221,7 +221,16 @@ static inline void __switch_mm(struct mm_struct *next)
 		update_saved_ttbr0(tsk, next);
 }
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+static inline void deactivate_mm(struct task_struct *tsk, struct mm_struct *mm)
+{
+	if (system_uses_ttbr0_pan())
+		task_thread_info(tsk)->ttbr0 = __pa_symbol(empty_zero_page);
+}
+#else
 #define deactivate_mm(tsk,mm)	do { } while (0)
+#endif
+
 #define activate_mm(prev,next)	switch_mm(prev, next, current)
 
 void verify_cpu_asid_bits(void);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
