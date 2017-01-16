From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 16 Jan 2017 11:08:53 +0100
Subject: [PATCH] rtc: stm32: fix comparison warnings
Message-ID: <1484561333-12087-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches fixes comparison between signed and unsigned values as it
could produce an incorrect result when the signed value is converted to
unsigned:

drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_valid_alrm':
drivers/rtc/rtc-stm32.c:404:21: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if ((((tm->tm_year > cur_year) &&
...

It also fixes comparison always true or false due to the fact that unsigned
value is compared against zero with >= or <:

drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_init':
drivers/rtc/rtc-stm32.c:514:35: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  for (pred_a = pred_a_max; pred_a >= 0; pred_a-- ) {

drivers/rtc/rtc-stm32.c:530:44: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
     (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 03c97c1..bd57eb1 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -383,7 +383,7 @@ static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
 {
-	unsigned int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
+	int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
 	unsigned int dr = readl_relaxed(rtc->base + STM32_RTC_DR);
 	unsigned int tr = readl_relaxed(rtc->base + STM32_RTC_TR);
 
@@ -509,7 +509,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
 	pred_s_max = STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
 
-	for (pred_a = pred_a_max; pred_a >= 0; pred_a--) {
+	for (pred_a = pred_a_max; pred_a + 1 > 0; pred_a--) {
 		pred_s = (rate / (pred_a + 1)) - 1;
 
 		if (((pred_s + 1) * (pred_a + 1)) == rate)
@@ -525,7 +525,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 		pred_s = (rate / (pred_a + 1)) - 1;
 
 		dev_warn(&pdev->dev, "ck_rtc is %s\n",
-			 (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?
+			 (rate < ((pred_a + 1) * (pred_s + 1))) ?
 			 "fast" : "slow");
 	}
 
-- 
1.9.1
