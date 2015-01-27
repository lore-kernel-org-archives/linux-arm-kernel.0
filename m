From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 27 Jan 2015 16:27:21 +0530
Subject: [PATCH 4/7] spi: spi-fsl-dspi: avoid preparing the clock two times
In-Reply-To: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <1422356244-15629-5-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_read/regmap_write will expect the peripheral clock
to be enabled before accessing the registers of the peripheral.
Since the peripheral clock is enabled separatly, avoid redundant clock
prepare (with devm_regmap_init_mmio_clk) and use devm_regmap_init_mmio instead.

Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9b80d54..5378148 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -502,7 +502,7 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	dspi->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "dspi", base,
+	dspi->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 						&dspi_regmap_config);
 	if (IS_ERR(dspi->regmap)) {
 		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
-- 
2.2.2
