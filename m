From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon,  7 Nov 2011 16:16:54 +0000
Subject: [PATCH v8 12/16] ARM: LPAE: Add context switching support
In-Reply-To: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1320682618-1182-13-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With LPAE, TTBRx registers are 64-bit. The ASID is stored in TTBR0
rather than a separate Context ID register. This patch makes the
necessary changes to handle context switching on LPAE.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/context.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 93aac06..ee9bb36 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -22,6 +22,21 @@ unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 DEFINE_PER_CPU(struct mm_struct *, current_mm);
 #endif
 
+#ifdef CONFIG_ARM_LPAE
+#define cpu_set_asid(asid) {						\
+	unsigned long ttbl, ttbh;					\
+	asm volatile(							\
+	"	mrrc	p15, 0, %0, %1, c2		@ read TTBR0\n"	\
+	"	mov	%1, %2, lsl #(48 - 32)		@ set ASID\n"	\
+	"	mcrr	p15, 0, %0, %1, c2		@ set TTBR0\n"	\
+	: "=&r" (ttbl), "=&r" (ttbh)					\
+	: "r" (asid & ~ASID_MASK));					\
+}
+#else
+#define cpu_set_asid(asid) \
+	asm("	mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (asid))
+#endif
+
 /*
  * We fork()ed a process, and we need a new context for the child
  * to run in.  We reserve version 0 for initial tasks so we will
@@ -37,7 +52,7 @@ void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 static void flush_context(void)
 {
 	/* set the reserved ASID before flushing the TLB */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (0));
+	cpu_set_asid(0);
 	isb();
 	local_flush_tlb_all();
 	if (icache_is_vivt_asid_tagged()) {
@@ -99,7 +114,7 @@ static void reset_context(void *info)
 	set_mm_context(mm, asid);
 
 	/* set the new ASID */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
+	cpu_set_asid(mm->context.id);
 	isb();
 }
 
