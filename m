From: neilb@suse.de (NeilBrown)
Date: Wed, 25 Apr 2012 13:05:24 +1000
Subject: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice level-triggered
 interrupts.
In-Reply-To: <20120425025637.7832.14013.stgit@notabene.brown>
References: <20120425025637.7832.14013.stgit@notabene.brown>
Message-ID: <20120425030524.7832.85239.stgit@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Level triggered interrupts do not cause IRQS_PENDING to be set, so
check_wakeup_irqs ignores them.
They don't need to set IRQS_PENDING as the level stays high which
shows that they must be pending.  However if such an interrupt fired
during late suspend, it will have been masked so the fact that it
is still asserted will not cause the suspend to abort.

So if any wakeup interrupt is masked, unmask it when checking wakeup
irqs.  If the interrupt is asserted, suspend will abort.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 kernel/irq/pm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 15e53b1..0d26206 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -106,6 +106,12 @@ int check_wakeup_irqs(void)
 		if (irqd_is_wakeup_set(&desc->irq_data)) {
 			if (desc->istate & IRQS_PENDING)
 				return -EBUSY;
+			if (irqd_irq_masked(&desc->irq_data))
+				/* Probably a level interrupt
+				 * which fired recently and was
+				 * masked
+				 */
+				unmask_irq(desc);
 			continue;
 		}
 		/*
