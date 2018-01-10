From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 10 Jan 2018 18:07:42 +0100
Subject: [PATCH v2 1/2] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180110170743.27082-1-gregory.clement@free-electrons.com>
References: <20180110170743.27082-1-gregory.clement@free-electrons.com>
Message-ID: <20180110170743.27082-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2 functions called from clk_disable_unprepare() already check that
the clock pointer is valid: no need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a832c45276a4..f69066266faa 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -950,9 +950,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 exit_reset:
 	reset_control_assert(drv_data->rstc);
 exit_clk:
-	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk))
-		clk_disable_unprepare(drv_data->clk);
+	clk_disable_unprepare(drv_data->clk);
 
 	return rc;
 }
@@ -965,9 +963,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
 	reset_control_assert(drv_data->rstc);
-	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk))
-		clk_disable_unprepare(drv_data->clk);
+	clk_disable_unprepare(drv_data->clk);
 
 	return 0;
 }
-- 
2.15.1
