From: rogerq@ti.com (Roger Quadros)
Date: Fri, 18 Jan 2013 14:17:24 +0200
Subject: [PATCH v8 21/22] mfd: omap-usb-host: Don't spam console on
 clk_set_parent failure
In-Reply-To: <1358511445-26656-1-git-send-email-rogerq@ti.com>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
Message-ID: <1358511445-26656-22-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_set_parent is expected to fail on OMAP3 platforms. We don't
consider that as fatal so don't spam console.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/omap-usb-host.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 9dea92c..f87cac9 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -677,32 +677,32 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
-		/* for OMAP3 , the clk set paretn fails */
+		/* for OMAP3, clk_set_parent fails */
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->xclk60mhsp1_ck);
 		if (ret != 0)
-			dev_err(dev, "xclk60mhsp1_ck set parent"
-				"failed error:%d\n", ret);
+			dev_dbg(dev, "xclk60mhsp1_ck set parent failed: %d\n",
+					ret);
 	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->init_60m_fclk);
 		if (ret != 0)
-			dev_err(dev, "init_60m_fclk set parent"
-				"failed error:%d\n", ret);
+			dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
+					ret);
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 					omap->xclk60mhsp2_ck);
 		if (ret != 0)
-			dev_err(dev, "xclk60mhsp2_ck set parent"
-					"failed error:%d\n", ret);
+			dev_dbg(dev, "xclk60mhsp2_ck set parent failed: %d\n",
+					ret);
 	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 						omap->init_60m_fclk);
 		if (ret != 0)
-			dev_err(dev, "init_60m_fclk set parent"
-				"failed error:%d\n", ret);
+			dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
+					ret);
 	}
 
 	omap_usbhs_init(dev);
-- 
1.7.4.1
