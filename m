From: stefan@agner.ch (Stefan Agner)
Date: Fri, 21 Apr 2017 18:23:34 -0700
Subject: [PATCH v2 1/5] mtd: nand: gpmi: unify clock handling
In-Reply-To: <20170422012338.4635-1-stefan@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
Message-ID: <20170422012338.4635-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device specific list of clocks required, and handle all clocks
in a single for loop. This avoids further code duplication when
adding i.MX 7 support.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 41 +++++++++++++++-------------------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  2 ++
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index d52139635b67..c8bbf5da2ab8 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -82,6 +82,10 @@ static int gpmi_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const char * const gpmi_clks_for_mx2x[] = {
+	"gpmi_io",
+};
+
 static const struct mtd_ooblayout_ops gpmi_ooblayout_ops = {
 	.ecc = gpmi_ooblayout_ecc,
 	.free = gpmi_ooblayout_free,
@@ -91,24 +95,36 @@ static const struct gpmi_devdata gpmi_devdata_imx23 = {
 	.type = IS_MX23,
 	.bch_max_ecc_strength = 20,
 	.max_chain_delay = 16,
+	.clks = gpmi_clks_for_mx2x,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx2x),
 };
 
 static const struct gpmi_devdata gpmi_devdata_imx28 = {
 	.type = IS_MX28,
 	.bch_max_ecc_strength = 20,
 	.max_chain_delay = 16,
+	.clks = gpmi_clks_for_mx2x,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx2x),
+};
+
+static const char * const gpmi_clks_for_mx6[] = {
+	"gpmi_io", "gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
 };
 
 static const struct gpmi_devdata gpmi_devdata_imx6q = {
 	.type = IS_MX6Q,
 	.bch_max_ecc_strength = 40,
 	.max_chain_delay = 12,
+	.clks = gpmi_clks_for_mx6,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
 };
 
 static const struct gpmi_devdata gpmi_devdata_imx6sx = {
 	.type = IS_MX6SX,
 	.bch_max_ecc_strength = 62,
 	.max_chain_delay = 12,
+	.clks = gpmi_clks_for_mx6,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
 };
 
 static irqreturn_t bch_irq(int irq, void *cookie)
@@ -599,35 +615,14 @@ static int acquire_dma_channels(struct gpmi_nand_data *this)
 	return -EINVAL;
 }
 
-static char *extra_clks_for_mx6q[GPMI_CLK_MAX] = {
-	"gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
-};
-
 static int gpmi_get_clks(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
-	char **extra_clks = NULL;
 	struct clk *clk;
 	int err, i;
 
-	/* The main clock is stored in the first. */
-	r->clock[0] = devm_clk_get(this->dev, "gpmi_io");
-	if (IS_ERR(r->clock[0])) {
-		err = PTR_ERR(r->clock[0]);
-		goto err_clock;
-	}
-
-	/* Get extra clocks */
-	if (GPMI_IS_MX6(this))
-		extra_clks = extra_clks_for_mx6q;
-	if (!extra_clks)
-		return 0;
-
-	for (i = 1; i < GPMI_CLK_MAX; i++) {
-		if (extra_clks[i - 1] == NULL)
-			break;
-
-		clk = devm_clk_get(this->dev, extra_clks[i - 1]);
+	for (i = 0; i < this->devdata->clks_count; i++) {
+		clk = devm_clk_get(this->dev, this->devdata->clks[i]);
 		if (IS_ERR(clk)) {
 			err = PTR_ERR(clk);
 			goto err_clock;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 4e49a1f5fa27..8879c4eff25e 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -130,6 +130,8 @@ struct gpmi_devdata {
 	enum gpmi_type type;
 	int bch_max_ecc_strength;
 	int max_chain_delay; /* See the async EDO mode */
+	const char * const *clks;
+	const int clks_count;
 };
 
 struct gpmi_nand_data {
-- 
2.12.2
