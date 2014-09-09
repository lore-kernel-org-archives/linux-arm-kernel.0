From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  9 Sep 2014 11:30:34 +0200
Subject: [PATCH v2 5/6] rtc: at91sam9: use clk API instead of relying on
 AT91_SLOW_CLOCK
In-Reply-To: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410255035-26775-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTT block is using the slow clock which is accessible through the clk
API.
Use the clk API to retrieve, enable and get the slow clk rate instead of
the AT91_SLOW_CLOCK macro (which hardcodes the slow clk rate).
Doing this allows us to reference the clk thus preventing the CCF from
disabling it during the "disable unused" phase.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 57014b7..a6c498e 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 /*
  * This driver uses two configurable hardware resources that live in the
@@ -59,8 +60,6 @@
 #define AT91_RTT_ALMS		(1 << 0)		/* Real-time Alarm Status */
 #define AT91_RTT_RTTINC		(1 << 1)		/* Real-time Timer Increment */
 
-#define AT91_SLOW_CLOCK		32768
-
 /*
  * We store ALARM_DISABLED in ALMV to record that no alarm is set.
  * It's also the reset value for that field.
@@ -74,6 +73,7 @@ struct sam9_rtc {
 	u32			imr;
 	void __iomem		*gpbr;
 	int 			irq;
+	struct clk		*sclk;
 };
 
 #define rtt_readl(rtc, field) \
@@ -310,6 +310,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	struct sam9_rtc	*rtc;
 	int		ret, irq;
 	u32		mr;
+	unsigned int	sclk_rate;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	r_gpbr = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -348,11 +349,27 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	rtc->sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(rtc->sclk))
+		return PTR_ERR(rtc->sclk);
+
+	sclk_rate = clk_get_rate(rtc->sclk);
+	if (!sclk_rate || sclk_rate > AT91_RTT_RTTRST) {
+		dev_err(&pdev->dev, "Invalid slow clock rate");
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(rtc->sclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not enable slow clock");
+		return ret;
+	}
+
 	mr = rtt_readl(rtc, MR);
 
 	/* unless RTT is counting at 1 Hz, re-initialize it */
-	if ((mr & AT91_RTT_RTPRES) != AT91_SLOW_CLOCK) {
-		mr = AT91_RTT_RTTRST | (AT91_SLOW_CLOCK & AT91_RTT_RTPRES);
+	if ((mr & AT91_RTT_RTPRES) != sclk_rate) {
+		mr = AT91_RTT_RTTRST | (sclk_rate & AT91_RTT_RTPRES);
 		gpbr_writel(rtc, 0);
 	}
 
@@ -397,6 +414,9 @@ static int at91_rtc_remove(struct platform_device *pdev)
 	/* disable all interrupts */
 	rtt_writel(rtc, MR, mr & ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
 
+	if (!IS_ERR(rtc->sclk))
+		clk_disable_unprepare(rtc->sclk);
+
 	return 0;
 }
 
-- 
1.9.1
