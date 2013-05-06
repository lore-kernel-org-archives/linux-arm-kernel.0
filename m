From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 May 2013 14:32:13 +0200
Subject: [RFC patch 7/8] fixup 2/2: genirq: generic chip: Add linear irq
 domain support
In-Reply-To: <1367843533-7117-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130503214629.810207749@linutronix.de>
 <1367843533-7117-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367843533-7117-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mask_cache pointer also needs to be initialized for domain generic
chips.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 kernel/irq/generic-chip.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 3dbfe2e..3e0312f 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -275,12 +275,22 @@ int irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 
 	p += sizeof(*dgc) + numchips * sizeof(void *);
 	for (i = 0; i < numchips; i++) {
+		int k;
+
 		gc = (struct irq_chip_generic *)p;
 		dgc->gc[i] = gc;
 		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
 				      NULL, handler);
 		gc->domain = d;
 
+		for (k = 0; k < gc->num_ct; k++) {
+			struct irq_chip_type *ct = &gc->chip_types[k];
+			if (gcflags & IRQ_GC_MASK_CACHE_PER_TYPE)
+				ct->mask_cache = &ct->mask_cache_priv;
+			else
+				ct->mask_cache = &gc->mask_cache;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
-- 
1.7.2.5
