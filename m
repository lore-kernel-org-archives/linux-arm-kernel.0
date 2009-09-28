From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 12:48:24 +0300
Subject: [PATCH] ARM: add warning for invalid kernel page faults
In-Reply-To: <20090928092919.GA30271@localhost>
References: <20090928092919.GA30271@localhost>
Message-ID: <1254131304-32057-1-git-send-email-imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Imre Deak <imre.deak@nokia.com>

According to the following in arch/arm/mm/fault.c page faults from
kernel mode are invalid if mmap_sem is already held and there is
no exception handler defined for the faulting instruction:

/*
 * As per x86, we may deadlock here.  However, since the kernel only
 * validly references user space from well defined areas of the code,
 * we can bug out early if this is from code which shouldn't.
 */
if (!down_read_trylock(&mm->mmap_sem)) {
	if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
		goto no_context;

Since mmap_sem can be held at arbitrary times by another thread this
also means that any page faults from kernel mode are invalid if no
exception handler is defined for them, regardless whether mmap_sem is
held at the time of fault.

To easier detect code that can trigger the above error, add a check
also for the case where mmap_sem is acquired. As this has an overhead
make it a VM debug warning.

This will emit a warning at least for arm_syscall cacheflush users
on VIPT platforms, where the breakage would happen only in a less
likely situation.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/mm/fault.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index cc8829d..d719746 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -278,6 +278,20 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
 			goto no_context;
 		down_read(&mm->mmap_sem);
+#ifdef CONFIG_DEBUG_VM
+		if (!user_mode(regs) &&
+		    !search_exception_tables(regs->ARM_pc)) {
+			static unsigned long last_warn_jiffies;
+
+			if (printk_timed_ratelimit(&last_warn_jiffies, 10000)) {
+				printk(KERN_WARNING
+				       "Invalid kernel paging request at virtual address %08lx",
+				       addr);
+				show_pte(mm, addr);
+				WARN_ON(1);
+			}
+		}
+#endif
 	}
 
 	fault = __do_page_fault(mm, addr, fsr, tsk);
-- 
1.6.3.3
