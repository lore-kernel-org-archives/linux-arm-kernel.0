From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 10 Jan 2018 17:51:47 +0100
Subject: [PATCH 2/2] i2c: mv64xxx: Fix clock resource by adding an optional
 bus clock
In-Reply-To: <20180110165147.26605-1-gregory.clement@free-electrons.com>
References: <20180110165147.26605-1-gregory.clement@free-electrons.com>
Message-ID: <20180110165147.26605-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
is optional because not all the SoCs need them but at least for Armada
7K/8K it is actually mandatory.

The binding documentation is updating accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index f69066266faa..cce37d8ecf41 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -135,6 +135,7 @@ struct mv64xxx_i2c_data {
 	u32			freq_m;
 	u32			freq_n;
 	struct clk              *clk;
+	struct clk              *axi_clk;
 	wait_queue_head_t	waitq;
 	spinlock_t		lock;
 	struct i2c_msg		*msg;
@@ -894,13 +895,20 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	init_waitqueue_head(&drv_data->waitq);
 	spin_lock_init(&drv_data->lock);
 
-	/* Not all platforms have a clk */
+	/* Not all platforms have clocks */
 	drv_data->clk = devm_clk_get(&pd->dev, NULL);
 	if (IS_ERR(drv_data->clk) && PTR_ERR(drv_data->clk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (!IS_ERR(drv_data->clk))
 		clk_prepare_enable(drv_data->clk);
 
+	drv_data->axi_clk = devm_clk_get(&pd->dev, "axi");
+	if (IS_ERR(drv_data->axi_clk) &&
+	    PTR_ERR(drv_data->axi_clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!IS_ERR(drv_data->axi_clk))
+		clk_prepare_enable(drv_data->axi_clk);
+
 	drv_data->irq = platform_get_irq(pd, 0);
 
 	if (pdata) {
@@ -950,6 +958,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 exit_reset:
 	reset_control_assert(drv_data->rstc);
 exit_clk:
+	clk_disable_unprepare(drv_data->axi_clk);
 	clk_disable_unprepare(drv_data->clk);
 
 	return rc;
@@ -963,6 +972,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
 	reset_control_assert(drv_data->rstc);
+	clk_disable_unprepare(drv_data->axi_clk);
 	clk_disable_unprepare(drv_data->clk);
 
 	return 0;
-- 
2.15.1
