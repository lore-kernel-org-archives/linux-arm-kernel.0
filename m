From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 26 Feb 2013 23:57:53 +0100
Subject: [PATCH 1/5] ARM: S3C24XX: fix redundant checks in the irq mapping
 function
In-Reply-To: <201302262357.24544.heiko@sntech.de>
References: <201302262357.24544.heiko@sntech.de>
Message-ID: <201302262357.53354.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check during the parent handling itself was wrong, as it should have
checked for parent_irq_data.

The interrupt controller structs always contain an irq_data array with 32
entries and the only possible error could be a parent_irq assignment of >31.

As this would point to outside the irq_data array this could contain
anything including non-NULL values. Therefore correct this to check
the parent_irq value to be in the right range.

With the same explanation of a valid interrupt controller always having a
full irq_data array, the topmost irq_data check in s3c24xx_irq_map
can also go away.

Finally the mapping function is only called thru the irq_domain ops, in
which case the intc struct is already successfully created, so there is
no need to check for it again.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 3f3de74..5257c9f 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -324,16 +324,6 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned 
int virq,
 	struct s3c_irq_data *parent_irq_data;
 	unsigned int irqno;
 
-	if (!intc) {
-		pr_err("irq-s3c24xx: no controller found for hwirq %lu\n", hw);
-		return -EINVAL;
-	}
-
-	if (!irq_data) {
-		pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n", hw);
-		return -EINVAL;
-	}
-
 	/* attach controller pointer to irq_data */
 	irq_data->intc = intc;
 
@@ -383,13 +373,13 @@ static int s3c24xx_irq_map(struct irq_domain *h, 
unsigned int virq,
 			goto err;
 		}
 
-		parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
-		if (!irq_data) {
-			pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n",
-			       hw);
+		if (irq_data->parent_irq > 31) {
+			pr_err("irq-s3c24xx: parent irq %lu is out of range\n",
+			       irq_data->parent_irq);
 			goto err;
 		}
 
+		parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
 		parent_irq_data->sub_intc = intc;
 		parent_irq_data->sub_bits |= (1UL << hw);
 
-- 
1.7.2.3
