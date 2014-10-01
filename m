From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  1 Oct 2014 13:07:59 +0100
Subject: [PATCHv2 5/5] arm64: Trace emulation of AArch32 legacy instructions
In-Reply-To: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1412165279-8709-6-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce an event to trace the usage of emulated instructions. The
trace event is intended to help identify and encourage the migration
of legacy software using the emulation features.

Use this event to trace usage of swp and CP15 barrier emulation.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c |   19 ++++++++++++++++--
 include/trace/events/emulation.h     |   35 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/emulation.h

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 53a6252..1726b3f 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -16,6 +16,9 @@
 #include <linux/sched.h>
 #include <linux/sysctl.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/emulation.h>
+
 #include <asm/insn.h>
 #include <asm/opcodes.h>
 #include <asm/system_misc.h>
@@ -189,6 +192,11 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 		regs->user_regs.regs[destreg] = data;
 
 ret:
+	if (type == TYPE_SWPB)
+		trace_instruction_emulation("swpb", regs->pc);
+	else
+		trace_instruction_emulation("swp", regs->pc);
+
 	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
 			current->comm, (unsigned long)current->pid, regs->pc);
 
@@ -283,16 +291,23 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
 		 * dmb - mcr p15, 0, Rt, c7, c10, 5
 		 * dsb - mcr p15, 0, Rt, c7, c10, 4
 		 */
-		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
+		if (aarch32_insn_mcr_extract_opc2(instr) == 5) {
 			dmb(sy);
-		else
+			trace_instruction_emulation(
+				"mcr p15, 0, Rt, c7, c10, 5", regs->pc);
+		} else {
 			dsb(sy);
+			trace_instruction_emulation(
+				"mcr p15, 0, Rt, c7, c10, 4", regs->pc);
+		}
 		break;
 	case 5:
 		/*
 		 * isb - mcr p15, 0, Rt, c7, c5, 4
 		 */
 		isb();
+		trace_instruction_emulation(
+			"mcr p15, 0, Rt, c7, c5, 4", regs->pc);
 		break;
 	}
 
diff --git a/include/trace/events/emulation.h b/include/trace/events/emulation.h
new file mode 100644
index 0000000..e77726a
--- /dev/null
+++ b/include/trace/events/emulation.h
@@ -0,0 +1,35 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM emulation
+
+#if !defined(_TRACE_EMULATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EMULATION_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(instruction_emulation,
+
+	TP_PROTO(const char *instr, u64 addr),
+	TP_ARGS(instr, addr),
+
+	TP_STRUCT__entry(
+		__array(char, comm, TASK_COMM_LEN)
+		__field(pid_t, pid)
+		__string(instr, instr)
+		__field(u64, addr)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->pid = current->pid;
+		__assign_str(instr, instr);
+		__entry->addr = addr;
+	),
+
+	TP_printk("instr=%s comm=%s pid=%d addr=0x%llx", __get_str(instr),
+		__entry->comm, __entry->pid, __entry->addr)
+);
+
+#endif /* _TRACE_EMULATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.10.4
