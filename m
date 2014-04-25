From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:48:17 +0100
Subject: [PATCH 164/222] dw-hdmi-audio: basic suspend/resume support
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdec5-0007OK-4P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index 185c1de2c8ef..2280094fc6ff 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -611,12 +611,40 @@ static int snd_dw_hdmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int snd_dw_hdmi_suspend(struct device *dev)
+{
+	struct snd_dw_hdmi *dw = dev_get_drvdata(dev);
+
+	snd_power_change_state(dw->card, SNDRV_CTL_POWER_D3cold);
+	snd_pcm_suspend_all(dw->pcm);
+
+	return 0;
+}
+
+static int snd_dw_hdmi_resume(struct device *dev)
+{
+	struct snd_dw_hdmi *dw = dev_get_drvdata(dev);
+
+	snd_power_change_state(dw->card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(snd_dw_hdmi_pm, snd_dw_hdmi_suspend,
+			 snd_dw_hdmi_resume);
+#define PM_OPS &snd_dw_hdmi_pm
+#else
+#define PM_OPS NULL
+#endif
+
 static struct platform_driver snd_dw_hdmi_driver = {
 	.probe	= snd_dw_hdmi_probe,
 	.remove	= snd_dw_hdmi_remove,
 	.driver	= {
 		.name = "dw-hdmi-audio",
 		.owner = THIS_MODULE,
+		.pm = PM_OPS,
 	},
 };
 
-- 
1.8.3.1
