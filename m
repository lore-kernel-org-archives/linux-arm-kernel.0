From: slash.tmp@free.fr (Mason)
Date: Sun, 16 Jul 2017 19:40:06 +0200
Subject: [PATCH] irqchip/gic: Use GIC_SPI symbolic constant
Message-ID: <e25e0ac5-abe2-6024-f669-c5352183114e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_SPI explicitly instead of an implicit 0.

Signed-off-by: Mason <slash.tmp@free.fr>
---
FWIW, 'make C=2' flagged a few lines:

$ make C=2 drivers/irqchip/irq-gic.o
  CHECK   drivers/irqchip/irq-gic.c
drivers/irqchip/irq-gic.c:1079:44: warning: incorrect type in assignment (different address spaces)
drivers/irqchip/irq-gic.c:1079:44:    expected void [noderef] <asn:3>*[noderef] <asn:2>*percpu_base
drivers/irqchip/irq-gic.c:1079:44:    got void [noderef] <asn:2>*[noderef] <asn:3>*<noident>
drivers/irqchip/irq-gic.c:1080:43: warning: incorrect type in assignment (different address spaces)
drivers/irqchip/irq-gic.c:1080:43:    expected void [noderef] <asn:3>*[noderef] <asn:2>*percpu_base
drivers/irqchip/irq-gic.c:1080:43:    got void [noderef] <asn:2>*[noderef] <asn:3>*<noident>
drivers/irqchip/irq-gic.c:1091:26: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-gic.c:1091:26:    expected void const [noderef] <asn:3>*__vpp_verify
drivers/irqchip/irq-gic.c:1091:26:    got void [noderef] <asn:3>*[noderef] <asn:2>*<noident>
drivers/irqchip/irq-gic.c:1091:71: warning: incorrect type in assignment (different address spaces)
drivers/irqchip/irq-gic.c:1091:71:    expected void [noderef] <asn:3>*<noident>
drivers/irqchip/irq-gic.c:1091:71:    got void [noderef] <asn:2>*
drivers/irqchip/irq-gic.c:1093:26: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-gic.c:1093:26:    expected void const [noderef] <asn:3>*__vpp_verify
drivers/irqchip/irq-gic.c:1093:26:    got void [noderef] <asn:3>*[noderef] <asn:2>*<noident>
drivers/irqchip/irq-gic.c:1093:70: warning: incorrect type in assignment (different address spaces)
drivers/irqchip/irq-gic.c:1093:70:    expected void [noderef] <asn:3>*<noident>
drivers/irqchip/irq-gic.c:1093:70:    got void [noderef] <asn:2>*
drivers/irqchip/irq-gic.c:1167:43: warning: incorrect type in argument 1 (different address spaces)
drivers/irqchip/irq-gic.c:1167:43:    expected void [noderef] <asn:3>*__pdata
drivers/irqchip/irq-gic.c:1167:43:    got void [noderef] <asn:3>*[noderef] <asn:2>*percpu_base
drivers/irqchip/irq-gic.c:1168:42: warning: incorrect type in argument 1 (different address spaces)
drivers/irqchip/irq-gic.c:1168:42:    expected void [noderef] <asn:3>*__pdata
drivers/irqchip/irq-gic.c:1168:42:    got void [noderef] <asn:3>*[noderef] <asn:2>*percpu_base
---
 drivers/irqchip/irq-gic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1b1df4f770bd..ae414f5223b6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -42,6 +42,8 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include <asm/cputype.h>
 #include <asm/irq.h>
 #include <asm/exception.h>
@@ -990,7 +992,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		 * For SPIs, we need to add 16 more to get the GIC irq
 		 * ID number
 		 */
-		if (!fwspec->param[0])
+		if (fwspec->param[0] == GIC_SPI)
 			*hwirq += 16;
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-- 
2.8.2
