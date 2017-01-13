From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jan 2017 16:32:51 +0100
Subject: [PATCH 1/3] rtc: stm32: remove __exit annotation on remove callback
Message-ID: <20170113153311.2611510-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The remove function can be called at runtime for a manual 'unbind'
operation and must not be left out from a built-in driver, as kbuild
complains:

`stm32_rtc_remove' referenced in section `.data.stm32_rtc_driver' of drivers/rtc/rtc-stm32.o: defined in discarded section `.exit.text' of drivers/rtc/rtc-stm32.o

This removes the extraneous annotation.

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index c4789b5a5d81..3513e052722f 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -657,7 +657,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit stm32_rtc_remove(struct platform_device *pdev)
+static int stm32_rtc_remove(struct platform_device *pdev)
 {
 	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
 	unsigned int cr;
-- 
2.9.0
