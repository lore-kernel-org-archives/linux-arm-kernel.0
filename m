From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Sep 2011 11:31:37 -0500
Subject: [PATCH 2/5] irq: fix existing domain check in irq_domain_add
In-Reply-To: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
Message-ID: <1316017900-19918-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

irq_data will normally exist, so the domain was prevented from being set.
The simple domain code did not hit this as nr_irq is always 0.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d5828da..84f4110 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -29,7 +29,7 @@ void irq_domain_add(struct irq_domain *domain)
 	 */
 	for (hwirq = 0; hwirq < domain->nr_irq; hwirq++) {
 		d = irq_get_irq_data(irq_domain_to_irq(domain, hwirq));
-		if (d || d->domain) {
+		if (d && d->domain) {
 			/* things are broken; just report, don't clean up */
 			WARN(1, "error: irq_desc already assigned to a domain");
 			return;
-- 
1.7.5.4
