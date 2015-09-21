From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:33 +0200
Subject: [PATCH v5 0/6] irqchip,
 gicv3: Updates and Cavium ThunderX errata workarounds
Message-ID: <1442869119-1814-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch series adds gicv3 updates and workarounds for HW errata in
Cavium's ThunderX GICV3.

The patches has been rebased onto 4.3-rc1. Note that there are two
important fixes. See below for all changes.

The first one is an unchanged resubmission of a patch from a gicv3
series I sent a while ago.

The next patches implement the workarounds for ThunderX's gicv3. Patch
#2 implements the cpu workaround for gicv3 on ThunderX. Patch #3 is a
prerequisit for patch #5. Patch #4 adds generic code to parse the hw
revision provided by an IIDR. This patch is used for the implementa-
tion of the actual gicv3-its workaround in #5. Patch #6 updates to the
new jump label API.

All current review comments addressed so far with v5

v5:
 * fixed calling gic_read_iar_cavium_thunderx() if jump label is
   enabled
 * fix table size wrongly allocating only 4MB
 * made is_cavium_thunderx static
 * removed ARCH_THUNDER dependency for Cavium errata options to
   make it available for generic kernels
 * renamed caps names to quirk
 * introduced CAVIUM_ERRATUM_22375 config option
 * introduced ITS_FLAGS_WORKAROUND_CAVIUM_22375
 * added config descriptions
 * update to new jump label API

v4:
 * simplify code to only use cpus_have_cap() in gicv3_enable_quirks()
 * only enable hw detection for its in its_enable_quirks()
 * removed gicv3_check_capabilities()
 * drop special cpu capability for zero

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
  irqchip, gicv3: Workaround for Cavium ThunderX erratum 23154
  irqchip, gicv3-its: Read typer register outside the loop
  irqchip, gicv3-its: Add HW revision detection and configuration
  irqchip, gicv3-its: Workaround for Cavium ThunderX errata 22375, 24313
  irqchip, gicv3-its: Use new jump label API

 arch/arm64/Kconfig                  | 27 +++++++++++++++
 arch/arm64/include/asm/cpufeature.h |  3 +-
 arch/arm64/include/asm/cputype.h    | 17 ++++++----
 arch/arm64/kernel/cpu_errata.c      |  9 +++++
 drivers/irqchip/irq-gic-common.c    | 11 +++++++
 drivers/irqchip/irq-gic-common.h    |  9 +++++
 drivers/irqchip/irq-gic-v3-its.c    | 65 +++++++++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c        | 42 +++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h  |  1 +
 9 files changed, 169 insertions(+), 15 deletions(-)

-- 
2.1.1
