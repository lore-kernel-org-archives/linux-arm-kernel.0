From: wagi@monom.org (Daniel Wagner)
Date: Wed,  3 Aug 2016 14:03:11 +0200
Subject: [PATCH v0 4/4] i2c: meson: Use complete() instead of complete_all()
In-Reply-To: <1470225791-16613-1-git-send-email-wagi@monom.org>
References: <1470225791-16613-1-git-send-email-wagi@monom.org>
Message-ID: <1470225791-16613-5-git-send-email-wagi@monom.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

There is only one waiter for the completion, therefore there
is no need to use complete_all(). Let's make that clear by
using complete() instead of complete_all().

The usage pattern of the completion is:

meson_i2c_xfer_msg()
  reinit_completion()
  ...
  /* Start the transfer */
  ...
  wait_for_completion_timeout()

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 drivers/i2c/busses/i2c-meson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 71d3929..76e2898 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -211,7 +211,7 @@ static void meson_i2c_stop(struct meson_i2c *i2c)
 		meson_i2c_add_token(i2c, TOKEN_STOP);
 	} else {
 		i2c->state = STATE_IDLE;
-		complete_all(&i2c->done);
+		complete(&i2c->done);
 	}
 }
 
@@ -238,7 +238,7 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		dev_dbg(i2c->dev, "error bit set\n");
 		i2c->error = -ENXIO;
 		i2c->state = STATE_IDLE;
-		complete_all(&i2c->done);
+		complete(&i2c->done);
 		goto out;
 	}
 
@@ -269,7 +269,7 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		break;
 	case STATE_STOP:
 		i2c->state = STATE_IDLE;
-		complete_all(&i2c->done);
+		complete(&i2c->done);
 		break;
 	case STATE_IDLE:
 		break;
-- 
2.7.4
