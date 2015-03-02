From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:38 +0800
Subject: [RFC PATCH v4 00/34] Early kprobe: enable kprobes at very early
 booting stage.
Message-ID: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 4 of early kprobes. The original idea and the previous
version can be found from [1] and [2].

The aim of early kprobe is to provide a method to enable kprobe as early
as possible to allow users to debug booting stage.

The user interface and data collection are still very weak in this
series. However, this series is different from previous version at many
places so I think it is worth to post at this time. The main changes
including:

 a) Don't rely on OPTPROBE. This series enable breakpoint based kprobe
    rely on early_trap_init(). Early kprobes now usable after
    setup_arch(). Later than previous version, but enough for debugging.

 b) Makes ftrace and early kprobe coupled with each other based on
    suggection from Steven Rostedt, remove the notification chain.

Patch 1-3 are some bugfix for x86. Patch 1 should has been already
merged into -tip tree. Without patch 1 early_trap_init() of x86 doesn't
work correctly.

Patch 4-17 are basic early kprobes support. Main part of it is
statically allocation support.

Patch 18 only enables early kprobes for ARM.

Patch 19-30 deal with copuling of kprobe and ftrace. Ftrace notifies
kprobe about its initialization and instruction conversion. After ftrace
fully initialized, kprobe use arm_kprobe_ftrace() reinstall all
ftrace-based kprobes, directly convert kprobe into ftrace.

Patch 31 enables early kprobes for X86.

Patch 32 shows a rough kernel cmdline support. The usage is similar to
my V1 patch. I'd like to drop it and design a new one so let it
unchanged.

Patch 33-34 convert ftrace entries into NOP at early stage, enable
kprobe to optimize them.

[1] https://lkml.org/lkml/2015/1/7/76

[2] https://lkml.org/lkml/2015/2/13/24

Wang Nan (34):
  x86, traps: Enable DEBUG_STACK after cpu_init() for TRAP_DB/BP.
  x86, traps: separate set_intr_gate() and cleanup early_trap_init().
  x86, traps: install gates using IST after cpu_init().
  early kprobes: within_kprobe_blacklist_early() early.
  early kprobes: introduce kprobe_is_early for futher early kprobe use.
  early kprobes: enable kprobe smoke test for early kprobes.
  early kprobes: init kprobes at very early stage.
  early kprobes: ARM: add definition for vmlinux.lds use.
  early kprobes: x86: add definition for vmlinux.lds use.
  early kprobes: introduce early kprobes related code area.
  early kprobes: introduces macros for allocing early kprobe resources.
  early kprobes: allows __alloc_insn_slot() from early kprobes slots.
  early kprobes: alloc optimized kprobe before memory system is ready.
  early kprobes: use stop_machine() based x86 optimizer.
  early kprobes: use stop_machine() based optimization method for early
    kprobes.
  early kprobes: perhibit probing at early kprobe reserved area.
  early kprobes: run kprobes smoke test for early kprobes.
  early kprobes: add CONFIG_EARLY_KPROBES option.
  ftrace: don't update record flags if code modification fail.
  ftrace/x86: Ensure rec->flags no change when failure occures.
  ftrace: sort ftrace entries earlier.
  ftrace: allow search ftrace addr before ftrace fully inited.
  ftrace: notify kprobe when ftrace is initialized.
  early kprobes on ftrace: introduce x86 arch_fix_ftrace_early_kprobe().
  ftrace: don't fire ftrace_bug if the instruction is taken by early
    kprobes.
  early kprobes on ftrace: x86: arch code for retrieving kprobed
    instruction.
  early kprobes on ftrace: kprobe_on_ftrace_get_old_insn()
  ftrace: x86: get old instruction from early kprobes when make call.
  ftrace: x86: call kprobe_int3_handler() in ftrace int3 handler.
  early kprobes: convert early kprobes on ftrace to ftrace.
  early kprobes: enable early kprobes for x86.
  early kprobes: enable 'ekprobe=' cmdline option for early kprobes.
  ftrace: enable make ftrace nop before ftrace_init().
  early kprobes: enable optimization of kprobes on ftrace before ftrace
    is ready.

 arch/Kconfig                      |  19 ++
 arch/arm/Kconfig                  |   1 +
 arch/arm/kernel/vmlinux.lds.S     |  10 +
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/desc.h       |   7 +-
 arch/x86/kernel/ftrace.c          |  46 ++++-
 arch/x86/kernel/kprobes/core.c    |  56 ++++++
 arch/x86/kernel/kprobes/opt.c     |  45 ++++-
 arch/x86/kernel/traps.c           |  39 +++-
 arch/x86/kernel/vmlinux.lds.S     |  10 +
 include/asm-generic/vmlinux.lds.h |  19 +-
 include/linux/ftrace.h            |  12 +-
 include/linux/kprobes.h           | 167 +++++++++++++++++
 init/main.c                       |   3 +
 kernel/kprobes.c                  | 375 ++++++++++++++++++++++++++++++++++++--
 kernel/test_kprobes.c             |  58 ++++--
 kernel/trace/ftrace.c             | 130 +++++++++++--
 17 files changed, 932 insertions(+), 66 deletions(-)

-- 
1.8.4
