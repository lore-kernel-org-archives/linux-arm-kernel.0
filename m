From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:52 +0100
Subject: [RFC PATCH 00/14] arm64: suspend/resume implementation
Message-ID: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides an implementation of suspend/resume and
related CPU PM notifiers for the arm64 architecture. The implementation
mirrors the arm32 version, so that the usage model is left unchanged
and the suspend/resume interface is kept common for both implementations.

The context restore split between processor specific functions and
generic code has been kept similar to arm32 as well, since this makes
sense from a functionality perspective, even though there is just a
an architecture specific save/restore implementation for arm64, for v8.
Code that deals with turning on the MMU and returning from suspend is kept
in the same file as the the suspend method itself, so that assembly code is
self contained in a single file and separated from the interface.

The CPU register context is allocated on the stack; this behaviour is
the same as in the arm 32-bit port, even though context could have been
allocated statically as a NR_CPUS array of struct and the context
addresses stored once of all in the context pointers array after virtual
to physical conversion. Current solution uses the stack, since there is
no need to allocate additional context space for context that can be
easily saved on the suspend threads stacks, with no additional memory
requirement.

Cache flushing is kept to a minimum; the cpu_suspend method cleans only the
few bytes of context to DRAM that need to be retrieved with the MMU off,
the remainder of cache cleaning is delegated to suspend finishers.

The series also provides patches to simplify the MPIDR_EL1 management
and MPIDR_EL1 hashing that are integrated to the series but are also useful
as stand alone code.

Code has been tested on AEM v8 models and a simple CPU idle driver that
enables a C-state where CPUs are reset when wfi is hit.

KVM CPU PM notifier has been tested using kvm-tools, and by booting a KVM guest
on a host with deep idle states enabled.

HW breakpoint CPU PM notifier has been tested using a simple perf test that
sets up per-cpu watchpoints and checks the proper behaviour when deep idle
states are enabled.

Lorenzo Pieralisi (14):
  arm64: kernel: add MPIDR_EL1 accessors macros
  arm64: kernel: build MPIDR_EL1 hash function data structure
  arm64: kernel: add structure to define cpu context layout
  arm64: kernel: suspend/resume registers save/restore
  arm64: kernel: cpu_{suspend/resume} implementation
  arm64: add CPU PM infrastructure selection
  arm64: kernel: implement fpsimd CPU PM notifier
  arm: kvm: implement CPU PM notifier
  arm64: kernel: implement debug monitors CPU PM notifiers
  arm64: kernel: refactor code to install/uninstall breakpoints
  arm64: kernel: implement HW breakpoints CPU PM notifier
  arm64: kernel: add cpu_{suspend}/{resume} build infrastructure
  arm64: kernel: add CPU idle call
  arm64: add CPU power management menu/entries

 arch/arm/kvm/arm.c                 |  30 ++++++
 arch/arm64/Kconfig                 |  19 ++++
 arch/arm64/include/asm/cputype.h   |  10 ++
 arch/arm64/include/asm/proc-fns.h  |   3 +
 arch/arm64/include/asm/processor.h |  18 ++++
 arch/arm64/include/asm/smp_plat.h  |  13 +++
 arch/arm64/include/asm/suspend.h   |  12 +++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |  21 ++++
 arch/arm64/kernel/debug-monitors.c |  38 +++++++
 arch/arm64/kernel/fpsimd.c         |  36 +++++++
 arch/arm64/kernel/hw_breakpoint.c  | 205 +++++++++++++++++++++++++++----------
 arch/arm64/kernel/process.c        |   7 +-
 arch/arm64/kernel/setup.c          |  70 +++++++++++++
 arch/arm64/kernel/sleep.S          | 181 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/suspend.c        |  76 ++++++++++++++
 arch/arm64/mm/proc.S               |  64 ++++++++++++
 17 files changed, 746 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm64/include/asm/suspend.h
 create mode 100644 arch/arm64/kernel/sleep.S
 create mode 100644 arch/arm64/kernel/suspend.c

-- 
1.8.3.4
