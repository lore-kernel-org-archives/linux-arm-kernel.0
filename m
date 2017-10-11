From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 14:00:55 +0100
Subject: [RFC 0/7] arm64: provide pseudo NMI with GICv3
Message-ID: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is a continuation of the work started by Daniel [1]. The goal is
to use GICv3 interrupt priorities to simulate an NMI.

To achieve this, set two priorities, one for standard interrupts and
another, higher priority, for NMIs. Whenever we want to disable interrupts,
we mask the standard priority instead so NMIs can still be raised. Some
corner cases though still require to actually mask all interrupts
effectively disabling the NMI.

Of course, using priority masking instead of PSR.I comes at some cost. On
hackbench, I notice a ~6% drop of performance. However, on a kernel build,
I do not see significant differences.

Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
for now. I don't think there is any reason LPIs should be allowed to be set
as NMI as they do not have an active state.
When an NMI is active on a CPU, no other NMI can be triggered on the CPU.

Requirements to use this:
- Have GICv3
- SCR_EL3.FIQ is set to 1 when linux runs
- Select Kernel Feature -> Use ICC system registers for IRQ masking

>From my testing with the perf interrupt, there doesn't seem to be any major
issue left (but if you find some, do tell!).

* Patches 1 and 5 are minor utility changes.
* Patches 2 and 3 allows to detect and enable the use of GICv3 system
  registers during boot time.
* Patch 4 introduces the masking of IRQs using priorities replacing irq
  disabling.
* Patch 6 add detection of the view linux has on GICv3 priorities, without
  this we cannot easily mask specific priorities in an accurate manner
* Patch 7 adds the support for NMIs


[1] http://www.spinics.net/lists/arm-kernel/msg525077.html

Thanks,

Julien Thierry


Daniel Thompson (4):
  arm64: irqflags: Reorder the fiq & async macros
  arm64: cpufeature: Allow early detect of specific features
  arm64: alternative: Apply alternatives early in boot process
  arm64: irqflags: Use ICC sysregs to implement IRQ masking

Julien Thierry (3):
  irqchip/gic: Add functions to access irq priorities
  arm64: Detect current view of GIC priorities
  arm64: Add support for pseudo-NMIs

 Documentation/arm64/booting.txt        |   5 +
 arch/arm64/Kconfig                     |  15 ++
 arch/arm64/include/asm/alternative.h   |   1 +
 arch/arm64/include/asm/arch_gicv3.h    |  24 +++
 arch/arm64/include/asm/assembler.h     |  33 +++-
 arch/arm64/include/asm/efi.h           |   5 +
 arch/arm64/include/asm/irqflags.h      | 143 +++++++++++++++-
 arch/arm64/include/asm/kvm_host.h      |  40 +++++
 arch/arm64/include/asm/processor.h     |   4 +
 arch/arm64/include/asm/ptrace.h        |  14 +-
 arch/arm64/include/asm/sysreg.h        |   1 +
 arch/arm64/kernel/alternative.c        |  39 ++++-
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/cpufeature.c         |  67 +++++---
 arch/arm64/kernel/entry.S              | 132 ++++++++++++--
 arch/arm64/kernel/head.S               |  38 +++++
 arch/arm64/kernel/process.c            |   6 +
 arch/arm64/kernel/smp.c                |  14 ++
 arch/arm64/mm/proc.S                   |  23 +++
 drivers/irqchip/irq-gic-common.c       |  10 ++
 drivers/irqchip/irq-gic-common.h       |   2 +
 drivers/irqchip/irq-gic-v3-its.c       |   2 +-
 drivers/irqchip/irq-gic-v3.c           | 304 +++++++++++++++++++++++++++++----
 include/linux/interrupt.h              |   1 +
 include/linux/irqchip/arm-gic-common.h |   6 +
 include/linux/irqchip/arm-gic.h        |   5 -
 26 files changed, 845 insertions(+), 90 deletions(-)

--
1.9.1
