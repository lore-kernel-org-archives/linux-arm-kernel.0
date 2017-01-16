From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 16 Jan 2017 09:57:38 +0100
Subject: [PATCH] rtc: stm32: use 0 instead of ~PWR_CR_DBP in regmap_update_bits
Message-ID: <1484557058-21601-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the ~ operator on a BIT() constant results in a large 'unsigned long'
constant that won't fit into an 'unsigned int' function argument on 64-bit
architectures, resulting in a harmless build warning in x86 allmodconfig:

drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
  regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);

As PWR_CR_DBP mask prevents other bits to be cleared, replace all
~PWR_CR_DBP by 0.

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 8c599f5..03c97c1 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -648,7 +648,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 err:
 	clk_disable_unprepare(rtc->ck_rtc);
 
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
 
 	device_init_wakeup(&pdev->dev, false);
 
@@ -670,7 +670,7 @@ static int stm32_rtc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(rtc->ck_rtc);
 
 	/* Enable backup domain write protection */
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
 
 	device_init_wakeup(&pdev->dev, false);
 
-- 
1.9.1
