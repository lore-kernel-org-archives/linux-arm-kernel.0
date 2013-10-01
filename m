From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Tue,  1 Oct 2013 21:27:55 +0530
Subject: [PATCH RFC v1 0/5] ARM64 kernel probes(kprobes) support
Message-ID: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for basic kernel probes(kprobes), jump probes(jprobes)
and return probes(kretprobes) support for AArch64.

This kprobes mechanism make use of software breakpoint and single stepping
support available in ARM v8 kernel.

Basic verification is done with sample test modules available as part of
"samples/kprobes/" running on ARM v8 fast model (RTSM). 

Patch 1 (AArch64-Add-single-step-and-breakpoint-handler-hooks.patch) is v3 version of: 
	http://permalink.gmane.org/gmane.linux.ports.arm.kernel/269733

Changes:
  v2 -> v3
  - Renamed break_lock to break_hook_lock
  - Use rcu protected list traversal for step_hook
  - eliminated addr argument for debug hooks, now callback functions shall extract address from pt_regs instead.
  - refined entry.S changes only to handler 'BRK64' esr value.

Patch 2 (arm64-Kernel-code-patching-support.patch) implement basic code patching support needed for kprobes. 
Similar api is published earlier on LKML/LAKML as part of jump label support: https://lkml.org/lkml/2013/9/25/250  
However, for kprobes some changes required with that version, can rebase on new version of patch from Jiang.


Sandeepa Prabhu (5):
  AArch64: Add single-step and breakpoint handler hooks
  arm64: Kernel code patching support
  AArch64: Instruction simulation and decode support
  AArch64: Add Kprobes support for ARM v8 kernel
  AArch64: Support kretprobe support for ARM v8

 arch/arm64/Kconfig                      |   2 +
 arch/arm64/include/asm/debug-monitors.h |  23 ++
 arch/arm64/include/asm/kprobes.h        |  58 +++
 arch/arm64/include/asm/probes.h         |  48 +++
 arch/arm64/include/asm/ptrace.h         |   6 +
 arch/arm64/kernel/Makefile              |   2 +
 arch/arm64/kernel/debug-monitors.c      |  85 ++++-
 arch/arm64/kernel/entry.S               |   2 +
 arch/arm64/kernel/kprobes-arm64.c       | 245 ++++++++++++
 arch/arm64/kernel/kprobes-arm64.h       |  26 ++
 arch/arm64/kernel/kprobes.c             | 642 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/kprobes.h             |  28 ++
 arch/arm64/kernel/patch.c               |  58 +++
 arch/arm64/kernel/patch.h               |  20 +
 arch/arm64/kernel/probes-aarch64.c      | 235 ++++++++++++
 arch/arm64/kernel/probes-aarch64.h      | 127 +++++++
 arch/arm64/kernel/probes-common.c       | 117 ++++++
 arch/arm64/kernel/vmlinux.lds.S         |   1 +
 18 files changed, 1722 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/kprobes.h
 create mode 100644 arch/arm64/include/asm/probes.h
 create mode 100644 arch/arm64/kernel/kprobes-arm64.c
 create mode 100644 arch/arm64/kernel/kprobes-arm64.h
 create mode 100644 arch/arm64/kernel/kprobes.c
 create mode 100644 arch/arm64/kernel/kprobes.h
 create mode 100644 arch/arm64/kernel/patch.c
 create mode 100644 arch/arm64/kernel/patch.h
 create mode 100644 arch/arm64/kernel/probes-aarch64.c
 create mode 100644 arch/arm64/kernel/probes-aarch64.h
 create mode 100644 arch/arm64/kernel/probes-common.c

-- 
1.8.1.2
