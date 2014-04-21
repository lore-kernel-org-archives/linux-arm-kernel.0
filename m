From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Apr 2014 20:07:17 +0200
Subject: [PATCH] ARM: fix v7-M setup stack location
Message-ID: <1398103637-22828-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__v7m_setup_stack currently sits in the .proc.info.init section, and
thus creates a bogus proc info entry (which by the way matches any
unknown CPU IDs, due to the entry's mask being 0).  Move it out of
there.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/mm/proc-v7m.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 0c93588..1ca37c7 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -123,6 +123,11 @@ __v7m_setup:
 	mov	pc, lr
 ENDPROC(__v7m_setup)
 
+	.align 2
+__v7m_setup_stack:
+	.space	4 * 8				@ 8 registers
+__v7m_setup_stack_top:
+
 	define_processor_functions v7m, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
 	.section ".rodata"
@@ -152,6 +157,3 @@ __v7m_proc_info:
 	.long	nop_cache_fns		@ proc_info_list.cache
 	.size	__v7m_proc_info, . - __v7m_proc_info
 
-__v7m_setup_stack:
-	.space	4 * 8				@ 8 registers
-__v7m_setup_stack_top:
-- 
1.9.1
