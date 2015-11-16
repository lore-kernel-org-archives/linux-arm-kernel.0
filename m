From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 19:13:24 +0000
Subject: [PATCH 0/4] irqchip/gic: Deal with the active state across kexec and
 suspend/resume
Message-ID: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the kernel uses EOImode==1 for the GIC, this uncovers a
number of cases where the active state is not correctly handled:

- When doing kexec, we directly call the irq_eoi() method, which may
  violate ordering constraints, or leave interrupts active.
- When booting, we don't reset the active state, trusting whatever was
  there before.
- When doing suspend/resume, we're not saving/restoring the active
  state, which could result in lost interrupts if VMs were running at
  this precise moment.

This has also uncovered a small bug in the way we restore enabled
interrupts (which could result in a fix to stable).

These patches are on top of v4.4-rc1.

Marc Zyngier (4):
  arm: kexec: Deactivate in-flight interrupts
  irqchip/gic: Make sure all interrupts are deactivated at boot
  irqchip/gic: Clear enable bits before restoring them
  irqchip/gic: Add save/restore of the active state

 arch/arm/kernel/machine_kexec.c  | 11 ++++++++++-
 drivers/irqchip/irq-gic-common.c | 13 +++++++++----
 drivers/irqchip/irq-gic.c        | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.1.4
