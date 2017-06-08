From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu,  8 Jun 2017 18:25:28 +0100
Subject: [PATCH v3 3/4] arm64: mm: Update perf accounting to handle poison
 faults
In-Reply-To: <20170608172529.11986-1-punit.agrawal@arm.com>
References: <20170608172529.11986-1-punit.agrawal@arm.com>
Message-ID: <20170608172529.11986-4-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-organise the perf accounting for fault handling in preparation for
enabling handling of hardware poison faults in subsequent commits. The
change updates perf accounting to be inline with the behaviour on
x86.

With this update, the perf fault accounting -

  * Always report PERF_COUNT_SW_PAGE_FAULTS

  * Doesn't report anything else for VM_FAULT_ERROR (which includes
    hwpoison faults)

  * Reports PERF_COUNT_SW_PAGE_FAULTS_MAJ if it's a major
    fault (indicated by VM_FAULT_MAJOR)

  * Otherwise, reports PERF_COUNT_SW_PAGE_FAULTS_MIN

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/mm/fault.c | 68 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a85b44343ac6..7e501e7faec1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -342,7 +342,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	int fault, sig, code;
+	int fault, sig, code, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
@@ -381,6 +381,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			die("Accessing user space memory outside uaccess.h routines", regs, esr);
 	}
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -404,24 +406,42 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	}
 
 	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk);
+	major |= fault & VM_FAULT_MAJOR;
 
-	/*
-	 * If we need to retry but a fatal signal is pending, handle the
-	 * signal first. We do not need to release the mmap_sem because it
-	 * would already be released in __lock_page_or_retry in mm/filemap.c.
-	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
-		return 0;
+	if (fault & VM_FAULT_RETRY) {
+		/*
+		 * If we need to retry but a fatal signal is pending,
+		 * handle the signal first. We do not need to release
+		 * the mmap_sem because it would already be released
+		 * in __lock_page_or_retry in mm/filemap.c.
+		 */
+		if (fatal_signal_pending(current))
+			return 0;
+
+		/*
+		 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
+		 * starvation.
+		 */
+		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
+			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			mm_flags |= FAULT_FLAG_TRIED;
+			goto retry;
+		}
+	}
+	up_read(&mm->mmap_sem);
 
 	/*
-	 * Major/minor page fault accounting is only done on the initial
-	 * attempt. If we go through a retry, it is extremely likely that the
-	 * page will be found in page cache at that point.
+	 * Handle the "normal" (no error) case first.
 	 */
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
-	if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
+	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
+			      VM_FAULT_BADACCESS)))) {
+		/*
+		 * Major/minor page fault accounting is only done
+		 * once. If we go through a retry, it is extremely
+		 * likely that the page will be found in page cache at
+		 * that point.
+		 */
+		if (major) {
 			tsk->maj_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
 				      addr);
@@ -430,25 +450,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
 				      addr);
 		}
-		if (fault & VM_FAULT_RETRY) {
-			/*
-			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
-			 * starvation.
-			 */
-			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			mm_flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
-	}
-
-	up_read(&mm->mmap_sem);
 
-	/*
-	 * Handle the "normal" case first - VM_FAULT_MAJOR
-	 */
-	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
-			      VM_FAULT_BADACCESS))))
 		return 0;
+	}
 
 	/*
 	 * If we are in kernel mode at this point, we have no context to
-- 
2.11.0
