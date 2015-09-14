From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Sep 2015 14:26:14 +0100
Subject: [RFC PATCH v2 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)
Message-ID: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
the irqflags macros to modify the GIC PMR (the priority mask register is
accessible as a system register on GICv3 and later) rather than the
PSR. The patchset includes an implementation of
arch_trigger_all_cpu_backtrace() for arm64 allowing the new code to be
exercised.

The code works-for-me (tm) and is much more "real" than the last time I
shared these patches. However there remain a couple of limitations and
caveats:

 1. Requires GICv3+ hardware to be effective. The alternatives runtime
    patching system is employed so systems with earlier GIC architectures
    are still bootable but will not benefit from NMI simulation.

 2. Currently hardcoded to use ICC_PMR_EL1. Extra work might be needed
    on the alternatives system so we can peacefully coexist with ARMv8.1
    KVM support (when kernel will be running at EL2).

 3. FVP needs a bit of hacking to be able to run <SysRq-L> from an ISR.
    That's a shame because <SysRq-L> is a great way to observe an NMI
    preempting an IRQ handler. Testers are welcome to ping me offline
    and I can share the hacks (and DTs) I have been using to test with.

 4. Testing for non regression on a GICv2 system will require this patch
    to avoid crashes during <SysRq-L>:
    http://article.gmane.org/gmane.linux.kernel/2037558

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
  arm64: alternative: Apply alternatives early in boot process
  arm64: irqflags: Reorder the fiq & async macros
  arm64: irqflags: Use ICC sysregs to implement IRQ masking
  arm64: Implement IPI_CPU_BACKTRACE using pseudo-NMIs
  arm64: irqflags: Automatically identify I bit mis-management

 arch/arm64/Kconfig                   |  15 ++++
 arch/arm64/include/asm/alternative.h |   1 +
 arch/arm64/include/asm/assembler.h   |  56 ++++++++++++-
 arch/arm64/include/asm/hardirq.h     |   2 +-
 arch/arm64/include/asm/irq.h         |   3 +
 arch/arm64/include/asm/irqflags.h    | 154 +++++++++++++++++++++++++++++++++--
 arch/arm64/include/asm/ptrace.h      |  18 ++++
 arch/arm64/include/asm/smp.h         |   2 +
 arch/arm64/kernel/alternative.c      |  15 ++++
 arch/arm64/kernel/entry.S            | 149 +++++++++++++++++++++++++++------
 arch/arm64/kernel/head.S             |  35 ++++++++
 arch/arm64/kernel/setup.c            |  13 +++
 arch/arm64/kernel/smp.c              |  44 ++++++++++
 arch/arm64/mm/proc.S                 |  23 ++++++
 drivers/irqchip/irq-gic-v3.c         | 117 +++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h   |  10 +++
 include/linux/irqchip/arm-gic.h      |   2 +-
 lib/nmi_backtrace.c                  |   8 +-
 18 files changed, 629 insertions(+), 38 deletions(-)

--
2.4.3
