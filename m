From: imre.deak@nokia.com (Imre Deak)
Date: Tue, 29 Sep 2009 13:07:46 +0300
Subject: [PATCH v3] ARM: add debug check for invalid kernel page faults
In-Reply-To: <20090928113412.GD10671@n2100.arm.linux.org.uk>
References: <20090928113412.GD10671@n2100.arm.linux.org.uk>
Message-ID: <1254218866-29915-1-git-send-email-imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Imre Deak <imre.deak@nokia.com>

According to the following in arch/arm/mm/fault.c page faults from
kernel mode are invalid if mmap_sem is already held and there is
no fixup handler defined for the faulting instruction:

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
fixup handler is defined for them, regardless whether mmap_sem is
held at the time of fault.

To easier detect code that can trigger the above error, add a check
also for the case where mmap_sem is acquired. As this has an overhead
make it a VM debug check.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---

Instead of a warning kill the process if the problem is detected.

 arch/arm/mm/fault.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index cc8829d..b5e9c88 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -278,6 +278,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
 			goto no_context;
 		down_read(&mm->mmap_sem);
+	} else {
+#ifdef CONFIG_DEBUG_VM
+		if (!user_mode(regs) &&
+		    !search_exception_tables(regs->ARM_pc))
+			goto no_context;
+#endif
 	}
 
 	fault = __do_page_fault(mm, addr, fsr, tsk);
-- 
1.6.3.3
