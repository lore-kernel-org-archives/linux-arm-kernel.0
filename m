From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  3 Feb 2014 15:56:27 +0900
Subject: [PATCH v3 0/3] arm64: Add audit support
In-Reply-To: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds system call audit support on arm64.
Both 32-bit (AUDIT_ARCH_ARM) and 64-bit tasks (AUDIT_ARCH_AARCH64)
are supported. Since arm64 has the exact same set of system calls
on LE and BE, we don't care about endianness (or more specifically
__AUDIT_ARCH_64BIT bit in AUDIT_ARCH_*).

There are some prerequisites for this patch to work correctly:
* "generic compat system call audit support" patch
* "correct a type mismatch in audit_syscall_exit()" patch
   (already accepted and queued in 3.14)
* "Modify a set of system calls in audit class" patch
   (already accepted and queued in 3.14)
* "__NR_* definitions for compat syscalls" patch from Catalin
* userspace audit tool (v2.3.2 + my patch for arm64)

Please review them as well for better understandings.

This code was tested on both 32-bit and 64-bit LE userland 
in the following two ways:
1) basic operations with auditctl/autrace
  # auditctl -a exit,always -S openat -F path=/etc/inittab
  # auditctl -a exit,always -F dir=/tmp -F perm=rw
  # auditctl -a task,always
  # autrace /bin/ls
    by comparing output from autrace with one from strace

2) audit-test-code (+ my workarounds for arm/arm64)
  by running "audit-tool", "filter" and "syscalls" test categories.

Changes v1 -> v2:
* Modified to utilize "generic compat system call audit" [3/6, 4/6, 5/6]
  Please note that a required header, unistd_32.h, is automatically
  generated from unistd32.h.
* Refer to regs->orig_x0 instead of regs->x0 as the first argument of
  system call in audit_syscall_entry() [6/6]
* Include "Add regs_return_value() in syscall.h" patch [2/6],
  which was not intentionally included in v1 because it could be added
  by "kprobes support".

Changes v2 -> v3:
* Remove asm/audit.h.
  See "generic compat syscall audit support" patch v4
* Remove endianness dependency, ie. AUDIT_ARCH_ARMEB/AARCH64EB.
* Remove kernel/syscalls/Makefile which was used to create unistd32.h.
  See Catalin's "Add __NR_* definitions for compat syscalls" patch

AKASHI Takahiro (3):
  arm64: Add regs_return_value() in syscall.h
  arm64: Add audit support
  arm64: audit: Add audit hook in ptrace/syscall_trace

 arch/arm64/Kconfig                   |    1 +
 arch/arm64/include/asm/ptrace.h      |    5 +++++
 arch/arm64/include/asm/syscall.h     |   15 +++++++++++++++
 arch/arm64/include/asm/thread_info.h |    1 +
 arch/arm64/kernel/entry.S            |    3 +++
 arch/arm64/kernel/ptrace.c           |   10 ++++++++++
 include/uapi/linux/audit.h           |    1 +
 7 files changed, 36 insertions(+)

-- 
1.7.9.5
