From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 21:09:48 +0100
Subject: [PATCH 5/6] i2c/pxa2xx: check timeout correctly
In-Reply-To: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291320589-31570-6-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

timeout here maybe 0 if the event occured and a task with a higher
priority stole the cpu and we were sleeping longer than the timeout
value we specified.
In case of a real timeout I changed the error code to I2C_RETRY so we
retry the transfer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 7c724b2..c2089fe 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -757,8 +757,10 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	 */
 	ret = i2c->msg_idx;
 
-	if (timeout == 0)
+	if (!timeout && i2c->msg_num) {
 		i2c_pxa_scream_blue_murder(i2c, "timeout");
+		ret = I2C_RETRY;
+	}
 
  out:
 	return ret;
-- 
1.7.3.2
