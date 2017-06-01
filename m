From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  1 Jun 2017 22:05:59 +0200
Subject: [PATCH v4 4/6] ARM: at91: handle CONFIG_PM for armv7m configurations
In-Reply-To: <20170601200601.11035-1-alexandre.belloni@free-electrons.com>
References: <20170601200601.11035-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170601200601.11035-5-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently no PM support for samx7 but the symbol can still be
selected. This avoids compilation issues.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig  | 6 ++++++
 arch/arm/mach-at91/Makefile | 3 +--
 arch/arm/mach-at91/samv7.c  | 9 +++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2594b6a412f0..7497a28a79d1 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -60,6 +60,7 @@ config SOC_AT91RM9200
 	bool "AT91RM9200"
 	depends on ARCH_MULTI_V4T
 	select ATMEL_AIC_IRQ
+	select ATMEL_PM if PM
 	select ATMEL_ST
 	select CPU_ARM920T
 	select HAVE_AT91_USB_CLK
@@ -73,6 +74,7 @@ config SOC_AT91SAM9
 	bool "AT91SAM9"
 	depends on ARCH_MULTI_V5
 	select ATMEL_AIC_IRQ
+	select ATMEL_PM if PM
 	select ATMEL_SDRAMC
 	select CPU_ARM926T
 	select HAVE_AT91_SMD
@@ -131,9 +133,13 @@ config SOC_SAM_V7
 config SOC_SAMA5
 	bool
 	select ATMEL_AIC5_IRQ
+	select ATMEL_PM if PM
 	select ATMEL_SDRAMC
 	select MEMORY
 	select SOC_SAM_V7
 	select SRAM if PM
 
+config ATMEL_PM
+	bool
+
 endif
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index a189081dccc0..ee34aa34cc51 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -9,8 +9,7 @@ obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 
 # Power Management
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= pm_suspend.o
+obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
 
 ifeq ($(CONFIG_CPU_V7),y)
 AFLAGS_pm_suspend.o := -march=armv7-a
diff --git a/arch/arm/mach-at91/samv7.c b/arch/arm/mach-at91/samv7.c
index 11386f190c83..910f0c68db62 100644
--- a/arch/arm/mach-at91/samv7.c
+++ b/arch/arm/mach-at91/samv7.c
@@ -15,6 +15,15 @@
 #include <asm/system_misc.h>
 #include "generic.h"
 
+#ifdef CONFIG_PM
+/* This function has to be defined for various drivers that are using it */
+int at91_suspend_entering_slow_clock(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
+#endif
+
 static const char *const samv7_dt_board_compat[] __initconst = {
 	"atmel,samv7",
 	NULL
-- 
2.11.0
