From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 8 Apr 2013 10:08:40 +0200 (CEST)
Subject: [PATCH v3] irqchip: renesas-intc-irqpin: DT binding for sense bitfield
 width
Message-ID: <Pine.LNX.4.64.1304081002190.29945@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most Renesas irqpin controllers have 4-bit sense fields, however, some
have different widths. This patch adds a DT binding to optionally
specify such non-standard values.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: move the code to a common location, where device configuration 
parameters are retrieved

 .../interrupt-controller/renesas,intc-irqpin.txt   |   13 +++++++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
new file mode 100644
index 0000000..c6f09b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -0,0 +1,13 @@
+DT bindings for the R-/SH-Mobile irqpin controller
+
+Required properties:
+
+- compatible: has to be "renesas,intc-irqpin"
+- #interrupt-cells: has to be <2>
+
+Optional properties:
+
+- any properties, listed in interrupts.txt in this directory, and any standard
+  resource allocation properties
+- sense-bitfield-width: width of a single sense bitfield in the SENSE register,
+  if different from the default 4 bits
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 5a68e5a..4aca1b2 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -349,6 +350,9 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	/* deal with driver instance configuration */
 	if (pdata)
 		memcpy(&p->config, pdata, sizeof(*pdata));
+	else
+		of_property_read_u32(pdev->dev.of_node, "sense-bitfield-width",
+				     &p->config.sense_bitfield_width);
 	if (!p->config.sense_bitfield_width)
 		p->config.sense_bitfield_width = 4; /* default to 4 bits */
 
-- 
1.7.2.5
