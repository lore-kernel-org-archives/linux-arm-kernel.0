From: masami.hiramatsu.pt@hitachi.com (=?gb2312?B?xr3LydHFy8ggLyBISVJBTUFUVaOsTUFTQU1J?=)
Date: Mon, 14 Mar 2016 09:36:00 +0000
Subject: [PATCH v10 0/9] arm64: Add kernel probes (kprobes) support
In-Reply-To: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
References: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
Message-ID: <50399556C9727B4D88A595C8584AAB37B4E47FBB@GSjpTKYDCembx32.service.hitachi.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thank you for updating the series.
I'll review it this week.

Just one comment on __kprobes. Nowadays kprobes already using
NOKPROBE_SYMBOL() instead of that, since __kprobes moves all
functions into another section and will mess up symbol table.
In asm code, maybe you can reuse _ASM_NOKPROBE() macro in 
arch/x86/include/asm/asm.h

Thank you,

>From: "David A. Long" <dave.long@linaro.org>
>
>This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
>first seen in October 2013. This version attempts to address concerns raised by
>reviewers and also fixes problems discovered during testing.
>
>This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>and return probes(kretprobes) support for ARM64.
>
>The kprobes mechanism makes use of software breakpoint and single stepping
>support available in the ARM v8 kernel.
>
>Changes since v2 include:
>
>1) Removal of NOP padding in kprobe XOL slots. Slots are now exactly one
>instruction long.
>2) Disabling of interrupts during execution in single-step mode.
>3) Fixing of numerous problems in instruction simulation code (mostly
>thanks to Will Cohen).
>4) Support for the HAVE_REGS_AND_STACK_ACCESS_API feature is added, to allow
>access to kprobes through debugfs.
>5) kprobes is *not* enabled in defconfig.
>6) Numerous complaints from checkpatch have been cleaned up, although a couple
>remain as removing the function pointer typedefs results in ugly code.
>
>Changes since v3 include:
>
>1) Remove table-driven instruction parsing and replace with an if statement
>calling out to old and new instruction test functions in insn.c.
>2) I removed the addition of orig_x0 to ptrace.h.
>3) Reorder the patches.
>4) Replace the previous interrupt disabling (from Will Cohen) with
>an improved solution (from Steve Capper).
>
>Changes since v4 include:
>
>1) Added insn.c functions to detect exception instructions and DAIF
>   read/write instructions, and use them to reject probing same.
>2) Changed adr detect function to also recognize adrp. Reject both.
>3) Added missing __kprobes for some new functions.
>4) Added call to kprobes_fault_handler from mm do_page_fault.
>5) Reject all non-simulated branch/ret instructions, not just those
>   that use an immediate offset.
>6) Moved software breakpoint definitions into debug-monitors.h.
>7) Removed "!XIP_KERNEL" from Kconfig.
>8) changed kprobes_condition_check_t and kprobes_prepare_t to probes_*,
>   for future sharing with uprobes.
>9) Removed bogus call to kprobes_restore_local_irqflag() from
>   trampoline_probe_handler().
>
>Changes since v5 include:
>
>1) Replaced installation of breakpoint hook with direct call from the
>handlers in debug-monitors.c, as requested.
>2) Reject probing of instructions that read the interrupt mask, in
>addition to instructions that set it.
>3) Cleaned up comments describing usage of Debug Mask.
>4) Added KPROBE_REENTER case in reenter_kprobe.
>5) Corrected the ifdef'd definitions for notify_page_fault() to be
>consistent when KPROBES is not configed.
>6) Changed "cpsr" to "pstate" for HAVE_REGS_AND_STACK_ACCESS_API feature.
>7) Added back in missing new files in previous patch.
>8) Changed two instances of pr_warning() to pr_warn().
>
>Note that there seems to be at least a potential issue with kprobes
>on multiple (possibly all) platforms having to do with use of kfree
>inside of the kretprobes trampoline handler.  This has manifested
>occasionally in systemtap testing on arm64.  There does not appear to
>be an simple solution to the problem.
>
>Changes since v6 include:
>
>1) New trampoline code from Will Cohen fixes the occasional failure seen
>when processing kretprobes by replacing the software breakpoint with
>assembly code to implement the return to the original execution stream.
>2) Changed ip0, ip1, fp, and lr to plain numbered registers for purposes
>of recognizing them as an ascii string in the stack/reg access code.
>3) Removed orig_x0.
>4) Moved ARM_x* defines from arch/arm64/include/uapi/asm/ptrace.h to
>arch/arm64/kernel/ptrace.c.
>
>Changes since v7 include:
>
>1) Move trampoline entry/return code into separate ".S" file instead
>of making it a macro in a header file.
>2) Add missing register name definitions in asm-offsets.c and use them
>in place of hard-coded integer offsets in the trampoline code.
>3) Correct the values used to decode MSR immediate instructions, in insn.h.
>4) Remove the currently unused simulate_none() function.
>
>Changes since v8 include:
>
>1) Replaced use of REG_OFFSET_NAME with GPR_OFFSET_NAME for numbered
>registers.
>2) Added an alias for "lr" in the register name lookup table, which perf
>tools need to be able to recognize.
>3) Changed the code for checking instruction types for probeability and
>steppability as per review feedback.
>4) Fixed the size of cache being flushed when filling single-step slot.
>5) Fixed big-endian issues.
>6) Blacklisted copy_to/from_user to avoid aborts while single-stepping.
>7) Record conditional instructions that fail the conditional test just
>like any other probed (non-conditional) instruction.
>8) Removed use of magic number for detecting jprobe return and just
>check the breakpoint address instead.
>9) Got rid of the unnecessary arch/arm64/kprobes.h.
>10) The PSTATE and SP are now properly saved in the kretprobe trampoline
>code.
>11) This patch no longer depends on the "Consolidate redundant
>register/stack access code" patch set.
>12) Remove call to fixup_exception from kprobe_fault_handler.
>
>Changes since v9 include:
>
>1) Remove arch/arm/opcodes.c from the arm64 build and move the renamed
>arm64_check_condition() function to armv8_deprecated.c. Remove the
>asmlinkage.
>2) Various other type and style changes suggested by Marc Zyngier.
>3) Put back the call to fixup_exception from kprobe_fault_handler.
>It proved to be necessary for correct operation.
>
>David A. Long (4):
>  arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
>  arm64: Add more test functions to insn.c
>  arm64: add copy_to/from_user to kprobes blacklist
>  arm64: add conditional instruction simulation support
>
>Sandeepa Prabhu (4):
>  arm64: Kprobes with single stepping support
>  arm64: kprobes instruction simulation support
>  arm64: Add kernel return probes support (kretprobes)
>  kprobes: Add arm64 case in kprobe example module
>
>William Cohen (1):
>  arm64: Add trampoline code for kretprobes
>
> arch/arm64/Kconfig                       |   3 +
> arch/arm64/include/asm/debug-monitors.h  |   5 +
> arch/arm64/include/asm/insn.h            |  41 ++
> arch/arm64/include/asm/kprobes.h         |  62 ++++
> arch/arm64/include/asm/probes.h          |  45 +++
> arch/arm64/include/asm/ptrace.h          |  33 +-
> arch/arm64/kernel/Makefile               |   6 +-
> arch/arm64/kernel/armv8_deprecated.c     |  19 +-
> arch/arm64/kernel/asm-offsets.c          |  22 ++
> arch/arm64/kernel/debug-monitors.c       |  18 +-
> arch/arm64/kernel/insn.c                 | 131 +++++++
> arch/arm64/kernel/kprobes-arm64.c        | 150 ++++++++
> arch/arm64/kernel/kprobes-arm64.h        |  35 ++
> arch/arm64/kernel/kprobes.c              | 616 +++++++++++++++++++++++++++++++
> arch/arm64/kernel/kprobes_trampoline.S   |  67 ++++
> arch/arm64/kernel/probes-simulate-insn.c | 187 ++++++++++
> arch/arm64/kernel/probes-simulate-insn.h |  28 ++
> arch/arm64/kernel/ptrace.c               | 117 ++++++
> arch/arm64/kernel/vmlinux.lds.S          |   1 +
> arch/arm64/lib/copy_from_user.S          |   1 +
> arch/arm64/lib/copy_to_user.S            |   1 +
> arch/arm64/mm/fault.c                    |  25 ++
> samples/kprobes/kprobe_example.c         |   8 +
> 23 files changed, 1613 insertions(+), 8 deletions(-)
> create mode 100644 arch/arm64/include/asm/kprobes.h
> create mode 100644 arch/arm64/include/asm/probes.h
> create mode 100644 arch/arm64/kernel/kprobes-arm64.c
> create mode 100644 arch/arm64/kernel/kprobes-arm64.h
> create mode 100644 arch/arm64/kernel/kprobes.c
> create mode 100644 arch/arm64/kernel/kprobes_trampoline.S
> create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
> create mode 100644 arch/arm64/kernel/probes-simulate-insn.h
>
>--
>2.5.0
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
