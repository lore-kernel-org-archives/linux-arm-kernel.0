From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 23 Sep 2016 00:22:06 +0200
Subject: [PATCH 2/4] ARM: at91: handle CONFIG_PM for armv7m configurations
In-Reply-To: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
References: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160922222208.23798-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently no PM support for samx7 but the symbol can still be
selected. This avoids compilation issues.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig  |  6 ++++++
 arch/arm/mach-at91/Makefile |  3 +--
 arch/arm/mach-at91/samx7.c  | 10 ++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 3ca2724a6ca6..df3b6efa888d 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -59,6 +59,7 @@ config SOC_AT91RM9200
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
index 84956a18d604..116691714bb8 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -10,8 +10,7 @@ obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 obj-$(CONFIG_SOC_SAMX7)		+= samx7.o
 
 # Power Management
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= pm_suspend.o
+obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
 
 ifeq ($(CONFIG_CPU_V7),y)
 AFLAGS_pm_suspend.o := -march=armv7-a
diff --git a/arch/arm/mach-at91/samx7.c b/arch/arm/mach-at91/samx7.c
index bd33bc56278e..240f8cda79ee 100644
--- a/arch/arm/mach-at91/samx7.c
+++ b/arch/arm/mach-at91/samx7.c
@@ -16,6 +16,16 @@
 #include "generic.h"
 #include "soc.h"
 
+
+#ifdef CONFIG_PM
+/* This function has to be defined for various drivers that are using it */
+int at91_suspend_entering_slow_clock(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
+#endif
+
 static const struct at91_soc samx7_socs[] = {
 	AT91_SOC(SAME70Q21_CIDR_MATCH, SAME70Q21_EXID_MATCH,
 		 "same70q21", "samx7"),
-- 
2.9.3
