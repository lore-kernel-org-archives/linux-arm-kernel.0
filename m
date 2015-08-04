From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 4 Aug 2015 19:44:52 +0800
Subject: [PATCH 1/2] i2c: mediatek: Reset DMA engine in hardware init function
In-Reply-To: <1438688693-60275-1-git-send-email-eddie.huang@mediatek.com>
References: <1438688693-60275-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1438688693-60275-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset DMA in hardware init function to avoid unknown hardware state
before do any I2C operation.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 9920eef..055159d 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1,6 +1,8 @@
 /*
  * Copyright (c) 2014 MediaTek Inc.
- * Author: Xudong Chen <xudong.chen@mediatek.com>
+ * Author:
+ *   Xudong Chen <xudong.chen@mediatek.com>
+ *   Liguo Zhang <liguo.zhang@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -59,6 +61,7 @@
 #define I2C_DMA_START_EN		0x0001
 #define I2C_DMA_INT_FLAG_NONE		0x0000
 #define I2C_DMA_CLR_FLAG		0x0000
+#define I2C_DMA_HARD_RST		0x0002
 
 #define I2C_DEFAULT_SPEED		100000	/* hz */
 #define MAX_FS_MODE_SPEED		400000
@@ -81,6 +84,7 @@ enum DMA_REGS_OFFSET {
 	OFFSET_INT_FLAG = 0x0,
 	OFFSET_INT_EN = 0x04,
 	OFFSET_EN = 0x08,
+	OFFSET_RST = 0x0c,
 	OFFSET_CON = 0x18,
 	OFFSET_TX_MEM_ADDR = 0x1c,
 	OFFSET_RX_MEM_ADDR = 0x20,
@@ -262,6 +266,10 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
 	writew(control_reg, i2c->base + OFFSET_CONTROL);
 	writew(I2C_DELAY_LEN, i2c->base + OFFSET_DELAY_LEN);
+
+	writel(I2C_DMA_HARD_RST, i2c->pdmabase + OFFSET_RST);
+	udelay(50);
+	writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_RST);
 }
 
 /*
-- 
1.7.9.5
