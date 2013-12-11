From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:26 +0100
Subject: [PATCH 06/10] sh-pfc: Support GPIO to IRQ mapping specified IRQ
 resources
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On non-DT platforms IRQ controllers associated with the GPIOs have a
fixed IRQ base value known at compile time. The sh-pfc driver translates
GPIO number to IRQ numbers using a hardcoded table. This mechanism
breaks on DT platforms, as the IRQ base values are dynamic in that case.

Fix this by specifying IRQs associated with GPIOs in IRQ resources,
populated automatically from the device tree. When IRQ resources are
specified the driver requires one IRQ resource per GPIO able to generate
an interrupt, and uses the translation table to compute the IRQ resource
offset instead of the IRQ number.

Cc: devicetree at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 14 +++++
 drivers/pinctrl/sh-pfc/core.c                      | 69 +++++++++++++++++-----
 drivers/pinctrl/sh-pfc/core.h                      |  2 +
 drivers/pinctrl/sh-pfc/gpio.c                      | 14 ++++-
 4 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index d5dac7b..35d2e1f 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -26,6 +26,11 @@ Optional properties:
   - #gpio-range-cells: Mandatory when the PFC doesn't handle GPIO, forbidden
     otherwise. Should be 3.
 
+  - interrupts-extended: Specify the interrupts associated with external
+    IRQ pins. This property is mandatory when the PFC handles GPIOs and
+    forbidden otherwise. When specified, it must contain one interrupt per
+    external IRQ, sorted by external IRQ number.
+
 The PFC node also acts as a container for pin configuration nodes. Please refer
 to pinctrl-bindings.txt in this directory for the definition of the term "pin
 configuration node" and for the common pinctrl bindings used by client devices.
@@ -103,6 +108,15 @@ Example 1: SH73A0 (SH-Mobile AG5) pin controller node
 		      <0xe605801c 0x1c>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupts-extended =
+			<&irqpin0 0 0>, <&irqpin0 1 0>, <&irqpin0 2 0>, <&irqpin0 3 0>,
+			<&irqpin0 4 0>, <&irqpin0 5 0>, <&irqpin0 6 0>, <&irqpin0 7 0>,
+			<&irqpin1 0 0>, <&irqpin1 1 0>, <&irqpin1 2 0>, <&irqpin1 3 0>,
+			<&irqpin1 4 0>, <&irqpin1 5 0>, <&irqpin1 6 0>, <&irqpin1 7 0>,
+			<&irqpin2 0 0>, <&irqpin2 1 0>, <&irqpin2 2 0>, <&irqpin2 3 0>,
+			<&irqpin2 4 0>, <&irqpin2 5 0>, <&irqpin2 6 0>, <&irqpin2 7 0>,
+			<&irqpin3 0 0>, <&irqpin3 1 0>, <&irqpin3 2 0>, <&irqpin3 3 0>,
+			<&irqpin3 4 0>, <&irqpin3 5 0>, <&irqpin3 6 0>, <&irqpin3 7 0>;
 	};
 
 Example 2: A GPIO LED node that references a GPIO
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 7831f07..b9b464d 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -26,30 +26,67 @@
 
 #include "core.h"
 
