From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:28 -0700
Subject: [PATCH 29/34] clk: si570: Migrate to clk_hw based OF and registration
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-30-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-si570.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index d56648521a95..646af1d1898d 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -408,7 +408,6 @@ static int si570_probe(struct i2c_client *client,
 {
 	struct clk_si570 *data;
 	struct clk_init_data init;
-	struct clk *clk;
 	u32 initial_fout, factory_fout, stability;
 	int err;
 	enum clk_si570_variant variant = id->driver_data;
@@ -462,13 +461,13 @@ static int si570_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	clk = devm_clk_register(&client->dev, &data->hw);
-	if (IS_ERR(clk)) {
+	err = devm_clk_hw_register(&client->dev, &data->hw);
+	if (err) {
 		dev_err(&client->dev, "clock registration failed\n");
-		return PTR_ERR(clk);
+		return err;
 	}
-	err = of_clk_add_provider(client->dev.of_node, of_clk_src_simple_get,
-			clk);
+	err = of_clk_add_hw_provider(client->dev.of_node, of_clk_hw_simple_get,
+				     &data->hw);
 	if (err) {
 		dev_err(&client->dev, "unable to add clk provider\n");
 		return err;
@@ -477,7 +476,7 @@ static int si570_probe(struct i2c_client *client,
 	/* Read the requested initial output frequency from device tree */
 	if (!of_property_read_u32(client->dev.of_node, "clock-frequency",
 				&initial_fout)) {
-		err = clk_set_rate(clk, initial_fout);
+		err = clk_set_rate(data->hw.clk, initial_fout);
 		if (err) {
 			of_clk_del_provider(client->dev.of_node);
 			return err;
-- 
2.7.4
