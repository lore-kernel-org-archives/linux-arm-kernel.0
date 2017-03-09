From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Mar 2017 12:04:22 +0100
Subject: [PATCH v2 1/3] usb: orion-echi: Add support for the Armada 3700
In-Reply-To: <20170309110424.2187-1-gregory.clement@free-electrons.com>
References: <20170309110424.2187-1-gregory.clement@free-electrons.com>
Message-ID: <20170309110424.2187-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hua Jing <jinghua@marvell.com>

- Add a new compatible string for the Armada 3700 SoCs

- add sbuscfg support for orion usb controller driver. For the SoCs
  without hlock, need to program BAWR/BARD/AHBBRST fields in the sbuscfg
  register to guarantee the AHB master's burst would not overrun or
  underrun the FIFO.

- the sbuscfg register has to be set after the usb controller reset,
  otherwise the value would be overridden to 0. In order to do this, the
  reset callback is registered.

[gregory.clement at free-electrons.com: - reword commit and comments
				     - fix checkpatch warning]
Signed-off-by: Hua Jing <jinghua@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/usb/ehci-orion.txt         |  4 ++-
 drivers/usb/host/ehci-orion.c                      | 39 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
index 17c3bc858b86..2855bae79fda 100644
--- a/Documentation/devicetree/bindings/usb/ehci-orion.txt
+++ b/Documentation/devicetree/bindings/usb/ehci-orion.txt
@@ -1,7 +1,9 @@
 * EHCI controller, Orion Marvell variants
 
 Required properties:
-- compatible: must be "marvell,orion-ehci"
+- compatible: must be one of the following
+	"marvell,orion-ehci"
+	"marvell,armada-3700-ehci"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: The EHCI interrupt
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index ee8d5faa0194..762bba41e06d 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -47,6 +47,21 @@
 #define USB_PHY_IVREF_CTRL	0x440
 #define USB_PHY_TST_GRP_CTRL	0x450
 
+#define USB_SBUSCFG		0x90
+#define	    USB_SBUSCFG_BAWR_SHIFT	    0x6
+#define	    USB_SBUSCFG_BARD_SHIFT	    0x3
+#define	    USB_SBUSCFG_AHBBRST_SHIFT	    0x0
+
+/* BAWR = BARD = 3 : Align read/write bursts packets larger than 128 bytes */
+#define USB_SBUSCFG_BAWR_ALIGN_128B	(0x3 << USB_SBUSCFG_BAWR_SHIFT)
+#define USB_SBUSCFG_BARD_ALIGN_128B	(0x3 << USB_SBUSCFG_BARD_SHIFT)
+/* AHBBRST = 3	   : Align AHB Burst to INCR16 (64 bytes) */
+#define USB_SBUSCFG_AHBBRST_INCR16	(0x3 << USB_SBUSCFG_AHBBRST_SHIFT)
+
+#define USB_SBUSCFG_DEF_VAL (USB_SBUSCFG_BAWR_ALIGN_128B	\
+			     | USB_SBUSCFG_BARD_ALIGN_128B	\
+			     | USB_SBUSCFG_AHBBRST_INCR16)
+
 #define DRIVER_DESC "EHCI orion driver"
 
 #define hcd_to_orion_priv(h) ((struct orion_ehci_hcd *)hcd_to_ehci(h)->priv)
@@ -151,8 +166,31 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
+static int ehci_orion_drv_reset(struct usb_hcd *hcd)
+{
+	struct device *dev = hcd->self.controller;
+	int retval;
+
+	retval = ehci_setup(hcd);
+	if (retval)
+		dev_err(dev, "ehci_setup failed %d\n", retval);
+
+	/*
+	 * For SoC without hlock, need to program sbuscfg value to guarantee
+	 * AHB master's burst would not overrun or underrun FIFO.
+	 *
+	 * sbuscfg reg has to be set after usb controller reset, otherwise
+	 * the value would be override to 0.
+	 */
+	if (of_device_is_compatible(dev->of_node, "marvell,armada-3700-ehci"))
+		wrl(USB_SBUSCFG, USB_SBUSCFG_DEF_VAL);
+
+	return retval;
+}
+
 static const struct ehci_driver_overrides orion_overrides __initconst = {
 	.extra_priv_size =	sizeof(struct orion_ehci_hcd),
+	.reset = ehci_orion_drv_reset,
 };
 
 static int ehci_orion_drv_probe(struct platform_device *pdev)
@@ -310,6 +348,7 @@ static int ehci_orion_drv_remove(struct platform_device *pdev)
 
 static const struct of_device_id ehci_orion_dt_ids[] = {
 	{ .compatible = "marvell,orion-ehci", },
+	{ .compatible = "marvell,armada-3700-ehci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ehci_orion_dt_ids);
-- 
2.11.0
