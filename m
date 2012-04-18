From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Apr 2012 15:36:07 +0200
Subject: [PATCH v3 2/10] ohci-nxp: Device tree support
In-Reply-To: <1334756176-25144-1-git-send-email-stigge@antcom.de>
References: <1334756176-25144-1-git-send-email-stigge@antcom.de>
Message-ID: <1334756176-25144-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support to ohci-nxp.c

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Applies to v3.4-rc3

 Documentation/devicetree/bindings/usb/ohci-nxp.txt |   16 ++++++++++++++++
 drivers/usb/host/ohci-nxp.c                        |   10 ++++++++++
 2 files changed, 26 insertions(+)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/usb/ohci-nxp.txt
@@ -0,0 +1,16 @@
+* OHCI controller, NXP ohci-nxp variant
+
+Required properties:
+- compatible: must be "nxp,ohci-nxp"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: The OHCI interrupt
+
+Example (LPC32xx):
+
+	ohci at 31020000 {
+		compatible = "nxp,ohci-nxp";
+		reg = <0x31020000 0x300>;
+		interrupt-parent = <&mic>;
+		interrupts = <0x3b 0>;
+	};
--- linux-2.6.orig/drivers/usb/host/ohci-nxp.c
+++ linux-2.6/drivers/usb/host/ohci-nxp.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/of.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -525,10 +526,19 @@ static int usb_hcd_nxp_remove(struct pla
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:usb-ohci");
 
+#ifdef CONFIG_OF
+static const struct of_device_id usb_hcd_nxp_match[] = {
+	{ .compatible = "nxp,ohci-nxp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, usb_hcd_nxp_match);
+#endif
+
 static struct platform_driver usb_hcd_nxp_driver = {
 	.driver = {
 		.name = "usb-ohci",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(usb_hcd_nxp_match),
 	},
 	.probe = usb_hcd_nxp_probe,
 	.remove = usb_hcd_nxp_remove,
