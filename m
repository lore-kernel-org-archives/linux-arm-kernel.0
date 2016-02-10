From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Feb 2016 15:46:55 +0100
Subject: [PATCH v3 0/6] irqchip: irq-armada-370-xp: generic MSI infrastructure
 and assorted fixes
Message-ID: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series converts the Armada 370/XP irqchip driver (also used
on Armada 375, 38x and 39x) to the new MSI infrastructure put in place
by Marc. It doesn't bring any functional difference other than using
the right, modern, MSI mechanism, which might ultimately allow Marc to
remove the old way of implementing MSI support.

It has been tested on Armada 38x and Armada XP with an Intel e1000e
NIC and an Intel IGB NIC, both of which use MSI interrupts.

Note that this patch series depends on the patch series from Marc
Zyngier for proper operation, which have already been merged in
tip.git by Thomas Gleixner:

  http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=530cbe100ef7587aa5b5ac3a4b670cda4d50e598
  http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=14a0db3cdd114da757197193f66786e63649c91e

Changes since v2:

 - No code changes.

 - Added Reviewed-by from Marc Zyngier on patches:

   irqchip: irq-armada-370-xp: use the generic MSI infrastructure

 - Added Acked-by from Gregory Clement on patches:

   irqchip: irq-armada-370-xp: use PCI_MSI_DOORBELL_START where appropriate
   irqchip: irq-armada-370-xp: use shorter names for irq_chip
   ARM: mvebu: use the ARMADA_370_XP_IRQ option

 - Added Reviewed-by from Gregory Clement on patches:

   irqchip: irq-armada-370-xp: allow allocation of multiple MSIs

 - Posted to a wider audience, including lkml.

Changes since v1:

 - Rebased on top of v4.5-rc1, and the latest version of Marc Zyngier
   irqchip core fixes, which are needed for this series to work.

 - Added Acked-by from Gregory Clement on patch "irqchip:
   irq-armada-370-xp: add Kconfig option for the driver"

 - Add a new patch that changes hardcoded "16" values by the
   appropriate PCI_MSI_DOORBELL_START definition. Noticed by Gregory
   Clement.

 - Drop the ->irq_enable() and ->irq_disable() callbacks from struct
   irq_chip armada_370_xp_msi_irq_chip, as they are not needed, since
   we already provide the same callbacks for ->irq_mask() and
   ->irq_unmask(). Noticed by Marc Zyngier.

 - Drop the MSI_FLAG_MULTI_PCI_MSI, since we don't (yet) support
   allocating multiple MSIs as once. Noticed by Marc Zyngier.

 - Added a separate commit actually implementing the allocation of
   multiple MSIs at once, and therefore adds the
   MSI_FLAG_MULTI_PCI_MSI.

 - Reorder code in armada_370_xp_mpic_of_init() to make a BUG_ON()
   really useful. Noticed by Marc Zyngier.

Thanks!

Thomas

Thomas Petazzoni (6):
  irqchip: irq-armada-370-xp: add Kconfig option for the driver
  irqchip: irq-armada-370-xp: use the generic MSI infrastructure
  irqchip: irq-armada-370-xp: use PCI_MSI_DOORBELL_START where
    appropriate
  irqchip: irq-armada-370-xp: use shorter names for irq_chip
  irqchip: irq-armada-370-xp: allow allocation of multiple MSIs
  ARM: mvebu: use the ARMADA_370_XP_IRQ option

 arch/arm/mach-mvebu/Kconfig         |   6 +-
 drivers/irqchip/Kconfig             |   6 ++
 drivers/irqchip/Makefile            |   2 +-
 drivers/irqchip/irq-armada-370-xp.c | 156 +++++++++++++++---------------------
 4 files changed, 78 insertions(+), 92 deletions(-)

-- 
2.6.4
