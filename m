From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 11 Aug 2013 19:04:30 +0800
Subject: [PATCH v2 3/4] iio: at91: ADC start-up time calculation changed since
 at91sam9x5
In-Reply-To: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1376219071-29946-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed.
This patch can choose different start up time calculation formula for different
chips.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v1 --> v2:
  add a new variable for different start_time calculation.

 drivers/iio/adc/at91_adc.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index b41eb60..9b0ffff 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -40,6 +40,7 @@
 	(writel_relaxed(val, st->reg_base + reg))
 
 struct at91_adc_caps {
+	bool	start_time_use_lookup_tab;
 	u32	mr_prescal_mask;
 	u32	mr_startup_mask;
 };
@@ -700,13 +701,39 @@ static int at91_adc_probe(struct platform_device *pdev)
 		goto error_disable_adc_clk;
 	}
 
-	/*
-	 * Number of ticks needed to cover the startup time of the ADC as
-	 * defined in the electrical characteristics of the board, divided by 8.
-	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
-	 */
-	ticks = round_up((st->startup_time * adc_clk_khz /
-			  1000) - 1, 8) / 8;
+	if (!st->caps->start_time_use_lookup_tab) {
+		/*
+		 * Number of ticks needed to cover the startup time of the ADC
+		 * as defined in the electrical characteristics of the board,
+		 * divided by 8. The formula thus is :
+		 *   Startup Time = (ticks + 1) * 8 / ADC Clock
+		 */
+		ticks = round_up((st->startup_time * adc_clk_khz /
+				  1000) - 1, 8) / 8;
+	} else {
+		/*
+		 * For sama5d3x and at91sam9x5, the formula changes to:
+		 * Startup Time = <lookup_table_value> / ADC Clock
+		 */
+		const int startup_lookup[] = {
+			0  , 8  , 16 , 24 ,
+			64 , 80 , 96 , 112,
+			512, 576, 640, 704,
+			768, 832, 896, 960
+			};
+
+		int i, size = ARRAY_SIZE(startup_lookup);
+		ticks = st->startup_time * adc_clk_khz / 1000;
+		for (i = 0; i < size; i++)
+			if (ticks < startup_lookup[i])
+				break;
+
+		ticks = i;
+		if (ticks == size)
+			/* Reach the end of lookup table */
+			ticks = size - 1;
+	}
+
 	/*
 	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
 	 * the best converted final value between two channels selection
@@ -798,6 +825,7 @@ static struct at91_adc_caps at91sam9g45_caps = {
 };
 
 static struct at91_adc_caps at91sam9x5_caps = {
+	.start_time_use_lookup_tab = true,
 	.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,	/* same as 9G45 */
 	.mr_startup_mask = AT91_ADC_STARTUP_9X5,
 };
-- 
1.7.10
