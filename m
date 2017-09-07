From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  7 Sep 2017 15:50:58 +0200
Subject: [PATCH] soc: bcm: brcmstb: fix ARM build errors
Message-ID: <20170907135136.2923775-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the new PM driver on older ARM architectures, we can
run into one of two build errors:

drivers/soc/bcm/brcmstb/pm/pm-arm.c: In function 'brcmstb_do_pmsm_power_down':
drivers/soc/bcm/brcmstb/pm/pm-arm.c:334:2: error: implicit declaration of function 'wfi' [-Werror=implicit-function-declaration]

drivers/soc/bcm/brcmstb/pm/pm-arm.o: In function `brcmstb_pm_s3_finish':
pm-arm.c:(.text+0x860): undefined reference to `cpu_resume'

The first one requires at least ARMv6K, the second one requires the CPU
suspend/resume logic which is not available on some of the older CPUs,
and needs to be selected explicitly.

This adds the extra Kconfig statements to enforce this, limiting
compilation on ARM to the STB platform that is guaranteed to be
ARMv7. We could enable compile-testing for other ARMv7 platforms,
but there seems to be little value as an allmodconfig kernel
already includes it.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/bcm/brcmstb/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
index d05bfce82e71..d36f6e03c1a6 100644
--- a/drivers/soc/bcm/brcmstb/Kconfig
+++ b/drivers/soc/bcm/brcmstb/Kconfig
@@ -4,6 +4,7 @@ config BRCMSTB_PM
 	bool "Support suspend/resume for STB platforms"
 	default y
 	depends on PM
-	depends on ARM || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	select ARM_CPU_SUSPEND if ARM
 
 endif # SOC_BRCMSTB
-- 
2.9.0
