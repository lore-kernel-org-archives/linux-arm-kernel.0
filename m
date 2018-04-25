From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Wed, 25 Apr 2018 08:13:31 -0600
Subject: [PATCH] arm64: mm: Fix false positives in W+X checking
Message-ID: <1524665611-14040-1-git-send-email-jhugo@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

load_module() creates W+X mappings via __vmalloc_node_range() (from
layout_and_allocate()->move_module()->module_alloc()) by using
PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
"call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().

This is a problem because call_rcu_sched() queues work, which can be run
after debug_checkwx() is run, resulting in a race condition.  If hit, the
race results in a nasty splat about insecure W+X mappings, which results
in a poor user experience as these are not the mappings that
debug_checkwx() is intended to catch.

Address the race by flushing the queued work before running
debug_checkwx().

Reported-by: Timur Tabi <timur@codeaurora.org>
Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
Fixes: 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9..40d45fd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -503,6 +503,12 @@ void mark_rodata_ro(void)
 	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
 
+	/*
+	 * load_module() results in W+X mappings, which are cleaned up with
+	 * call_rcu_sched().  Let's make sure that queued work is flushed so
+	 * that we don't hit false positives.
+	 */
+	rcu_barrier_sched();
 	debug_checkwx();
 }
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
