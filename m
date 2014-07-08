From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:23 +0100
Subject: [PATCH 00/15] arm/arm64: fix use of irq_find_mapping outside of legal
 RCU context
Message-ID: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of irqchip drivers are directly calling irq_find_mapping,
which may use a rcu_read_lock call when walking the radix tree.

Turns out that if you hit that point with CONFIG_PROVE_RCU enabled,
the kernel will shout at you, as using RCU in this context may be
illegal (specially if coming from the idle state, where RCU would be
in a quiescent state).

A possible fix would be to wrap calls to irq_find_mapping into a
RCU_NONIDLE macro, but that really looks ugly.

This patch series introduce another IRQ entry point on arm and arm64
(handle_domain_irq), which has the exact same behaviour as handle_IRQ,
except that it also takes a irq_domain pointer. This allows the
logical IRQ lookup to be done inside the irq_{enter,exit} section,
which contains a rcu_irq_{enter,exit}, making it safe.

A number of irqchips are then converted to this new entry point. I've
converted all the direct users of irq_find_mapping, except for the
cases where it was used as a chained handler (chained_irq_{enter,exit}
makes it safe). Users of irq_linear_revmap are safe as well.

I've given it some light testing on arm64. The series is also
available in my tree:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git handle_domain_irq

Marc Zyngier (15):
  arm64: pass IRQ domain to the core IRQ handler
  ARM: pass IRQ domain to the core IRQ handler
  irqchip: GIC: convert to handle_domain_irq
  irqchip: armada-370-xp: convert to handle_domain_irq
  irqchip: clps711x: convert to handle_domain_irq
  irqchip: mmp: convert to handle_domain_irq
  irqchip: mxs: convert to handle_domain_irq
  irqchip: orion: convert to handle_domain_irq
  irqchip: s3c24xx: convert to handle_domain_irq
  irqchip: sirfsoc: convert to handle_domain_irq
  irqchip: sun4i: convert to handle_domain_irq
  irqchip: versatile-fpga: convert to handle_domain_irq
  irqchip: vic: convert to handle_domain_irq
  irqchip: vt8500: convert to handle_domain_irq
  irqchip: zevio: convert to handle_domain_irq

 arch/arm/include/asm/irq.h           |  2 ++
 arch/arm/kernel/irq.c                | 23 +++++++++++++++++++----
 arch/arm64/include/asm/hardirq.h     |  4 ++++
 arch/arm64/kernel/irq.c              | 23 ++++++++++++++++++++---
 drivers/irqchip/irq-armada-370-xp.c  | 19 ++++++++++---------
 drivers/irqchip/irq-clps711x.c       | 18 +++++++-----------
 drivers/irqchip/irq-gic.c            |  3 +--
 drivers/irqchip/irq-mmp.c            | 10 ++++------
 drivers/irqchip/irq-mxs.c            |  3 +--
 drivers/irqchip/irq-orion.c          |  5 ++---
 drivers/irqchip/irq-s3c24xx.c        |  4 +---
 drivers/irqchip/irq-sirfsoc.c        |  6 ++----
 drivers/irqchip/irq-sun4i.c          |  5 ++---
 drivers/irqchip/irq-versatile-fpga.c |  2 +-
 drivers/irqchip/irq-vic.c            |  2 +-
 drivers/irqchip/irq-vt8500.c         |  5 ++---
 drivers/irqchip/irq-zevio.c          |  3 +--
 17 files changed, 80 insertions(+), 57 deletions(-)

-- 
2.0.0
