From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Sat, 25 Feb 2012 12:55:03 -0700
Subject: [PATCH 2/6] ARM: ux500: Add board autoselection
In-Reply-To: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1330199707-5179-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

At least one platform needs to be selected, so pick the u8500
development board if nothing else is selected. The first
menu to choose the actual platform is meaningless and can be
made invisible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5cfa539..dc488de 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -9,24 +9,20 @@ config UX500_SOC_COMMON
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369
 
-menu "Ux500 SoC"
-
 config UX500_SOC_DB5500
-	bool "DB5500"
+	bool
 	select MFD_DB5500_PRCMU
 
 config UX500_SOC_DB8500
-	bool "DB8500"
+	bool
 	select MFD_DB8500_PRCMU
 	select REGULATOR_DB8500_PRCMU
 
-endmenu
-
 menu "Ux500 target platform (boards)"
 
 config MACH_U8500
 	bool "U8500 Development platform"
-	depends on UX500_SOC_DB8500
+	select UX500_SOC_DB8500
 	select TPS6105X
 	select SOC_BUS
 	help
@@ -34,22 +30,30 @@ config MACH_U8500
 
 config MACH_HREFV60
        bool "U85000 Development platform, HREFv60 version"
-       depends on UX500_SOC_DB8500
+       select UX500_SOC_DB8500
        help
          Include support for the HREFv60 new development platform.
 
 config MACH_SNOWBALL
 	bool "U8500 Snowball platform"
-	depends on UX500_SOC_DB8500
 	select MACH_U8500
 	help
 	  Include support for the snowball development platform.
 
 config MACH_U5500
 	bool "U5500 Development platform"
-	depends on UX500_SOC_DB5500
+	select UX500_SOC_DB5500
 	help
 	  Include support for the U5500 development platform.
+
+config UX500_AUTO_PLATFORM
+	def_bool y
+	depends on !MACH_U5500
+	select MACH_U8500
+	help
+	  At least one platform needs to be selected in order to build
+	  a working kernel. If everything else is disabled, this
+	  automatically enables MACH_U8500.
 endmenu
 
 config UX500_DEBUG_UART
-- 
1.7.5.4
