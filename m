From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed,  3 May 2017 16:37:45 +0100
Subject: [PATCH v2 1/4] arm64: traps: fix userspace cache maintenance
 emulation on a tagged pointer
In-Reply-To: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
References: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1493825868-30872-2-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we emulate userspace cache maintenance in the kernel, we can
currently send the task a SIGSEGV even though the maintenance was done
on a valid address. This happens if the address has a non-zero address
tag, and happens to not be mapped in.

When we get the address from a user register, we don't currently remove
the address tag before performing cache maintenance on it. If the
maintenance faults, we end up in either __do_page_fault, where find_vma
can't find the VMA if the address has a tag, or in do_translation_fault,
where the tagged address will appear to be above TASK_SIZE. In both
cases, the address is not mapped in, and the task is sent a SIGSEGV.

This patch removes the tag from the address before using it. With this
patch, the fault is handled correctly, the address gets mapped in, and
the cache maintenance succeeds.

As a second bug, if cache maintenance (correctly) fails on an invalid
tagged address, the address gets passed into arm64_notify_segfault,
where find_vma fails to find the VMA due to the tag, and the wrong
si_code may be sent as part of the siginfo_t of the segfault. With this
patch, the correct si_code is sent.

Fixes: 7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on errata-affected core")
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---

Note that patch #3 would also fix the first bug (incorrect segfault),
but not the second (wrong si_code), hence this patch.

 arch/arm64/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e52be6aa44ee..45c8eca951bc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -443,7 +443,7 @@ int cpu_enable_cache_maint_trap(void *__unused)
 }
 
 #define __user_cache_maint(insn, address, res)			\
-	if (untagged_addr(address) >= user_addr_max()) {	\
+	if (address >= user_addr_max()) {			\
 		res = -EFAULT;					\
 	} else {						\
 		uaccess_ttbr0_enable();				\
@@ -469,7 +469,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	int crm = (esr & ESR_ELx_SYS64_ISS_CRM_MASK) >> ESR_ELx_SYS64_ISS_CRM_SHIFT;
 	int ret = 0;
 
-	address = pt_regs_read_reg(regs, rt);
+	address = untagged_addr(pt_regs_read_reg(regs, rt));
 
 	switch (crm) {
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAU:	/* DC CVAU, gets promoted */
-- 
2.1.4
