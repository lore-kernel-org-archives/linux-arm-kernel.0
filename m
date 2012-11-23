From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Nov 2012 15:19:29 +0000
Subject: [PATCH 1/1] mfd: Simplify IRQ domain registration code in STMPE
Message-ID: <1353683969-9332-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Historically, a driver would have to decide whether it required
a Linear or Legacy IRQ domain when registering one. This can end
up as quite a lot of code. A new Simple call now exists which
simplifies this process. Let's make use of it here.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/stmpe.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index b03cc64..0e6d8b8 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -889,18 +889,14 @@ static struct irq_domain_ops stmpe_irq_ops = {
 static int __devinit stmpe_irq_init(struct stmpe *stmpe,
 				struct device_node *np)
 {
-	int base = stmpe->irq_base;
+	int base = 0;
 	int num_irqs = stmpe->variant->num_irqs;
 
-	if (base) {
-		stmpe->domain = irq_domain_add_legacy(
-			np, num_irqs, base, 0, &stmpe_irq_ops, stmpe);
-	}
-	else {
-		stmpe->domain = irq_domain_add_linear(
-			np, num_irqs, &stmpe_irq_ops, stmpe);
-	}
+	if (!np)
+		base = stmpe->irq_base;
 
+	stmpe->domain = irq_domain_add_simple(np, num_irqs, base,
+					      &stmpe_irq_ops, stmpe);
 	if (!stmpe->domain) {
 		dev_err(stmpe->dev, "Failed to create irqdomain\n");
 		return -ENOSYS;
-- 
1.7.9.5
