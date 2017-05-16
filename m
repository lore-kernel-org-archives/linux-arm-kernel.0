From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 May 2017 14:09:04 +0200
Subject: [PATCH] of: irq: use of_irq_get() in of_irq_to_resource()
Message-ID: <1494936544-27541-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_to_resource() currently uses irq_of_parse_and_map() to
translate a DT interrupt specification into a Linux virtual interrupt
number. While this works in most cases, irq_of_parse_and_map() doesn't
properly handle the case where the interrupt controller is not yet
available (due to deferred probing for example).

So instead, use of_irq_get(), which is implemented exactly like
irq_of_parse_and_map(), with the exception that if the interrupt
controller is not yet available, it returns -EPROBE_DEFER. Obviously,
we also handle this error and bail out from of_irq_to_resource() when
of_irq_get() returns an error.

This allows to avoid silly error messages at boot time caused by
irq_create_of_mapping() when the interrupt controller is not
available:

[    0.153168] irq: no irq domain found for /ap806/config-space at f0000000/interrupt-controller at 3f0100 !
[    0.154041] irq: no irq domain found for /cp110-master/config-space at f2000000/interrupt-controller at 1e0000 !
[    0.154124] irq: no irq domain found for /cp110-master/config-space at f2000000/interrupt-controller at 1e0000 !
[    0.154207] irq: no irq domain found for /cp110-master/config-space at f2000000/interrupt-controller at 1e0000 !
[    0.154437] irq: no irq domain found for /cp110-master/config-space at f2000000/interrupt-controller at 1e0000 !
[    0.154518] irq: no irq domain found for /cp110-master/config-space at f2000000/interrupt-controller at 1e0000 !

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/of/irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 7c56b72..47b3614 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -369,7 +369,10 @@ EXPORT_SYMBOL_GPL(of_irq_parse_one);
  */
 int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 {
-	int irq = irq_of_parse_and_map(dev, index);
+	int irq = of_irq_get(dev, index);
+
+	if (irq < 0)
+		return irq;
 
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
-- 
2.7.4
