From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:16 +0200
Subject: [PATCH 03/17] irqchip: irq-armada-370-xp: use proper return value for
 ->set_affinity()
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->set_affinity() hook of 'struct irq_chip' is supposed to return
one of IRQ_SET_MASK_OK or IRQ_SET_MASK_OK_NOCOPY. However, the code
currently simply returns 0. This patch fixes that by using
IRQ_SET_MASK_OK, which tells the IRQ core that it is responsible for
updating irq_data.affinity.

Note that this patch does not cause any change to the compiled code,
as IRQ_SET_MASK_OK has the value 0. This is therefore just a simple
cleanup.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel at vger.kernel.org
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 3e238cd..9e630f2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -265,7 +265,7 @@ static int armada_xp_set_affinity(struct irq_data *d,
 	writel(reg, main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
 	raw_spin_unlock(&irq_controller_lock);
 
-	return 0;
+	return IRQ_SET_MASK_OK;
 }
 #endif
 
-- 
2.0.0
