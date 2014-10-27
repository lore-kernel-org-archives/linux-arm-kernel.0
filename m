From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 27 Oct 2014 18:40:07 +0000
Subject: [PATCHv3 5/5] arm64: Trace emulation of AArch32 legacy instructions
In-Reply-To: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1414435207-30240-7-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce an event to trace the usage of emulated instructions. The
trace event is intended to help identify and encourage the migration
of legacy software using the emulation features.

Use this event to trace usage of swp and CP15 barrier emulation.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/kernel/Makefile                 |  1 +
 arch/arm64/kernel/armv8_deprecated.c       | 19 ++++++++++++--
 arch/arm64/kernel/trace-events-emulation.h | 40 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/trace-events-emulation.h

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 5362578..1fc7abd 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -5,6 +5,7 @@
 CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_efi-stub.o 	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
+CFLAGS_armv8_deprecated.o := -I$(src)
 
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index fded15f..d376fe2 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -15,6 +15,9 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace-events-emulation.h"
+
 #include <asm/insn.h>
 #include <asm/opcodes.h>
 #include <asm/system_misc.h>
@@ -203,6 +206,11 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 		regs->user_regs.regs[destreg] = data;
 
 ret:
+	if (type == TYPE_SWPB)
+		trace_instruction_emulation("swpb", regs->pc);
+	else
+		trace_instruction_emulation("swp", regs->pc);
+
 	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
 			current->comm, (unsigned long)current->pid, regs->pc);
 
@@ -260,16 +268,23 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
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
 
diff --git a/arch/arm64/kernel/trace-events-emulation.h b/arch/arm64/kernel/trace-events-emulation.h
new file mode 100644
index 0000000..73aa750
--- /dev/null
+++ b/arch/arm64/kernel/trace-events-emulation.h
@@ -0,0 +1,40 @@
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
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+
+#define TRACE_INCLUDE_FILE trace-events-emulation
+#include <trace/define_trace.h>
-- 
2.1.1
