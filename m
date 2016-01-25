From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:02:49 +0100
Subject: [PATCH] clocksource: select CLKSRC_MMIO where needed
Message-ID: <1453737776-1960372-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra clocksource implementation uses the clocksource_mmio helper
functions, but currently can be configured without them, which fails:

drivers/clocksource/built-in.o: In function `tegra20_init_timer':
:(.init.text+0xac): undefined reference to `clocksource_mmio_init'
:(.init.text+0x140): undefined reference to `clocksource_mmio_readl_up'

The same problem exists for Digicolor:

drivers/clocksource/built-in.o: In function `digicolor_timer_init':
:(.init.text+0xfa): undefined reference to `clocksource_mmio_init'
:(.init.text+0x14c): undefined reference to `clocksource_mmio_readl_down'

I've inspected the Kconfig file to look for other cases that I have not
yet run into, and added an explicit 'select' to each one to ensure we
can successfully link the drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 56777f04d2d9..f70b4f3b4857 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -30,6 +30,7 @@ config CLKSRC_MMIO
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
 	help
 	  Enables the support for the digicolor timer driver.
 
@@ -55,6 +56,7 @@ config ARMADA_370_XP_TIMER
 	bool "Armada 370 and XP timer driver" if COMPILE_TEST
 	depends on ARM
 	select CLKSRC_OF
+	select CLKSRC_MMIO
 	help
 	  Enables the support for the Armada 370 and XP timer driver.
 
@@ -89,6 +91,7 @@ config SUN5I_HSTIMER
 
 config TEGRA_TIMER
 	bool "Tegra timer driver" if COMPILE_TEST
+	select CLKSRC_MMIO
 	depends on ARM
 	help
 	  Enables support for the Tegra driver.
@@ -263,6 +266,7 @@ config FSL_FTM_TIMER
 
 config VF_PIT_TIMER
 	bool
+	select CLKSRC_MMIO
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
 
@@ -394,6 +398,7 @@ config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select CLKSRC_OF if OF
 	depends on HAS_IOMEM
+	select CLKSRC_MMIO
 	help
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
-- 
2.7.0
