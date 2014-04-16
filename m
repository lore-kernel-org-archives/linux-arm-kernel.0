From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Apr 2014 20:40:12 +0200
Subject: [PATCH] clocksource: efm32: let CLKSRC_EFM32 select CLKSRC_OF
In-Reply-To: <CAL_JsqKXYOdpCkixBLg8kAXwpkaLHhckJnTkzdNVeOQDYzxK3w@mail.gmail.com>
References: <CAL_JsqKXYOdpCkixBLg8kAXwpkaLHhckJnTkzdNVeOQDYzxK3w@mail.gmail.com>
Message-ID: <1397673612-24247-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The efm32 timer driver is only usable with CLKSRC_OF, so it makes sense
to let its Kconfig symbol select it. For compile coverage testing it's not
needed though, so only select it if ARCH_EFM32 is enabled.

This allows to drop ARCH_EFM32 selecting CLKSRC_OF which is done here
for simplicity, too.

Reported-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig            | 1 -
 drivers/clocksource/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb5af55..e345419fb112 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -424,7 +424,6 @@ config ARCH_EFM32
 	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
 	select ARM_NVIC
-	select CLKSRC_OF
 	select COMMON_CLK
 	select CPU_V7M
 	select GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -80,6 +80,7 @@ config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
 	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
 	select CLKSRC_MMIO
+	select CLKSRC_OF if ARCH_EFM32
 	default ARCH_EFM32
 	help
 	  Support to use the timers of EFM32 SoCs as clock source and clock
-- 
1.9.1
