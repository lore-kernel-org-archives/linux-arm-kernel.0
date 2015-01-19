From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 14:01:12 +0100
Subject: [PATCH v2 1/3] usb: XHCI: platform: Move the Marvell quirks after the
 enabling the clocks
In-Reply-To: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1421672474-2945-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 973747928514 ("usb: host: xhci-plat: add support for the Armada
375/38x XHCI controllers") extended the xhci-plat driver to support the Armada
375/38x SoCs, mostly by adding a quirk configuring the MBUS window.

However, that quirk was run before the clock the controllers needs has been
enabled. This usually worked because the clock was first enabled by the
bootloader, and left as such until the driver is probe, where it tries to
access the MBUS configuration registers before enabling the clock.

Things get messy when EPROBE_DEFER is involved during the probe, since as part
of its error path, the driver will rightfully disable the clock. When the
driver will be reprobed, it will retry to access the MBUS registers, but this
time with the clock disabled, which hangs forever.

Fix this by running the quirks after the clock has been enabled by the driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.16+
---
 drivers/usb/host/xhci-plat.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 08d402b15482..0e11d61408ff 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -83,16 +83,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
-
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "marvell,armada-375-xhci") ||
-	    of_device_is_compatible(pdev->dev.of_node,
-				    "marvell,armada-380-xhci")) {
-		ret = xhci_mvebu_mbus_init_quirk(pdev);
-		if (ret)
-			return ret;
-	}
-
 	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
 	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
@@ -127,6 +117,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_hcd;
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "marvell,armada-375-xhci") ||
+	    of_device_is_compatible(pdev->dev.of_node,
+				    "marvell,armada-380-xhci")) {
+		ret = xhci_mvebu_mbus_init_quirk(pdev);
+		if (ret)
+			goto disable_clk;
+	}
+
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto disable_clk;
-- 
2.2.2
