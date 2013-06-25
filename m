From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 17:38:23 +0200
Subject: [PATCH 1/4] usb: gadget: s3c-hsotg: Allow driver instantiation using
 device tree
In-Reply-To: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
Message-ID: <1372174706-5459-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds OF match table to the driver to allow instantiating it
using device tree.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/usb/samsung-hsotg.txt      | 40 ++++++++++++++++++++++
 drivers/usb/gadget/s3c-hsotg.c                     | 10 ++++++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-hsotg.txt

diff --git a/Documentation/devicetree/bindings/usb/samsung-hsotg.txt b/Documentation/devicetree/bindings/usb/samsung-hsotg.txt
new file mode 100644
index 0000000..b83d428
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/samsung-hsotg.txt
@@ -0,0 +1,40 @@
+Samsung High Speed USB OTG controller
+-----------------------------
+
+The Samsung HSOTG IP can be found on Samsung SoCs, from S3C6400 onwards.
+It gives functionality of OTG-compliant USB 2.0 host and device with
+support for USB 2.0 high-speed (480Mbps) and full-speed (12 Mbps)
+operation.
+
+Currently only device mode is supported.
+
+Binding details
+-----
+
+Required properties:
+- compatible: "samsung,s3c6400-hsotg" should be used for all currently
+    supported SoC,
+- interrupt-parent: phandle for the interrupt controller to which the
+    interrupt signal of the HSOTG block is routed,
+- interrupts: specifier of interrupt signal of interrupt controller,
+    according to bindings of interrupt controller,
+- clocks: contains an array of clock specifiers:
+    - first entry: OTG clock
+- clock-names: contains array of clock names:
+    - first entry: must be "otg"
+- vusb_d-supply: phandle to voltage regulator of digital section,
+- vusb_a-supply: phandle to voltage regulator of analog section.
+
+Example
+-----
+
+	hsotg at 12480000 {
+		compatible = "samsung,s3c6400-hsotg";
+		reg = <0x12480000 0x20000>;
+		interrupts = <0 71 0>;
+		clocks = <&clock 305>;
+		clock-names = "otg";
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+	};
+
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index af22f24..616ed51 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_platform.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -3648,10 +3649,19 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
 #define s3c_hsotg_resume NULL
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c_hsotg_of_ids[] = {
+	{ .compatible = "samsung,s3c6400-hsotg", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s3c_hsotg_of_ids);
+#endif
+
 static struct platform_driver s3c_hsotg_driver = {
 	.driver		= {
 		.name	= "s3c-hsotg",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(s3c_hsotg_of_ids),
 	},
 	.probe		= s3c_hsotg_probe,
 	.remove		= s3c_hsotg_remove,
-- 
1.8.2.1
