From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:33 -0700
Subject: [PATCH v5 20/23] usb: chipidea: msm: Handle phy power states
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-21-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULPI phy on qcom platforms needs to be initialized and
powered on after a USB reset and before we toggle the run/stop
bit. Otherwise, the phy locks up and doesn't work properly. Hook
the phy initialization into the RESET event and the phy power off
into the STOPPED event.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 40 +++++++++++++++++++-------------------
 drivers/usb/chipidea/core.c        |  8 ++++++--
 drivers/usb/chipidea/host.c        |  8 ++++++--
 include/linux/usb/chipidea.h       |  2 +-
 4 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index fe96df7b530c..316044dba0ac 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -80,20 +80,33 @@ static const struct reset_control_ops ci_hdrc_msm_reset_ops = {
 	.reset = ci_hdrc_msm_por_reset,
 };
 
-static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
+static int ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 {
 	struct device *dev = ci->dev->parent;
 	struct ci_hdrc_msm *msm_ci = dev_get_drvdata(dev);
+	int ret;
 
 	switch (event) {
 	case CI_HDRC_CONTROLLER_RESET_EVENT:
 		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
+
+		hw_phymode_configure(ci);
 		if (msm_ci->secondary_phy) {
 			u32 val = readl_relaxed(msm_ci->base + HS_PHY_SEC_CTRL);
 			val |= HS_PHY_DIG_CLAMP_N;
 			writel_relaxed(val, msm_ci->base + HS_PHY_SEC_CTRL);
 		}
 
+		ret = phy_init(ci->phy);
+		if (ret)
+			return ret;
+
+		ret = phy_power_on(ci->phy);
+		if (ret) {
+			phy_exit(ci->phy);
+			return ret;
+		}
+
 		/* use AHB transactor, allow posted data writes */
 		hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
 
@@ -113,21 +126,18 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 				 HSPHY_SESS_VLD_CTRL);
 
 		}
-
-		usb_phy_init(ci->usb_phy);
 		break;
 	case CI_HDRC_CONTROLLER_STOPPED_EVENT:
 		dev_dbg(dev, "CI_HDRC_CONTROLLER_STOPPED_EVENT received\n");
-		/*
-		 * Put the phy in non-driving mode. Otherwise host
-		 * may not detect soft-disconnection.
-		 */
-		usb_phy_notify_disconnect(ci->usb_phy, USB_SPEED_UNKNOWN);
+		phy_power_off(ci->phy);
+		phy_exit(ci->phy);
 		break;
 	default:
 		dev_dbg(dev, "unknown ci_hdrc event\n");
 		break;
 	}
+
+	return 0;
 }
 
 static int ci_hdrc_msm_mux_phy(struct ci_hdrc_msm *ci,
@@ -167,7 +177,6 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 {
 	struct ci_hdrc_msm *ci;
 	struct platform_device *plat_ci;
-	struct usb_phy *phy;
 	struct clk *clk;
 	struct reset_control *reset;
 	struct resource *res;
@@ -181,21 +190,12 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, ci);
 
-	/*
-	 * OTG(PHY) driver takes care of PHY initialization, clock management,
-	 * powering up VBUS, mapping of registers address space and power
-	 * management.
-	 */
-	phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
-
 	ci->pdata.name = "ci_hdrc_msm";
 	ci->pdata.capoffset = DEF_CAPOFFSET;
 	ci->pdata.flags	= CI_HDRC_REGS_SHARED | CI_HDRC_DISABLE_STREAMING |
-			  CI_HDRC_OVERRIDE_AHB_BURST;
+			  CI_HDRC_OVERRIDE_AHB_BURST |
+			  CI_HDRC_OVERRIDE_PHY_CONTROL;
 	ci->pdata.notify_event = ci_hdrc_msm_notify_event;
-	ci->pdata.usb_phy = phy;
 
 	reset = devm_reset_control_get(&pdev->dev, "core");
 	if (IS_ERR(reset))
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index d1ae9a03e0fa..fbef1c961572 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -327,6 +327,7 @@ void hw_phymode_configure(struct ci_hdrc *ci)
 			hw_write(ci, OP_PORTSC, PORTSC_STS, PORTSC_STS);
 	}
 }
+EXPORT_SYMBOL_GPL(hw_phymode_configure);
 
 /**
  * _ci_usb_phy_init: initialize phy taking in account both phy and usb_phy
@@ -503,9 +504,12 @@ int hw_device_reset(struct ci_hdrc *ci)
 		return ret;
 	}
 
-	if (ci->platdata->notify_event)
-		ci->platdata->notify_event(ci,
+	if (ci->platdata->notify_event) {
+		ret = ci->platdata->notify_event(ci,
 			CI_HDRC_CONTROLLER_RESET_EVENT);
+		if (ret)
+			return ret;
+	}
 
 	/* USBMODE should be configured step by step */
 	hw_write(ci, OP_USBMODE, USBMODE_CM, USBMODE_CM_IDLE);
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index f036a9e39ced..bbfb9e62d49d 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -90,8 +90,12 @@ static int ehci_ci_reset(struct usb_hcd *hcd)
 
 	ehci->need_io_watchdog = 0;
 
-	if (ci->platdata->notify_event)
-		ci->platdata->notify_event(ci, CI_HDRC_CONTROLLER_RESET_EVENT);
+	if (ci->platdata->notify_event) {
+		ret = ci->platdata->notify_event(ci,
+				CI_HDRC_CONTROLLER_RESET_EVENT);
+		if (ret)
+			return ret;
+	}
 
 	ci_platform_configure(ci);
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 7e3daa37cf60..c5fdfcf99828 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -61,7 +61,7 @@ struct ci_hdrc_platform_data {
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-	void	(*notify_event) (struct ci_hdrc *ci, unsigned event);
+	int	(*notify_event) (struct ci_hdrc *ci, unsigned event);
 	struct regulator	*reg_vbus;
 	struct usb_otg_caps	ci_otg_caps;
 	bool			tpl_support;
-- 
2.10.0.297.gf6727b0
