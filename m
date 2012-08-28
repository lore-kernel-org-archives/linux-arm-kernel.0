From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:16 +0800
Subject: [PATCH v2 10/11] USB: chipidea: add set_vbus_power support
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-11-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_vbus_power is used to enable or disable vbus power for usb host.

[Marc Kleine-Budde <mkl@pengutronix.de>: fix regulator unbalance disable]

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |   44 +++++++++++++++++++++---------------
 drivers/usb/chipidea/host.c        |    8 +++++++
 include/linux/usb/chipidea.h       |    2 ++
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 0f5ca4b..5c0be08 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -27,6 +27,8 @@
 
 #define pdev_to_phy(pdev) \
 	((struct usb_phy *)platform_get_drvdata(pdev))
+#define ci_to_imx_data(ci) \
+	((struct ci13xxx_imx_data *)dev_get_drvdata(ci->dev->parent))
 
 struct ci13xxx_imx_data {
 	struct device_node *phy_np;
@@ -85,12 +87,32 @@ EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
 
 /* End of common functions shared by usbmisc drivers*/
 
+static int ci13xxx_imx_vbus(struct ci13xxx *ci, int enable)
+{
+	struct ci13xxx_imx_data *data = ci_to_imx_data(ci);
+	int ret;
+
+	if (!data->reg_vbus)
+		return 0;
+
+	if (enable)
+		ret = regulator_enable(data->reg_vbus);
+	else
+		ret = regulator_disable(data->reg_vbus);
+	if (ret)
+		dev_err(ci->dev, "ci13xxx_imx_vbus failed, enable:%d err:%d\n",
+			enable, ret);
+
+	return ret;
+}
+
 static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
 	.name			= "ci13xxx_imx",
 	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
 				  CI13XXX_PULLUP_ON_VBUS |
 				  CI13XXX_DISABLE_STREAMING,
 	.capoffset		= DEF_CAPOFFSET,
+	.set_vbus_power		= ci13xxx_imx_vbus,
 };
 
 static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
@@ -153,20 +175,11 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
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
 
@@ -191,6 +204,8 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		}
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				&ci13xxx_imx_platdata);
@@ -203,7 +218,6 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	}
 
 	data->ci_pdev = plat_ci;
-	platform_set_drvdata(pdev, data);
 
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -211,9 +225,6 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	return 0;
 
 err:
-	if (reg_vbus)
-		regulator_disable(reg_vbus);
-put_np:
 	if (phy_np)
 		of_node_put(phy_np);
 	clk_disable_unprepare(data->clk);
@@ -227,9 +238,6 @@ static int __devexit ci13xxx_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	ci13xxx_remove_device(data->ci_pdev);
 
-	if (data->reg_vbus)
-		regulator_disable(data->reg_vbus);
-
 	if (data->phy) {
 		usb_phy_shutdown(data->phy);
 		module_put(data->phy->dev->driver->owner);
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index ebff9f4..e091147 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -106,6 +106,12 @@ static int host_start(struct ci13xxx *ci)
 	if (usb_disabled())
 		return -ENODEV;
 
+	if (ci->platdata->set_vbus_power) {
+		ret = ci->platdata->set_vbus_power(ci, 1);
+		if (ret)
+			return ret;
+	}
+
 	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
 	if (!hcd)
 		return -ENOMEM;
@@ -138,6 +144,8 @@ static void host_stop(struct ci13xxx *ci)
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
+	if (ci->platdata->set_vbus_power)
+		ci->platdata->set_vbus_power(ci, 0);
 }
 
 int ci_hdrc_host_init(struct ci13xxx *ci)
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 544825d..080f479 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -23,6 +23,8 @@ struct ci13xxx_platform_data {
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
 	void	(*notify_event) (struct ci13xxx *ci, unsigned event);
+	/* set vbus power, it must be called in non-atomic context */
+	int	(*set_vbus_power) (struct ci13xxx *ci, int enable);
 };
 
 /* Default offset of capability registers */
-- 
1.7.9.5
