From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:38:48 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
Message-ID: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Scalable Vector Extension (SVE) [1] is an extension to AArch64 which
adds extra SIMD functionality and supports much larger vectors.

This series implements core Linux support for SVE.

Recipents not copied on the whole series can find the rest of the
patches in the linux-arm-kernel archives [2].


The first 5 patches "arm64: signal: ..." factor out the allocation and
placement of state information in the signal frame.  The first three
are prerequisites for the SVE support patches.

Patches 04-05 implement expansion of the signal frame, and may remain
controversial due to ABI break issues:

 * Discussion is needed on how userspace should detect/negotiate signal
   frame size in order for this expansion mechanism to be workable.


The remaining patches implement initial SVE support for Linux, with the
following limitations:

 * No KVM/virtualisation support for guests.

 * No independent SVE vector length configuration per thread.  This is
   planned, but will follow as a separate add-on series.

 * As a temporary workaround for the signal frame size issue, vector
   length is software-limited to 512 bits (see patch 29), with a
   build-time kernel configuration option to relax this.

   Discussion is needed on how to smooth address the signal ABI issues
   so that this workaround can be removed.

 * A fair number of development BUG_ON()s are still present, which
   will be demoted or removed for merge.

 * There is a context-switch race condition lurking somewhere which
   fires in certain situations with my development KVM hacks (not part
   of this posting) -- the underlying bug might or might not be in this
   series.


Review and comments welcome.

Cheers
---Dave

[1] https://community.arm.com/groups/processors/blog/2016/08/22/technology-update-the-scalable-vector-extension-sve-for-the-armv8-a-architecture

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/thread.html


Alan Hayward (1):
  arm64/sve: ptrace support

Dave Martin (28):
  arm64: signal: Refactor sigcontext parsing in rt_sigreturn
  arm64: signal: factor frame layout and population into separate passes
  arm64: signal: factor out signal frame record allocation
  arm64: signal: Allocate extra sigcontext space as needed
  arm64: signal: Parse extra_context during sigreturn
  arm64: efi: Add missing Kconfig dependency on KERNEL_MODE_NEON
  arm64/sve: Allow kernel-mode NEON to be disabled in Kconfig
  arm64/sve: Low-level save/restore code
  arm64/sve: Boot-time feature detection and reporting
  arm64/sve: Boot-time feature enablement
  arm64/sve: Expand task_struct for Scalable Vector Extension state
  arm64/sve: Save/restore SVE state on context switch paths
  arm64/sve: Basic support for KERNEL_MODE_NEON
  Revert "arm64/sve: Allow kernel-mode NEON to be disabled in Kconfig"
  arm64/sve: Restore working FPSIMD save/restore around signals
  arm64/sve: signal: Add SVE state record to sigcontext
  arm64/sve: signal: Dump Scalable Vector Extension registers to user
    stack
  arm64/sve: signal: Restore FPSIMD/SVE state in rt_sigreturn
  arm64/sve: Avoid corruption when replacing the SVE state
  arm64/sve: traps: Add descriptive string for SVE exceptions
  arm64/sve: Enable SVE on demand for userspace
  arm64/sve: Implement FPSIMD-only context for tasks not using SVE
  arm64/sve: Move ZEN handling to the common task_fpsimd_load() path
  arm64/sve: Discard SVE state on system call
  arm64/sve: Avoid preempt_disable() during sigreturn
  arm64/sve: Avoid stale user register state after SVE access exception
  arm64: KVM: Treat SVE use by guests as undefined instruction execution
  arm64/sve: Limit vector length to 512 bits by default

 arch/arm64/Kconfig                       |  48 +++
 arch/arm64/include/asm/esr.h             |   3 +-
 arch/arm64/include/asm/fpsimd.h          |  37 +++
 arch/arm64/include/asm/fpsimdmacros.h    | 145 +++++++++
 arch/arm64/include/asm/kvm_arm.h         |   1 +
 arch/arm64/include/asm/sysreg.h          |  11 +
 arch/arm64/include/asm/thread_info.h     |   2 +
 arch/arm64/include/uapi/asm/hwcap.h      |   1 +
 arch/arm64/include/uapi/asm/ptrace.h     | 125 ++++++++
 arch/arm64/include/uapi/asm/sigcontext.h | 117 ++++++++
 arch/arm64/kernel/cpufeature.c           |   3 +
 arch/arm64/kernel/cpuinfo.c              |   1 +
 arch/arm64/kernel/entry-fpsimd.S         |  17 ++
 arch/arm64/kernel/entry.S                |  18 +-
 arch/arm64/kernel/fpsimd.c               | 301 ++++++++++++++++++-
 arch/arm64/kernel/head.S                 |  16 +-
 arch/arm64/kernel/process.c              |   2 +-
 arch/arm64/kernel/ptrace.c               | 254 +++++++++++++++-
 arch/arm64/kernel/setup.c                |   3 +
 arch/arm64/kernel/signal.c               | 497 +++++++++++++++++++++++++++++--
 arch/arm64/kernel/signal32.c             |   2 +-
 arch/arm64/kernel/traps.c                |   1 +
 arch/arm64/kvm/handle_exit.c             |   9 +
 arch/arm64/mm/proc.S                     |  27 +-
 include/uapi/linux/elf.h                 |   1 +
 25 files changed, 1583 insertions(+), 59 deletions(-)

-- 
2.1.4
