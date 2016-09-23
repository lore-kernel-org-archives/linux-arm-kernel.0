From: test.tberghammer@gmail.com (Pavel Labath)
Date: Fri, 23 Sep 2016 16:19:01 +0100
Subject: [PATCH 3/3] selftests: arm64: add test for inexact watchpoint address
 handling
In-Reply-To: <1474643941-109020-1-git-send-email-labath@google.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
Message-ID: <1474643941-109020-3-git-send-email-labath@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a test which triggers hardware watchpoints by memory accesses
of different sizes. Memory accesses of large blocks of memory were
confusing the kernel as in these cases, the address reported by the
hardware did not exactly match the address we were watching.

This is a follow-up to: "arm64: hw_breakpoint: Handle inexact watchpoint
addresses".

Signed-off-by: Pavel Labath <labath@google.com>
---
 tools/testing/selftests/breakpoints/Makefile       |   5 +-
 .../selftests/breakpoints/breakpoint_test-arm.c    | 217 +++++++++++++++++++++
 2 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test-arm.c

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
index 0000000..3ed46b7
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
+	const unsigned int byte_mask = (1 << size) - 1;
+	const unsigned int type = 2; /* Write */
+	const unsigned int enable = 1;
+	const unsigned int control = byte_mask << 5 | type << 3 | enable;
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
