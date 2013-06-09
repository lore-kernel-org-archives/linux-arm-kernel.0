From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sun,  9 Jun 2013 10:36:41 +0800
Subject: [PATCH 1/2] i2c-designware: support no DW_IC_COMP_TYPE platform
In-Reply-To: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
References: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1370745402-11844-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check accessor_flags before reading DW_IC_COMP_TYPE
Give chance to platform no such register

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   24 +++++++++++++-----------
 drivers/i2c/busses/i2c-designware-core.h |    1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c41ca63..80cabbd 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -286,17 +286,19 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 
 	input_clock_khz = dev->get_clk_rate_khz(dev);
 
-	reg = dw_readl(dev, DW_IC_COMP_TYPE);
-	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
-		/* Configure register endianess access */
-		dev->accessor_flags |= ACCESS_SWAP;
-	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
-		/* Configure register access mode 16bit */
-		dev->accessor_flags |= ACCESS_16BIT;
-	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
-		return -ENODEV;
+	if (!dev->accessor_flags) {
+		reg = dw_readl(dev, DW_IC_COMP_TYPE);
+		if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
+			/* Configure register endianess access */
+			dev->accessor_flags |= ACCESS_SWAP;
+		} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+			/* Configure register access mode 16bit */
+			dev->accessor_flags |= ACCESS_16BIT;
+		} else if (reg != DW_IC_COMP_TYPE_VALUE) {
+			dev_err(dev->dev, "Unknown Synopsys component type: "
+					"0x%08x\n", reg);
+			return -ENODEV;
+		}
 	}
 
 	/* Disable the adapter */
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e761ad1..b38b54e 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -94,6 +94,7 @@ struct dw_i2c_dev {
 
 #define ACCESS_SWAP		0x00000001
 #define ACCESS_16BIT		0x00000002
+#define ACCESS_32BIT		0x00000004
 
 extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
 extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
-- 
1.7.9.5
