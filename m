From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 20 Apr 2013 02:01:03 +0400
Subject: [PATCH v5 6/9] rcar-phy: correct base address
Message-ID: <201304200201.04320.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory region that is used by the driver overlaps EHCI and OHCI  register
regions for absolutely no reason now  -- fix it  by adding offset of 0x800 to
the base address, changing the register #define's accordingly. This has extra
positive effect that we now can use devm_ioremap_resource()...

Note that the driver and the SoC code have to be in one patch to keep the code
bisectable...

The patch has been tested on the Marzen board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 4:
- refreshed the patch.

Changes since version 2:
- refreshed atop of the prior patches;
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- added a note about bisectability to the changelog.

 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 drivers/usb/phy/rcar-phy.c             |   28 ++++++++++------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -391,7 +391,7 @@ static struct platform_device sata_devic
 /* USB PHY */
 static struct resource usb_phy_resources[] = {
 	[0] = {
-		.start		= 0xffe70000,
+		.start		= 0xffe70800,
 		.end		= 0xffe70900 - 1,
 		.flags		= IORESOURCE_MEM,
 	},
Index: renesas/drivers/usb/phy/rcar-phy.c
===================================================================
--- renesas.orig/drivers/usb/phy/rcar-phy.c
+++ renesas/drivers/usb/phy/rcar-phy.c
@@ -16,13 +16,13 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 
-/* USBH common register */
-#define USBPCTRL0	0x0800
-#define USBPCTRL1	0x0804
-#define USBST		0x0808
-#define USBEH0		0x080C
-#define USBOH0		0x081C
-#define USBCTL0		0x0858
+/* REGS block */
+#define USBPCTRL0	0x00
+#define USBPCTRL1	0x04
+#define USBST		0x08
+#define USBEH0		0x0C
+#define USBOH0		0x1C
+#define USBCTL0		0x58
 
 /* USBPCTRL1 */
 #define PHY_RST		(1 << 2)
@@ -139,17 +139,9 @@ static int rcar_usb_phy_probe(struct pla
 		return -EINVAL;
 	}
 
-	/*
-	 * CAUTION
-	 *
-	 * Because this phy address is also mapped under OHCI/EHCI address area,
-	 * this driver can't use devm_request_and_ioremap(dev, res) here
-	 */
-	reg0 = devm_ioremap_nocache(dev, res0->start, resource_size(res0));
-	if (!reg0) {
-		dev_err(dev, "ioremap error\n");
-		return -ENOMEM;
-	}
+	reg0 = devm_ioremap_resource(dev, res0);
+	if (IS_ERR(reg0))
+		return PTR_ERR(reg0);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
