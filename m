From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 21 Feb 2010 23:14:03 -0800
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <201002220058.52583.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002212344.39633.anarsoul@gmail.com>
	<20100221225125.GA18604@core.coreip.homeip.net>
	<201002220058.52583.anarsoul@gmail.com>
Message-ID: <20100222071403.GD2095@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2010 at 12:58:48AM +0200, Vasily Khoruzhick wrote:
> ? ????????? ?? 22 ??????? 2010 00:51:25 ????? Dmitry Torokhov ???????:
> > We do put it in WAIT4INT mode rigtht there though so it looks like we
> > just need to move that call (well the original doing WAIT4INT | INT_UP)
> > before we check for pen state.
> 
> And we need to disable WAIT4INT mode in s3c24xx_ts_schedule_read (actually 
> according to spec we need to disable it right after we got interrupt).
> 

So is the below sufficient to make it work? Even if it works aI think we
need to add socke locking around scheduling reads from irq and
callback...

-- 
Dmitry


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/touchscreen/s3c2410_ts.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)


diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 60f18c2..b389648 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -152,9 +152,12 @@ static void s3c24xx_ts_schedule_read(void)
  */
 static irqreturn_t s3c24xx_ts_stylus_irq(int irq, void *dev_id)
 {
-	if (s3c24xx_ts_check_pen_down())
+	if (s3c24xx_ts_check_pen_down()) {
+		/* Reset WAIT4INT state */
+		writel(0, ts.io + S3C2410_ADCTSC);
+
 		s3c24xx_ts_schedule_read();
-	else
+	} else
 		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);
 
 	return IRQ_HANDLED;
@@ -211,14 +214,25 @@ static void s3c24xx_ts_select(struct s3c_adc_client *client, unsigned select)
 		/*
 		 * Conversion is complete, we have desired number of samples.
 		 */
+
+		/*
+		 * We need to be in WAIT4INT mode to successfully check for
+		 * pen state.
+		 */
+		writel(WAIT4INT | INT_UP, ts.io + S3C2410_ADCTSC);
+
 		pen_is_down = s3c24xx_ts_check_pen_down();
 
 		s3c24xx_ts_report_state(pen_is_down);
 
-		if (pen_is_down)
+		if (pen_is_down) {
+			/* Reset WAIT4INT state */
+			writel(0, ts.io + S3C2410_ADCTSC);
+
 			s3c24xx_ts_schedule_read();
-		else
+		} else {
 			writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
+		}
 	}
 }
 
