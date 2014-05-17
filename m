From: dgreid@chromium.org (Dylan Reid)
Date: Sat, 17 May 2014 11:21:21 -0700
Subject: [PATCH 2/2] drm/tegra: Enable HDMI_5V_CON regulator
In-Reply-To: <1400350881-22008-1-git-send-email-dgreid@chromium.org>
References: <1400350881-22008-1-git-send-email-dgreid@chromium.org>
Message-ID: <1400350881-22008-2-git-send-email-dgreid@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DDC bus uses this for it's supply, enable it so EDID can be read.
This eliminates I2C read timeouts on Venice2 and EDID can be verified
with i2cdump.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 drivers/gpu/drm/tegra/hdmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 6928015..3d3cd7e 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -44,6 +44,7 @@ struct tegra_hdmi {
 
 	struct regulator *vdd;
 	struct regulator *pll;
+	struct regulator *hdmi_5v;
 
 	void __iomem *regs;
 	unsigned int irq;
@@ -1263,6 +1264,13 @@ static int tegra_hdmi_init(struct host1x_client *client)
 		return err;
 	}
 
+	err = regulator_enable(hdmi->hdmi_5v);
+	if (err < 0) {
+		dev_err(client->dev, "failed to enable HDMI 5V regulator: %d\n",
+			err);
+		return err;
+	}
+
 	hdmi->output.type = TEGRA_OUTPUT_HDMI;
 	hdmi->output.dev = client->dev;
 	hdmi->output.ops = &hdmi_ops;
@@ -1307,6 +1315,7 @@ static int tegra_hdmi_exit(struct host1x_client *client)
 	}
 
 	regulator_disable(hdmi->vdd);
+	regulator_disable(hdmi->hdmi_5v);
 
 	return 0;
 }
@@ -1411,6 +1420,12 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 		return PTR_ERR(hdmi->pll);
 	}
 
+	hdmi->hdmi_5v = devm_regulator_get(&pdev->dev, "hdmi");
+	if (IS_ERR(hdmi->hdmi_5v)) {
+		dev_err(&pdev->dev, "failed to get HDMI 5V regulator\n");
+		return PTR_ERR(hdmi->hdmi_5v);
+	}
+
 	hdmi->output.dev = &pdev->dev;
 
 	err = tegra_output_probe(&hdmi->output);
-- 
1.8.1.3.605.g02339dd
