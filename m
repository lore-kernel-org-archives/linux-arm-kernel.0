From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 22 Nov 2011 09:25:09 +0100
Subject: [PATCH 5/7] spi/pl022: disable the PL022 block when unused
Message-ID: <1321950309-4816-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>

Make sure we clear the enable bit when the block is not used.
This will save some energy in certain hardware versions.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Move this patch after the movement of disabling code to workqueue
  at Viresh:s request.
- Add Vireshs Reviewed-by
---
 drivers/spi/spi-pl022.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 8cdf052..82a929f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1513,6 +1513,9 @@ static void pump_messages(struct work_struct *work)
 	spin_lock_irqsave(&pl022->queue_lock, flags);
 	if (list_empty(&pl022->queue) || !pl022->running) {
 		if (pl022->busy) {
+			/* nothing more to do - disable spi/ssp and power off */
+			writew((readw(SSP_CR1(pl022->virtbase)) &
+				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
 			pm_runtime_put(&pl022->adev->dev);
 		}
 		pl022->busy = false;
-- 
1.7.3.2
