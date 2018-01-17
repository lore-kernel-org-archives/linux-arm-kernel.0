From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 11:54:38 +0000
Subject: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
Message-ID: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is a continuation of the work started by Daniel [1]. The goal
is to use GICv3 interrupt priorities to simulate an NMI.

To achieve this, set two priorities, one for standard interrupts and
another, higher priority, for NMIs. Whenever we want to disable interrupts,
we mask the standard priority instead so NMIs can still be raised. Some
corner cases though still require to actually mask all interrupts
effectively disabling the NMI.

Of course, using priority masking instead of PSR.I comes at some cost. On
hackbench, the drop of performance seems to be >1% on average for this
version. I can only attribute that to recent changes in the kernel as
hackbench seems slightly slower compared to my other benchmarks while the
runs with the use of GICv3 priorities have stayed in the same time frames.
KVM Guests do not seem to be affected preformance-wise by the host using
PMR to mask interrupts or not.

Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
for now. I don't think there is any reason LPIs should be allowed to be set
as NMI as they do not have an active state.
When an NMI is active on a CPU, no other NMI can be triggered on the CPU.


Requirements to use this:
- Have GICv3
- SCR_EL3.FIQ is set to 1 when linux runs
- Select Kernel Feature -> Use ICC system registers for IRQ masking

* Patches 1 and 2 allows to detect and enable the use of GICv3 system
  registers during boot time.
* Patch 3 introduces the masking of IRQs using priorities replacing irq
  disabling.
* Patch 4 adds some utility functions
* Patch 5 add detection of the view linux has on GICv3 priorities, without
  this we cannot easily mask specific priorities in an accurate manner
* Patch 6 adds the support for NMIs


Changes since V1[2]:
* Series rebased to v4.15-rc8.

* Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).

* Fix issue where debug exception were not masked when enabling debug in
  mdscr_el1.


Changes since RFC[3]:
* The series was rebased to v4.15-rc2 which implied some changes mainly
  related to the work on exception entries and daif flags by James Morse.

  - The first patch in the previous series was dropped because no longer
    applicable.

  - With the semantics James introduced of "inheriting" daif flags,
    handling of PMR on exception entry is simplified as PMR is not altered
    by taking an exception and already inherited from previous state.

  - James pointed out that taking a PseudoNMI before reading the FAR_EL1
    register should not be allowed as per the TRM (D10.2.29):
    "FAR_EL1 is made UNKNOWN on an exception return from EL1."
    So in this submission PSR.I bit is cleared only after FAR_EL1 is read.

* For KVM, only deal with PMR unmasking/restoring in common code, and VHE
  specific code makes sure PSR.I bit is set when necessary.

* When detecting the GIC priority view (patch 5), wait for an actual
  interrupt instead of trying only once.


[1] http://www.spinics.net/lists/arm-kernel/msg525077.html
[2] https://www.spinics.net/lists/arm-kernel/msg620763.html
[3] https://www.spinics.net/lists/arm-kernel/msg610736.html

Cheers,

Julien

-->

Daniel Thompson (3):
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
 arch/arm64/include/asm/arch_gicv3.h    |  42 +++++
 arch/arm64/include/asm/assembler.h     |  23 ++-
 arch/arm64/include/asm/daifflags.h     |  36 ++--
 arch/arm64/include/asm/efi.h           |   5 +
 arch/arm64/include/asm/irqflags.h      | 131 ++++++++++++++
 arch/arm64/include/asm/processor.h     |   4 +
 arch/arm64/include/asm/ptrace.h        |  14 +-
 arch/arm64/include/asm/sysreg.h        |   1 +
 arch/arm64/kernel/alternative.c        |  39 ++++-
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/cpufeature.c         |  69 +++++---
 arch/arm64/kernel/entry.S              |  84 ++++++++-
 arch/arm64/kernel/head.S               |  38 ++++
 arch/arm64/kernel/process.c            |   6 +
 arch/arm64/kernel/smp.c                |  14 ++
 arch/arm64/kvm/hyp/hyp-entry.S         |  20 +++
 arch/arm64/kvm/hyp/switch.c            |  21 +++
 arch/arm64/mm/proc.S                   |  23 +++
 drivers/irqchip/irq-gic-common.c       |  10 ++
 drivers/irqchip/irq-gic-common.h       |   2 +
 drivers/irqchip/irq-gic-v3-its.c       |   2 +-
 drivers/irqchip/irq-gic-v3.c           | 307 +++++++++++++++++++++++++++++----
 include/linux/interrupt.h              |   1 +
 include/linux/irqchip/arm-gic-common.h |   6 +
 include/linux/irqchip/arm-gic.h        |   5 -
 28 files changed, 841 insertions(+), 84 deletions(-)

--
1.9.1
