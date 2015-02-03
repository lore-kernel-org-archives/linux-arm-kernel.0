From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:01:13 -0500
Subject: [PATCH v3 01/15] drm: bridge/dw_hdmi: add irq control to
 suspend/resume
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422975673-13456-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when kernel enter into suspend, cpus will shutdown, hdmi registers
will reset invisibly. After kernel resume, drm core will call the
bridge enable function. All of hdmi registers will be setup again
except the interrupt registers. In that case we should mute all the
interrupt in suspend stage, and umnute the interrupt we need in the
resume stage.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Clear Hotplug interrupts before dw_hdmi_fb_register

Changes in v2:
- Add irq control to suspend/resume interfaces

 drivers/gpu/drm/bridge/dw_hdmi.c | 41 ++++++++++++++++++++++++++++++++++++++++
 include/drm/bridge/dw_hdmi.h     |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index cd6a706..dc314f5 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1699,6 +1699,47 @@ void dw_hdmi_unbind(struct device *dev, struct device *master, void *data)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
 
+int dw_hdmi_suspend(struct device *dev)
+{
+	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
+	u8 ih_mute;
+
+	/* Disable all interrupts */
+	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
+
+	 /* Disable top level interrupt bits in HDMI block */
+	ih_mute = hdmi_readb(hdmi, HDMI_IH_MUTE) |
+		  HDMI_IH_MUTE_MUTE_WAKEUP_INTERRUPT |
+		  HDMI_IH_MUTE_MUTE_ALL_INTERRUPT;
+
+	hdmi_writeb(hdmi, ih_mute, HDMI_IH_MUTE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
+
+int dw_hdmi_resume(struct device *dev)
+{
+	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
+
+	/*
+	 * Configure registers related to HDMI interrupt
+	 * generation before registering IRQ.
+	 */
+	hdmi_writeb(hdmi, HDMI_PHY_HPD, HDMI_PHY_POL0);
+
+	/* Clear Hotplug interrupts */
+	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
+
+	dw_hdmi_fb_registered(hdmi);
+
+	/* Unmute interrupts */
+	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_resume);
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 5a4f490..e8cfe1c 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -53,6 +53,8 @@ struct dw_hdmi_plat_data {
 					   struct drm_display_mode *mode);
 };
 
+int dw_hdmi_resume(struct device *dev);
+int dw_hdmi_suspend(struct device *dev);
 void dw_hdmi_unbind(struct device *dev, struct device *master, void *data);
 int dw_hdmi_bind(struct device *dev, struct device *master,
 		 void *data, struct drm_encoder *encoder,
-- 
2.1.2
