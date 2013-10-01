From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  1 Oct 2013 10:48:45 +0200
Subject: [PATCH] ARM: gemini: delete <mach/gpio.h>
Message-ID: <1380617325-7477-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gemini has no need of a <mach/gpio.h> header as this is only
used by the machine-local gpio.c gpiochip driver, which is also
only using the irq_to_gpio() macro. Delete the file, move the single
macro into the driver and remove the NEED_MACH_GPIO_H flag.

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This will be applied to the GPIO tree unless there are protests.
---
 arch/arm/Kconfig                         |  1 -
 arch/arm/mach-gemini/gpio.c              |  2 +-
 arch/arm/mach-gemini/include/mach/gpio.h | 20 --------------------
 3 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f7714d..b46a078 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -388,7 +388,6 @@ config ARCH_GEMINI
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_USES_GETTIMEOFFSET
 	select CPU_FA526
-	select NEED_MACH_GPIO_H
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
index 70bfa57..f8cb571 100644
--- a/arch/arm/mach-gemini/gpio.c
+++ b/arch/arm/mach-gemini/gpio.c
@@ -21,9 +21,9 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 
 #define GPIO_BASE(x)		IO_ADDRESS(GEMINI_GPIO_BASE(x))
+#define irq_to_gpio(x)		((x) - GPIO_IRQ_BASE)
 
 /* GPIO registers definition */
 #define GPIO_DATA_OUT		0x0
diff --git a/arch/arm/mach-gemini/include/mach/gpio.h b/arch/arm/mach-gemini/include/mach/gpio.h
deleted file mode 100644
index 40a0527..0000000
--- a/arch/arm/mach-gemini/include/mach/gpio.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Gemini gpiolib specific defines
- *
- * Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __MACH_GPIO_H__
-#define __MACH_GPIO_H__
-
-#include <mach/irqs.h>
-
-#define gpio_to_irq(x)	((x) + GPIO_IRQ_BASE)
-#define irq_to_gpio(x)	((x) - GPIO_IRQ_BASE)
-
-#endif /* __MACH_GPIO_H__ */
-- 
1.8.3.1
