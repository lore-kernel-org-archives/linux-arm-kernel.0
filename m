From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:52 +0800
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@marvell.com>

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig                          |    5 -----
 arch/arm/mach-pxa/Makefile                         |    1 -
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/plat-pxa/Kconfig                          |    5 +++++
 arch/arm/plat-pxa/Makefile                         |    1 +
 .../include/mach => plat-pxa/include/plat}/ssp.h   |    0
 arch/arm/{mach-pxa => plat-pxa}/ssp.c              |    2 +-
 drivers/spi/pxa2xx_spi.c                           |    2 +-
 sound/soc/pxa/pxa-ssp.c                            |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)
 rename arch/arm/{mach-pxa/include/mach => plat-pxa/include/plat}/ssp.h (100%)
 rename arch/arm/{mach-pxa => plat-pxa}/ssp.c (99%)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 8f7eb12..6dd450a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -648,11 +648,6 @@ config PXA_SHARP_Cxx00
 	help
 	  Enable common support for Sharp Cxx00 models
 
-config PXA_SSP
-	tristate
-	help
-	  Enable support for PXA2xx SSP ports
-
 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
 	depends on MACH_TOSA
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index a83aff3..cf57fb2 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_PXA3xx)		+= cpufreq-pxa3xx.o
 endif
 
 # Generic drivers that other drivers may depend upon
-obj-$(CONFIG_PXA_SSP)		+= ssp.o
 
 # SoC-specific code
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 48b10c7..dcb1788 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -40,12 +40,12 @@
 #include <mach/pxa25x.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
-#include <plat/i2c.h>
 #include <mach/irda.h>
 #include <mach/poodle.h>
 #include <mach/pxafb.h>
 #include <mach/sharpsl.h>
 #include <mach/pxa2xx_spi.h>
+#include <plat/i2c.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
diff --git a/arch/arm/plat-pxa/Kconfig b/arch/arm/plat-pxa/Kconfig
index b158e98..da53395 100644
--- a/arch/arm/plat-pxa/Kconfig
+++ b/arch/arm/plat-pxa/Kconfig
@@ -1,3 +1,8 @@
 if PLAT_PXA
 
+config PXA_SSP
+	tristate
+	help
+	  Enable support for PXA2xx SSP ports
+
 endif
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 0264bfb..4aacdd1 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
 
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
+obj-$(CONFIG_PXA_SSP)		+= ssp.o
diff --git a/arch/arm/mach-pxa/include/mach/ssp.h b/arch/arm/plat-pxa/include/plat/ssp.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/ssp.h
rename to arch/arm/plat-pxa/include/plat/ssp.h
diff --git a/arch/arm/mach-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
similarity index 99%
rename from arch/arm/mach-pxa/ssp.c
rename to arch/arm/plat-pxa/ssp.c
index a9b2d3e..5fe2301 100644
--- a/arch/arm/mach-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -32,7 +32,7 @@
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
-#include <mach/ssp.h>
+#include <plat/ssp.h>
 
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index acc431f..4a64da7 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -35,7 +35,7 @@
 #include <asm/delay.h>
 
 #include <mach/dma.h>
-#include <mach/ssp.h>
+#include <plat/ssp.h>
 #include <mach/pxa2xx_spi.h>
 
 MODULE_AUTHOR("Stephen Street");
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b53d81f..4ca9245 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -32,7 +32,7 @@
 #include <mach/hardware.h>
 #include <mach/dma.h>
 #include <mach/audio.h>
-#include <mach/ssp.h>
+#include <plat/ssp.h>
 
 #include "pxa2xx-pcm.h"
 #include "pxa-ssp.h"
-- 
1.6.3.3
