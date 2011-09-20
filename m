From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Sep 2011 15:24:01 -0500
Subject: [PATCH 0/3] GIC OF bindings
Message-ID: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Hopefully, this is the final or near final version of GIC binding support.

Changes from the previous version:
- SPIs and PPIs are numbered starting at 0. Now the gic has it's own irq
  domain translate function instead of the simple domain one.
- interrupt cell format has changed based on Grant's proposal.
- Dropped "ARM: gic: allow irq_start to be 0". Instead, the first 16 irqs
  are skipped and the domain irq_base adjusted accordingly.
- Added a fix to of_irq_find_parent when the parent == child.
- Renamed intc_desc.parent to intc_desc.interrupt_parent.
- Implemented Grant's algorithm for walking the list of interrupt
  controllers. Added a return value to interrupt init functions, so they
  don't get added to the parent list on a init failure.

The changes are significant enough that I did not include previous
acked/reviewed/tested-by's.

Rob

Rob Herring (3):
  of/irq: of_irq_find_parent: check for parent equal to child
  of/irq: introduce of_irq_init
  ARM: gic: add OF based initialization

 Documentation/devicetree/bindings/arm/gic.txt |   55 +++++++++++
 arch/arm/common/gic.c                         |   89 ++++++++++++++++-
 arch/arm/include/asm/hardware/gic.h           |   12 +++
 drivers/of/irq.c                              |  128 +++++++++++++++++++++++--
 include/linux/of_irq.h                        |    1 +
 5 files changed, 274 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

-- 
1.7.5.4
