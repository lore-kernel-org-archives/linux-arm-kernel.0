From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:04:21 +0100
Subject: [PATCH 12/12] drm: bridge/dw_hdmi: improve HDMI enable/disable
 handling
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6bd-0002vx-DL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDMI sinks are permitted to de-assert and re-assert the HPD signal to
indicate that their EDID has been updated, which may not involve a
change of video information.

An example of where such a situation can arise is when an AV receiver
is connected between the source and the display device.  Events which
can cause the HPD to be deasserted include:

 * turning on or switching to standby the AV receiver.
 * turning on or switching to standby the display device.

Each of these can change the entire EDID data, or just a part of the
EDID data - it's up to the connected HDMI sink to do what they desire
here.  For example

 - with the AV receiver and display device both in standby, a source
   connected to the AV receiver may provide its own EDID to the source.
 - turning on the display device causes the display device's EDID to be
   made available in an unmodified form to the source.
 - subsequently turning on the AV receiver then provides a modified
   version of the display device's EDID.

Moreover, HPD doesn't tell us whether something is actually listening
on the HDMI TDMS signals.  The phy gives us a set of RXSENSE indications
which tell us whether there is a sink connected to the TMDS signals.

Currently, we use the HPD signal to enable or disable the HDMI block,
which is questionable when HPD is used in this manner.  Using the
RXSENSE would be more appropriate, but there is some bad behaviour
which needs to be coped with.  The iMX6 implementation lets the TMDS
signals float when the phy is "powered down", which cause spurious
interrupts.  Rather than just using RXSENSE, use RXSENSE and HPD
becoming both active to signal the presence of a device, but loss
of RXSENSE to indicate that the device has been unplugged.

The side effect of this change is that a sink deasserting the HPD
signal to cause a re-read of the EDID data will not cause the bridge
to immediately disable the video signal.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 124 ++++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 2d1c7e4ec086..fba25607ef88 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -129,6 +129,8 @@ struct dw_hdmi {
 	enum drm_connector_force force;	/* mutex-protected force state */
 	bool disabled;			/* DRM has disabled our bridge */
 	bool bridge_is_on;		/* indicates the bridge is on */
+	bool rxsense;			/* rxsense state */
+	u8 phy_mask;			/* desired phy int mask settings */
 
 	spinlock_t audio_lock;
 	struct mutex audio_mutex;
@@ -142,6 +144,14 @@ struct dw_hdmi {
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
 };
 
+#define HDMI_IH_PHY_STAT0_RX_SENSE \
+	(HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
+	 HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
+
+#define HDMI_PHY_RX_SENSE \
+	(HDMI_PHY_RX_SENSE0 | HDMI_PHY_RX_SENSE1 | \
+	 HDMI_PHY_RX_SENSE2 | HDMI_PHY_RX_SENSE3)
+
 static void dw_hdmi_writel(struct dw_hdmi *hdmi, u8 val, int offset)
 {
 	writel(val, hdmi->regs + (offset << 2));
@@ -1318,10 +1328,11 @@ static int dw_hdmi_fb_registered(struct dw_hdmi *hdmi)
 		    HDMI_PHY_I2CM_CTLINT_ADDR);
 
 	/* enable cable hot plug irq */
-	hdmi_writeb(hdmi, (u8)~HDMI_PHY_HPD, HDMI_PHY_MASK0);
+	hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
 
 	/* Clear Hotplug interrupts */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
+	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
+		    HDMI_IH_PHY_STAT0);
 
 	return 0;
 }
@@ -1397,7 +1408,7 @@ static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
 	if (hdmi->disabled) {
 		force = DRM_FORCE_OFF;
 	} else if (force == DRM_FORCE_UNSPECIFIED) {
-		if (hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD)
+		if (hdmi->rxsense)
 			force = DRM_FORCE_ON;
 		else
 			force = DRM_FORCE_OFF;
@@ -1412,6 +1423,31 @@ static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
 	}
 }
 
+/*
+ * Adjust the detection of RXSENSE according to whether we have a forced
+ * connection mode enabled, or whether we have been disabled.  There is
+ * no point processing RXSENSE interrupts if we have a forced connection
+ * state, or DRM has us disabled.
+ *
+ * We also disable rxsense interrupts when we think we're disconnected
+ * to avoid floating TDMS signals giving false rxsense interrupts.
+ *
+ * Note: we still need to listen for HPD interrupts even when DRM has us
+ * disabled so that we can detect a connect event.
+ */
+static void dw_hdmi_update_phy_mask(struct dw_hdmi *hdmi)
+{
+	u8 old_mask = hdmi->phy_mask;
+
+	if (hdmi->force || hdmi->disabled || !hdmi->rxsense)
+		hdmi->phy_mask |= HDMI_PHY_RX_SENSE;
+	else
+		hdmi->phy_mask &= ~HDMI_PHY_RX_SENSE;
+
+	if (old_mask != hdmi->phy_mask)
+		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
+}
+
 static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
 				    struct drm_display_mode *orig_mode,
 				    struct drm_display_mode *mode)
