From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Oct 2015 15:48:15 +0200
Subject: [PATCH] irqchip: irq-armada-370-xp: fix regression by clearing
 IRQ_NOAUTOEN
In-Reply-To: <alpine.DEB.2.11.1510202121590.8159@nanos>
References: <alpine.DEB.2.11.1510202121590.8159@nanos>
Message-ID: <1445435295-19956-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d17cab4451df1 ("irqchip: Kill off set_irq_flags usage") changed
the code of armada_370_xp_mpic_irq_map() from using set_irq_flags() to
irq_set_probe().

While the commit log seems to imply that there are no functional
changes, there are indeed functional changes introduced by this
commit: the IRQ_NOAUTOEN flag is no longer cleared. This functional
change causes a regression on Armada XP, which no longer works
properly after suspend/resume because per-CPU interrupts remain
disabled.

Due to how the hardware registers work, the irq-armada-370-xp cannot
simply save/restore a bunch of registers at suspend/resume to make
sure that the interrupts remain in the same state after
resuming. Therefore, it relies on the kernel to say whether the
interrupt is disabled or not, using the irqd_irq_disabled()
function. This was all working fine while the IRQ_NOAUTOEN flag was
cleared.

With the change introduced by Rob Herring in d17cab4451df1, the
IRQ_NOAUTOEN flag is now set for all interrupts. irqd_irq_disabled()
returns false for per-CPU interrupts, and therefore our per-CPU
interrupts are no longer re-enabled after resume.

This commit works around this problem by clearing again the
IRQ_NOAUTOEN flags, so that we are back to the situation we had before
commit d17cab4451df1. This work around is proposed as a minimal fix
for the problem, while a better long-term solution is being worked on.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Here is the one-line minimal change that tglx said would be more
acceptable to have in 4.3.
---
 drivers/irqchip/irq-armada-370-xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 655cb96..389318a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -317,6 +317,7 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 					handle_level_irq);
 	}
 	irq_set_probe(virq);
+	irq_clear_status_flags(virq, IRQ_NOAUTOEN);
 
 	return 0;
 }
-- 
2.6.2
