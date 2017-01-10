From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 10 Jan 2017 06:50:58 +0000
Subject: [PATCH] clk: cs2000: add Suspend/Redume feature
Message-ID: <87pojvxve9.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>

CS2000 needs re-setup when redume, otherwise, it can't
handle correct clock rate.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
[Kuninori: cleanup original patch]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/clk/clk-cs2000-cp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
index 021f3da..3fca052 100644
--- a/drivers/clk/clk-cs2000-cp.c
+++ b/drivers/clk/clk-cs2000-cp.c
@@ -59,6 +59,10 @@ struct cs2000_priv {
 	struct i2c_client *client;
 	struct clk *clk_in;
 	struct clk *ref_clk;
+
+	/* suspend/resume */
+	unsigned long saved_rate;
+	unsigned long saved_parent_rate;
 };
 
 static const struct of_device_id cs2000_of_match[] = {
@@ -286,6 +290,9 @@ static int __cs2000_set_rate(struct cs2000_priv *priv, int ch,
 	if (ret < 0)
 		return ret;
 
+	priv->saved_rate	= rate;
+	priv->saved_parent_rate	= parent_rate;
+
 	return 0;
 }
 
@@ -489,9 +496,24 @@ static int cs2000_probe(struct i2c_client *client,
 	return ret;
 }
 
+static int cs2000_resume(struct device *dev)
+{
+	struct cs2000_priv *priv = dev_get_drvdata(dev);
+	int ch = 0; /* it uses ch0 only at this point */
+
+	return __cs2000_set_rate(priv, ch,
+				 priv->saved_rate,
+				 priv->saved_parent_rate);
+}
+
+static const struct dev_pm_ops cs2000_pm_ops = {
+	.resume_early	= cs2000_resume,
+};
+
 static struct i2c_driver cs2000_driver = {
 	.driver = {
 		.name = "cs2000-cp",
+		.pm	= &cs2000_pm_ops,
 		.of_match_table = cs2000_of_match,
 	},
 	.probe		= cs2000_probe,
-- 
1.9.1
