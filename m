From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 17 Feb 2013 17:24:40 +0800
Subject: [PATCH v9 6/9] usb: chipidea: imx: add internal vbus regulator control
In-Reply-To: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1361093083-22940-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- For host, the vbus should always be on.
- For otg, the vbus is off defaultly, the vbus needs to be
turned on/off when usb role switches.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h          |    2 +
 drivers/usb/chipidea/ci13xxx_imx.c |   76 ++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 0bd17a5..5663092 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -133,6 +133,7 @@ struct hw_bank {
  * @id_event: indicates there is a id event, and handled at ci_otg_work
  * @b_sess_valid_event: indicates there is a vbus event, and handled
  * at ci_otg_work
+ * @reg_vbus: used to control internal vbus regulator
  */
 struct ci13xxx {
 	struct device			*dev;
@@ -172,6 +173,7 @@ struct ci13xxx {
 	struct usb_otg      		otg;
 	bool				id_event;
 	bool				b_sess_valid_event;
+	struct regulator		*reg_vbus;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci13xxx *ci)
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 3ed119e..5499cf8 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -85,11 +85,43 @@ EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
 
 /* End of common functions shared by usbmisc drivers*/
 
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
 	struct ci13xxx_platform_data *pdata;
 	struct platform_device *plat_ci;
+	struct ci13xxx	*ci;
 	struct resource *res;
 	struct regulator *reg_vbus;
 	struct pinctrl *pinctrl;
@@ -163,20 +195,11 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		data->phy = phy;
 	}
 
-	/* we only support host now, so enable vbus here */
 	reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
-	if (!IS_ERR(reg_vbus)) {
-		ret = regulator_enable(reg_vbus);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vbus regulator, err=%d\n",
-				ret);
-			goto err_clk;
-		}
+	if (!IS_ERR(reg_vbus))
 		data->reg_vbus = reg_vbus;
-	} else {
+	else
 		reg_vbus = NULL;
-	}
 
 	pdata->phy = data->phy;
 
@@ -186,7 +209,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		if (!pdev->dev.dma_mask) {
 			ret = -ENOMEM;
 			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
-			goto err;
+			goto err_clk;
 		}
 		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
@@ -197,7 +220,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"usbmisc init failed, ret=%d\n", ret);
-			goto err;
+			goto err_clk;
 		}
 	}
 
@@ -209,20 +232,39 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register ci_hdrc platform device, err=%d\n",
 			ret);
-		goto err;
+		goto err_clk;
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
+			goto err_clk;
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
 err_clk:
 	clk_disable_unprepare(data->clk);
 	return ret;
-- 
1.7.0.4
