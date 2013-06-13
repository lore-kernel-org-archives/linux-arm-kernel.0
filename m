From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:30 +0900
Subject: [PATCH 06/12] phy-rcar-usb: correct base address
In-Reply-To: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106836-25388-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The memory region that is used by the driver overlaps EHCI and OHCI  register
regions for absolutely no reason now  -- fix it  by adding offset of 0x800 to
the base address, changing the register #define's accordingly. This has extra
positive effect that we now can use devm_ioremap_resource()...

Note that the driver and the SoC code have to be in one patch to keep the code
bisectable...

The patch has been tested on the Marzen board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |  2 +-
 drivers/usb/phy/phy-rcar-usb.c         | 28 ++++++++++------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index a6406cd..a00283f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -391,7 +391,7 @@ static struct platform_device sata_device = {
 /* USB PHY */
 static struct resource usb_phy_resources[] = {
 	[0] = {
-		.start		= 0xffe70000,
+		.start		= 0xffe70800,
 		.end		= 0xffe70900 - 1,
 		.flags		= IORESOURCE_MEM,
 	},
diff --git a/drivers/usb/phy/phy-rcar-usb.c b/drivers/usb/phy/phy-rcar-usb.c
index 4893dbd..d636cc7 100644
--- a/drivers/usb/phy/phy-rcar-usb.c
+++ b/drivers/usb/phy/phy-rcar-usb.c
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
@@ -139,17 +139,9 @@ static int rcar_usb_phy_probe(struct platform_device *pdev)
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
-- 
1.8.2.1
