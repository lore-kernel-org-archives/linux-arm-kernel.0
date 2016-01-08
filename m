From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 08 Jan 2016 10:07:26 +0100
Subject: [PATCH] mmc: pwrseq_simple: Make reset-gpios optional to match doc
Message-ID: <20160108090726.13066.66125.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT binding doc says reset-gpios is an optional property but the code
currently bails out if it is omitted.

Make the code match the documentation.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/mmc/core/pwrseq_simple.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index d10538b..4d2962b 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -29,15 +29,18 @@ struct mmc_pwrseq_simple {
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 					      int value)
 {
-	int i;
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
-	int values[reset_gpios->ndescs];
 
-	for (i = 0; i < reset_gpios->ndescs; i++)
-		values[i] = value;
+	if (!IS_ERR(reset_gpios)) {
+		int i;
+		int values[reset_gpios->ndescs];
 
-	gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
-				       values);
+		for (i = 0; i < reset_gpios->ndescs; i++)
+			values[i] = value;
+
+		gpiod_set_array_value_cansleep(
+			reset_gpios->ndescs, reset_gpios->desc, values);
+	}
 }
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
@@ -79,7 +82,8 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
-	gpiod_put_array(pwrseq->reset_gpios);
+	if (!IS_ERR(pwrseq->reset_gpios))
+		gpiod_put_array(pwrseq->reset_gpios);
 
 	if (!IS_ERR(pwrseq->ext_clk))
 		clk_put(pwrseq->ext_clk);
@@ -112,7 +116,8 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
 	}
 
 	pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpios)) {
+	if (IS_ERR(pwrseq->reset_gpios) &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT) {
 		ret = PTR_ERR(pwrseq->reset_gpios);
 		goto clk_put;
 	}
