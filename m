From: rogerq@ti.com (Roger Quadros)
Date: Thu, 27 Feb 2014 16:18:24 +0200
Subject: [PATCH v9 2/9] mfd: omap-usb-host: Always fail on clk_get() error
In-Reply-To: <1393510711-4697-1-git-send-email-rogerq@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
Message-ID: <1393510711-4697-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Be more strict and always fail on clk_get() error.

CC: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c | 62 +++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index c63bfdf..c31baa7 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -695,7 +695,8 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 							    "ehci_logic_fck");
 			if (IS_ERR(omap->ehci_logic_fck)) {
 				ret = PTR_ERR(omap->ehci_logic_fck);
-				dev_dbg(dev, "ehci_logic_fck failed:%d\n", ret);
+				dev_err(dev, "ehci_logic_fck failed:%d\n", ret);
+				goto err_mem;
 			}
 		}
 		goto initialize;
@@ -749,51 +750,68 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		 * them
 		 */
 		omap->utmi_clk[i] = devm_clk_get(dev, clkname);
-		if (IS_ERR(omap->utmi_clk[i]))
-			dev_dbg(dev, "Failed to get clock : %s : %ld\n",
-				clkname, PTR_ERR(omap->utmi_clk[i]));
+		if (IS_ERR(omap->utmi_clk[i])) {
+			ret = PTR_ERR(omap->utmi_clk[i]);
+			dev_err(dev, "Failed to get clock : %s : %d\n",
+				clkname, ret);
+			goto err_mem;
+		}
 
 		snprintf(clkname, sizeof(clkname),
 				"usb_host_hs_hsic480m_p%d_clk", i + 1);
 		omap->hsic480m_clk[i] = devm_clk_get(dev, clkname);
-		if (IS_ERR(omap->hsic480m_clk[i]))
-			dev_dbg(dev, "Failed to get clock : %s : %ld\n",
-				clkname, PTR_ERR(omap->hsic480m_clk[i]));
+		if (IS_ERR(omap->hsic480m_clk[i])) {
+			ret = PTR_ERR(omap->hsic480m_clk[i]);
+			dev_err(dev, "Failed to get clock : %s : %d\n",
+				clkname, ret);
+			goto err_mem;
+		}
 
 		snprintf(clkname, sizeof(clkname),
 				"usb_host_hs_hsic60m_p%d_clk", i + 1);
 		omap->hsic60m_clk[i] = devm_clk_get(dev, clkname);
-		if (IS_ERR(omap->hsic60m_clk[i]))
-			dev_dbg(dev, "Failed to get clock : %s : %ld\n",
-				clkname, PTR_ERR(omap->hsic60m_clk[i]));
+		if (IS_ERR(omap->hsic60m_clk[i])) {
+			ret = PTR_ERR(omap->hsic60m_clk[i]);
+			dev_err(dev, "Failed to get clock : %s : %d\n",
+				clkname, ret);
+			goto err_mem;
+		}
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->xclk60mhsp1_ck);
-		if (ret != 0)
-			dev_dbg(dev, "xclk60mhsp1_ck set parent failed: %d\n",
-					ret);
+		if (ret != 0) {
+			dev_err(dev, "xclk60mhsp1_ck set parent failed: %d\n",
+				ret);
+			goto err_mem;
+		}
 	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->init_60m_fclk);
-		if (ret != 0)
-			dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
-					ret);
+		if (ret != 0) {
+			dev_err(dev, "P0 init_60m_fclk set parent failed: %d\n",
+				ret);
+			goto err_mem;
+		}
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 					omap->xclk60mhsp2_ck);
-		if (ret != 0)
-			dev_dbg(dev, "xclk60mhsp2_ck set parent failed: %d\n",
-					ret);
+		if (ret != 0) {
+			dev_err(dev, "xclk60mhsp2_ck set parent failed: %d\n",
+				ret);
+			goto err_mem;
+		}
 	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 						omap->init_60m_fclk);
-		if (ret != 0)
-			dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
-					ret);
+		if (ret != 0) {
+			dev_err(dev, "P1 init_60m_fclk set parent failed: %d\n",
+				ret);
+			goto err_mem;
+		}
 	}
 
 initialize:
-- 
1.8.3.2
