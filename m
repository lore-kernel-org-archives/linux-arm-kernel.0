From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Wed, 26 Oct 2016 21:41:55 +0200
Subject: [PATCH] ARM: davinci: Add full regulator constraints for non-DT boot
Message-ID: <20161026194155.14304-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The phy framework requests an optional "phy" regulator. If it does
not find one, it returns -EPROBE_DEFER. In the case of non-DT boot
for the omap138-lcdk board, this would prevent the usb11 phy to probe
correctly and ohci would not enumerate.

By calling "regulator_has_full_constraints", An error would be returned
instead of DEFER for the regulator, and the probe of the phy driver can
continue normally without a regulator.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---

This applies cleanly after David's recent patches:

[PATCH v6 0/5] da8xx USB PHY platform devices and clocks
https://lkml.org/lkml/2016/10/25/867

 arch/arm/mach-davinci/board-da830-evm.c     | 3 +++
 arch/arm/mach-davinci/board-omapl138-hawk.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c62766e..b33fc6b 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -26,6 +26,7 @@
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -631,6 +632,8 @@ static __init void da830_evm_init(void)
 	ret = da8xx_register_spi_bus(0, ARRAY_SIZE(da830evm_spi_info));
 	if (ret)
 		pr_warn("%s: spi 0 registration failed: %d\n", __func__, ret);
+
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c5cb8d9..c3ab7ea 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -14,6 +14,7 @@
 #include <linux/console.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -328,6 +329,8 @@ static __init void omapl138_hawk_init(void)
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
 			__func__, ret);
+
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.9.1
