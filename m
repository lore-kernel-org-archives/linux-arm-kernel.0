From: james.morse@arm.com (James Morse)
Date: Fri,  4 Dec 2015 11:02:24 +0000
Subject: [PATCH v8 0/4] arm64: Add support for IRQ stack
Message-ID: <1449226948-14251-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This consolidated series adds a per-cpu irq_stack, which will eventually allow
us to reduce the size of task stacks.

Code in entry.S switches to the per-cpu irq_stack when irq_count is zero.
This counter is updated in do_softirq_own_stack(), which is called before
__do_softirq() re-enables interrupts, which could cause recursive use of the
irq stack.

sp_el0 is used as a scratch register to store struct thread_info during el1
execution, this means code to find it by masking the stack pointer no longer
needs to be inlined. This also lets us remove the alignment requirements for
the irq stack, (task stacks still need to be naturally aligned).

Patch 2 is a combination of Akashi Takahiro's 'arm64: unwind_frame for
interrupt stack' and 'arm64: fix dump_backtrace() to show correct pt_regs at
interrupt', both of which need to be present before irq_stack is enabled in
Patch 3.

Patch 4 is new, following Catalin's comments, but I don't think it is
necessary unless we also decrease the stack size, which I don't think we
should do immediatly - it would be good to collect some max_stack_size values
for various workloads first.

This series is based on the v4.4-rc3
The series can be pulled from git://linux-arm.org/linux-jm.git -b irq_stack/v8

Comments welcome,


James

Changes since v7 [0]:
 * Removed independent irq_stack_ptr and irq_count values. The lowest irq_stack
   value is used as irq_count, irq_stack_entry adds IRQ_STACK_START_SP to this
   when switching stack.
 * Moved irq_stack definition from patch 1 to patch 2.
 * Added patch 4

Changes since v6 [1]:
 * Add irq_count and do_softirq_own_stack().
 * Removed requirement that the irq_stack is naturally aligned.
 * Made irq_stack per_cpu regardless of page size.


[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385337.html
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/382238.html


AKASHI Takahiro (1):
  arm64: Modify stack trace and dump for use with irq_stack

James Morse (2):
  arm64: Add do_softirq_own_stack() and enable irq_stacks
  arm64: switch to irq_stack during softirq

Jungseok Lee (1):
  arm64: Store struct task_info in sp_el0

 arch/arm64/include/asm/irq.h         | 36 ++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 10 ++++-
 arch/arm64/kernel/entry.S            | 82 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/head.S             |  5 +++
 arch/arm64/kernel/irq.c              | 37 ++++++++++++++++
 arch/arm64/kernel/sleep.S            |  3 ++
 arch/arm64/kernel/stacktrace.c       | 29 ++++++++++++-
 arch/arm64/kernel/traps.c            | 14 +++++-
 8 files changed, 206 insertions(+), 10 deletions(-)

-- 
2.6.2
