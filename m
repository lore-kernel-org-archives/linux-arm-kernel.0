From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 16:13:25 +0000
Subject: [PATCH] ARM: PNX4008: i2c-pnx: use the same dev_id for request_irq
	and free_irq
Message-ID: <E1NBsaT-0007az-Aa@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows i2c-pnx to free its interrupt handler when the module
is removed or if an error occurs; using the same dev_id for both
request_irq and free_irq is desirable.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-pnx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 1fca590..fbab684 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -650,7 +650,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	return 0;
 
 out_irq:
-	free_irq(alg_data->irq, alg_data);
+	free_irq(alg_data->irq, i2c_pnx->adapter);
 out_clock:
 	i2c_pnx->set_clock_stop(pdev);
 out_unmap:
@@ -669,7 +669,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 	struct i2c_adapter *adap = i2c_pnx->adapter;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 
-	free_irq(alg_data->irq, alg_data);
+	free_irq(alg_data->irq, i2c_pnx->adapter);
 	i2c_del_adapter(adap);
 	i2c_pnx->set_clock_stop(pdev);
 	iounmap((void *)alg_data->ioaddr);
-- 
1.6.2.5
