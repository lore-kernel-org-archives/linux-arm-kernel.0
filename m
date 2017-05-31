From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 03:06:21 +0200
Subject: [PATCH v3 3/6] ARM: at91: Add armv7m support
In-Reply-To: <20170531010624.32552-1-alexandre.belloni@free-electrons.com>
References: <20170531010624.32552-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170531010624.32552-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Szemz? Andr?s <sza@esh.hu>

Add Atmel SAME70/SAMS70/SAMV71 SoC support and detection.

Signed-off-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig       |  9 ++++++++-
 arch/arm/mach-at91/Makefile      |  1 +
 arch/arm/mach-at91/Makefile.boot |  3 +++
 arch/arm/mach-at91/samx7.c       | 25 +++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/Makefile.boot
 create mode 100644 arch/arm/mach-at91/samx7.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 841e924143f9..bade64e0cb49 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,12 +1,19 @@
 menuconfig ARCH_AT91
 	bool "Atmel SoCs"
-	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7
+	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 	select COMMON_CLK_AT91
 	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
 
 if ARCH_AT91
+config SOC_SAMX7
+	bool "SAM Cortex-M7 family" if ARM_SINGLE_ARMV7M
+	select COMMON_CLK_AT91
+	select PINCTRL_AT91
+	help
+	  Select this if you are using one of Atmel's SAMx7 family SoC.
+
 config SOC_SAMA5D2
 	bool "SAMA5D2 family"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index cfd8f60a9268..55a88c104e5d 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
+obj-$(CONFIG_SOC_SAMX7)		+= samx7.o
 
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
new file mode 100644
index 000000000000..eacfc3f5c33e
--- /dev/null
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -0,0 +1,3 @@
+# Empty file waiting for deletion once Makefile.boot isn't needed any more.
+# Patch waits for application at
+# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-at91/samx7.c b/arch/arm/mach-at91/samx7.c
new file mode 100644
index 000000000000..e2e7d153a7b9
--- /dev/null
+++ b/arch/arm/mach-at91/samx7.c
@@ -0,0 +1,25 @@
+/*
+ *  Setup code for SAMx7
+ *
+ *  Copyright (C) 2013 Atmel,
+ *                2016 Andras Szemzo <szemzo.andras@gmail.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/system_misc.h>
+#include "generic.h"
+
+static const char *const samx7_dt_board_compat[] __initconst = {
+	"atmel,samx7",
+	NULL
+};
+
+DT_MACHINE_START(samx7_dt, "Atmel SAMx7")
+	.dt_compat	= samx7_dt_board_compat,
+MACHINE_END
-- 
2.11.0
