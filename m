From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:38:27 +0800
Subject: [RFC PATCH v3 00/26] Early kprobe: enable kprobes at very early
 booting stage.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423805907-61335-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I fell very sorry for people who reviewed my v2 patch series yesterday
at https://lkml.org/lkml/2015/2/12/234 because I didn't provide enough
information in commit log. This v3 patch series add those missing
commit messages. There are also 2 small fix based on v2:

 1. Fixes ftrace_sort_mcount_area. Original patch doesn't work for module.
 2. Wraps setting of kprobes_initialized in stop_machine() context. 

Wang Nan (26):
  kprobes: set kprobes_all_disarmed earlier to enable re-optimization.
  kprobes: makes kprobes/enabled works correctly for optimized kprobes.
  kprobes: x86: mark 2 bytes NOP as boostable.
  ftrace: don't update record flags if code modification fail.
  ftrace/x86: Ensure rec->flags no change when failure occures.
  ftrace: sort ftrace entries earlier.
  ftrace: allow search ftrace addr before ftrace fully inited.
  ftrace: enable make ftrace nop before ftrace_init().
  ftrace: allow fixing code update failure by notifier chain.
  ftrace: x86: try to fix ftrace when ftrace_replace_code.
  early kprobes: introduce kprobe_is_early for futher early kprobe use.
  early kprobes: Add an KPROBE_FLAG_EARLY for early kprobe.
  early kprobes: ARM: directly modify code.
  early kprobes: ARM: introduce early kprobes related code area.
  early kprobes: x86: directly modify code.
  early kprobes: x86: introduce early kprobes related code area.
  early kprobes: introduces macros for allocing early kprobe resources.
  early kprobes: allows __alloc_insn_slot() from early kprobes slots.
  early kprobes: perhibit probing at early kprobe reserved area.
  early kprobes: core logic of eraly kprobes.
  early kprobes: add CONFIG_EARLY_KPROBES option.
  early kprobes: introduce arch_fix_ftrace_early_kprobe().
  early kprobes: x86: arch_restore_optimized_kprobe().
  early kprobes: core logic to support early kprobe on ftrace.
  early kprobes: introduce kconfig option to support early kprobe on
    ftrace.
  kprobes: enable 'ekprobe=' cmdline option for early kprobes.

 arch/Kconfig                      |  15 ++
 arch/arm/include/asm/kprobes.h    |  31 ++-
 arch/arm/kernel/vmlinux.lds.S     |   2 +
 arch/arm/probes/kprobes/opt-arm.c |  12 +-
 arch/x86/include/asm/insn.h       |   7 +-
 arch/x86/include/asm/kprobes.h    |  47 +++-
 arch/x86/kernel/ftrace.c          |  23 +-
 arch/x86/kernel/kprobes/core.c    |   2 +-
 arch/x86/kernel/kprobes/opt.c     |  69 +++++-
 arch/x86/kernel/vmlinux.lds.S     |   2 +
 include/linux/ftrace.h            |  37 +++
 include/linux/kprobes.h           | 132 +++++++++++
 init/main.c                       |   1 +
 kernel/kprobes.c                  | 479 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/ftrace.c             | 157 +++++++++++--
 15 files changed, 969 insertions(+), 47 deletions(-)

-- 
1.8.4
