From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 18 Mar 2015 14:20:21 +0000
Subject: [RFC PATCH 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)
Message-ID: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
the irqflags macros to modify the GIC PMR (the priority mask register is
accessible as a system register on GICv3 and later) rather than the
PSR. The pseudo-NMI changes are support by a prototype implementation of
arch_trigger_all_cpu_backtrace that allows the new code to be exercised.

In addition to the arm64 changes I've bundled in a few patches from
other patchsets to make the patchset self-contained. Of particular note
of the serial break emulation patch which allows ^B^R^K to be used
instead of a serial break to trigger SysRq-L (FVP UART sockets don't
seem to support serial breaks). This makes it easy to run
arch_trigger_all_cpu_backtrace from an IRQ handler (i.e. somewhere with
interrupts masked so we are forced to preempt and take the NMI).

The code works-for-me (tm) but there are currently some pretty serious
limitations.

 1. Exercised only on the foundation model with gicv3 support. It has
    not been exercised on real silicon or even on the more advanced
    ARM models.

 2. It has been written without any documentation describing GICv3
    architecture (which has not yet been released by ARM). I've been
    guessing about the behaviour based on the ARMv8 and GICv2
    architecture specs. The code works on the foundation model but
    I cannot check that it conforms architecturally.

 3. Requires GICv3+ hardware together with firmware support to enable
    GICv3 features at EL3. If CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS is
    enabled the kernel will not boot on older hardware. It will be hard
    to diagnose because we will crash very early in the boot (i.e.
    before the call to start_kernel). Auto-detection might be possible
    but the performance and code size cost of adding conditional code to
    the irqflags macros probably makes it impractical. As such it may
    never be possible to remove this limitation (although it might be
    possible to find a way to survive long enough to panic and show the
    results on the console).

 4. No benchmarking (see #1 above). Unlike the PSR, updates to the PMR
    do not self synchronize which requires me to sprinkle isb
    instructions fairly liberally. I've been told the cost of isb varies
    from almost-free (A53) to somewhat costly (A57) thus we export this
    code to reduce kernel performance. However this needs to be
    quantified and I am currently unable to do this. I'd really like to
    but don't have any suitable hardware.

 5. There is no code in el1_irq to detect NMI and switch from IRQ to NMI
    handling. This means all the irq handling machinary is re-entered in
    order to handle the NMI. This not safe and deadlocks are likely.
    This is a severe limitation although, in this proof-of-concept
    work, NMI can only be triggered by SysRq-L or severe kernel damage.
    This means we just about get away with it for simple test (lockdep
    detects that we are doing wrong and shows a backtrace). This is
    definitely the first thing that needs to be tackled to take this
    code further.

Note also that alternative approaches to implementing a pseudo-NMI on
arm64 are possible but only through runtime cooperation with other
software components in the system, potentially both those running at EL3
and at secure EL1. I should like to explore these options in future but,
as far as I know, this is the only sane way to provide NMI-like features
whilst being implementable entirely in non-secure EL1[1]

[1] Except for a single register write to ICC_SRE_EL3 by the EL3
    firmware (and already implemented by ARM trusted firmware).


Daniel Thompson (7):
  serial: Emulate break using control characters
  printk: Simple implementation for NMI backtracing
  irqchip: gic-v3: Reset BPR during initialization
  arm64: irqflags: Reorder the fiq & async macros
  arm64: irqflags: Use ICC sysregs to implement IRQ masking
  arm64: irqflags: Automatically identify I bit mis-management
  arm64: Add support for on-demand backtrace of other CPUs

 arch/arm64/Kconfig                   |  16 ++++
 arch/arm64/include/asm/assembler.h   |  72 +++++++++++++++--
 arch/arm64/include/asm/hardirq.h     |   2 +-
 arch/arm64/include/asm/irq.h         |   5 ++
 arch/arm64/include/asm/irqflags.h    | 130 ++++++++++++++++++++++++++++--
 arch/arm64/include/asm/ptrace.h      |  10 +++
 arch/arm64/include/asm/smp.h         |   4 +
 arch/arm64/include/uapi/asm/ptrace.h |   8 ++
 arch/arm64/kernel/entry.S            |  70 ++++++++++++++---
 arch/arm64/kernel/head.S             |  27 +++++++
 arch/arm64/kernel/irq.c              |   6 ++
 arch/arm64/kernel/smp.c              |  70 +++++++++++++++++
 arch/arm64/mm/cache.S                |   4 +-
 arch/arm64/mm/proc.S                 |  19 +++++
 drivers/irqchip/irq-gic-v3.c         |  70 ++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h   |   6 +-
 include/linux/irqchip/arm-gic.h      |   2 +-
 include/linux/printk.h               |  20 +++++
 include/linux/serial_core.h          |  83 +++++++++++++++-----
 init/Kconfig                         |   3 +
 kernel/printk/Makefile               |   1 +
 kernel/printk/nmi_backtrace.c        | 148 +++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug                    |  15 ++++
 23 files changed, 746 insertions(+), 45 deletions(-)
 create mode 100644 kernel/printk/nmi_backtrace.c

--
2.1.0
