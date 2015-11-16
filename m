From: james.morse@arm.com (James Morse)
Date: Mon, 16 Nov 2015 18:22:04 +0000
Subject: [PATCH v7 0/3] arm64: Add support for IRQ stack
Message-ID: <1447698128-8490-1-git-send-email-james.morse@arm.com>
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

This series is split into three for reasons of (coarse) attribution, although
I've added bugs to all the patches...

This series is based on the v4.4-rc1.
The series can be pulled from git://linux-arm.org/linux-jm.git -b irq_stack/v7

Comments welcome,


James

AKASHI Takahiro (1):
  arm64: Modify stack trace and dump for use with irq_stack

James Morse (1):
  arm64: Add do_softirq_own_stack() and enable irq_stacks

Jungseok Lee (1):
  arm64: Add irq_stack boiler plate, store struct task_info in sp_el0

 arch/arm64/include/asm/irq.h         | 26 +++++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 10 ++++++--
 arch/arm64/kernel/entry.S            | 48 ++++++++++++++++++++++++++++++++----
 arch/arm64/kernel/head.S             |  5 ++++
 arch/arm64/kernel/irq.c              | 47 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/sleep.S            |  3 +++
 arch/arm64/kernel/smp.c              |  5 ++++
 arch/arm64/kernel/stacktrace.c       | 29 ++++++++++++++++++++--
 arch/arm64/kernel/traps.c            | 14 ++++++++++-
 9 files changed, 177 insertions(+), 10 deletions(-)

-- 
2.1.4
