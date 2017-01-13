From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jan 2017 16:32:52 +0100
Subject: [PATCH 2/3] rtc: stm32: fix building without CONFIG_OF
In-Reply-To: <20170113153311.2611510-1-arnd@arndb.de>
References: <20170113153311.2611510-1-arnd@arndb.de>
Message-ID: <20170113153311.2611510-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new driver has a stray #ifdef in it that causes a build error:

drivers/rtc/rtc-stm32.c:718:21: error: 'stm32_rtc_of_match' undeclared here (not in a function); did you mean 'stm32_rtc_pm_ops'?

As the #ifdef serves no purpose here, let's just remove it.

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-stm32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 3513e052722f..8c599f52124c 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -490,13 +490,11 @@ static const struct rtc_class_ops stm32_rtc_ops = {
 	.alarm_irq_enable = stm32_rtc_alarm_irq_enable,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id stm32_rtc_of_match[] = {
 	{ .compatible = "st,stm32-rtc" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_rtc_of_match);
-#endif
 
 static int stm32_rtc_init(struct platform_device *pdev,
 			  struct stm32_rtc *rtc)
-- 
2.9.0