-static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
+static int sh_pfc_map_resources(struct sh_pfc *pfc,
+				struct platform_device *pdev)
 {
+	unsigned int num_windows = 0;
+	unsigned int num_irqs = 0;
+	struct sh_pfc_window *windows;
+	unsigned int *irqs = NULL;
 	struct resource *res;
-	unsigned int k;
+	unsigned int i;
+
+	/* Count the MEM and IRQ resources. */
+	for (i = 0; i < pdev->num_resources; ++i) {
+		switch (resource_type(&pdev->resource[i])) {
+		case IORESOURCE_MEM:
+			num_windows++;
+			break;
+
+		case IORESOURCE_IRQ:
+			num_irqs++;
+			break;
+		}
+	}
 
-	if (pdev->num_resources == 0)
+	if (num_windows == 0)
 		return -EINVAL;
 
-	pfc->windows = devm_kzalloc(pfc->dev, pdev->num_resources *
-				    sizeof(*pfc->windows), GFP_NOWAIT);
-	if (!pfc->windows)
+	/* Allocate memory windows and IRQs arrays. */
+	windows = devm_kzalloc(pfc->dev, num_windows * sizeof(*windows),
+			       GFP_KERNEL);
+	if (windows == NULL)
 		return -ENOMEM;
 
-	pfc->num_windows = pdev->num_resources;
+	pfc->num_windows = num_windows;
+	pfc->windows = windows;
 
-	for (k = 0, res = pdev->resource; k < pdev->num_resources; k++, res++) {
-		WARN_ON(resource_type(res) != IORESOURCE_MEM);
-		pfc->windows[k].phys = res->start;
-		pfc->windows[k].size = resource_size(res);
-		pfc->windows[k].virt =
-			devm_ioremap_nocache(pfc->dev, res->start,
-					     resource_size(res));
-		if (!pfc->windows[k].virt)
+	if (num_irqs) {
+		irqs = devm_kzalloc(pfc->dev, num_irqs * sizeof(*irqs),
+				    GFP_KERNEL);
+		if (irqs == NULL)
 			return -ENOMEM;
+
+		pfc->num_irqs = num_irqs;
+		pfc->irqs = irqs;
+	}
+
+	/* Fill them. */
+	for (i = 0, res = pdev->resource; i < pdev->num_resources; i++, res++) {
+		switch (resource_type(res)) {
+		case IORESOURCE_MEM:
+			windows->phys = res->start;
+			windows->size = resource_size(res);
+			windows->virt = devm_ioremap_resource(pfc->dev, res);
+			if (IS_ERR(windows->virt))
+				return -ENOMEM;
+			windows++;
+			break;
+
+		case IORESOURCE_IRQ:
+			*irqs++ = res->start;
+			break;
+		}
 	}
 
 	return 0;
@@ -482,7 +519,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	pfc->info = info;
 	pfc->dev = &pdev->dev;
 
-	ret = sh_pfc_ioremap(pfc, pdev);
+	ret = sh_pfc_map_resources(pfc, pdev);
 	if (unlikely(ret < 0))
 		return ret;
 
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index a83b747..b7b0e6c 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -38,6 +38,8 @@ struct sh_pfc {
 
 	unsigned int num_windows;
 	struct sh_pfc_window *windows;
+	unsigned int num_irqs;
+	unsigned int *irqs;
 
 	struct sh_pfc_pin_range *ranges;
 	unsigned int nr_ranges;
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 6a21349..6348081 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -211,11 +211,17 @@ static int gpio_pin_to_irq(struct gpio_chip *gc, unsigned offset)
 
 		for (k = 0; gpios[k] >= 0; k++) {
 			if (gpios[k] == offset)
-				return pfc->info->gpio_irq[i].irq;
+				goto found;
 		}
 	}
 
 	return -ENOSYS;
+
+found:
+	if (pfc->num_irqs)
+		return pfc->irqs[i];
+	else
+		return pfc->info->gpio_irq[i].irq;
 }
 
 static int gpio_pin_setup(struct sh_pfc_chip *chip)
@@ -357,6 +363,12 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	if (i == pfc->num_windows)
 		return 0;
 
+	/* If we have IRQ resources make sure their number is correct. */
+	if (pfc->num_irqs && pfc->num_irqs != pfc->info->gpio_irq_size) {
+		dev_err(pfc->dev, "invalid number of IRQ resources\n");
+		return -EINVAL;
+	}
+
 	/* Register the real GPIOs chip. */
 	chip = sh_pfc_add_gpiochip(pfc, gpio_pin_setup, &pfc->windows[i]);
 	if (IS_ERR(chip))
-- 
1.8.3.2
