From: test.tberghammer@gmail.com (Pavel Labath)
Date: Mon, 12 Sep 2016 15:07:24 +0100
Subject: [PATCH] arm64: hw_breakpoint: Handle inexact watchpoint addresses
Message-ID: <1473689244-147136-1-git-send-email-labath@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 hardware does not always report a watchpoint hit address that
matches one of the watchpoints set. It can also report an address
"near" the watchpoint if a single instruction access both watched and
unwatched addresses. There is no straight-forward way, short of
disassembling the offending instruction, to map that address back to
the watchpoint.

Previously, when the hardware reported a watchpoint hit on an address
that did not match our watchpoint (this happens in case of instructions
which access large chunks of memory such as "stp") the process would
enter a loop where we would be continually resuming it (because we did
not recognise that watchpoint hit) and it would keep hitting the
watchpoint again and again. The tracing process would never get
notified of the watchpoint hit.

This commit fixes the problem by looking at the watchpoints near the
address reported by the hardware. If the address does not exactly match
one of the watchpoints we have set, it attributes the hit to the
nearest watchpoint we have.  This heuristic is a bit dodgy, but I don't
think we can do much more, given the hardware limitations.
I include a kernel selftest which triggers this code.

Signed-off-by: Pavel Labath <labath@google.com>
---
 arch/arm64/kernel/hw_breakpoint.c                  | 104 +++++++---
 tools/testing/selftests/breakpoints/Makefile       |   5 +-
 .../selftests/breakpoints/breakpoint_test-arm.c    | 217 +++++++++++++++++++++
 3 files changed, 298 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test-arm.c

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 26a6bf7..d0ebfe6 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -661,50 +661,80 @@ unlock:
 }
 NOKPROBE_SYMBOL(breakpoint_handler);
 
