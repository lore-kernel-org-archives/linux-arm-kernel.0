From: wagi@monom.org (Daniel Wagner)
Date: Wed,  3 Aug 2016 14:03:10 +0200
Subject: [PATCH v0 3/4] i2c: brcmstb: Use complete() instead of complete_all()
In-Reply-To: <1470225791-16613-1-git-send-email-wagi@monom.org>
References: <1470225791-16613-1-git-send-email-wagi@monom.org>
Message-ID: <1470225791-16613-4-git-send-email-wagi@monom.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

There is only one waiter for the completion, therefore there
is no need to use complete_all(). Let's make that clear by
using complete() instead of complete_all().

The usage pattern of the completion is:

brcmstb_send_i2c_cmd()
  reinit_completion()
  ...
  /* initiate transfer by setting iic_enable */
  ...
  brcmstb_i2c_wait_for_completion()

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 drivers/i2c/busses/i2c-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 6a8cfc1..ab4ff96 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -228,7 +228,7 @@ static irqreturn_t brcmstb_i2c_isr(int irq, void *devid)
 		return IRQ_NONE;
 
 	brcmstb_i2c_enable_disable_irq(dev, INT_DISABLE);
-	complete_all(&dev->done);
+	complete(&dev->done);
 
 	dev_dbg(dev->device, "isr handled");
 	return IRQ_HANDLED;
-- 
2.7.4
