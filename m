From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:04:46 +0100
Subject: [PATCH] rtc: mt6397: add IRQ domain dependency
Message-ID: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt6397 RTC driver can be built either when the MFD_MT6397 driver
is enabled (which selects IRQ_DOMAIN), or when compile testing.
The latter however fails without IRQ domains:

drivers/rtc/rtc-mt6397.c: In function 'mtk_rtc_probe':
drivers/rtc/rtc-mt6397.c:326:13: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
  rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);

This adds an explicit dependency for the COMPILE_TEST case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f71fd5..4395608bf7fc 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1603,7 +1603,7 @@ config RTC_DRV_MOXART
 
 config RTC_DRV_MT6397
 	tristate "Mediatek Real Time Clock driver"
-	depends on MFD_MT6397 || COMPILE_TEST
+	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
 	help
 	  This selects the Mediatek(R) RTC driver. RTC is part of Mediatek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
-- 
2.7.0
