From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 29 Jun 2015 18:23:15 +0100
Subject: [PATCH v7 0/7] arm64: Add kernel probes (kprobes) support
In-Reply-To: <1434395229-6654-1-git-send-email-dave.long@linaro.org>
References: <1434395229-6654-1-git-send-email-dave.long@linaro.org>
Message-ID: <CAPvkgC24o0==avNp-eXOjRtqG4M+UzOr_Sicc99Z-tOBkUEZrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 June 2015 at 20:07, David Long <dave.long@linaro.org> wrote:
> From: "David A. Long" <dave.long@linaro.org>
>
> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
> first seen in October 2013. This version attempts to address concerns raised by
> reviewers and also fixes problems discovered during testing.
>
> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
> and return probes(kretprobes) support for ARM64.
>
> The kprobes mechanism makes use of software breakpoint and single stepping
> support available in the ARM v8 kernel.
>

Hi David,
Thanks for this, and apologies for getting to this late...
I've had a good read through the patches in this series, and have some comments.

Cheers,
--
Steve

> The is patch depends on:
>         [PATCH 1/2] Move the pt_regs_offset struct definition from arch to common include file
>         [PATCH 2/2] Consolidate redundant register/stack access code
>
> Changes since v2 include:
>
> 1) Removal of NOP padding in kprobe XOL slots. Slots are now exactly one
> instruction long.
> 2) Disabling of interrupts during execution in single-step mode.
> 3) Fixing of numerous problems in instruction simulation code (mostly
> thanks to Will Cohen).
> 4) Support for the HAVE_REGS_AND_STACK_ACCESS_API feature is added, to allow
> access to kprobes through debugfs.
> 5) kprobes is *not* enabled in defconfig.
> 6) Numerous complaints from checkpatch have been cleaned up, although a couple
> remain as removing the function pointer typedefs results in ugly code.
>
> Changes since v3 include:
>
> 1) Remove table-driven instruction parsing and replace with an if statement
> calling out to old and new instruction test functions in insn.c.
> 2) I removed the addition of orig_x0 to ptrace.h.
> 3) Reorder the patches.
> 4) Replace the previous interrupt disabling (from Will Cohen) with
> an improved solution (from Steve Capper).
>
> Changes since v4 include:
>
> 1) Added insn.c functions to detect exception instructions and DAIF
>    read/write instructions, and use them to reject probing same.
> 2) Changed adr detect function to also recognize adrp. Reject both.
> 3) Added missing __kprobes for some new functions.
> 4) Added call to kprobes_fault_handler from mm do_page_fault.
> 5) Reject all non-simulated branch/ret instructions, not just those
>    that use an immediate offset.
> 6) Moved software breakpoint definitions into debug-monitors.h.
> 7) Removed "!XIP_KERNEL" from Kconfig.
> 8) changed kprobes_condition_check_t and kprobes_prepare_t to probes_*,
>    for future sharing with uprobes.
> 9) Removed bogus call to kprobes_restore_local_irqflag() from
>    trampoline_probe_handler().
>
> Changes since v5 include:
>
> 1) Replaced installation of breakpoint hook with direct call from the
> handlers in debug-monitors.c, as requested.
> 2) Reject probing of instructions that read the interrupt mask, in
> addition to instructions that set it.
> 3) Cleaned up comments describing usage of Debug Mask.
> 4) Added KPROBE_REENTER case in reenter_kprobe.
> 5) Corrected the ifdef'd definitions for notify_page_fault() to be
> consistent when KPROBES is not configed.
> 6) Changed "cpsr" to "pstate" for HAVE_REGS_AND_STACK_ACCESS_API feature.
> 7) Added back in missing new files in previous patch.
> 8) Changed two instances of pr_warning() to pr_warn().
>
> Note that there seems to be at least a potential issue with kprobes
> on multiple (possibly all) platforms having to do with use of kfree
> inside of the kretprobes trampoline handler.  This has manifested
> occasionally in systemtap testing on arm64.  There does not appear to
> be an simple solution to the problem.
>
> Changes since v6 include:
>
> 1) New trampoline code from Will Cohen fixes the occasional failure seen
> when processing kretprobes by replacing the software breakpoint with
> assembly code to implement the return to the original execution stream.
> 2) Changed ip0, ip1, fp, and lr to plain numbered registers for purposes
> of recognizing them as an ascii string in the stack/reg access code.
> 3) Removed orig_x0.
> 4) Moved ARM_x* defines from arch/arm64/include/uapi/asm/ptrace.h to
> arch/arm64/kernel/ptrace.c.
>
> David A. Long (2):
>   arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
>   arm64: Add more test functions to insn.c
>
> Sandeepa Prabhu (4):
>   arm64: Kprobes with single stepping support
>   arm64: kprobes instruction simulation support
>   arm64: Add kernel return probes support (kretprobes)
>   kprobes: Add arm64 case in kprobe example module
>
> William Cohen (1):
>   arm64: Add trampoline code for kretprobes
>
>  arch/arm64/Kconfig                       |   3 +
>  arch/arm64/include/asm/debug-monitors.h  |   5 +
>  arch/arm64/include/asm/insn.h            |  18 +
>  arch/arm64/include/asm/kprobes.h         |  63 +++
>  arch/arm64/include/asm/probes.h          |  50 +++
>  arch/arm64/include/asm/ptrace.h          |  28 +-
>  arch/arm64/kernel/Makefile               |   3 +
>  arch/arm64/kernel/debug-monitors.c       |  35 +-
>  arch/arm64/kernel/insn.c                 |  28 ++
>  arch/arm64/kernel/kprobes-arm64.c        | 166 ++++++++
>  arch/arm64/kernel/kprobes-arm64.h        |  71 ++++
>  arch/arm64/kernel/kprobes.c              | 665 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/kprobes.h              |  24 ++
>  arch/arm64/kernel/probes-condn-check.c   | 122 ++++++
>  arch/arm64/kernel/probes-simulate-insn.c | 174 ++++++++
>  arch/arm64/kernel/probes-simulate-insn.h |  33 ++
>  arch/arm64/kernel/ptrace.c               |  77 ++++
>  arch/arm64/kernel/vmlinux.lds.S          |   1 +
>  arch/arm64/mm/fault.c                    |  25 ++
>  samples/kprobes/kprobe_example.c         |   8 +
>  20 files changed, 1588 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kprobes.h
>  create mode 100644 arch/arm64/include/asm/probes.h
>  create mode 100644 arch/arm64/kernel/kprobes-arm64.c
>  create mode 100644 arch/arm64/kernel/kprobes-arm64.h
>  create mode 100644 arch/arm64/kernel/kprobes.c
>  create mode 100644 arch/arm64/kernel/kprobes.h
>  create mode 100644 arch/arm64/kernel/probes-condn-check.c
>  create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
>  create mode 100644 arch/arm64/kernel/probes-simulate-insn.h
>
> --
> 1.8.1.2
>
