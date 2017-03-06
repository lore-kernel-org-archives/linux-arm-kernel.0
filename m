From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  6 Mar 2017 01:35:56 +0000
Subject: [PATCH] reset: sunxi: fix for 64-bit compilation
Message-ID: <1488764156-22197-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner reset controller has 32-bit registers, so translating
the reset cell number into a register and bit offset should not use
any architecture dependent data size. Otherwise this breaks for 64-bit
architectures like arm64.
Fix this by making it clear that it's the hardware register width which
matters here in the calculation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/reset/reset-sunxi.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index b44f6b5..cd585cd 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -34,15 +34,16 @@ static int sunxi_reset_assert(struct reset_controller_dev *rcdev,
 	struct sunxi_reset_data *data = container_of(rcdev,
 						     struct sunxi_reset_data,
 						     rcdev);
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
 	unsigned long flags;
 	u32 reg;
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * 4));
-	writel(reg & ~BIT(offset), data->membase + (bank * 4));
+	reg = readl(data->membase + (bank * reg_width));
+	writel(reg & ~BIT(offset), data->membase + (bank * reg_width));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -55,15 +56,16 @@ static int sunxi_reset_deassert(struct reset_controller_dev *rcdev,
 	struct sunxi_reset_data *data = container_of(rcdev,
 						     struct sunxi_reset_data,
 						     rcdev);
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
 	unsigned long flags;
 	u32 reg;
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * 4));
-	writel(reg | BIT(offset), data->membase + (bank * 4));
+	reg = readl(data->membase + (bank * reg_width));
+	writel(reg | BIT(offset), data->membase + (bank * reg_width));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-- 
2.8.2
