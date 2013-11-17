From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 18 Nov 2013 00:06:08 +0100
Subject: [PATCH v5 08/17] spi: mpc512x: adjust to OF based clock lookup
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
Message-ID: <1384729577-7336-9-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the PSC index,
remove the "psc%d_mclk" template and unconditionally use 'mclk'

acquire and release the 'ipg' clock item for register access as well

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi at vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 6adf4e35816d..5beb30c61a39 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -39,6 +39,7 @@ struct mpc512x_psc_spi {
 	unsigned int irq;
 	u8 bits_per_word;
 	struct clk *clk_mclk;
+	struct clk *clk_ipg;
 	u32 mclk_rate;
 
 	struct completion txisrdone;
@@ -474,8 +475,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 	void *tempp;
-	int psc_num;
-	char clk_name[16];
 	struct clk *clk;
 
 	master = spi_alloc_master(dev, sizeof *mps);
@@ -519,9 +518,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_master;
 	init_completion(&mps->txisrdone);
 
-	psc_num = master->bus_num;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	clk = devm_clk_get(dev, clk_name);
+	clk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		goto free_irq;
@@ -532,17 +529,29 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->clk_mclk = clk;
 	mps->mclk_rate = clk_get_rate(clk);
 
+	clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto free_mclk_clock;
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto free_mclk_clock;
+	mps->clk_ipg = clk;
+
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
-		goto free_clock;
+		goto free_ipg_clock;
 
 	ret = spi_register_master(master);
 	if (ret < 0)
-		goto free_clock;
+		goto free_ipg_clock;
 
 	return ret;
 
-free_clock:
+free_ipg_clock:
+	clk_disable_unprepare(mps->clk_ipg);
+free_mclk_clock:
 	clk_disable_unprepare(mps->clk_mclk);
 free_irq:
 	free_irq(mps->irq, mps);
@@ -561,6 +570,7 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
 
 	spi_unregister_master(master);
 	clk_disable_unprepare(mps->clk_mclk);
+	clk_disable_unprepare(mps->clk_ipg);
 	free_irq(mps->irq, mps);
 	if (mps->psc)
 		iounmap(mps->psc);
-- 
1.7.10.4
