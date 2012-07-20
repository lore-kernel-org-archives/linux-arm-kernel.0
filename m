From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 21 Jul 2012 00:29:32 +1200
Subject: [PATCHv2 1/2] ARM: vt8500: Update vt8500-ehci driver to support
 device tree.
Message-ID: <1342787373-2230-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/usb/vt8500-ehci.txt        |   10 ++++++++++
 drivers/usb/host/ehci-vt8500.c                     |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt

diff --git a/Documentation/devicetree/bindings/usb/vt8500-ehci.txt b/Documentation/devicetree/bindings/usb/vt8500-ehci.txt
new file mode 100644
index 0000000..74f75c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/vt8500-ehci.txt
@@ -0,0 +1,10 @@
+VIA VT8500 and Wondermedia WM8xxx SoC USB controllers.
+
+Required properties:
+ - compatible: Should be "via,vt8500-ehci" or "wm,prizm-ehci".
+
+usb: ehci at D8007100 {
+	compatible = "wm,prizm-ehci", "usb-ehci";
+	reg = <0xD8007100 0x200>;
+	interrupts = <1>;
+};
diff --git a/drivers/usb/host/ehci-vt8500.c b/drivers/usb/host/ehci-vt8500.c
index c1eda73..4ba8f0c 100644
--- a/drivers/usb/host/ehci-vt8500.c
+++ b/drivers/usb/host/ehci-vt8500.c
@@ -16,6 +16,7 @@
  *
  */
 
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 static int ehci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
@@ -162,6 +163,12 @@ static int vt8500_ehci_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id vt8500_ehci_ids[] = {
+	{ .compatible = "via,vt8500-ehci", },
+	{ .compatible = "wm,prizm-ehci", },
+	{}
+};
+
 static struct platform_driver vt8500_ehci_driver = {
 	.probe		= vt8500_ehci_drv_probe,
 	.remove		= vt8500_ehci_drv_remove,
@@ -169,7 +176,9 @@ static struct platform_driver vt8500_ehci_driver = {
 	.driver = {
 		.name	= "vt8500-ehci",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(vt8500_ehci_ids),
 	}
 };
 
 MODULE_ALIAS("platform:vt8500-ehci");
+MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
1.7.2.5
