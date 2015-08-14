From: rric@kernel.org (Robert Richter)
Date: Fri, 14 Aug 2015 15:18:34 +0200
Subject: [PATCH v3 0/6] irqchip,
 gicv3: Updates and Cavium ThunderX errata workarounds
Message-ID: <1439558320-5777-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch series adds gicv3 updates and workarounds for HW errata in
Cavium's ThunderX GICV3.

The first one is an unchanged resubmission of a patch from a gicv3
series I sent a while ago.

The next patches implement the workarounds for ThunderX's gicv3. Patch
#2 adds generic code to parse the hw revision provided by an IIDR or
MIDR register value and runs specific code if hw matches. For MIDR
detection it uses the arm64 errata framework. This patch is used for
the implementation of the actual errata fixes in patch #3 (gicv3) and
#5 (gicv3-its). Patch #4 is a prerequisit for patch #5. Patch #6 is a
change to the errata framework to only check for cpu features if the
capability value is non-zero.

All current review comments addressed so far with v3.

v3:
 * use arm64 errata framework for midr check
 * fix mixup of errata to be dependend from midr/iidr

v2:
 * Workaround for 23154:
   * implement code in a single asm() to keep instruction sequence
   * added comment to the code that explains the erratum
   * apply workaround also if running as guest, thus check MIDR
 * adding MIDR check

Robert Richter (6):
  irqchip, gicv3-its: Add range check for number of allocated pages
  irqchip, gicv3: Add HW revision detection and configuration
  irqchip, gicv3: Workaround for Cavium ThunderX erratum 23154
  irqchip, gicv3-its: Read typer register outside the loop
  irqchip, gicv3-its: Workaround for Cavium ThunderX errata 22375, 24313
  arm64: errata: Match all cpus if capability value is zero

 arch/arm64/Kconfig                  | 11 +++++++
 arch/arm64/include/asm/cpufeature.h | 16 +++++++---
 arch/arm64/include/asm/cputype.h    | 18 ++++++-----
 arch/arm64/kernel/cpu_errata.c      |  9 ++++++
 drivers/irqchip/irq-gic-common.c    | 13 ++++++++
 drivers/irqchip/irq-gic-common.h    | 10 ++++++
 drivers/irqchip/irq-gic-v3-its.c    | 62 ++++++++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c        | 63 ++++++++++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h  |  1 +
 9 files changed, 184 insertions(+), 19 deletions(-)

-- 
2.1.1
