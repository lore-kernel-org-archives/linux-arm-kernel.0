From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed,  2 Oct 2013 14:31:58 +0200
Subject: [PATCH 0/1] fix MVEBU GPIO driver bug causing kernel hang
Message-ID: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MVEBU GPIO driver (like the old orion-gpio) is affected by a subtle
bug, where requesting (and triggering) both EDGE- and LEVEL- based IRQs
causes the kernel to hang.
Part of the reworking necessary to fix this bug (i.e. handling two
separate mask registers, one per chip type) was first submitted by me,
then reworked by Thomas Gleixner, then mainlined, finally landing in 3.11.

The final bits to actually fix this are still missing though.
This patch will fix this.
I also marked the necessary prerequisites to apply this to linux-stable.

SIDE NOTE: If I understand correctly, a brand new driver from
Sebastian Hesselbarth (drivers/irqchip/irq-orion.c) may replace this driver
in the future, but it still misses the IRQ_GC_MASK_CACHE_PER_TYPE bit:

static int __init orion_bridge_irq_init(struct device_node *np,
                                       struct device_node *parent)
{
[...]
       ret = irq_alloc_domain_generic_chips(domain, nrirqs, 1, np->name,
                            handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
#Cc: <stable@vger.kernel.org> # 3.7.x cfeaa93 genirq: Generic chip: Remove the local cur_regs() function
#Cc: <stable@vger.kernel.org> # 3.7.x 899f0e6 genirq: Generic chip: Add support for per chip type mask cache
#Cc: <stable@vger.kernel.org> # 3.7.x af80b0f genirq: Generic chip: Handle separate mask registers

Gerlando Falauto (1):
  gpio: mvebu: enable and use IRQ_GC_MASK_CACHE_PER_TYPE

 drivers/gpio/gpio-mvebu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
1.8.0.1
