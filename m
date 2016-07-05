From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  5 Jul 2016 12:17:52 +0200
Subject: [PATCH 3/3] reset: socfpga: use readl/writel_relaxed
In-Reply-To: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
References: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1467713872-4051-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This just removes the rmb()/wmb() pair between register read and
write. Since no relevant reads follow the rmb and no relevant writes
precede the wmb, they should be safe to remove.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-socfpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 78ebf84..4a65128 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -44,8 +44,8 @@ static int socfpga_reset_assert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * NR_BANKS));
-	writel(reg | BIT(offset), data->membase + (bank * NR_BANKS));
+	reg = readl_relaxed(data->membase + (bank * NR_BANKS));
+	writel_relaxed(reg | BIT(offset), data->membase + (bank * NR_BANKS));
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	return 0;
@@ -65,8 +65,8 @@ static int socfpga_reset_deassert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * NR_BANKS));
-	writel(reg & ~BIT(offset), data->membase + (bank * NR_BANKS));
+	reg = readl_relaxed(data->membase + (bank * NR_BANKS));
+	writel_relaxed(reg & ~BIT(offset), data->membase + (bank * NR_BANKS));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-- 
2.8.1
