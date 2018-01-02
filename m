From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue,  2 Jan 2018 14:28:03 +0100
Subject: [PATCH 07/12] i2c: rk3x: account for const type of of_device_id.data
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver creates a number of const structures that it stores in
the data field of an of_device_id array.

The data field of an of_device_id structure has type const void *, so
there is no need for a const-discarding cast when putting const values
into such a structure.

Furthermore, adding const to the declaration of the location that
receives a const value from such a field ensures that the compiler
will continue to check that the value is not modified.  The
const-discarding cast on the extraction from the data field is thus
no longer needed.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/i2c/busses/i2c-rk3x.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -u -p a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -194,7 +194,7 @@ struct rk3x_i2c_soc_data {
 struct rk3x_i2c {
 	struct i2c_adapter adap;
 	struct device *dev;
-	struct rk3x_i2c_soc_data *soc_data;
+	const struct rk3x_i2c_soc_data *soc_data;
 
 	/* Hardware resources */
 	void __iomem *regs;
@@ -1164,27 +1164,27 @@ static const struct rk3x_i2c_soc_data rk
 static const struct of_device_id rk3x_i2c_match[] = {
 	{
 		.compatible = "rockchip,rv1108-i2c",
-		.data = (void *)&rv1108_soc_data
+		.data = &rv1108_soc_data
 	},
 	{
 		.compatible = "rockchip,rk3066-i2c",
-		.data = (void *)&rk3066_soc_data
+		.data = &rk3066_soc_data
 	},
 	{
 		.compatible = "rockchip,rk3188-i2c",
-		.data = (void *)&rk3188_soc_data
+		.data = &rk3188_soc_data
 	},
 	{
 		.compatible = "rockchip,rk3228-i2c",
-		.data = (void *)&rk3228_soc_data
+		.data = &rk3228_soc_data
 	},
 	{
 		.compatible = "rockchip,rk3288-i2c",
-		.data = (void *)&rk3288_soc_data
+		.data = &rk3288_soc_data
 	},
 	{
 		.compatible = "rockchip,rk3399-i2c",
-		.data = (void *)&rk3399_soc_data
+		.data = &rk3399_soc_data
 	},
 	{},
 };
@@ -1207,7 +1207,7 @@ static int rk3x_i2c_probe(struct platfor
 		return -ENOMEM;
 
 	match = of_match_node(rk3x_i2c_match, np);
-	i2c->soc_data = (struct rk3x_i2c_soc_data *)match->data;
+	i2c->soc_data = match->data;
 
 	/* use common interface to get I2C timing properties */
 	i2c_parse_fw_timings(&pdev->dev, &i2c->t, true);
