From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:47 +0200
Subject: [PATCH/RFT 02/12] ARM: davinci: hawk: add full constraints for ohci
 plat boot
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-3-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The phy framework requests an optional "phy" regulator. If it does
not find one, it returns -EPROBE_DEFER. In the case of non-DT based boot
for the omap138-lcdk board, this would prevent the usb11 phy to probe
correctly and ohci would not enumerate.

By calling "regulator_has_full_constraints", An error would be returned
instead of DEFER for the "optional" regulator, and the probe of
the phy driver can continue normally without a regulator.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c5cb8d9..1dc6112 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -14,6 +14,7 @@
 #include <linux/console.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -328,6 +329,7 @@ static __init void omapl138_hawk_init(void)
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
 			__func__, ret);
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.7.1
