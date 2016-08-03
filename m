From: wagi@monom.org (Daniel Wagner)
Date: Wed,  3 Aug 2016 14:03:09 +0200
Subject: [PATCH v0 2/4] i2c: bcm-kona: Use complete() instead of complete_all()
In-Reply-To: <1470225791-16613-1-git-send-email-wagi@monom.org>
References: <1470225791-16613-1-git-send-email-wagi@monom.org>
Message-ID: <1470225791-16613-3-git-send-email-wagi@monom.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

There is only one waiter for the completion, therefore there
is no need to use complete_all(). Let's make that clear by
using complete() instead of complete_all().

The usage pattern of the completion is:

bcm_kona_send_i2c_cmd()
  reinit_completion()
  ...
  bcm_kona_i2c_send_cmd_to_ctrl()
  ...
  wait_for_completion_timeout()

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index ac9f476..f987432 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -229,7 +229,7 @@ static irqreturn_t bcm_kona_i2c_isr(int irq, void *devid)
 		       dev->base + TXFCR_OFFSET);
 
 	writel(status & ~ISR_RESERVED_MASK, dev->base + ISR_OFFSET);
-	complete_all(&dev->done);
+	complete(&dev->done);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4
