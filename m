From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Dec 2011 09:28:51 -0600
Subject: [PATCH 2/9] irq: check domain hwirq range for DT translate
In-Reply-To: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
Message-ID: <1323876538-20406-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

A DT node may have more than 1 domain associated with it, so make sure
the hwirq number is within range when doing DT translation.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 200ce83..ae6441e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -135,6 +135,9 @@ int irq_domain_simple_dt_translate(struct irq_domain *d,
 		return -EINVAL;
 	if (intsize < 1)
 		return -EINVAL;
+	if ((intspec[0] < d->hwirq_base) ||
+	    (intspec[0] >= d->hwirq_base + d->nr_irq))
+		return -EINVAL;
 
 	*out_hwirq = intspec[0];
 	*out_type = IRQ_TYPE_NONE;
-- 
1.7.5.4
