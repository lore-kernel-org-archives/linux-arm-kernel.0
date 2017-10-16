From: keescook@chromium.org (Kees Cook)
Date: Mon, 16 Oct 2017 16:27:29 -0700
Subject: [PATCH] i2c/busses: Convert timers to use timer_setup()
Message-ID: <20171016232729.GA101069@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-i2c at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/i2c/busses/i2c-img-scb.c | 7 +++----
 drivers/i2c/busses/i2c-pnx.c     | 8 +++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index eb1d91b986fd..823b0b33b2cb 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -826,9 +826,9 @@ static unsigned int img_i2c_atomic(struct img_i2c *i2c,
  * Timer function to check if something has gone wrong in automatic mode (so we
  * don't have to handle so many interrupts just to catch an exception).
  */
-static void img_i2c_check_timer(unsigned long arg)
+static void img_i2c_check_timer(struct timer_list *t)
 {
-	struct img_i2c *i2c = (struct img_i2c *)arg;
+	struct img_i2c *i2c = from_timer(i2c, t, check_timer);
 	unsigned long flags;
 	unsigned int line_status;
 
@@ -1362,8 +1362,7 @@ static int img_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Set up the exception check timer */
-	setup_timer(&i2c->check_timer, img_i2c_check_timer,
-		    (unsigned long)i2c);
+	timer_setup(&i2c->check_timer, img_i2c_check_timer, 0);
 
 	i2c->bitrate = timings[0].max_bitrate;
 	if (!of_property_read_u32(node, "clock-frequency", &val))
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 42d6b3a226f8..a542041df0cd 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -112,7 +112,6 @@ static inline void i2c_pnx_arm_timer(struct i2c_pnx_algo_data *alg_data)
 		jiffies, expires);
 
 	timer->expires = jiffies + expires;
-	timer->data = (unsigned long)alg_data;
 
 	add_timer(timer);
 }
@@ -435,9 +434,9 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void i2c_pnx_timeout(unsigned long data)
+static void i2c_pnx_timeout(struct timer_list *t)
 {
-	struct i2c_pnx_algo_data *alg_data = (struct i2c_pnx_algo_data *)data;
+	struct i2c_pnx_algo_data *alg_data = from_timer(alg_data, t, mif.timer);
 	u32 ctl;
 
 	dev_err(&alg_data->adapter.dev,
@@ -659,8 +658,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (IS_ERR(alg_data->clk))
 		return PTR_ERR(alg_data->clk);
 
-	setup_timer(&alg_data->mif.timer, i2c_pnx_timeout,
-			(unsigned long)alg_data);
+	timer_setup(&alg_data->mif.timer, i2c_pnx_timeout, 0);
 
 	snprintf(alg_data->adapter.name, sizeof(alg_data->adapter.name),
 		 "%s", pdev->name);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
