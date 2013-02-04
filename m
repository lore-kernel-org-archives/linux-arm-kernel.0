From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 4 Feb 2013 16:59:49 +0800
Subject: [PATCH v7 7/8] usb: chipidea: imx: add internal vbus regulator control
In-Reply-To: <1359968390-317-1-git-send-email-peter.chen@freescale.com>
References: <1359968390-317-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1359968390-317-8-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- For host, the vbus should always be on.
- For otg, the vbus is off defaultly, the vbus needs to be
turned on/off when usb role switches.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h          |    2 +
 drivers/usb/chipidea/ci13xxx_imx.c |   80 ++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 3ebe87a..bd78078 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -131,6 +131,7 @@ struct hw_bank {
  * @hcd: pointer to usb_hcd for ehci host driver
  * @otg: for otg support
  * @events: events for otg, and handled at ci_role_work
+ * @reg_vbus: used to control internal vbus regulator
  */
 struct ci13xxx {
 	struct device			*dev;
@@ -170,6 +171,7 @@ struct ci13xxx {
 	struct usb_otg      		otg;
 	bool				id_event;
 	bool				b_sess_valid_event;
+	struct regulator		*reg_vbus;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci13xxx *ci)
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 3b91ff4..4c9df98 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -88,14 +88,47 @@ EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
 static struct ci13xxx_platform_data ci13xxx_imx_platdata  = {
 	.name			= "ci13xxx_imx",
 	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
-				  CI13XXX_DISABLE_STREAMING,
+				  CI13XXX_DISABLE_STREAMING |
+				  CI13XXX_REGS_SHARED,
 	.capoffset		= DEF_CAPOFFSET,
 };
 
+static int ci13xxx_otg_set_vbus(struct usb_otg *otg, bool enabled)
+{
+	struct ci13xxx	*ci = container_of(otg, struct ci13xxx, otg);
+	struct regulator *reg_vbus = ci->reg_vbus;
+	int ret;
+
+	WARN_ON(!reg_vbus);
+
+	if (reg_vbus) {
+		if (enabled) {
+			ret = regulator_enable(reg_vbus);
+			if (ret) {
+				dev_err(ci->dev,
+				"Failed to enable vbus regulator, ret=%d\n",
+				ret);
+				return ret;
+			}
+		} else {
+			ret = regulator_disable(reg_vbus);
+			if (ret) {
+				dev_err(ci->dev,
+				"Failed to disable vbus regulator, ret=%d\n",
+				ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int ci13xxx_imx_probe(struct platform_device *pdev)
 {
 	struct ci13xxx_imx_data *data;
 	struct platform_device *plat_ci, *phy_pdev;
+	struct ci13xxx	*ci;
 	struct device_node *phy_np;
 	struct resource *res;
 	struct regulator *reg_vbus;
@@ -152,20 +185,11 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* we only support host now, so enable vbus here */
 	reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
-	if (!IS_ERR(reg_vbus)) {
-		ret = regulator_enable(reg_vbus);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vbus regulator, err=%d\n",
-				ret);
-			goto put_np;
-		}
+	if (!IS_ERR(reg_vbus))
 		data->reg_vbus = reg_vbus;
-	} else {
+	else
 		reg_vbus = NULL;
-	}
 
 	ci13xxx_imx_platdata.phy = data->phy;
 
@@ -175,7 +199,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		if (!pdev->dev.dma_mask) {
 			ret = -ENOMEM;
 			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
-			goto err;
+			goto put_np;
 		}
 		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
@@ -186,7 +210,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"usbmisc init failed, ret=%d\n", ret);
-			goto err;
+			goto put_np;
 		}
 	}
 
@@ -198,24 +222,44 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register ci_hdrc platform device, err=%d\n",
 			ret);
-		goto err;
+		goto put_np;
 	}
 
 	data->ci_pdev = plat_ci;
 	platform_set_drvdata(pdev, data);
 
+	ci = platform_get_drvdata(plat_ci);
+	/*
+	 * Internal vbus on/off policy
+	 * - Always on for host only function
+	 * - Always off for gadget only function
+	 * - call otg.set_vbus to control on/off according usb role
+	 */
+
+	if (ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]
+			&& reg_vbus) {
+		ret = regulator_enable(reg_vbus);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable vbus regulator, ret=%d\n",
+				ret);
+			goto put_np;
+		}
+	} else if (ci->is_otg) {
+		ci->otg.set_vbus = ci13xxx_otg_set_vbus;
+		ci->reg_vbus = data->reg_vbus;
+	}
+
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
 
-err:
-	if (reg_vbus)
-		regulator_disable(reg_vbus);
 put_np:
 	if (phy_np)
 		of_node_put(phy_np);
 	clk_disable_unprepare(data->clk);
+
 	return ret;
 }
 
-- 
1.7.0.4
