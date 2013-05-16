From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 May 2013 21:33:09 +0100
Subject: [PATCH 3/9] I2C: mv64xxx: use devm_ioremap_resource()
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Message-ID: <E1Ud4rN-0004Jc-CL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate reg_base_p and reg_size, mv64xxx_i2c_unmap_regs() and an
unchecked ioremap() return from this driver by using the devm_*
API for requesting and ioremapping resources.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   46 +++++---------------------------------
 1 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 0339cd8..19cc9bf 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -92,8 +92,6 @@ struct mv64xxx_i2c_data {
 	u32			aborting;
 	u32			cntl_bits;
 	void __iomem		*reg_base;
-	u32			reg_base_p;
-	u32			reg_size;
 	u32			addr1;
 	u32			addr2;
 	u32			bytes_left;
@@ -495,40 +493,6 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
  *
  *****************************************************************************
  */
-static int
-mv64xxx_i2c_map_regs(struct platform_device *pd,
-	struct mv64xxx_i2c_data *drv_data)
-{
-	int size;
-	struct resource	*r = platform_get_resource(pd, IORESOURCE_MEM, 0);
-
-	if (!r)
-		return -ENODEV;
-
-	size = resource_size(r);
-
-	if (!request_mem_region(r->start, size, drv_data->adapter.name))
-		return -EBUSY;
-
-	drv_data->reg_base = ioremap(r->start, size);
-	drv_data->reg_base_p = r->start;
-	drv_data->reg_size = size;
-
-	return 0;
-}
-
-static void
-mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
-{
-	if (drv_data->reg_base) {
-		iounmap(drv_data->reg_base);
-		release_mem_region(drv_data->reg_base_p, drv_data->reg_size);
-	}
-
-	drv_data->reg_base = NULL;
-	drv_data->reg_base_p = 0;
-}
-
 #ifdef CONFIG_OF
 static int
 mv64xxx_calc_freq(const int tclk, const int n, const int m)
@@ -610,6 +574,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 {
 	struct mv64xxx_i2c_data		*drv_data;
 	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
+	struct resource	*r;
 	int	rc;
 
 	if ((!pdata && !pd->dev.of_node))
@@ -619,9 +584,12 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	if (!drv_data)
 		return -ENOMEM;
 
-	rc = mv64xxx_i2c_map_regs(pd, drv_data);
-	if (rc)
+	r = platform_get_resource(pd, IORESOURCE_MEM, 0);
+	drv_data->reg_base = devm_ioremap_resource(&pd->dev, r);
+	if (IS_ERR(drv_data->reg_base)) {
+		rc = PTR_ERR(drv_data->reg_base);
 		goto exit_kfree;
+	}
 
 	strlcpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
 		sizeof(drv_data->adapter.name));
@@ -690,7 +658,6 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		clk_unprepare(drv_data->clk);
 	}
 #endif
-		mv64xxx_i2c_unmap_regs(drv_data);
 	exit_kfree:
 		kfree(drv_data);
 	return rc;
@@ -704,7 +671,6 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 
 	rc = i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
-	mv64xxx_i2c_unmap_regs(drv_data);
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
 	if (!IS_ERR(drv_data->clk)) {
-- 
1.7.4.4