+/*
+ * Arm64 hardware does not always report a watchpoint hit address that matches
+ * one of the watchpoints set. It can also report an address "near" the
+ * watchpoint if a single instruction access both watched and unwatched
+ * addresses. There is no straight-forward way, short of disassembling the
+ * offending instruction, to map that address back to the watchpoint. This
+ * function computes the distance of the memory access from the watchpoint as a
+ * heuristic for the likelyhood that a given access triggered the watchpoint.
+ *
+ * See Section D2.10.5 "Determining the memory location that caused a Watchpoint
+ * exception" of ARMv8 Architecture Reference Manual for details.
+ *
+ * The function returns the distance of the address from the bytes watched by
+ * the watchpoint. In case of an exact match, it returns 0.
+ */
+static u64 get_distance_from_watchpoint(unsigned long addr, int i,
+					struct arch_hw_breakpoint *info)
+{
+	u64 val, alignment_mask, wp_low, wp_high;
+	u32 ctrl_reg;
+	int first_bit;
+	struct arch_hw_breakpoint_ctrl ctrl;
+
+	/* AArch32 watchpoints are either 4 or 8 bytes aligned. */
+	if (is_compat_task()) {
+		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
+			alignment_mask = 0x7;
+		else
+			alignment_mask = 0x3;
+	} else {
+		alignment_mask = 0x7;
+	}
+
+	val = read_wb_reg(AARCH64_DBG_REG_WVR, i) & ~alignment_mask;
+
+	ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
+	decode_ctrl_reg(ctrl_reg, &ctrl);
+	first_bit = ffs(ctrl.len);
+	if (first_bit == 0)
+		return -1;
+	wp_low = val + first_bit - 1;
+	wp_high = val + fls(ctrl.len) - 1;
+	if (addr < wp_low)
+		return wp_low - addr;
+	else if (addr > wp_high)
+		return addr - wp_high;
+	else
+		return 0;
+
+}
+
 static int watchpoint_handler(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
-	int i, step = 0, *kernel_step, access;
-	u32 ctrl_reg;
-	u64 val, alignment_mask;
+	int i, step = 0, *kernel_step, access, closest_match;
+	u64 min_dist = -1, dist;
 	struct perf_event *wp, **slots;
 	struct debug_info *debug_info;
 	struct arch_hw_breakpoint *info;
-	struct arch_hw_breakpoint_ctrl ctrl;
 
 	slots = this_cpu_ptr(wp_on_reg);
 	debug_info = &current->thread.debug;
 
+	/*
+	 * Find all watchpoints that match the reported address. If no exact
+	 * match is found. Attribute the hit to the closest watchpoint.
+	 */
 	for (i = 0; i < core_num_wrps; ++i) {
 		rcu_read_lock();
 
 		wp = slots[i];
-
 		if (wp == NULL)
 			goto unlock;
 
-		info = counter_arch_bp(wp);
-		/* AArch32 watchpoints are either 4 or 8 bytes aligned. */
-		if (is_compat_task()) {
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
-				alignment_mask = 0x7;
-			else
-				alignment_mask = 0x3;
-		} else {
-			alignment_mask = 0x7;
-		}
-
-		/* Check if the watchpoint value matches. */
-		val = read_wb_reg(AARCH64_DBG_REG_WVR, i);
-		if (val != (addr & ~alignment_mask))
-			goto unlock;
-
-		/* Possible match, check the byte address select to confirm. */
-		ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
-		decode_ctrl_reg(ctrl_reg, &ctrl);
-		if (!((1 << (addr & alignment_mask)) & ctrl.len))
-			goto unlock;
-
 		/*
 		 * Check that the access type matches.
 		 * 0 => load, otherwise => store
@@ -714,6 +744,17 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 		if (!(access & hw_breakpoint_type(wp)))
 			goto unlock;
 
+		info = counter_arch_bp(wp);
+
+		dist = get_distance_from_watchpoint(addr, i, info);
+		if (dist < min_dist) {
+			min_dist = dist;
+			closest_match = i;
+		}
+		/* Is this an exact match? */
+		if (dist != 0)
+			goto unlock;
+
 		info->trigger = addr;
 		perf_bp_event(wp, regs);
 
@@ -724,6 +765,15 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 unlock:
 		rcu_read_unlock();
 	}
+	if (min_dist > 0 && min_dist != -1) {
+		/* No exact match found. */
+		rcu_read_lock();
+		wp = slots[closest_match];
+		info = counter_arch_bp(wp);
+		info->trigger = addr;
+		perf_bp_event(wp, regs);
+		rcu_read_unlock();
+	}
 
 	if (!step)
 		return 0;
diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
index 74e533f..458a31a 100644
--- a/tools/testing/selftests/breakpoints/Makefile
+++ b/tools/testing/selftests/breakpoints/Makefile
@@ -5,6 +5,9 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 ifeq ($(ARCH),x86)
 TEST_PROGS := breakpoint_test
 endif
+ifeq ($(ARCH),arm64)
+TEST_PROGS := breakpoint_test-arm
+endif
 
 TEST_PROGS += step_after_suspend_test
 
@@ -13,4 +16,4 @@ all: $(TEST_PROGS)
 include ../lib.mk
 
 clean:
-	rm -fr breakpoint_test step_after_suspend_test
+	rm -fr breakpoint_test breakpoint_test-arm step_after_suspend_test
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test-arm.c b/tools/testing/selftests/breakpoints/breakpoint_test-arm.c
new file mode 100644
index 0000000..9f00ea6
--- /dev/null
+++ b/tools/testing/selftests/breakpoints/breakpoint_test-arm.c
@@ -0,0 +1,217 @@
+/*
+ * Copyright (C) 2016 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <elf.h>
+#include <signal.h>
+
+#include "../kselftest.h"
+
+enum Test {
+	TEST_WRITE_1, TEST_WRITE_2, TEST_WRITE_4, TEST_WRITE_8,
+	TEST_WRITE_16, TEST_WRITE_32, TEST_MAX
+};
+
+struct Data {
+	union {
+		uint8_t u8[32];
+		uint16_t u16[16];
+		uint32_t u32[8];
+		uint64_t u64[4];
+	};
+};
+volatile struct Data var __aligned(32);
+
+
+void child(enum Test test)
+{
+	if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != 0) {
+		perror("ptrace(PTRACE_TRACEME) failed");
+		_exit(1);
+	}
+
+	if (raise(SIGSTOP) != 0) {
+		perror("raise(SIGSTOP) failed");
+		_exit(1);
+	}
+
+	switch (test) {
+	case TEST_WRITE_1:
+		var.u8[31] = 47;
+		break;
+	case TEST_WRITE_2:
+		var.u16[15] = 47;
+		break;
+	case TEST_WRITE_4:
+		var.u32[7] = 47;
+		break;
+	case TEST_WRITE_8:
+		var.u64[3] = 47;
+		break;
+	case TEST_WRITE_16:
+		__asm__ volatile ("stp x29, x30, %0" : "=m" (var.u64[2]));
+		break;
+	case TEST_WRITE_32:
+		__asm__ volatile ("stp q29, q30, %0" : "=m" (var));
+		break;
+	}
+
+	_exit(0);
+}
+
+static bool set_watchpoint(pid_t pid, const volatile void *address,
+			   size_t size)
+{
+	const unsigned byte_mask = (1 << size) - 1;
+	const unsigned type = 2; /* Write */
+	const unsigned enable = 1;
+	const unsigned control = byte_mask << 5 | type << 3 | enable;
+	struct user_hwdebug_state dreg_state;
+	struct iovec iov;
+
+	memset(&dreg_state, 0, sizeof(dreg_state));
+	dreg_state.dbg_regs[0].addr = (uintptr_t)address;
+	dreg_state.dbg_regs[0].ctrl = control;
+	iov.iov_base = &dreg_state;
+	iov.iov_len = offsetof(struct user_hwdebug_state, dbg_regs) +
+		      sizeof(dreg_state.dbg_regs[0]);
+	if (ptrace(PTRACE_SETREGSET, pid, NT_ARM_HW_WATCH, &iov) == 0)
+		return true;
+
+	if (errno == EIO) {
+		printf("ptrace(PTRACE_SETREGSET, NT_ARM_HW_WATCH) "
+		       "not supported on this hardware\n");
+		ksft_exit_skip();
+	}
+	perror("ptrace(PTRACE_SETREGSET, NT_ARM_HW_WATCH) failed");
+	return false;
+}
+
+
+bool run_test(enum Test test)
+{
+	int status;
+	siginfo_t siginfo;
+	pid_t pid = fork();
+	pid_t wpid;
+
+	if (pid < 0) {
+		perror("fork() failed");
+		return false;
+	}
+	if (pid == 0)
+		child(test);
+
+	wpid = waitpid(pid, &status, __WALL);
+	if (wpid != pid) {
+		perror("waitpid() failed");
+		return false;
+	}
+	if (!WIFSTOPPED(status)) {
+		printf("child did not stop\n");
+		return false;
+	}
+	if (WSTOPSIG(status) != SIGSTOP) {
+		printf("child did not stop with SIGSTOP\n");
+		return false;
+	}
+
+	if (!set_watchpoint(pid, &var.u64[3], 8))
+		return false;
+
+	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
+		perror("ptrace(PTRACE_SINGLESTEP) failed");
+		return false;
+	}
+
+	alarm(3);
+	wpid = waitpid(pid, &status, __WALL);
+	if (wpid != pid) {
+		perror("waitpid() failed");
+		return false;
+	}
+	alarm(0);
+	if (WIFEXITED(status)) {
+		printf("child did not single-step\n");
+		return false;
+	}
+	if (!WIFSTOPPED(status)) {
+		printf("child did not stop\n");
+		return false;
+	}
+	if (WSTOPSIG(status) != SIGTRAP) {
+		printf("child did not stop with SIGTRAP\n");
+		return false;
+	}
+	if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &siginfo) != 0) {
+		perror("ptrace(PTRACE_GETSIGINFO)");
+		return false;
+	}
+	if (siginfo.si_code != TRAP_HWBKPT) {
+		printf("Unexpected si_code %d\n", siginfo.si_code);
+		return false;
+	}
+
+	kill(pid, SIGKILL);
+	wpid = waitpid(pid, &status, 0);
+	if (wpid != pid) {
+		perror("waitpid() failed");
+		return false;
+	}
+	return true;
+}
+
+void sigalrm(int sig)
+{
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+	bool succeeded = true;
+	enum Test test;
+	struct sigaction act;
+
+	act.sa_handler = sigalrm;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = 0;
+	sigaction(SIGALRM, &act, NULL);
+	for (test = 0; test < TEST_MAX; ++test) {
+		printf("Test %d ", test);
+		if (run_test(test)) {
+			printf("[OK]\n");
+			ksft_inc_pass_cnt();
+		} else {
+			printf("[FAILED]\n");
+			ksft_inc_fail_cnt();
+			succeeded = false;
+		}
+	}
+
+	ksft_print_cnts();
+	if (succeeded)
+		ksft_exit_pass();
+	else
+		ksft_exit_fail();
+}
+
-- 
2.8.0.rc3.226.g39d4020
