From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 7 Apr 2017 13:53:46 +0200
Subject: [PATCH] iio: stm32 trigger: fix sampling_frequency read
Message-ID: <1491566026-302-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When prescaler (PSC) is 0, it means div factor is 1: counter clock
frequency is equal to input clk / (PSC + 1).
When reload value is 8 for example, counter counts 9 cycles, from 0 to 8.
This is handled in frequency write routine, by writing respectively:
- prescaler - 1 to PSC
- reload value - 1 to ARR
This fix does the opposite when reading the frequency from PSC and ARR:
- prescaler is PSC + 1
- reload value is ARR + 1

Thus, PSC may be 0, depending on requested sampling frequency (div 1).
In this case, reading freq wrongly reports 0, instead of computing and
reporting correct value.
Remove test on !psc and !arr.

Small test on stm32f4 (example on tim1_trgo), before this fix:
$ cd /sys/bus/iio/devices/triggerX
$ echo 10000 > sampling_frequency
$ cat sampling_frequency
0

After this fix:
$ echo 10000 > sampling_frequency
$ cat sampling_frequency
10000

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 994b96d..5ee362b 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -152,10 +152,10 @@ static ssize_t stm32_tt_read_frequency(struct device *dev,
 	regmap_read(priv->regmap, TIM_PSC, &psc);
 	regmap_read(priv->regmap, TIM_ARR, &arr);
 
-	if (psc && arr && (cr1 & TIM_CR1_CEN)) {
+	if (cr1 & TIM_CR1_CEN) {
 		freq = (unsigned long long)clk_get_rate(priv->clk);
-		do_div(freq, psc);
-		do_div(freq, arr);
+		do_div(freq, psc + 1);
+		do_div(freq, arr + 1);
 	}
 
 	return sprintf(buf, "%d\n", (unsigned int)freq);
-- 
1.9.1
