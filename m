From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 25 Oct 2014 12:06:52 +0100
Subject: [PATCH 0/3] genirq: Add support for "split-EOI" irqchips
Message-ID: <1414235215-10468-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moderately recent ARM interrupt controllers can use a "split mode" EOI,
where instead of just using a single write to notify the controller of
the end of interrupt, uses the following:
- priority-drop: the interrupt is still active, but other interrupts can
  now be taken
- deactivate: the interrupt is not active anymore, and can be taken again.

This makes it very useful for threaded interrupts, as it avoids the
usual mask/unmask dance (and has the potential of being more efficient
on ARM, as it is using the CPU interface instead of the global
distributor, specially with the use of virtualization).

To implement this, a new optional irqchip method is added
(irq_priority_drop).  The usual irq_eoi is expected to implement the
deactivate method.

Non threaded interrupts are using these two callbacks back to back,
but threaded ones only perform the irq_priority_drop call in the
interrupt context, leaving the irq_eoi call to the thread context
(which are expected to use the IRQCHIP_EOI_THREADED flag).

I've tried to keep the changes as simple as possible, but I'm afraid
it might be too simple (I'm basically considering that a a irq_desc
with the IRQS_ONESHOT flag is a threaded interrupt, which might not
alwayd be true).

This has been tested on a dual Cortex-A7 board, with the ahci driver
using a threaded interrupt handler. Patches based on my
irq/irqchip_state branch previously posted, and also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/priority_drop

Marc Zyngier (3):
  genirq: Add support for priority-drop/deactivate interrupt controllers
  irqchip: GIC: Convert to EOImode == 1
  irqchip: GICv3: Convert to EOImode == 1

 drivers/irqchip/irq-gic-v3.c       | 30 ++++++++++++++++--
 drivers/irqchip/irq-gic.c          | 64 ++++++++++++++++++++++++++++++++++----
 include/linux/irq.h                |  1 +
 include/linux/irqchip/arm-gic-v3.h | 10 ++++++
 include/linux/irqchip/arm-gic.h    |  4 +++
 kernel/irq/chip.c                  | 53 +++++++++++++++++++++----------
 6 files changed, 138 insertions(+), 24 deletions(-)

-- 
2.1.0
