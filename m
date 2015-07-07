From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jul 2015 19:16:43 +0200
Subject: [PATCH v3] mfd: atmel-hlcdc: implement config synchronization
Message-ID: <1436289403-20524-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some HLCDC registers cannot be written until the hardware has finished
applying the previous configuration request. If they are written while
an action is still in progress, the new configuration might be silently
ignored, resulting in unpredictable behavior.

Hide the config synchronization stuff in a regmap implementation and use
this implementation instead of the generic mmio one.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

---
Changes since v2:
 - reword the commit message

Changes since v1:
 - add a 100 usec timeout
---
 drivers/mfd/atmel-hlcdc.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index cfd58f4..04e01cc 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 #include <linux/mfd/atmel-hlcdc.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
@@ -37,11 +38,41 @@ static const struct mfd_cell atmel_hlcdc_cells[] = {
 	},
 };
 
+static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
+					unsigned int val)
+{
+	void __iomem *regs = context;
+
+	if (reg <= ATMEL_HLCDC_DIS) {
+		u32 status;
+
+		readl_poll_timeout(regs + ATMEL_HLCDC_SR, status,
+				   !(status & ATMEL_HLCDC_SIP), 1, 100);
+	}
+
+	writel(val, regs + reg);
+
+	return 0;
+}
+
+static int regmap_atmel_hlcdc_reg_read(void *context, unsigned int reg,
+				       unsigned int *val)
+{
+	void __iomem *regs = context;
+
+	*val = readl(regs + reg);
+
+	return 0;
+}
+
 static const struct regmap_config atmel_hlcdc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = ATMEL_HLCDC_REG_MAX,
+	.reg_write = regmap_atmel_hlcdc_reg_write,
+	.reg_read = regmap_atmel_hlcdc_reg_read,
+	.fast_io = true,
 };
 
 static int atmel_hlcdc_probe(struct platform_device *pdev)
@@ -82,8 +113,8 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 		return PTR_ERR(hlcdc->slow_clk);
 	}
 
-	hlcdc->regmap = devm_regmap_init_mmio(dev, regs,
-					      &atmel_hlcdc_regmap_config);
+	hlcdc->regmap = devm_regmap_init(dev, NULL, regs,
+					 &atmel_hlcdc_regmap_config);
 	if (IS_ERR(hlcdc->regmap))
 		return PTR_ERR(hlcdc->regmap);
 
-- 
1.9.1
