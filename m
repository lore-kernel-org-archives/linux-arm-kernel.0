From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 23 Jan 2014 23:38:03 +0100
Subject: [PATCH 0/3] irqchip: orion: bridge irq fixes for v3.14-rc1
Message-ID: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small patch set to fix some shortcomings how Orion bridge
irqs are handled. The patches are based on v3.13-rc8 and should go
into v3.14. They can possibly also marked for -stable down to v3.10.

This patches are the result of a discussion about a stale watchdog irq,
that can accidentially trigger the watchdog's irq handler and cause a
reset [1].

The first patch will add a write to clear already pending interrupts
on init. The second patch replaces handle_level_irq with handle_edge_irq
which is more appropriate for bridge irqs which are edge-triggered.
The last patch finally, fixes stale interrupts by installing an
.irq_enable callback, that will clear a possible pending interrupt
before unmasking it.

[1] http://www.spinics.net/lists/arm-kernel/msg302106.html

Sebastian Hesselbarth (3):
  irqchip: orion: clear bridge cause register on init
  irqchip: orion: use handle_edge_irq on bridge irqs
  irqchip: orion: clear stale interrupts in irq_enable

 drivers/irqchip/irq-orion.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.8.5.2
