From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  6 Sep 2016 14:19:29 +0200
Subject: [PATCH] mfd: atmel-hlcdc: Do not sleep in atomic context
Message-ID: <1473164369-10033-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

readl_poll_timeout() calls usleep_range(), but
regmap_atmel_hlcdc_reg_write() is called in atomic context (regmap
spinlock held).

Replace the readl_poll_timeout() call by readl_poll_timeout_atomic().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: ea31c0cf9b07 ("mfd: atmel-hlcdc: Implement config synchronization")
Cc: <stable@vger.kernel.org>
---
 drivers/mfd/atmel-hlcdc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index eca7ea69b81c..4b15b0840f16 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -50,8 +50,9 @@ static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
 	if (reg <= ATMEL_HLCDC_DIS) {
 		u32 status;
 
-		readl_poll_timeout(hregmap->regs + ATMEL_HLCDC_SR, status,
-				   !(status & ATMEL_HLCDC_SIP), 1, 100);
+		readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
+					  status, !(status & ATMEL_HLCDC_SIP),
+					  1, 100);
 	}
 
 	writel(val, hregmap->regs + reg);
-- 
2.7.4
