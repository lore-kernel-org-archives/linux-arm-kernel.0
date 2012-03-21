From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Mar 2012 21:15:49 -0500
Subject: [PATCH 2/2] ARM: pxa: use commom IOMEM definiton
In-Reply-To: <1332296149-28110-1-git-send-email-robherring2@gmail.com>
References: <4F68CD9C.3090001@windriver.com>
 <1332296149-28110-1-git-send-email-robherring2@gmail.com>
Message-ID: <1332296149-28110-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

pxa was missed in the moving of IOMEM to a common defintion, so lots of
IOMEM redefined warnings were introduced. So remove pxa IOMEM definition
and fix all the fallout.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: rtc-linux at googlegroups.com
Cc: alsa-devel at alsa-project.org
---
 arch/arm/mach-pxa/clock-pxa2xx.c          |    1 +
 arch/arm/mach-pxa/corgi_pm.c              |    1 +
 arch/arm/mach-pxa/cpufreq-pxa3xx.c        |    1 +
 arch/arm/mach-pxa/include/mach/hardware.h |    2 --
 arch/arm/mach-pxa/mfp-pxa2xx.c            |    1 +
 arch/arm/mach-pxa/pxa2xx.c                |    1 +
 arch/arm/mach-pxa/pxa300.c                |    1 +
 arch/arm/mach-pxa/pxa320.c                |    1 +
 arch/arm/mach-pxa/sharpsl_pm.c            |    1 +
 drivers/rtc/rtc-sa1100.c                  |    1 +
 sound/arm/pxa2xx-ac97-lib.c               |    1 +
 sound/arm/pxa2xx-ac97.c                   |    1 +
 sound/soc/pxa/pxa2xx-ac97.c               |    1 +
 13 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/clock-pxa2xx.c b/arch/arm/mach-pxa/clock-pxa2xx.c
index 1d5859d..9ee2ad6 100644
--- a/arch/arm/mach-pxa/clock-pxa2xx.c
+++ b/arch/arm/mach-pxa/clock-pxa2xx.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/syscore_ops.h>
 
 #include <mach/pxa2xx-regs.h>
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 39e265c..048c429 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
+#include <linux/io.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
index 88fbec0..b85b4ab 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <mach/pxa3xx-regs.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index 54b64ea..56d92e5 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -40,7 +40,6 @@
 #define io_p2v(x) IOMEM(0xf2000000 + ((x) & 0x01ffffff) + (((x) & 0x1c000000) >> 1))
 
 #ifndef __ASSEMBLY__
-# define IOMEM(x) ((void __iomem *)(x))
 # define __REG(x)	(*((volatile u32 __iomem *)io_p2v(x)))
 
 /* With indexed regs we don't want to feed the index through io_p2v()
@@ -52,7 +51,6 @@
 
 #else
 
-# define IOMEM(x)	x 
 # define __REG(x)	io_p2v(x)
 # define __PREG(x)	io_v2p(x)
 
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index f147755..b029562 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/syscore_ops.h>
 
 #include <mach/pxa2xx-regs.h>
diff --git a/arch/arm/mach-pxa/pxa2xx.c b/arch/arm/mach-pxa/pxa2xx.c
index 8682704..f8ec854 100644
--- a/arch/arm/mach-pxa/pxa2xx.c
+++ b/arch/arm/mach-pxa/pxa2xx.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <mach/pxa2xx-regs.h>
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 40bb165..17cbc0c 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <mach/pxa300.h>
 
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index 8d614ec..6dc99d4 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <mach/pxa320.h>
 
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 8d5168d..6d3b39f 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -24,6 +24,7 @@
 #include <linux/leds.h>
 #include <linux/suspend.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
 
 #include <asm/mach-types.h>
 #include <mach/pm.h>
diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index cb9a585..398ab7a 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -30,6 +30,7 @@
 #include <linux/string.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index d1aa421..d760371 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
 #include <sound/ac97_codec.h>
 #include <sound/pxa2xx-lib.h>
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 3a39626..afef72c 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 837ff34..b4bfd97 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-- 
1.7.5.4
