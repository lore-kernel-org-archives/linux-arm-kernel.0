From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 19 Aug 2016 17:13:08 +0100
Subject: [RFC PATCH v3 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)
Message-ID: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
the irqflags macros to modify the GIC PMR (the priority mask register
accessible as a system register on GICv3 and later) rather than the
PSR. The patchset includes an implementation of
arch_trigger_all_cpu_backtrace() for arm64 allowing the new code to be
exercised.

The code works-for-me (tm) and is more "real" than the last time I
shared these patches. However there remain a couple of limitations
and caveats:

 1. Requires GICv3+ hardware to be effective meaning it has mostly been
    tested using FVP. The alternatives runtime patching system is
    employed so systems with earlier GIC architectures are still
    bootable but will not benefit from NMI simulation.

 2. FVP needs a bit of hacking to be able to run <SysRq-L> from an ISR.
    That's a shame because <SysRq-L> is a great way to observe an NMI
    preempting an IRQ handler. Testers are welcome to ping me offline
    and I will share the hacks I have been using to test with.

v3:

 * Rebased on v4.8-rc2
 * Restrict apply_alternatives_early() to consider only the
   capabilities needed for the kernel to function correctly (Will
   Deacon).
 * Added a bunch of notrace qualifiers (Will Deacon)
 * Used byte addressing to configure the interrupt priorities (Marc
   Zygnier)
 * Fixed implementation of interrupts_enabled()
 * Eliminated the over-zealous inclusion of <linux/irqchip/arm-gic-v3.h>.
 * Pushed a few symbol defintions towards the end of the patch series.

v2:

 * Removed the isb instructions. The PMR is self-synchronizing so
   these are not needed (Dave Martin)
 * Use alternative runtime patching to allow the same kernel binary
   to boot systems with and without GICv3+ (Dave Martin).
 * Added code to properly distinguish between NMI and normal IRQ and to
   call into NMI handling code where needed.
 * Replaced the IPI backtrace logic with a newer version (from Russell
   King).


Daniel Thompson (7):
  irqchip: gic-v3: Reset BPR during initialization
  arm64: Add support for on-demand backtrace of other CPUs
  arm64: cpufeature: Allow early detect of specific features
  arm64: alternative: Apply alternatives early in boot process
  arm64: irqflags: Reorder the fiq & async macros
  arm64: irqflags: Use ICC sysregs to implement IRQ masking
  arm64: Implement IPI_CPU_BACKTRACE using pseudo-NMIs

 arch/arm/include/asm/arch_gicv3.h      |   6 ++
 arch/arm64/Kconfig                     |  16 ++++
 arch/arm64/include/asm/alternative.h   |   1 +
 arch/arm64/include/asm/arch_gicv3.h    |  57 +++++++++++++
 arch/arm64/include/asm/assembler.h     |  55 +++++++++++-
 arch/arm64/include/asm/hardirq.h       |   2 +-
 arch/arm64/include/asm/irq.h           |   3 +
 arch/arm64/include/asm/irqflags.h      | 118 ++++++++++++++++++++++++--
 arch/arm64/include/asm/ptrace.h        |  23 +++++
 arch/arm64/include/asm/smp.h           |   2 +
 arch/arm64/kernel/alternative.c        |  36 +++++++-
 arch/arm64/kernel/cpufeature.c         |  92 +++++++++++---------
 arch/arm64/kernel/entry.S              | 151 +++++++++++++++++++++++++++------
 arch/arm64/kernel/head.S               |  35 ++++++++
 arch/arm64/kernel/smp.c                |  68 ++++++++++++++-
 arch/arm64/mm/proc.S                   |  23 +++++
 drivers/irqchip/irq-gic-v3.c           |  72 ++++++++++++++++
 include/linux/irqchip/arm-gic-common.h |   8 ++
 include/linux/irqchip/arm-gic.h        |   5 --
 lib/nmi_backtrace.c                    |   9 +-
 20 files changed, 697 insertions(+), 85 deletions(-)

--
2.7.4
