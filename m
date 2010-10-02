From: robherring2@gmail.com (Rob Herring)
Date: Sat,  2 Oct 2010 09:34:44 -0500
Subject: [PATCH v2 1/3] ARM: move timer-sp.c from versatile to common
In-Reply-To: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
References: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
Message-ID: <1286030086-25556-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@smooth-stone.com>

The timer-sp h/w used on versatile platforms can also be used for other
platforms, so move it to a common location.

Signed-off-by: Rob Herring <rob.herring@smooth-stone.com>
---
 arch/arm/common/Makefile                           |    1 +
 arch/arm/{plat-versatile => common}/timer-sp.c     |    4 +---
 .../plat => include/asm/hardware}/timer-sp.h       |    0
 arch/arm/mach-integrator/integrator_cp.c           |    2 +-
 arch/arm/mach-realview/core.c                      |    2 +-
 arch/arm/mach-versatile/core.c                     |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    2 +-
 arch/arm/mach-vexpress/v2m.c                       |    2 +-
 arch/arm/plat-versatile/Makefile                   |    1 -
 9 files changed, 7 insertions(+), 9 deletions(-)
 rename arch/arm/{plat-versatile => common}/timer-sp.c (98%)
 rename arch/arm/{plat-versatile/include/plat => include/asm/hardware}/timer-sp.h (100%)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e6e8664..e7521bc 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
+obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
diff --git a/arch/arm/plat-versatile/timer-sp.c b/arch/arm/common/timer-sp.c
similarity index 98%
rename from arch/arm/plat-versatile/timer-sp.c
rename to arch/arm/common/timer-sp.c
index fb0d1c2..4740313 100644
--- a/arch/arm/plat-versatile/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/plat-versatile/timer-sp.c
+ *  linux/arch/arm/common/timer-sp.c
  *
  *  Copyright (C) 1999 - 2003 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
@@ -26,8 +26,6 @@
 
 #include <asm/hardware/arm_timer.h>
 
-#include <plat/timer-sp.h>
-
 /*
  * These timers are currently always setup to be clocked at 1MHz.
  */
diff --git a/arch/arm/plat-versatile/include/plat/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
similarity index 100%
rename from arch/arm/plat-versatile/include/plat/timer-sp.h
rename to arch/arm/include/asm/hardware/timer-sp.h
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 05db40e..6c432a0 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -41,7 +41,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 2fa38df..121c6d6 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -50,7 +50,7 @@
 #include <mach/clkdev.h>
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..6b93bd6 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -49,7 +49,7 @@
 #include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index efb1270..685e6ee 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -21,7 +21,7 @@
 #include <mach/clkdev.h>
 #include <mach/ct-ca9x4.h>
 
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 817f0ad..5bc853d 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -22,7 +22,7 @@
 #include <mach/clkdev.h>
 #include <mach/motherboard.h>
 
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 5cf88e8..aaa571d 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,5 +1,4 @@
 obj-y	:= clock.o
-obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
 obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
 obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
 ifeq ($(CONFIG_LEDS_CLASS),y)
-- 
1.7.0.4
