From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 15 Nov 2012 17:43:32 +0530
Subject: [PATCH 3/4] i2c-s3c2410: use exponential back off while polling for
 bus idle
In-Reply-To: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
References: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1352981613-2098-4-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

Usually, the i2c controller has finished emitting the i2c STOP before the
driver reaches the bus idle polling loop.  Optimize for this most common
case by reading IICSTAT first and potentially skipping the loop.

If the cpu is faster than the hardware, we wait for bus idle in a polling
loop.  However, since the duration of one iteration of the loop is
dependent on cpu freq, and this i2c IP is used on many different systems,
use a time based loop timeout (5 ms).

We would like very low latencies to detect bus idle for the normal
'fast' case.  However, if a device is slow to release the bus for some
reason, it could hold off the STOP generation for up to several
milliseconds.  Rapidly polling for bus idle would seriously load the CPU
while waiting for it to release the bus.  So, use a partial exponential
backoff as a compromise between idle detection latency and cpu load.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Cc: Olof Johansson <olofj@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/i2c/busses/i2c-s3c2410.c |   67 ++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index fc4bf35..362a307 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -49,6 +49,9 @@
 #define QUIRK_HDMIPHY		(1 << 1)
 #define QUIRK_NO_GPIO		(1 << 2)
 
+/* Max time to wait for bus to become idle after a xfer (in us) */
+#define S3C2410_IDLE_TIMEOUT	5000
+
 /* i2c controller state */
 enum s3c24xx_i2c_state {
 	STATE_IDLE,
@@ -556,6 +559,48 @@ static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 	return -ETIMEDOUT;
 }
 
+/* s3c24xx_i2c_wait_idle
+ *
+ * wait for the i2c bus to become idle.
+*/
+
+static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
+{
+	unsigned long iicstat;
+	ktime_t start, now;
+	unsigned long delay;
+
+	/* ensure the stop has been through the bus */
+
+	dev_dbg(i2c->dev, "waiting for bus idle\n");
+
+	start = now = ktime_get();
+
+	/*
+	 * Most of the time, the bus is already idle within a few usec of the
+	 * end of a transaction.  However, really slow i2c devices can stretch
+	 * the clock, delaying STOP generation.
+	 *
+	 * As a compromise between idle detection latency for the normal, fast
+	 * case, and system load in the slow device case, use an exponential
+	 * back off in the polling loop, up to 1/10th of the total timeout,
+	 * then continue to poll at a constant rate up to the timeout.
+	 */
+	iicstat = readl(i2c->regs + S3C2410_IICSTAT);
+	delay = 1;
+	while ((iicstat & S3C2410_IICSTAT_START) &&
+	       ktime_us_delta(now, start) < S3C2410_IDLE_TIMEOUT) {
+		usleep_range(delay, 2 * delay);
+		if (delay < S3C2410_IDLE_TIMEOUT / 10)
+			delay <<= 1;
+		now = ktime_get();
+		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
+	}
+
+	if (iicstat & S3C2410_IICSTAT_START)
+		dev_warn(i2c->dev, "timeout waiting for bus idle\n");
+}
+
 /* s3c24xx_i2c_doxfer
  *
  * this starts an i2c transfer
@@ -564,8 +609,7 @@ static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 			      struct i2c_msg *msgs, int num)
 {
-	unsigned long iicstat, timeout;
-	int spins = 20;
+	unsigned long timeout;
 	int ret;
 
 	if (i2c->suspended)
@@ -603,24 +647,7 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	if (i2c->quirks & QUIRK_HDMIPHY)
 		goto out;
 
-	/* ensure the stop has been through the bus */
-
-	dev_dbg(i2c->dev, "waiting for bus idle\n");
-
-	/* first, try busy waiting briefly */
-	do {
-		cpu_relax();
-		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
-	} while ((iicstat & S3C2410_IICSTAT_START) && --spins);
-
-	/* if that timed out sleep */
-	if (!spins) {
-		msleep(1);
-		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
-	}
-
-	if (iicstat & S3C2410_IICSTAT_START)
-		dev_warn(i2c->dev, "timeout waiting for bus idle\n");
+	s3c24xx_i2c_wait_idle(i2c);
 
  out:
 	return ret;
-- 
1.7.9.5
