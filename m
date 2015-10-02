From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:37:49 +0100
Subject: [PATCH 0/5] arm64: Allow booting with GICv3 in GICv2 mode
Message-ID: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent evolutions of the ARM Trusted Firmware have outlined issues
when the system is equipped with a GICv3 interrupt controller, but the
firmware has decided to restrict it to GICv2 compatibility mode.

In this mode, system registers cannot be enabled, and the firmware is
expected to pass a GICv2 description (DT or ACPI tables).

This series makes sure that system register access is checked at EL2
setup time and when the feature detection is performed. Additionally,
the GICv2 driver checks that system registers are disabled, and warns
if they are enabled.

The booting requirements are also updated to make the above explicit.

Marc Zyngier (5):
  arm64: el2_setup: Make sure ICC_SRE_EL2.SRE sticks before using GICv3
    sysregs
  irqchip/gic-v3: Make gic_enable_sre an inline function
  arm64: cpufeatures: Check ICC_EL1_SRE.SRE before enabling
    ARM64_HAS_SYSREG_GIC_CPUIF
  irqchip/gic: Warn if GICv3 system registers are enabled
  arm64: Update booting requirements for GICv3 in GICv2 mode

 Documentation/arm64/booting.txt    | 11 ++++++++++-
 arch/arm64/kernel/cpufeature.c     | 19 ++++++++++++++++++-
 arch/arm64/kernel/head.S           |  2 ++
 drivers/irqchip/irq-gic-v3.c       | 32 +++++++++-----------------------
 drivers/irqchip/irq-gic.c          | 15 +++++++++++++++
 include/linux/irqchip/arm-gic-v3.h | 16 ++++++++++++++++
 6 files changed, 70 insertions(+), 25 deletions(-)

-- 
2.1.4
