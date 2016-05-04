From: david.wu@rock-chips.com (David Wu)
Date: Wed,  4 May 2016 22:13:09 +0800
Subject: [PATCH v7 4/9] i2c: rk3x: Move setting STATE_START and add STATE_SETUP
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462371194-5809-5-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v7:
- none

 drivers/i2c/busses/i2c-rk3x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 9eeb4e5..0838fcf 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -87,6 +87,7 @@ struct rk3x_i2c_calced_timings {
 
 enum rk3x_i2c_state {
 	STATE_IDLE,
+	STATE_SETUP,
 	STATE_START,
 	STATE_READ,
 	STATE_WRITE,
@@ -174,6 +175,7 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
 	u32 val;
 
+	i2c->state = STATE_START;
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
@@ -451,6 +453,7 @@ static irqreturn_t rk3x_i2c_irq(int irqno, void *dev_id)
 		rk3x_i2c_handle_stop(i2c, ipd);
 		break;
 	case STATE_IDLE:
+	case STATE_SETUP:
 		break;
 	}
 
@@ -781,7 +784,7 @@ static int rk3x_i2c_setup(struct rk3x_i2c *i2c, struct i2c_msg *msgs, int num)
 
 	i2c->addr = msgs[0].addr;
 	i2c->busy = true;
-	i2c->state = STATE_START;
+	i2c->state = STATE_SETUP;
 	i2c->processed = 0;
 	i2c->error = 0;
 
-- 
1.9.1
