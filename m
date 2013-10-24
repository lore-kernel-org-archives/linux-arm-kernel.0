From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Oct 2013 16:08:02 +0900
Subject: [PATCH v2 0/6] arm64: Add ftrace support
Message-ID: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is my second version of patchset for ftrace support.
Actually v1 was submitted serveral weeks ago, but is still moderated.
(Just ignore them for now.)
There is another implementation from Cavium network, but both works
are independent, and my code has additional system call trace support.

I confirmed that I could compile the patches on v3.12-rc4 by Linaro's
coming 2013.10 gcc (4.8.2), and that the kernel worked on Fast Model
with the following tracers:
     function tracer with dynamic ftrace
     function graph tracer with dynamic ftrace
     syscall tracepoint
     irqsoff & preemptirqsoff (which use CALLER_ADDRx)
Also verified with in-kernel tests, FTRACE_SELFTEST, FTRACE_STARTUP_TEST
and EVENT_TRACE_TEST_SYSCALLS.

Patch[3/6] has warnings from checkpatch, but they follow other arch's style.

Please be careful that host's elf.h must have AArch64 definitions,
EM_AARCH64 and R_AARCH64_ABS64, to build the kernel. See [4/6].

Issues
* Can we optimize register usages in asm (by not saving x0, x1 and x2)? [1/6]
* Do we need "fault protection" code in ftrace_modify_code()? [1/6]
  It exists in x86 and other architectures, but not in arm.
* We may be able to use aarch64_insn_patch_text_nosync() instead of
  ftrace_modify_code().[2/6] But the former function does not use
  probe_kernel_write(). Is this safe?

Changes from v1 to v2:
* splitted one patch into some pieces for easier review
  (especially function tracer + dynamic ftrace + CALLER_ADDRx)
* put return_address() in a separate file
* renamed __mcount to _mcount (it was my mistake)
* changed stackframe handling to get parent's frame pointer
* removed ARCH_SUPPORTS_FTRACE_OPS
* switched to "hotpatch" interfaces from Huawai
* revised descriptions in comments

AKASHI Takahiro (6):
  arm64: Add ftrace support
  arm64: ftrace: Add dynamic ftrace support
  arm64: ftrace: Add CALLER_ADDRx macros
  ftrace: Add arm64 support to recordmcount
  arm64: ftrace: Add system call tracepoint
  arm64: Add 'notrace' attribute to unwind_frame() for ftrace

 arch/arm64/Kconfig                   |    6 +
 arch/arm64/include/asm/ftrace.h      |   54 +++++++++
 arch/arm64/include/asm/syscall.h     |    1 +
 arch/arm64/include/asm/thread_info.h |    1 +
 arch/arm64/include/asm/unistd.h      |    2 +
 arch/arm64/kernel/Makefile           |    9 +-
 arch/arm64/kernel/arm64ksyms.c       |    4 +
 arch/arm64/kernel/entry-ftrace.S     |  211 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry.S            |    1 +
 arch/arm64/kernel/ftrace.c           |  186 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/ptrace.c           |   10 ++
 arch/arm64/kernel/return_address.c   |   55 +++++++++
 arch/arm64/kernel/stacktrace.c       |    2 +-
 scripts/recordmcount.c               |    4 +
 scripts/recordmcount.pl              |    5 +
 15 files changed, 549 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/ftrace.h
 create mode 100644 arch/arm64/kernel/entry-ftrace.S
 create mode 100644 arch/arm64/kernel/ftrace.c
 create mode 100644 arch/arm64/kernel/return_address.c

-- 
1.7.9.5
