From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Feb 2012 16:58:28 +0100
Subject: [PATCH 3/4] ARM: at91: usb ehci add dt support
In-Reply-To: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
References: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1329235109-6688-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-usb at vger.kernel.org
---
Hi Greg,

	I you don't mind I'll apply this via at91 tree as it's part a DT USB
	patch series

Best Regards,
J.
 .../devicetree/bindings/usb/atmel-usb.txt          |   12 ++++++++++
 drivers/usb/host/ehci-atmel.c                      |   24 +++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 6c7f728..0143d7c 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -17,3 +17,15 @@ usb0: ohci at 00500000 {
 	interrupts = <20 4>;
 	num-ports = <2>;
 };
+
+EHCI
+
+Required properties:
+ - compatible: Should be "atmel,at91sam9g45-ehci" for USB controllers
+   used in host mode.
+
+usb1: ehci at 00800000 {
+	compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
+	reg = <0x00800000 0x100000>;
+	interrupts = <22 4>;
+};
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index a5a3ef1..55e0044 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 /* interface and function clocks */
 static struct clk *iclk, *fclk;
@@ -115,6 +116,8 @@ static const struct hc_driver ehci_atmel_hc_driver = {
 	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
 };
 
+static u64 at91_ehci_dma_mask = DMA_BIT_MASK(32);
+
 static int __devinit ehci_atmel_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
@@ -137,6 +140,13 @@ static int __devinit ehci_atmel_drv_probe(struct platform_device *pdev)
 		goto fail_create_hcd;
 	}
 
+	/* Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &at91_ehci_dma_mask;
+
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		retval = -ENOMEM;
@@ -225,9 +235,21 @@ static int __devexit ehci_atmel_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_ehci_dt_ids[] = {
+	{ .compatible = "atmel,at91samg945-ehci" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, atmel_ehci_dt_ids);
+#endif
+
 static struct platform_driver ehci_atmel_driver = {
 	.probe		= ehci_atmel_drv_probe,
 	.remove		= __devexit_p(ehci_atmel_drv_remove),
 	.shutdown	= usb_hcd_platform_shutdown,
-	.driver.name	= "atmel-ehci",
+	.driver		= {
+		.name	= "atmel-ehci",
+		.of_match_table	= of_match_ptr(atmel_ehci_dt_ids),
+	},
 };
-- 
1.7.7
