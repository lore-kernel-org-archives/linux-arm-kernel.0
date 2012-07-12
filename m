From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:50 +0800
Subject: [PATCH 10/12] USB: chipidea: add set_vbus_power support
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342076512-19207-11-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_vbus_power is used to enable or disable vbus power for usb host.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |   39 +++++++++++++++++++++++++-----------
 drivers/usb/chipidea/host.c        |    8 ++++++++
 include/linux/usb/chipidea.h       |    2 ++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index c94e30f..b3173d8 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -26,6 +26,8 @@
 
 #define pdev_to_phy(pdev) \
 	((struct usb_phy *)platform_get_drvdata(pdev))
+#define ci_to_imx_data(ci) \
+	((struct ci13xxx_imx_data *)dev_get_drvdata(ci->dev->parent))
 
 struct ci13xxx_imx_data {
 	struct device_node *phy_np;
@@ -35,12 +37,32 @@ struct ci13xxx_imx_data {
 	struct regulator *reg_vbus;
 };
 
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
@@ -101,18 +123,10 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 
 	/* we only support host now, so enable vbus here */
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
 
@@ -127,6 +141,9 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
 	}
+
+	platform_set_drvdata(pdev, data);
+
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				&ci13xxx_imx_platdata);
@@ -139,7 +156,6 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	}
 
 	data->ci_pdev = plat_ci;
-	platform_set_drvdata(pdev, data);
 
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -149,7 +165,6 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 err:
 	if (reg_vbus)
 		regulator_disable(reg_vbus);
-put_np:
 	if (phy_np)
 		of_node_put(phy_np);
 	clk_disable_unprepare(data->clk);
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
