From: credmonster@gmail.com (Chris Redmon)
Date: Wed, 12 Apr 2017 22:20:39 -0400
Subject: [PATCH 2/3] arm: Utilize trace events for major and minor page faults
In-Reply-To: <20170413022040.10156-1-credmonster@gmail.com>
References: <20170413022040.10156-1-credmonster@gmail.com>
Message-ID: <20170413022040.10156-3-credmonster@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Redmon <credmonster@gmail.com>
---
 arch/arm/mm/fault.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ff8b0aa2dfde..e59514f85e01 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -29,6 +29,9 @@
 
 #include "fault.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fault.h>
+
 #ifdef CONFIG_MMU
 
 #ifdef CONFIG_KPROBES
@@ -262,6 +265,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm;
 	int fault, sig, code;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	ktime_t start_time;
+	bool trace_fault_enabled = false;
 
 	if (notify_page_fault(regs, fsr))
 		return 0;
@@ -285,6 +290,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (fsr & FSR_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 
+	if (trace_fault_major_enabled() || trace_fault_minor_enabled()) {
+		start_time = ktime_get();
+		trace_fault_enabled = true;
+	}
+
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -330,10 +340,14 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			tsk->maj_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
 					regs, addr);
+			if (trace_fault_enabled)
+				trace_fault_major(addr, regs, fsr, start_time, flags, fault);
 		} else {
 			tsk->min_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
 					regs, addr);
+			if (trace_fault_enabled)
+				trace_fault_minor(addr, regs, fsr, start_time, flags, fault);
 		}
 		if (fault & VM_FAULT_RETRY) {
 			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-- 
2.12.2.599.gcf11a67
