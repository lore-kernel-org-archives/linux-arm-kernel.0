From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Jan 2015 16:45:09 +0100
Subject: [PATCH 3/4] usb: xhci: plat: Add USB phy support
In-Reply-To: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1420559110-8043-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 385 AP needs a dumb phy in order to enable the USB3 VBUS.

Add a call to retrieve a USB PHY to XHCI plat in order to support this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/usb/host/xhci-plat.c | 13 +++++++++++++
 drivers/usb/host/xhci.h      |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 34c2f6d3e5d0..284ab70f13a3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/usb/phy.h>
 #include <linux/slab.h>
 #include <linux/usb/xhci_pdriver.h>
 
@@ -155,6 +156,18 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
+	xhci->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
+	if (IS_ERR(xhci->phy)) {
+		ret = PTR_ERR(xhci->phy);
+		if (ret == -EPROBE_DEFER)
+			goto put_usb3_hcd;
+		xhci->phy = NULL;
+	} else {
+		ret = usb_phy_init(xhci->phy);
+		if (ret)
+			goto put_usb3_hcd;
+	}
+
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto put_usb3_hcd;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index cc7c5bb7cbcf..d9468af2a8e4 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1474,6 +1474,8 @@ struct xhci_hcd {
 	struct msix_entry	*msix_entries;
 	/* optional clock */
 	struct clk		*clk;
+	/* optional phy */
+	struct usb_phy		*phy;
 	/* data structures */
 	struct xhci_device_context_array *dcbaa;
 	struct xhci_ring	*cmd_ring;
-- 
2.2.1
