From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:47:44 +0100
Subject: [PATCH 2/9] ARM: imx: MACH_MX31ADS_WM1133_EV1 needs REGULATOR_WM8350
In-Reply-To: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
Message-ID: <1360882071-4072668-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_MX31ADS_WM1133_EV1 already depends on REGULATOR_WM8350,
but that still allows REGULATOR_WM8350 to be a loadable
module. Depending on REGULATOR_WM8350 to be built-in
ensures we cannot create a broken configuration.

Without this patch, building allmodconfig results in:

arch/arm/mach-imx/built-in.o: In function `mx31_wm8350_init':
arch/arm/mach-imx/mach-mx31ads.c:461: undefined reference to `wm8350_register_regulator'
arch/arm/mach-imx/mach-mx31ads.c:471: undefined reference to `wm8350_dcdc_set_slot'
arch/arm/mach-imx/mach-mx31ads.c:473: undefined reference to `wm8350_isink_set_flash'
arch/arm/mach-imx/mach-mx31ads.c:480: undefined reference to `wm8350_dcdc25_set_mode'
arch/arm/mach-imx/mach-mx31ads.c:485: undefined reference to `wm8350_register_led'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7b11d33..4c9c6f9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -480,7 +480,7 @@ config MACH_MX31ADS_WM1133_EV1
 	bool "Support Wolfson Microelectronics 1133-EV1 module"
 	depends on MACH_MX31ADS
 	depends on MFD_WM8350_I2C
-	depends on REGULATOR_WM8350
+	depends on REGULATOR_WM8350 = y
 	select MFD_WM8350_CONFIG_MODE_0
 	select MFD_WM8352_CONFIG_MODE_0
 	help
-- 
1.8.1.2
