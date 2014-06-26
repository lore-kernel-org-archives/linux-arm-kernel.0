From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 26 Jun 2014 10:44:58 +0530
Subject: [PATCH 2/2 v2] i2c: exynos5: remove extra line and fix an assignment
In-Reply-To: <1403759698-15624-1-git-send-email-ch.naveen@samsung.com>
References: <1403759698-15624-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1403759698-15624-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does the following in exynos5_i2c_message_start() function
1. Fixes an assignment
   As, "i2c_auto_conf" is initialized to '0' at the beginning of the
   function and HSI2C_READ_WRITE is defined as (1u << 16)

   Using "|=" for the first assignment is more readable.

2. Removes an extra line 

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
Changes since v1:
Edited commit message for clarity

 drivers/i2c/busses/i2c-exynos5.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 0d1a7bc..4c2e6f3 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -525,7 +525,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	if (i2c->msg->flags & I2C_M_RD) {
 		i2c_ctl |= HSI2C_RXCHON;
 
-		i2c_auto_conf = HSI2C_READ_WRITE;
+		i2c_auto_conf |= HSI2C_READ_WRITE;
 
 		trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
 			(i2c->variant->fifo_depth * 3 / 4) : i2c->msg->len;
@@ -548,7 +548,6 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	writel(fifo_ctl, i2c->regs + HSI2C_FIFO_CTL);
 	writel(i2c_ctl, i2c->regs + HSI2C_CTL);
 
-
 	/*
 	 * Enable interrupts before starting the transfer so that we don't
 	 * miss any INT_I2C interrupts.
-- 
1.7.9.5
