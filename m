From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:45:25 +0100
Subject: [PATCH 157/222] imx-drm: imx-hdmi: fix hdmi hotplug detection initial
 state
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeZJ-0007Nl-NA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial state at boot is assumed to be disconnected, and we hope
to receive an interrupt to update the status.  Let's be more explicit
about the current state - reading the PHY status register tells us
the current level of the hotplug signal, which we can report back in
the _detect() method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index d47dedd2cdb4..6f5efcc89880 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -120,8 +120,6 @@ struct imx_hdmi {
 	struct clk *isfr_clk;
 	struct clk *iahb_clk;
 
-	enum drm_connector_status connector_status;
-
 	struct hdmi_data_info hdmi_data;
 	int vic;
 
@@ -1382,7 +1380,9 @@ static enum drm_connector_status imx_hdmi_connector_detect(struct drm_connector
 {
 	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
 					     connector);
-	return hdmi->connector_status;
+
+	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
+		connector_status_connected : connector_status_disconnected;
 }
 
 static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -1524,7 +1524,6 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 
 			hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
 
-			hdmi->connector_status = connector_status_connected;
 			imx_hdmi_poweron(hdmi);
 		} else {
 			dev_dbg(hdmi->dev, "EVENT=plugout\n");
@@ -1532,7 +1531,6 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 			hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD,
 				HDMI_PHY_POL0);
 
-			hdmi->connector_status = connector_status_disconnected;
 			imx_hdmi_poweroff(hdmi);
 		}
 		drm_helper_hpd_irq_event(hdmi->connector.dev);
@@ -1606,7 +1604,6 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return -ENOMEM;
 
 	hdmi->dev = dev;
-	hdmi->connector_status = connector_status_disconnected;
 	hdmi->sample_rate = 48000;
 	hdmi->ratio = 100;
 
-- 
1.8.3.1
