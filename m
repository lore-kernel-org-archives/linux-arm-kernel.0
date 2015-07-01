From: richardcochran@gmail.com (Richard Cochran)
Date: Wed,  1 Jul 2015 21:34:02 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <cover.1435777856.git.rcochran@linutronix.de>
References: <cover.1435777856.git.rcochran@linutronix.de>
Message-ID: <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system-on-chips using this IP core have well defined gpio numbers.
Instead of using random numbers, this patch lets the device tree specify
the correct gpio numbering.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt | 2 ++
 drivers/gpio/gpio-dwapb.c                                  | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
index dd5d2c0..5c9effd 100644
--- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
@@ -28,6 +28,7 @@ controller.
 - interrupt-parent : The parent interrupt controller.
 - interrupts : The interrupt to the parent controller raised when GPIOs
   generate the interrupts.
+- snps,base : The base gpio number.
 - snps,nr-gpios : The number of pins in the port, a single cell.
 
 Example:
@@ -42,6 +43,7 @@ gpio: gpio at 20000 {
 		compatible = "snps,dw-apb-gpio-port";
 		gpio-controller;
 		#gpio-cells = <2>;
+		snps,base = <8>;
 		snps,nr-gpios = <8>;
 		reg = <0>;
 		interrupt-controller;
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 58faf04..b7e7977 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -491,6 +491,13 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 			return ERR_PTR(-EINVAL);
 		}
 
+		if (of_property_read_u32(port_np, "snps,base",
+					 &pp->gpio_base)) {
+			dev_info(dev, "no base gpio specified for %s\n",
+				 port_np->full_name);
+			pp->gpio_base = -1;
+		}
+
 		if (of_property_read_u32(port_np, "snps,nr-gpios",
 					 &pp->ngpio)) {
 			dev_info(dev, "failed to get number of gpios for %s\n",
@@ -512,7 +519,6 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		}
 
 		pp->irq_shared	= false;
-		pp->gpio_base	= -1;
 		pp->name	= port_np->full_name;
 	}
 
-- 
2.1.4
