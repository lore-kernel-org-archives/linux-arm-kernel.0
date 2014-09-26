From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri, 26 Sep 2014 16:28:53 +0200
Subject: [PATCH] bcma: use device from DT (brcm,bus-gpio) for SoC GPIO chip
Message-ID: <1411741733-13888-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow us to define GPIO-attached devices (LEDs, buttons) in
the the device tree.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
This is based on top of
[PATCH v6] bcma: register bcma as device tree driver
that I hope will reach wireless-next git tree.
---
 Documentation/devicetree/bindings/bus/bcma.txt | 15 +++++++++++++++
 drivers/bcma/driver_gpio.c                     |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/bcma.txt b/Documentation/devicetree/bindings/bus/bcma.txt
index e9070c1..f1b381e 100644
--- a/Documentation/devicetree/bindings/bus/bcma.txt
+++ b/Documentation/devicetree/bindings/bus/bcma.txt
@@ -6,6 +6,15 @@ Required properties:
 
 - reg : iomem address range of chipcommon core
 
+The top-level axi bus may contain following children:
+
+- gpio: GPIO chip on the SoC
+
+  Required properties:
+  - compatible: "brcm,bus-gpio"
+  - gpio-controller : makes the node a GPIO controller
+  - #gpio-cells : size of the GPIO specifier, must be 2
+
 The cores on the AXI bus are automatically detected by bcma with the
 memory ranges they are using and they get registered afterwards.
 
@@ -17,4 +26,10 @@ Example:
 		ranges = <0x00000000 0x18000000 0x00100000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+
+		gpio at 0 {
+			compatible = "brcm,bus-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
 	};
diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 8ea497c..7ae39a8 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -218,6 +218,11 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 #if IS_BUILTIN(CONFIG_BCM47XX)
 	chip->to_irq		= bcma_gpio_to_irq;
 #endif
+#if IS_BUILTIN(CONFIG_OF)
+	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
+		chip->of_node	= of_find_compatible_node(NULL, NULL,
+							  "brcm,bus-gpio");
+#endif
 	switch (cc->core->bus->chipinfo.id) {
 	case BCMA_CHIP_ID_BCM5357:
 	case BCMA_CHIP_ID_BCM53572:
-- 
1.8.4.5
