From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  6 Nov 2013 19:25:42 +0900
Subject: [PATCH 0/4] arm64: Add audit support
Message-ID: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds audit support on arm64.
The implementation is just like in other architectures,
and so I think little explanation is needed.

I verified this patch with some commands on both 64-bit rootfs
and 32-bit rootfs(, but only in little-endian):
  # auditctl -a exit,always -S openat -F path=/etc/inittab
  # auditctl -a exit,always -F dir=/tmp -F perm=rw
  # auditctl -a task,always
  # autrace /bin/ls
What else?
(Thanks to Clayton for his cross-compiling patch)


I'd like to discuss about the following issues:
(issues)
* AUDIT_ARCH_*
  Why do we need to distiguish big-endian and little-endian? [2/4]
* AArch32
  We need to add a check for identifying the endian in 32-bit tasks. [3/4]
* syscall no in AArch32
  Currently all the definitions are added in unistd32.h with
  "ifdef __AARCH32_AUDITSYSCALL" to use asm-generic/audit_*.h. [3/4]
  "ifdef" is necessary to avoid a conflict with 64-bit definitions.
  Do we need a more sophisticated way?
* TIF_AUDITSYSCALL
  Most architectures, except x86, do not check TIF_AUDITSYSCALL. Why not? [4/4]
* Userspace audit package
  There are some missing syscall definitions in lib/aarch64_table.h.
  There is no support for AUDIT_ARCH_ARM (I mean LE. armeb is BE).


AKASHI Takahiro (4):
  audit: Enable arm64 support
  arm64: Add audit support
  arm64: audit: Add AArch32 support
  arm64: audit: Add audit hook in ptrace/syscall_trace

 arch/arm64/Kconfig                   |    3 +
 arch/arm64/include/asm/audit32.h     |   12 ++
 arch/arm64/include/asm/ptrace.h      |    5 +
 arch/arm64/include/asm/syscall.h     |   18 ++
 arch/arm64/include/asm/thread_info.h |    1 +
 arch/arm64/include/asm/unistd32.h    |  387 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile           |    4 +
 arch/arm64/kernel/audit.c            |   77 +++++++
 arch/arm64/kernel/audit32.c          |   46 ++++
 arch/arm64/kernel/entry.S            |    3 +
 arch/arm64/kernel/ptrace.c           |   12 ++
 include/uapi/linux/audit.h           |    2 +
 init/Kconfig                         |    2 +-
 13 files changed, 571 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/audit32.h
 create mode 100644 arch/arm64/kernel/audit.c
 create mode 100644 arch/arm64/kernel/audit32.c

-- 
1.7.9.5