@@ -1440,6 +1476,7 @@ static void dw_hdmi_bridge_disable(struct drm_bridge *bridge)
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = true;
 	dw_hdmi_update_power(hdmi);
+	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
 
@@ -1450,6 +1487,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = false;
 	dw_hdmi_update_power(hdmi);
+	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
 
@@ -1467,6 +1505,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = DRM_FORCE_UNSPECIFIED;
 	dw_hdmi_update_power(hdmi);
+	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 
 	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
@@ -1541,6 +1580,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = connector->force;
 	dw_hdmi_update_power(hdmi);
+	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
 
@@ -1582,33 +1622,69 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 {
 	struct dw_hdmi *hdmi = dev_id;
-	u8 intr_stat;
-	u8 phy_int_pol;
+	u8 intr_stat, phy_int_pol, phy_pol_mask, phy_stat;
 
 	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
-
 	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
+	phy_stat = hdmi_readb(hdmi, HDMI_PHY_STAT0);
+
+	phy_pol_mask = 0;
+	if (intr_stat & HDMI_IH_PHY_STAT0_HPD)
+		phy_pol_mask |= HDMI_PHY_HPD;
+	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE0)
+		phy_pol_mask |= HDMI_PHY_RX_SENSE0;
+	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE1)
+		phy_pol_mask |= HDMI_PHY_RX_SENSE1;
+	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE2)
+		phy_pol_mask |= HDMI_PHY_RX_SENSE2;
+	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE3)
+		phy_pol_mask |= HDMI_PHY_RX_SENSE3;
+
+	if (phy_pol_mask)
+		hdmi_modb(hdmi, ~phy_int_pol, phy_pol_mask, HDMI_PHY_POL0);
 
-	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
-		hdmi_modb(hdmi, ~phy_int_pol, HDMI_PHY_HPD, HDMI_PHY_POL0);
+	/*
+	 * RX sense tells us whether the TDMS transmitters are detecting
+	 * load - in other words, there's something listening on the
+	 * other end of the link.  Use this to decide whether we should
+	 * power on the phy as HPD may be toggled by the sink to merely
+	 * ask the source to re-read the EDID.
+	 */
+	if (intr_stat &
+	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
 		mutex_lock(&hdmi->mutex);
-		if (phy_int_pol & HDMI_PHY_HPD) {
-			dev_dbg(hdmi->dev, "EVENT=plugin\n");
-
-			if (!hdmi->disabled && !hdmi->force)
-				dw_hdmi_poweron(hdmi);
-		} else {
-			dev_dbg(hdmi->dev, "EVENT=plugout\n");
-
-			if (!hdmi->disabled && !hdmi->force)
-				dw_hdmi_poweroff(hdmi);
+		if (!hdmi->disabled && !hdmi->force) {
+			/*
+			 * If the RX sense status indicates we're disconnected,
+			 * clear the software rxsense status.
+			 */
+			if (!(phy_stat & HDMI_PHY_RX_SENSE))
+				hdmi->rxsense = false;
+
+			/*
+			 * Only set the software rxsense status when both
+			 * rxsense and hpd indicates we're connected.
+			 * This avoids what seems to be bad behaviour in
+			 * at least iMX6S versions of the phy.
+			 */
+			if (phy_stat & HDMI_PHY_HPD)
+				hdmi->rxsense = true;
+
+			dw_hdmi_update_power(hdmi);
+			dw_hdmi_update_phy_mask(hdmi);
 		}
 		mutex_unlock(&hdmi->mutex);
+	}
+
+	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
+		dev_dbg(hdmi->dev, "EVENT=%s\n",
+			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
 		drm_helper_hpd_irq_event(hdmi->bridge->dev);
 	}
 
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
+		    HDMI_IH_MUTE_PHY_STAT0);
 
 	return IRQ_HANDLED;
 }
@@ -1674,6 +1750,8 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->ratio = 100;
 	hdmi->encoder = encoder;
 	hdmi->disabled = true;
+	hdmi->rxsense = true;
+	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
 
 	mutex_init(&hdmi->mutex);
 	mutex_init(&hdmi->audio_mutex);
@@ -1764,10 +1842,11 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	 * Configure registers related to HDMI interrupt
 	 * generation before registering IRQ.
 	 */
-	hdmi_writeb(hdmi, HDMI_PHY_HPD, HDMI_PHY_POL0);
+	hdmi_writeb(hdmi, HDMI_PHY_HPD | HDMI_PHY_RX_SENSE, HDMI_PHY_POL0);
 
 	/* Clear Hotplug interrupts */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
+	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
+		    HDMI_IH_PHY_STAT0);
 
 	ret = dw_hdmi_fb_registered(hdmi);
 	if (ret)
@@ -1778,7 +1857,8 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_iahb;
 
 	/* Unmute interrupts */
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
+		    HDMI_IH_MUTE_PHY_STAT0);
 
 	dev_set_drvdata(dev, hdmi);
 
-- 
2.1.0
