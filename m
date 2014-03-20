From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:11:46 +0000
Subject: [PATCH 4/5] mtd: st_spi_fsm: Allow loop to run at least once before
 giving up CPU
In-Reply-To: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395313907-25318-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 9de753d..921b44a 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -860,8 +860,6 @@ static uint8_t stfsm_wait_busy(struct stfsm *fsm)
 	 */
 	deadline = jiffies + FLASH_MAX_BUSY_WAIT;
 	while (!timeout) {
-		cond_resched();
-
 		if (time_after_eq(jiffies, deadline))
 			timeout = 1;
 
@@ -880,6 +878,8 @@ static uint8_t stfsm_wait_busy(struct stfsm *fsm)
 		if (!timeout)
 			/* Restart */
 			writel(seq->seq_cfg, fsm->base + SPI_FAST_SEQ_CFG);
+
+		cond_resched();
 	}
 
 	dev_err(fsm->dev, "timeout on wait_busy\n");
-- 
1.8.3.2
