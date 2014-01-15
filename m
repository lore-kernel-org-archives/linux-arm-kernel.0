From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jan 2014 12:47:25 +0100
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
Message-ID: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new interrupts-extended property, which reuses the phandle+arguments
pattern used by GPIOs and other core bindings, still have some issue.

If an SoC have already specifiy interrupt and a board want to add specific
interrupt such as GPIO (which can be optionnal) be need to re-define
interrupts-extended. So allow to have an optionnale interrupts-extended-2
property.

Today the problem is ofen solve by defining a gpio-xxx property and then do a gpio_to_irq
in the C code. *Which is wrong!!*. We need to describe the IRQ.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
---

We have the same issue on pinctrl
 .../devicetree/bindings/interrupt-controller/interrupts.txt    |  4 ++++
 drivers/of/irq.c                                               | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
index 1486497..5d559fd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
@@ -25,8 +25,12 @@ to reference multiple interrupt parents. Each entry in this property contains
 both the parent phandle and the interrupt specifier. "interrupts-extended"
 should only be used when a device has multiple interrupt parents.
 
+The "interrupts-extended-2" allow to extend at board level node interrupt without
+having to re-define the SoC interrupts.
+
   Example:
 	interrupts-extended = <&intc1 5 1>, <&intc2 1 0>;
+	interrupts-extended-2 = <&intc1 6 1>
 
 A device node may contain either "interrupts" or "interrupts-extended", but not
 both. If both properties are present, then the operating system should log an
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 786b0b4..bc36710 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -307,8 +307,14 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		/* Try the new-style interrupts-extended */
 		res = of_parse_phandle_with_args(device, "interrupts-extended",
 						"#interrupt-cells", index, out_irq);
-		if (res)
-			return -EINVAL;
+		if (res) {
+			/* Try the new-style interrupts-extended-2 */
+			res = of_parse_phandle_with_args(device, "interrupts-extended-2",
+							"#interrupt-cells", index, out_irq);
+			if (res)
+				return -EINVAL;
+		}
+
 		return of_irq_parse_raw(addr, out_irq);
 	}
 	intlen /= sizeof(*intspec);
-- 
1.8.4.3
