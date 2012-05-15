From: ki0351.kim@samsung.com (Kyoungil Kim)
Date: Tue, 15 May 2012 19:13:28 +0900
Subject: [PATCH] serial: samsung: Fixed wrong comparison for baudclk_rate
Message-ID: <000101cd3283$5f58eba0$1e0ac2e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

port->baudclk_rate should be compared to the rate of port->baudclk,
because port->baudclk_rate was assigned as the rate of port->baudclk previously.
So to check that the current baudclk rate is same as previous rate,
the target of comparison sholud be the rate of port->baudclk.

Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>	
---
 drivers/tty/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d8b0aee..c4867ea 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1014,10 +1014,10 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 	 * a disturbance in the clock-rate over the change.
 	 */
 
-	if (IS_ERR(port->clk))
+	if (IS_ERR_OR_NULL(port->baudclk))
 		goto exit;
 
-	if (port->baudclk_rate == clk_get_rate(port->clk))
+	if (port->baudclk_rate == clk_get_rate(port->baudclk))
 		goto exit;
 
 	if (val == CPUFREQ_PRECHANGE) {
-- 
1.7.1
