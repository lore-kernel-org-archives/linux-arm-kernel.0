From: rric@kernel.org (Robert Richter)
Date: Thu, 13 Aug 2015 16:47:52 +0200
Subject: [PATCH v2 0/5] irqchip,
 gicv3: Updates and Cavium ThunderX errata workarounds
Message-ID: <1439477277-6157-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch series adds gicv3 updates and workarounds for HW errata in
Cavium's ThunderX GICV3.

The first one is an unchanged resubmission of a gicv3 series I sent a
while ago.

The next patches implement the workarounds for ThunderX's gicv3. Patch
#2 adds generic code to parse the hw revision provided by an IIDR or
MIDR register value and runs specific code if hw matches. This is used
to implement the actual errata fixes in patch #3 (gicv3) and #5
(gicv3-its). Patch #4 prerequisit for patch #5.

All current review comments addressed so far with V2.

V2:
 * Workaround for 23154:
   * implement code in a single asm() to keep instruction sequence
   * added comment to the code that explains the erratum
   * apply workaround also if running as guest, thus check MIDR
 * adding MIDR check

Robert Richter (5):
  arm64: gicv3: its: Add range check for number of allocated pages
  irqchip, gicv3: Add HW revision detection and configuration
  irqchip, gicv3: Workaround for Cavium ThunderX erratum 23154
  irqchip, gicv3-its: Read typer register outside the loop
  irqchip, gicv3-its: Workaround for Cavium ThunderX errata 22375, 24313

 drivers/irqchip/irq-gic-common.c   | 13 ++++++++
 drivers/irqchip/irq-gic-common.h   | 11 +++++++
 drivers/irqchip/irq-gic-v3-its.c   | 66 ++++++++++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c       | 59 +++++++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h |  1 +
 5 files changed, 143 insertions(+), 7 deletions(-)

-- 
2.1.1
