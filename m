From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:44:00 +0200
Subject: [PATCH v4 20/31] spi: mpc512x: switch to CCF names in clock lookup
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-21-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the PSC index,
remove the "psc%d_mclk" template and unconditionally use 'mclk'

acquire and release the 'ipg' clock for register access as well

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 85581f3..daedee7 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -38,6 +38,7 @@ struct mpc512x_psc_spi {
 	struct mpc512x_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
+	struct clk *clk_ipg;
 	struct clk *clk_mclk;
 	u32 mclk_rate;
 
@@ -474,8 +475,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 	void *tempp;
-	int psc_num;
-	char clk_name[16];
 	struct clk *clk;
 
 	master = spi_alloc_master(dev, sizeof *mps);
@@ -519,29 +518,41 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_master;
 	init_completion(&mps->txisrdone);
 
-	psc_num = master->bus_num;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	clk = devm_clk_get(dev, clk_name);
-	if (IS_ERR(clk))
+	clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
 		goto free_irq;
+	}
 	ret = clk_prepare_enable(clk);
 	if (ret)
 		goto free_irq;
+	mps->clk_ipg = clk;
+
+	clk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto free_ipg_clock;
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto free_ipg_clock;
 	mps->clk_mclk = clk;
 	mps->mclk_rate = clk_get_rate(clk);
 
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
-		goto free_clock;
+		goto free_mclk_clock;
 
 	ret = spi_register_master(master);
 	if (ret < 0)
-		goto free_clock;
+		goto free_mclk_clock;
 
 	return ret;
 
-free_clock:
+free_mclk_clock:
 	clk_disable_unprepare(mps->clk_mclk);
+free_ipg_clock:
+	clk_disable_unprepare(mps->clk_ipg);
 free_irq:
 	free_irq(mps->irq, mps);
 free_master:
@@ -559,6 +570,7 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
 
 	spi_unregister_master(master);
 	clk_disable_unprepare(mps->clk_mclk);
+	clk_disable_unprepare(mps->clk_ipg);
 	free_irq(mps->irq, mps);
 	if (mps->psc)
 		iounmap(mps->psc);
-- 
1.7.10.4
