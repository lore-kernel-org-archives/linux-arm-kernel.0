From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jan 2016 00:02:13 +0100
Subject: [PATCH] clocksource: ftm: select CLKSRC_MMIO
Message-ID: <11970328.RVc8t0Mk1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ftm clocksource driver does not build if CLKSRC_MMIO is disabled:

drivers/built-in.o: In function `ftm_timer_init':
(init.text+0xd324): undefined reference to `clocksource_mmio_init'
(init.text+0xd484): undefined reference to `clocksource_mmio_readl_up'

This adds the same 'select' statement that the other similar drivers
use. Prior to allowing this driver to be enabled with COMPILE_TEST,
it was apparently unused. I'm not entirely sure who is using this
hardware, but it certainly can't hurt to ensure it builds cleanly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ef49336bbd15 ("clocksource/drivers/fsl-ftm: Add the COMPILE_TEST option")

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b251013eef0a..d3ad9512312b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -256,6 +256,7 @@ config CLKSRC_SAMSUNG_PWM
 config FSL_FTM_TIMER
 	bool "Freescale FlexTimer Module driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
 
