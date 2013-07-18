From: gsi@denx.de (Gerhard Sittig)
Date: Thu, 18 Jul 2013 19:00:42 +0200
Subject: [PATCH v2 11/24] spi: mpc512x: remove now obsolete clock lookup name
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
Message-ID: <1374166855-7280-12-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the PSC index,
remove the "psc%d_mclk" template and unconditionally use "mclk"

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 7a32373..b04f094 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -474,8 +474,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 	void *tempp;
-	int psc_num;
-	char clk_name[16];
 
 	master = spi_alloc_master(dev, sizeof *mps);
 	if (master == NULL)
@@ -518,9 +516,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_master;
 	init_completion(&mps->txisrdone);
 
-	psc_num = master->bus_num;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	mps->clk_mclk = clk_get(dev, clk_name);
+	mps->clk_mclk = clk_get(dev, "mclk");
 	if (IS_ERR(mps->clk_mclk))
 		goto free_irq;
 	ret = clk_prepare_enable(mps->clk_mclk);
-- 
1.7.10.4
