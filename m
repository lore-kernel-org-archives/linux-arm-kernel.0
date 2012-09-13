From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Sep 2012 16:40:46 +0100
Subject: [PATCH v2] ARM: perf: add guest vs host discrimination
Message-ID: <1347550846-10158-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimal guest support to perf, so it can distinguish whether
the PMU interrupt was in the host or the guest, as well as collecting
some very basic information (guest PC, user vs kernel mode).

This is not feature complete though, as it doesn't support backtracing
in the guest.

Based on the x86 implementation, tested with KVM/ARM.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Hi Will,

This is v2 of this patch, based on your perf/updates branch.
If you don't have any additional comment, can you please merge it?

Thanks,

	M.

 arch/arm/include/asm/perf_event.h |  5 +++++
 arch/arm/kernel/perf_event.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 625cd62..00416ed 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -21,4 +21,9 @@
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
 #define CACHE_OP_UNSUPPORTED		0xFFFF
 
+struct pt_regs;
+extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_misc_flags(struct pt_regs *regs);
+#define perf_misc_flags(regs)	perf_misc_flags(regs)
+
 #endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 93971b1..27413aa 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -572,6 +572,10 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 {
 	struct frame_tail __user *tail;
 
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
 
 	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
 
@@ -599,9 +603,41 @@ perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
 {
 	struct stackframe fr;
 
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+
 	fr.fp = regs->ARM_fp;
 	fr.sp = regs->ARM_sp;
 	fr.lr = regs->ARM_lr;
 	fr.pc = regs->ARM_pc;
 	walk_stackframe(&fr, callchain_trace, entry);
 }
+
+unsigned long perf_instruction_pointer(struct pt_regs *regs)
+{
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+		return perf_guest_cbs->get_guest_ip();
+
+	return instruction_pointer(regs);
+}
+
+unsigned long perf_misc_flags(struct pt_regs *regs)
+{
+	int misc = 0;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		if (perf_guest_cbs->is_user_mode())
+			misc |= PERF_RECORD_MISC_GUEST_USER;
+		else
+			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+	} else {
+		if (user_mode(regs))
+			misc |= PERF_RECORD_MISC_USER;
+		else
+			misc |= PERF_RECORD_MISC_KERNEL;
+	}
+
+	return misc;
+}
-- 
1.7.12
