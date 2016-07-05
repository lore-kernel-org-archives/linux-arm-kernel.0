From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  5 Jul 2016 12:17:51 +0200
Subject: [PATCH 2/3] reset: sunxi: use readl/writel_relaxed
In-Reply-To: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
References: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1467713872-4051-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This just removes the rmb()/wmb() pair between register read and
write. Since no relevant reads follow the rmb and no relevant writes
precede the wmb, they should be safe to remove.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-sunxi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 3080190..7a35950 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -41,8 +41,8 @@ static int sunxi_reset_assert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * 4));
-	writel(reg & ~BIT(offset), data->membase + (bank * 4));
+	reg = readl_relaxed(data->membase + (bank * 4));
+	writel_relaxed(reg & ~BIT(offset), data->membase + (bank * 4));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -62,8 +62,8 @@ static int sunxi_reset_deassert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * 4));
-	writel(reg | BIT(offset), data->membase + (bank * 4));
+	reg = readl_relaxed(data->membase + (bank * 4));
+	writel_relaxed(reg | BIT(offset), data->membase + (bank * 4));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-- 
2.8.1
