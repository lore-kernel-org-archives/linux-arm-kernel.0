From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:36 +0100
Subject: [PATCH 3/7] at91 : group headers inclusion for the memory controller
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326293740-15735-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Group the headers inclusion depending on the arch in a single memory
controller file in order to clarify the pm.h header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/include/mach/at91_mc.h |   22 ++++++++++++++++++++++
 arch/arm/mach-at91/pm.h                   |    6 ++----
 2 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_mc.h

diff --git a/arch/arm/mach-at91/include/mach/at91_mc.h b/arch/arm/mach-at91/include/mach/at91_mc.h
new file mode 100644
index 0000000..c705ba9
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/at91_mc.h
@@ -0,0 +1,22 @@
+/*
+ * AT91 Memory controller
+ *
+ * Copyright (C) 2012 Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __ARCH_ARM_MACH_AT91_MC
+#define __ARCH_ARM_MACH_AT91_MC
+
+#ifdef CONFIG_ARCH_AT91RM9200
+#include <mach/at91rm9200_mc.h>
+#elif defined(CONFIG_ARCH_AT91CAP9)
+#include <mach/at91cap9_ddrsdr.h>
+#else
+#include <mach/at91sam9_sdramc.h>
+#endif
+
+#endif
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 325ef76..fc48bef 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -11,8 +11,9 @@
 #ifndef __ARCH_ARM_MACH_AT91_PM
 #define __ARCH_ARM_MACH_AT91_PM
 
+#include <mach/at91_mc.h>
+
 #ifdef CONFIG_ARCH_AT91RM9200
-#include <mach/at91rm9200_mc.h>
 
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
@@ -41,7 +42,6 @@ static inline u32 sdram_selfrefresh_enable(void)
 		      : : "r" (0))
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
-#include <mach/at91cap9_ddrsdr.h>
 
 static inline u32 sdram_selfrefresh_enable(void)
 {
@@ -62,7 +62,6 @@ static inline u32 sdram_selfrefresh_enable(void)
 	cpu_do_idle()
 
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
-#include <mach/at91sam9_ddrsdr.h>
 
 /* We manage both DDRAM/SDRAM controllers, we need more than one value to
  * remember.
@@ -100,7 +99,6 @@ static inline u32 sdram_selfrefresh_enable(void)
 #define wait_for_interrupt_enable()		cpu_do_idle()
 
 #else
-#include <mach/at91sam9_sdramc.h>
 
 #ifdef CONFIG_ARCH_AT91SAM9263
 /*
-- 
1.7.4.1
