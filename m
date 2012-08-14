From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 14 Aug 2012 19:49:03 +0530
Subject: [PATCHv6 21/24] i2c: omap: remove unnecessary pm_runtime_suspended
 check
In-Reply-To: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1344953946-13005-22-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

before starting any messages we call pm_runtime_get_sync()
which will make sure that by the time we program a transfer
and our IRQ handler gets called, we're not suspended
anymore.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 39e5d36..2d5db56 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -883,9 +883,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	u16 stat;
 	int err = 0, count = 0;
 
-	if (pm_runtime_suspended(dev->dev))
-		return IRQ_HANDLED;
-
 	spin_lock_irqsave(&dev->lock, flags);
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-- 
1.7.5.4
