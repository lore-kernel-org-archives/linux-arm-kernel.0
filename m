From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:57:03 +0200
Subject: [PATCHv3 31/41] OMAPDSS: remove DT hacks for regulators
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-32-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For booting Panda and 4430SDP with DT, while DSS did not support DT, we
had to had small hacks in the omapdss driver to get the regulators. With
DT now supported in DSS, we can remove those hacks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c   | 9 +--------
 drivers/video/omap2/dss/hdmi4.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 98bb2d68a462..f461fe015554 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1162,16 +1162,9 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 
 	vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdd");
 
-	if (IS_ERR(vdds_dsi))
-		vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdds_dsi");
-
-	/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
-	if (IS_ERR(vdds_dsi))
-		vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "VCXIO");
-
 	if (IS_ERR(vdds_dsi)) {
 		if (PTR_ERR(vdds_dsi) != -EPROBE_DEFER)
-			DSSERR("can't get VDDS_DSI regulator\n");
+			DSSERR("can't get DSI VDD regulator\n");
 		return PTR_ERR(vdds_dsi);
 	}
 
diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 064bec4e08d4..17b24b26f6cd 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -90,16 +90,9 @@ static int hdmi_init_regulator(void)
 
 	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda");
 
-	if (IS_ERR(reg)
-		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
-
-	/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
-	if (IS_ERR(reg))
-		reg = devm_regulator_get(&hdmi.pdev->dev, "VDAC");
-
 	if (IS_ERR(reg)) {
 		if (PTR_ERR(reg) != -EPROBE_DEFER)
-			DSSERR("can't get VDDA_HDMI_DAC regulator\n");
+			DSSERR("can't get VDDA regulator\n");
 		return PTR_ERR(reg);
 	}
 
-- 
1.8.3.2
