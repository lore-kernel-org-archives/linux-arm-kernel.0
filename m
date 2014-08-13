From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Aug 2014 19:33:39 +0800
Subject: [PATCH v5 2/7] regulator: core: factor out delay function from
 _regulator_do_enable
In-Reply-To: <1407929624-8737-1-git-send-email-guodong.xu@linaro.org>
References: <1407929624-8737-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1407929624-8737-3-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common delay function can be helpful when implementing new features. Factor
it out to maximize code reusability.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/regulator/core.c | 74 ++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index eb6f172..67d4246 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1753,6 +1753,45 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	return 0;
 }
 
+/**
+ * _regulator_enable_delay - a delay helper function
+ * @delay: time to delay in microseconds
+ *
+ * Delay for the requested amount of time as per the guidelines in:
+ *
+ *     Documentation/timers/timers-howto.txt
+ *
+ * The assumption here is that regulators will never be enabled in
+ * atomic context and therefore sleeping functions can be used.
+ */
+static void _regulator_enable_delay(unsigned int delay)
+{
+	unsigned int ms = delay / 1000;
+	unsigned int us = delay % 1000;
+
+	if (ms > 0) {
+		/*
+		 * For small enough values, handle super-millisecond
+		 * delays in the usleep_range() call below.
+		 */
+		if (ms < 20)
+			us += ms * 1000;
+		else
+			msleep(ms);
+	}
+
+	/*
+	 * Give the scheduler some room to coalesce with any other
+	 * wakeup sources. For delays shorter than 10 us, don't even
+	 * bother setting up high-resolution timers and just busy-
+	 * loop.
+	 */
+	if (us >= 10)
+		usleep_range(us, us + 100);
+	else
+		udelay(us);
+}
+
 static int _regulator_do_enable(struct regulator_dev *rdev)
 {
 	int ret, delay;
@@ -1786,40 +1825,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	 * together.  */
 	trace_regulator_enable_delay(rdev_get_name(rdev));
 
-	/*
-	 * Delay for the requested amount of time as per the guidelines in:
-	 *
-	 *     Documentation/timers/timers-howto.txt
-	 *
-	 * The assumption here is that regulators will never be enabled in
-	 * atomic context and therefore sleeping functions can be used.
-	 */
-	if (delay) {
-		unsigned int ms = delay / 1000;
-		unsigned int us = delay % 1000;
-
-		if (ms > 0) {
-			/*
-			 * For small enough values, handle super-millisecond
-			 * delays in the usleep_range() call below.
-			 */
-			if (ms < 20)
-				us += ms * 1000;
-			else
-				msleep(ms);
-		}
-
-		/*
-		 * Give the scheduler some room to coalesce with any other
-		 * wakeup sources. For delays shorter than 10 us, don't even
-		 * bother setting up high-resolution timers and just busy-
-		 * loop.
-		 */
-		if (us >= 10)
-			usleep_range(us, us + 100);
-		else
-			udelay(us);
-	}
+	_regulator_enable_delay(delay);
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
-- 
1.9.1
