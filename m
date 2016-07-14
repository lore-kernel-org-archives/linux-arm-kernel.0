From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:11:32 +0200
Subject: [PATCH 4/7] ARM: nuc900: make most header files local
In-Reply-To: <20160714111135.2476095-1-arnd@arndb.de>
References: <20160714111135.2476095-1-arnd@arndb.de>
Message-ID: <20160714111135.2476095-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once we enable CONFIG_ARCH_MULTIPLATFORM, we no longer reference the include/mach/
directory for header files, so they become invisible to the existing users.

Since all users of the headers are now in arch/arm/mach-w90x900/, we can simply
move the headers to the same place and include them using "" instead of <>.

The only exception is mach/uncompress.h, which gets included by the zImage
uncompress code for non-multiplatform configurations, so the header remains
there for the moment, and I add the few macros it actually needs there to
let it be included standalone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-w90x900/clksel.c                     |  4 ++--
 arch/arm/mach-w90x900/clock.c                      |  2 +-
 arch/arm/mach-w90x900/cpu.c                        |  6 +++---
 arch/arm/mach-w90x900/dev.c                        |  3 +--
 arch/arm/mach-w90x900/gpio.c                       |  2 +-
 arch/arm/mach-w90x900/include/mach/hardware.h      | 24 ----------------------
 arch/arm/mach-w90x900/include/mach/uncompress.h    |  5 +++--
 arch/arm/mach-w90x900/irq.c                        |  5 ++---
 arch/arm/mach-w90x900/mach-nuc910evb.c             |  2 +-
 arch/arm/mach-w90x900/mach-nuc950evb.c             |  2 +-
 arch/arm/mach-w90x900/mach-nuc960evb.c             |  2 +-
 arch/arm/mach-w90x900/{include/mach => }/map.h     |  0
 arch/arm/mach-w90x900/mfp.c                        |  2 +-
 arch/arm/mach-w90x900/{include/mach => }/mfp.h     |  0
 arch/arm/mach-w90x900/nuc910.c                     |  2 +-
 arch/arm/mach-w90x900/nuc950.c                     |  2 +-
 arch/arm/mach-w90x900/nuc960.c                     |  2 +-
 .../mach-w90x900/{include/mach => }/regs-clock.h   |  2 --
 .../arm/mach-w90x900/{include/mach => }/regs-irq.h |  2 --
 .../mach-w90x900/{include/mach => }/regs-serial.h  |  2 --
 arch/arm/mach-w90x900/time.c                       |  3 +--
 21 files changed, 21 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm/mach-w90x900/include/mach/hardware.h
 rename arch/arm/mach-w90x900/{include/mach => }/map.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/mfp.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-clock.h (96%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-irq.h (96%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-serial.h (96%)

diff --git a/arch/arm/mach-w90x900/clksel.c b/arch/arm/mach-w90x900/clksel.c
index 06d867dce551..ae9d53e09b60 100644
--- a/arch/arm/mach-w90x900/clksel.c
+++ b/arch/arm/mach-w90x900/clksel.c
@@ -21,8 +21,8 @@
 #include <linux/mutex.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-#include <mach/regs-clock.h>
+#include "map.h"
+#include "regs-clock.h"
 
 #define PLL0		0x00
 #define PLL1		0x01
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index 8b196d094daa..a143d4b8ab38 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -21,7 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
+#include "map.h"
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index ca763251ffe0..d96d0e3eb7a6 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -30,9 +30,9 @@
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
-#include <mach/hardware.h>
-#include <mach/regs-serial.h>
-#include <mach/regs-clock.h>
+#include "map.h"
+#include "regs-serial.h"
+#include "regs-clock.h"
 #include "regs-ebi.h"
 #include "regs-timer.h"
 
diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 9c9292feb066..f9f3aa46b1af 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -34,12 +34,11 @@
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-serial.h>
 #include <linux/platform_data/spi-nuc900.h>
-#include <mach/map.h>
 #include <linux/platform_data/video-nuc900fb.h>
 #include <linux/platform_data/keypad-w90p910.h>
 
+#include "map.h"
 #include "cpu.h"
 
 /*NUC900 evb norflash driver data */
diff --git a/arch/arm/mach-w90x900/gpio.c b/arch/arm/mach-w90x900/gpio.c
index 55d1a00dbd28..ae039e1ca465 100644
--- a/arch/arm/mach-w90x900/gpio.c
+++ b/arch/arm/mach-w90x900/gpio.c
@@ -22,7 +22,7 @@
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
 
-#include <mach/hardware.h>
+#include "map.h"
 
 #define GPIO_BASE 		(W90X900_VA_GPIO)
 #define GPIO_DIR		(0x04)
diff --git a/arch/arm/mach-w90x900/include/mach/hardware.h b/arch/arm/mach-w90x900/include/mach/hardware.h
deleted file mode 100644
index fe3c6265a466..000000000000
--- a/arch/arm/mach-w90x900/include/mach/hardware.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * arch/arm/mach-w90x900/include/mach/hardware.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * Based on arch/arm/mach-s3c2410/include/mach/hardware.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include <asm/sizes.h>
-#include <mach/map.h>
-
-#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index 3855ecebda6e..a1b6ea95e658 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -20,11 +20,12 @@
 
 /* Defines for UART registers */
 
-#include <mach/regs-serial.h>
-#include <mach/map.h>
 #include <linux/serial_reg.h>
 
 #define TX_DONE	(UART_LSR_TEMT | UART_LSR_THRE)
+
+#define UART0_PA		W90X900_PA_UART
+#define W90X900_PA_UART		(0xB8000000)
 static volatile u32 * const uart_base = (u32 *)UART0_PA;
 
 static inline void putc(int ch)
diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
index 6ef0ae50a23f..2a6fe35b76e7 100644
--- a/arch/arm/mach-w90x900/irq.c
+++ b/arch/arm/mach-w90x900/irq.c
@@ -26,9 +26,8 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
-#include <mach/regs-irq.h>
-
+#include "map.h"
+#include "regs-irq.h"
 #include "nuc9xx.h"
 
 struct group_irq {
diff --git a/arch/arm/mach-w90x900/mach-nuc910evb.c b/arch/arm/mach-w90x900/mach-nuc910evb.c
index 92f1c978f35e..e9631784493e 100644
--- a/arch/arm/mach-w90x900/mach-nuc910evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc910evb.c
@@ -17,8 +17,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
-#include <mach/map.h>
 
+#include "map.h"
 #include "nuc910.h"
 
 static void __init nuc910evb_map_io(void)
diff --git a/arch/arm/mach-w90x900/mach-nuc950evb.c b/arch/arm/mach-w90x900/mach-nuc950evb.c
index 26f7189056e3..eb8865b09288 100644
--- a/arch/arm/mach-w90x900/mach-nuc950evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc950evb.c
@@ -19,9 +19,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
-#include <mach/map.h>
 #include <linux/platform_data/video-nuc900fb.h>
 
+#include "map.h"
 #include "nuc950.h"
 
 static void __init nuc950evb_map_io(void)
diff --git a/arch/arm/mach-w90x900/mach-nuc960evb.c b/arch/arm/mach-w90x900/mach-nuc960evb.c
index 9b4e73fe10e5..d7b97913af7b 100644
--- a/arch/arm/mach-w90x900/mach-nuc960evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc960evb.c
@@ -17,8 +17,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
-#include <mach/map.h>
 
+#include "map.h"
 #include "nuc960.h"
 
 static void __init nuc960evb_map_io(void)
diff --git a/arch/arm/mach-w90x900/include/mach/map.h b/arch/arm/mach-w90x900/map.h
similarity index 100%
rename from arch/arm/mach-w90x900/include/mach/map.h
rename to arch/arm/mach-w90x900/map.h
diff --git a/arch/arm/mach-w90x900/mfp.c b/arch/arm/mach-w90x900/mfp.c
index c58d142b8a46..0d985ff0c57d 100644
--- a/arch/arm/mach-w90x900/mfp.c
+++ b/arch/arm/mach-w90x900/mfp.c
@@ -21,7 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
+#include "map.h"
 
 #define REG_MFSEL	(W90X900_VA_GCR + 0xC)
 
diff --git a/arch/arm/mach-w90x900/include/mach/mfp.h b/arch/arm/mach-w90x900/mfp.h
similarity index 100%
rename from arch/arm/mach-w90x900/include/mach/mfp.h
rename to arch/arm/mach-w90x900/mfp.h
diff --git a/arch/arm/mach-w90x900/nuc910.c b/arch/arm/mach-w90x900/nuc910.c
index 1523f4136985..59d865c6abfe 100644
--- a/arch/arm/mach-w90x900/nuc910.c
+++ b/arch/arm/mach-w90x900/nuc910.c
@@ -17,7 +17,7 @@
 
 #include <linux/platform_device.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
+#include "map.h"
 #include "cpu.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-w90x900/nuc950.c b/arch/arm/mach-w90x900/nuc950.c
index 5704f74a50ee..340e1a067d3c 100644
--- a/arch/arm/mach-w90x900/nuc950.c
+++ b/arch/arm/mach-w90x900/nuc950.c
@@ -17,7 +17,7 @@
 
 #include <linux/platform_device.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
+#include "map.h"
 
 #include "cpu.h"
 
diff --git a/arch/arm/mach-w90x900/nuc960.c b/arch/arm/mach-w90x900/nuc960.c
index 8851a3a27ce2..f01571f8c1f2 100644
--- a/arch/arm/mach-w90x900/nuc960.c
+++ b/arch/arm/mach-w90x900/nuc960.c
@@ -17,7 +17,7 @@
 
 #include <linux/platform_device.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
+#include "map.h"
 #include "cpu.h"
 
 /* define specific CPU platform device */
diff --git a/arch/arm/mach-w90x900/include/mach/regs-clock.h b/arch/arm/mach-w90x900/regs-clock.h
similarity index 96%
rename from arch/arm/mach-w90x900/include/mach/regs-clock.h
rename to arch/arm/mach-w90x900/regs-clock.h
index 516d6b477b61..345a6b51e823 100644
--- a/arch/arm/mach-w90x900/include/mach/regs-clock.h
+++ b/arch/arm/mach-w90x900/regs-clock.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-w90x900/include/mach/regs-clock.h
- *
  * Copyright (c) 2008 Nuvoton technology corporation.
  *
  * Wan ZongShun <mcuos.com@gmail.com>
diff --git a/arch/arm/mach-w90x900/include/mach/regs-irq.h b/arch/arm/mach-w90x900/regs-irq.h
similarity index 96%
rename from arch/arm/mach-w90x900/include/mach/regs-irq.h
rename to arch/arm/mach-w90x900/regs-irq.h
index 8a3185fbc9cf..75d7ed1bbec2 100644
--- a/arch/arm/mach-w90x900/include/mach/regs-irq.h
+++ b/arch/arm/mach-w90x900/regs-irq.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-w90x900/include/mach/regs-irq.h
- *
  * Copyright (c) 2008 Nuvoton technology corporation
  * All rights reserved.
  *
diff --git a/arch/arm/mach-w90x900/include/mach/regs-serial.h b/arch/arm/mach-w90x900/regs-serial.h
similarity index 96%
rename from arch/arm/mach-w90x900/include/mach/regs-serial.h
rename to arch/arm/mach-w90x900/regs-serial.h
index f08fa0d75e11..9cfeacd90aec 100644
--- a/arch/arm/mach-w90x900/include/mach/regs-serial.h
+++ b/arch/arm/mach-w90x900/regs-serial.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-w90x900/include/mach/regs-serial.h
- *
  * Copyright (c) 2008 Nuvoton technology corporation
  * All rights reserved.
  *
diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index cda085245e34..0129f5e92f3e 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -30,9 +30,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-#include <mach/map.h>
+#include "map.h"
 #include "regs-timer.h"
-
 #include "nuc9xx.h"
 
 #define RESETINT	0x1f
-- 
2.9.0
