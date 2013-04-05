From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 5 Apr 2013 11:33:42 +0200 (CEST)
Subject: [PATCH v2] irqchip: renesas-intc-irqpin: DT binding for sense bitfield
 width
Message-ID: <Pine.LNX.4.64.1304051128090.997@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most Renesas irqpin controllers have 4-bit sense fields, however, some
have different widths. This patch adds a DT binding to optionally
specify such non-standard values.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: is no longer based on an earlier "ARM: shmobile: irqpin: fix handling 
of spurious interrupts in DT case" patch, which needs more work.

 .../interrupt-controller/renesas,intc-irqpin.txt   |   13 +++++++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |    5 +++++
 2 files changed, 18 insertions(+), 0 deletions(-)
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
index 5a68e5a..7a02dfe 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -429,6 +430,10 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (!pdata)
+		of_property_read_u32(pdev->dev.of_node, "sense-bitfield-width",
+				     &p->config.sense_bitfield_width);
+
 	/* use more severe masking method if requested */
 	if (p->config.control_parent) {
 		enable_fn = intc_irqpin_irq_enable_force;
-- 
1.7.2.5
