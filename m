From: Barry.Song@csr.com (Barry Song)
Date: Wed, 26 Dec 2012 10:48:33 +0800
Subject: [PATCH 1/2] spi: sirf: use clk_prepare_enable and
 clk_disable_unprepare
Message-ID: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index e0f43a5..38a191c 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -570,7 +570,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto free_pin;
 	}
-	clk_enable(sspi->clk);
+	clk_prepare_enable(sspi->clk);
 	sspi->ctrl_freq = clk_get_rate(sspi->clk);
 
 	init_completion(&sspi->done);
@@ -594,7 +594,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	return 0;
 
 free_clk:
-	clk_disable(sspi->clk);
+	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
 free_pin:
 	pinctrl_put(sspi->p);
@@ -618,7 +618,7 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 		if (sspi->chipselect[i] > 0)
 			gpio_free(sspi->chipselect[i]);
 	}
-	clk_disable(sspi->clk);
+	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
 	pinctrl_put(sspi->p);
 	spi_master_put(master);
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
