From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Sep 2017 22:13:05 +0200
Subject: [PATCH] [v2] soc: bcm: brcmstb: fix ARM build errors
Message-ID: <20170911201324.3423067-1-arnd@arndb.de>
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
v2: change Makefile as well
---
 drivers/soc/bcm/brcmstb/Kconfig  | 3 ++-
 drivers/soc/bcm/brcmstb/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
index ee5b4de741b8..01687c26535b 100644
--- a/drivers/soc/bcm/brcmstb/Makefile
+++ b/drivers/soc/bcm/brcmstb/Makefile
@@ -1,2 +1,2 @@
 obj-y				+= common.o biuctrl.o
-obj-y				+= pm/
+obj-$(CONFIG_BRCMSTB_PM)	+= pm/
-- 
2.9.0
