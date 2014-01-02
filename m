From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:25 +0000
Subject: [PATCH RFC 43/46] imx-drm: imx-hdmi: add hotplug support to HDMI
 component
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VyppV-0007GO-K2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hotplug support.  We have to make the interrupt handler threaded so
we can call drm_helper_hpd_irq_event().  Keeping in mind that we will
want to share the interrupt with other HDMI interface drivers (eg, audio
and CEC) put the groundwork in now for that, rather than just using
IRQF_ONESHOT.

Also, we must not call drm_helper_hpd_irq_event() until we have fully
setup the connector; keep the interrupt(s) muted until after that point.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |   40 +++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 512b39710530..097403a602d8 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -124,6 +124,8 @@ struct imx_hdmi {
 	struct clk *isfr_clk;
 	struct clk *iahb_clk;
 
+	enum drm_connector_status connector_status;
+
 	struct hdmi_data_info hdmi_data;
 	int vic;
 
@@ -1305,9 +1307,6 @@ static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 	/* Clear Hotplug interrupts */
 	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
 
-	/* Unmute interrupts */
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
-
 	return 0;
 }
 
@@ -1376,8 +1375,9 @@ static void imx_hdmi_poweroff(struct imx_hdmi *hdmi)
 static enum drm_connector_status imx_hdmi_connector_detect(struct drm_connector
 							*connector, bool force)
 {
-	/* FIXME */
-	return connector_status_connected;
+	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
+					     connector);
+	return hdmi->connector_status;
 }
 
 static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -1491,6 +1491,18 @@ static struct drm_connector_helper_funcs imx_hdmi_connector_helper_funcs = {
 	.best_encoder = imx_hdmi_connector_best_encoder,
 };
 
+static irqreturn_t imx_hdmi_hardirq(int irq, void *dev_id)
+{
+	struct imx_hdmi *hdmi = dev_id;
+	u8 intr_stat;
+
+	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
+	if (intr_stat)
+		hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
+
+	return intr_stat ? IRQ_WAKE_THREAD : IRQ_NONE;
+}
+
 static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 {
 	struct imx_hdmi *hdmi = dev_id;
@@ -1507,17 +1519,21 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 
 			hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
 
+			hdmi->connector_status = connector_status_connected;
 			imx_hdmi_poweron(hdmi);
 		} else {
 			dev_dbg(hdmi->dev, "EVENT=plugout\n");
 
 			hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
 
+			hdmi->connector_status = connector_status_disconnected;
 			imx_hdmi_poweroff(hdmi);
 		}
+		drm_helper_hpd_irq_event(hdmi->connector.dev);
 	}
 
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
+	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
 
 	return IRQ_HANDLED;
 }
@@ -1531,6 +1547,8 @@ static int imx_hdmi_register(struct drm_device *drm, struct imx_hdmi *hdmi)
 	if (ret)
 		return ret;
 
+	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+
 	drm_encoder_helper_add(&hdmi->encoder, &imx_hdmi_encoder_helper_funcs);
 	drm_encoder_init(drm, &hdmi->encoder, &imx_hdmi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS);
@@ -1582,6 +1600,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return -ENOMEM;
 
 	hdmi->dev = dev;
+	hdmi->connector_status = connector_status_disconnected;
 	hdmi->sample_rate = 48000;
 	hdmi->ratio = 100;
 
@@ -1605,8 +1624,9 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (irq < 0)
 		return -EINVAL;
 
-	ret = devm_request_irq(dev, irq, imx_hdmi_irq, 0,
-			       dev_name(dev), hdmi);
+	ret = devm_request_threaded_irq(dev, irq, imx_hdmi_hardirq,
+					imx_hdmi_irq, IRQF_SHARED,
+					dev_name(dev), hdmi);
 	if (ret)
 		return ret;
 
@@ -1682,6 +1702,9 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_iahb;
 
+	/* Unmute interrupts */
+	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+
 	dev_set_drvdata(dev, hdmi);
 
 	return 0;
@@ -1699,6 +1722,9 @@ static void imx_hdmi_unbind(struct device *dev, struct device *master,
 {
 	struct imx_hdmi *hdmi = dev_get_drvdata(dev);
 
+	/* Disable all interrupts */
+	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
+
 	hdmi->connector.funcs->destroy(&hdmi->connector);
 	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 
-- 
1.7.4.4
