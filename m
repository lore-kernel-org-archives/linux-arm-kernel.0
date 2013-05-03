From: marek.belisko@gmail.com (Marek Belisko)
Date: Fri,  3 May 2013 07:53:23 +0200
Subject: [PATCH v2 2/2] clk: si5351: Set initial clkout rate when defined in
 platform data.
In-Reply-To: <1367560403-21685-1-git-send-email-marek.belisko@streamunlimited.com>
References: <1367560403-21685-1-git-send-email-marek.belisko@streamunlimited.com>
Message-ID: <1367560403-21685-2-git-send-email-marek.belisko@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek.belisko@streamunlimited.com>
---
Changes v1->v2:
- update commit message and comment to refer to platform data not DT

 drivers/clk/clk-si5351.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index cf39e53..24f5536 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1477,6 +1477,16 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			return -EINVAL;
 		}
 		drvdata->onecell.clks[n] = clk;
+
+		/* set initial clkout rate */
+		if (pdata->clkout[n].rate != 0) {
+			int ret;
+			ret = clk_set_rate(clk, pdata->clkout[n].rate);
+			if (ret != 0) {
+				dev_err(&client->dev, "Cannot set rate : %d\n",
+					ret);
+			}
+		}
 	}
 
 	ret = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
-- 
1.7.9.5
