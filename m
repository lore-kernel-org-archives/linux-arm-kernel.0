From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:29 +0000
Subject: [PATCH 12/18] ARM: PNX4008: Make ioaddr 'void __iomem *' rather than
	'u32'
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <1f03bcaf226fc81378a9ec1e7e655e81c4ae568d.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids unnecessary casting.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-pnx.c |    8 ++++----
 include/linux/i2c-pnx.h      |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index bfcd079..882579e 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -612,8 +612,8 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		goto out_clkget;
 	}
 
-	if (!(alg_data->ioaddr =
-			(u32)ioremap(alg_data->base, I2C_PNX_REGION_SIZE))) {
+	alg_data->ioaddr = ioremap(alg_data->base, I2C_PNX_REGION_SIZE);
+	if (!alg_data->ioaddr) {
 		dev_err(&pdev->dev, "Couldn't ioremap I2C I/O region\n");
 		ret = -ENOMEM;
 		goto out_release;
@@ -671,7 +671,7 @@ out_irq:
 out_clock:
 	clk_disable(alg_data->clk);
 out_unmap:
-	iounmap((void *)alg_data->ioaddr);
+	iounmap(alg_data->ioaddr);
 out_release:
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 out_clkget:
@@ -691,7 +691,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 	free_irq(alg_data->irq, i2c_pnx->adapter);
 	i2c_del_adapter(adap);
 	clk_disable(alg_data->clk);
-	iounmap((void *)alg_data->ioaddr);
+	iounmap(alg_data->ioaddr);
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 	clk_put(alg_data->clk);
 	platform_set_drvdata(pdev, NULL);
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 9035711..5a48f33 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -26,7 +26,7 @@ struct i2c_pnx_mif {
 
 struct i2c_pnx_algo_data {
 	u32			base;
-	u32			ioaddr;
+	void __iomem		*ioaddr;
 	int			irq;
 	struct i2c_pnx_mif	mif;
 	int			last;
-- 
1.6.2.5
