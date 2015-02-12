From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:17:56 +0800
Subject: [RFC PATCH v2 00/26] Early kprobe: enable kprobes at very early
 booting stage.
Message-ID: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of my previous early kprobe patch series. V1 can be
found from:

https://lkml.org/lkml/2015/1/7/76

I haven't finished development of early kprobe. The user interface and
data collection are still very weak, so you will find the weak point
pointed out by Steven Rostedt (https://lkml.org/lkml/2015/1/16/430)
still exists. I post this series because it has already become larger
than what I've ever thought. I want to get some early review. In futher
I'd like to drop patch 26/26 totally and redesign user interface.

The main change of this version is to allow early probe on ftrace entry
(makes early kprobe support KPROBE_ON_FTRACE). With this patch, on x86
we are able to probe at function entry if CONFIG_FTRACE is on.

The basic idea is to introduce a notify chain to ftrace, and make ftrace
notify kprobe when ftrace fails to modify instructions.

This patch series are based on linux-next commit df9f91e.

Patch 1/26 - 3/26 are already accepted, but currently they are not in
linux-next repository. I resend them here only for convenience if
someone want to test my code.

Patch 4/26 - 8/26 are some small ftrace improvement. Patch 4 - 5 keep
rec->flags unchanged when failure, make further code able to redu the
failed operation. Patch 6 - 7 makes ftrace_location() can be used at
early stage by sorting mcount_loc eariler. Patch 8 enables early kprobe
do ftrace_make_nop() before ftrace_init(), which is important to x86
because in x86 we are unable to boost 'call' instruction.

Patch 9/26 - 10/26 introduce a notify chain to ftrace and use it to
notify registered subsystems to try to fix the problem before issuing
ftrace_bug().

Patch 11/26 - 21/26 are core early kprobe code. Patch 11/26 introduces a
kprobe_is_early() function in response to Masami Hiramatsu's comment on

https://lkml.org/lkml/2015/1/13/389

that he thought comparing kprobes_initialized is hacky. There are no too
much change in these patches.

Patch 22/26 - 25/26 utilize the notify chain to support probe on ftrace.
Patch 22 is for x86. In setup_arch(), ideal_nops is possible to change.
We fix the probed nop by catching ftrace failure in
ftrace_code_disable(). Patch 23/26 makes kprobe able to temporarily
restore the probed instruction so ftrace is able to convert it.

Patch 24/26 is the core logic which enable early kprobe on ftrace,
including converting early kprobe on ftrace to normal kprobe on ftrace.

Patch 25/26 is corresponding kconfig update.

Patch 26/26 is a rough kernel cmdline support. The usage is similar to
my V1 patch. I'd like to drop it and design a new one so let it
unchanged.

In my v2 patch, it is possible to proble at function entries on x86:

 ... ekprobe=__alloc_pages_nodemask ...

and ekprobe option is able to coexist with ftrace= and ftrace_filter=
options:

   ... ekprobe=__alloc_pages_nodemask ftrace=function \
     ftrace_filter=__alloc_pages_nodemask ...

In that case, events between ftrace enabled and normal kprobe fully
initialized are missed in that case.

Thank you!

Wang Nan (26):
  kprobes: set kprobes_all_disarmed earlier to enable re-optimization.
  kprobes: makes kprobes/enabled works correctly for optimized kprobes.
  kprobes: x86: mark 2 bytes NOP as boostable.
  ftrace: don't update record flags if code modification fail.
  ftrace/x86: Ensure rec->flags no change when failure occures.
  ftrace: sort ftrace entries earlier.
  ftrace: allow search ftrace addr before ftrace fully inited.
  ftrace: enable other subsystems make ftrace nop before ftrace_init()
  ftrace: callchain and ftrace_bug_tryfix
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

 arch/Kconfig                      |  12 +
 arch/arm/include/asm/kprobes.h    |  31 ++-
 arch/arm/kernel/vmlinux.lds.S     |   2 +
 arch/arm/probes/kprobes/opt-arm.c |  12 +-
 arch/x86/include/asm/insn.h       |   7 +-
 arch/x86/include/asm/kprobes.h    |  47 +++-
 arch/x86/kernel/ftrace.c          |  23 +-
 arch/x86/kernel/kprobes/core.c    |   2 +-
 arch/x86/kernel/kprobes/opt.c     |  69 +++++-
 arch/x86/kernel/vmlinux.lds.S     |   2 +
 include/linux/ftrace.h            |  37 ++++
 include/linux/kprobes.h           | 131 +++++++++++
 init/main.c                       |   1 +
 kernel/kprobes.c                  | 451 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/ftrace.c             | 145 ++++++++++--
 15 files changed, 928 insertions(+), 44 deletions(-)

-- 
1.8.4
