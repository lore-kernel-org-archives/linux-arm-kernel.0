From: james.morse@arm.com (James Morse)
Date: Thu,  3 Aug 2017 16:15:30 +0100
Subject: [PATCH 0/3] interrupted single step fixes
Message-ID: <20170803151533.29438-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been playing with Pratyush's watchpoint and interrupt reproducer,
it looks like we have three bugs with the way these interact:
 * PSTATE.SS is saved when we take an IRQ, but not restored when we ERET.
 * We can context switch while single-step is enabled.
 * We can end up single stepping the irq handler.

What does this cause? Instead of stepping over a watchpoint, we step
the interrupt handler instead, re-enable the watchpoints and disable
MDSCR_EL1.SS. On return we hit the watchpoint again. (the same will happen
with breakpoints).

Akashi, Pratyush, do these fix (all!) the issues you've been seeing?

Patch 3 conflicts badly with my doomed attempt to enforce an order
on the DAIF flags in the Serror/RAS/IESB series.


These three patches, and v3 of Pratyush's three are at:
git://linux-arm.org/linux-jm -b perf_single_step/v1

Enable CONFIG_SAMPLE_HW_BREAKPOINT, then:
> insmod data_breakpoint.ko ksym=__sysrq_enabled
> cat /proc/sys/kernel/sysrq

With mainline you will hit the watchpoint forever, Pratyush's patches
reduce this to ~10 times. These patches reduce that to the expected
once.

Thanks,

James Morse (3):
  arm64: entry: Allow SPSR_EL1.SS to be restored
  arm64: debug-monitors: Disable preemption
  arm64: entry: Exceptions from single-step should leave debug masked

 arch/arm64/include/asm/assembler.h | 18 ++++++++++++++++++
 arch/arm64/kernel/debug-monitors.c |  5 +++--
 arch/arm64/kernel/entry.S          | 14 +++++++-------
 3 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.13.3
