From: imr@rtschenk.de (Rojhalat Ibrahim)
Date: Wed, 15 Feb 2017 14:06:08 +0100
Subject: [PATCH] reset-socfpga: Fix nr_resets property
Message-ID: <3302533.E0QKRXBlfc@pcimr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC-FPGA reset controller driver defines NR_BANKS as 4 and uses that define
for two unrelated purposes. It is used
1. as an increment for reset line banks which are 32-bit registers with 4-byte
aligned addresses.
2. as the total number of reset line banks which together with the number of
resets per bank (32) limits the total number of useable resets to 96 and the
highest useable reset ID to 95.

This is clearly wrong as there are resets with higher IDs than 95 defined in
include/dt-bindings/reset/altr,rst-mgr.h and altr,rst-mgr-a10.h.

The patch introduces a new define BANK_INCREMENT for calculating the register
addresses as before and increases NR_BANKS to 6 for useable reset IDs up to 191.

Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
---
 reset-socfpga.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 43e4a9f..1c8e491 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -25,7 +25,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#define NR_BANKS		4
+#define BANK_INCREMENT		4
+#define NR_BANKS		6
 
 struct socfpga_reset_data {
 	spinlock_t			lock;
@@ -46,8 +47,8 @@ static int socfpga_reset_assert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * NR_BANKS));
-	writel(reg | BIT(offset), data->membase + (bank * NR_BANKS));
+	reg = readl(data->membase + (bank * BANK_INCREMENT));
+	writel(reg | BIT(offset), data->membase + (bank * BANK_INCREMENT));
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	return 0;
@@ -67,8 +68,8 @@ static int socfpga_reset_deassert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * NR_BANKS));
-	writel(reg & ~BIT(offset), data->membase + (bank * NR_BANKS));
+	reg = readl(data->membase + (bank * BANK_INCREMENT));
+	writel(reg & ~BIT(offset), data->membase + (bank * BANK_INCREMENT));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -84,7 +85,7 @@ static int socfpga_reset_status(struct reset_controller_dev *rcdev,
 	int offset = id % BITS_PER_LONG;
 	u32 reg;
 
-	reg = readl(data->membase + (bank * NR_BANKS));
+	reg = readl(data->membase + (bank * BANK_INCREMENT));
 
 	return !(reg & BIT(offset));
 }

--
2.10.2
