From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 17 Jun 2015 18:21:36 +0200
Subject: [PATCH] iio: adc: at91_adc: allow to use full range of startup time
Message-ID: <1434558096-10619-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Leupold <leupold@rsi-elektrotechnik.de>

The DT-Property "atmel,adc-startup-time" is stored in an u8 for a microsecond
value. When trying to increase the value of STARTUP in Register AT91_ADC_MR
some higher values can't be reached.

Change the type in function parameter and private structure field from u8 to
u32.

Signed-off-by: Jan Leupold <leupold@rsi-elektrotechnik.de>
[nicolas.ferre at atmel.com: change commit message, increase u16 to u32 for startup time]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/iio/adc/at91_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 8a0eb4a04fb5..7b40925dd4ff 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -182,7 +182,7 @@ struct at91_adc_caps {
 	u8	ts_pen_detect_sensitivity;
 
 	/* startup time calculate function */
-	u32 (*calc_startup_ticks)(u8 startup_time, u32 adc_clk_khz);
+	u32 (*calc_startup_ticks)(u32 startup_time, u32 adc_clk_khz);
 
 	u8	num_channels;
 	struct at91_adc_reg_desc registers;
@@ -201,7 +201,7 @@ struct at91_adc_state {
 	u8			num_channels;
 	void __iomem		*reg_base;
 	struct at91_adc_reg_desc *registers;
-	u8			startup_time;
+	u32			startup_time;
 	u8			sample_hold_time;
 	bool			sleep_mode;
 	struct iio_trigger	**trig;
@@ -779,7 +779,7 @@ ret:
 	return ret;
 }
 
-static u32 calc_startup_ticks_9260(u8 startup_time, u32 adc_clk_khz)
+static u32 calc_startup_ticks_9260(u32 startup_time, u32 adc_clk_khz)
 {
 	/*
 	 * Number of ticks needed to cover the startup time of the ADC
@@ -790,7 +790,7 @@ static u32 calc_startup_ticks_9260(u8 startup_time, u32 adc_clk_khz)
 	return round_up((startup_time * adc_clk_khz / 1000) - 1, 8) / 8;
 }
 
-static u32 calc_startup_ticks_9x5(u8 startup_time, u32 adc_clk_khz)
+static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
 {
 	/*
 	 * For sama5d3x and at91sam9x5, the formula changes to:
-- 
2.1.3
