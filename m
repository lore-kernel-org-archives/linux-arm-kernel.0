From: Barry.Song@csr.com (Barry Song)
Date: Tue, 15 May 2012 10:21:00 +0800
Subject: [PATCH] SPI: PRIMA2: use the newest APIs of PINCTRL to fix compiling
 errors
Message-ID: <1337048460-30329-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Fix the compiling errors:
drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
make[3]: *** [drivers/spi/spi-sirf.o] Error 1

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-sirf.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 52fe495..ecc3d97 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -19,7 +19,7 @@
 #include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
 
 #define DRIVER_NAME "sirfsoc_spi"
 
@@ -127,7 +127,7 @@ struct sirfsoc_spi {
 	void __iomem *base;
 	u32 ctrl_freq;  /* SPI controller clock speed */
 	struct clk *clk;
-	struct pinmux *pmx;
+	struct pinctrl *p;
 
 	/* rx & tx bufs from the spi_transfer */
 	const void *tx;
@@ -560,17 +560,15 @@ static int __devinit spi_sirfsoc_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
-	sspi->pmx = pinmux_get(&pdev->dev, NULL);
-	ret = IS_ERR(sspi->pmx);
+	sspi->p = pinctrl_get_select_default(&pdev->dev);
+	ret = IS_ERR(sspi->p);
 	if (ret)
 		goto free_master;
 
-	pinmux_enable(sspi->pmx);
-
 	sspi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sspi->clk)) {
 		ret = -EINVAL;
-		goto free_pmx;
+		goto free_pin;
 	}
 	clk_enable(sspi->clk);
 	sspi->ctrl_freq = clk_get_rate(sspi->clk);
@@ -598,9 +596,8 @@ static int __devinit spi_sirfsoc_probe(struct platform_device *pdev)
 free_clk:
 	clk_disable(sspi->clk);
 	clk_put(sspi->clk);
-free_pmx:
-	pinmux_disable(sspi->pmx);
-	pinmux_put(sspi->pmx);
+free_pin:
+	pinctrl_put(sspi->p);
 free_master:
 	spi_master_put(master);
 err_cs:
@@ -623,8 +620,7 @@ static int  __devexit spi_sirfsoc_remove(struct platform_device *pdev)
 	}
 	clk_disable(sspi->clk);
 	clk_put(sspi->clk);
-	pinmux_disable(sspi->pmx);
-	pinmux_put(sspi->pmx);
+	pinctrl_put(sspi->p);
 	spi_master_put(master);
 	return 0;
 }
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
