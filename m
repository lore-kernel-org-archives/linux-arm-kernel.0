From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 15:06:18 +0200
Subject: [PATCH v2 5/5] reset: simple: read back to make sure changes are
 applied
In-Reply-To: <20170811130618.3676-1-p.zabel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
Message-ID: <20170811130618.3676-6-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read back the register after setting or clearing a reset bit to make
sure that the changes are applied to the reset controller hardware.
Theoretically, this avoids the write to stay stuck in a store buffer
during the delay of an assert-delay-deassert sequence, and makes sure
that the reset really is asserted for the specified duration.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Rebased to only modify the reset_simple_set helper function.
---
 drivers/reset/reset-simple.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index d2d6ac483d61d..1324ba45e138b 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -39,17 +39,20 @@ static int reset_simple_set(struct reset_controller_dev *rcdev,
 	int reg_width = sizeof(u32);
 	int bank = id / (reg_width * BITS_PER_BYTE);
 	int offset = id % (reg_width * BITS_PER_BYTE);
+	void __iomem *addr = data->membase + (bank * reg_width);
 	unsigned long flags;
 	u32 reg;
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * reg_width));
+	reg = readl(addr);
 	if (assert ^ data->inverted)
 		reg |= BIT(offset);
 	else
 		reg &= ~BIT(offset);
-	writel(reg, data->membase + (bank * reg_width));
+	writel(reg, addr);
+	/* Read back to make sure the write doesn't linger in a store buffer */
+	readl(addr);
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-- 
2.11.0
