From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 23 Sep 2016 00:22:05 +0200
Subject: [PATCH 1/4] ARM: at91: Add armv7m support
In-Reply-To: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
References: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160922222208.23798-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Szemz? Andr?s <sza@esh.hu>

Add Atmel SAME70/SAMS70/SAMV71 SoC support and detection.

Signed-off-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig       |  9 +++++-
 arch/arm/mach-at91/Makefile      |  1 +
 arch/arm/mach-at91/Makefile.boot |  3 ++
 arch/arm/mach-at91/samx7.c       | 62 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h         | 21 ++++++++++++++
 5 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/Makefile.boot
 create mode 100644 arch/arm/mach-at91/samx7.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 5204395efda8..3ca2724a6ca6 100644
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
index c5bbf8bb8c0f..84956a18d604 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,6 +7,7 @@ obj-y		:= soc.o
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
index 000000000000..bd33bc56278e
--- /dev/null
+++ b/arch/arm/mach-at91/samx7.c
@@ -0,0 +1,62 @@
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
+#include "soc.h"
+
+static const struct at91_soc samx7_socs[] = {
+	AT91_SOC(SAME70Q21_CIDR_MATCH, SAME70Q21_EXID_MATCH,
+		 "same70q21", "samx7"),
+	AT91_SOC(SAME70Q20_CIDR_MATCH, SAME70Q20_EXID_MATCH,
+		 "same70q20", "samx7"),
+	AT91_SOC(SAME70Q19_CIDR_MATCH, SAME70Q19_EXID_MATCH,
+		 "same70q19", "samx7"),
+	AT91_SOC(SAMS70Q21_CIDR_MATCH, SAMS70Q21_EXID_MATCH,
+		 "sams70q21", "samx7"),
+	AT91_SOC(SAMS70Q20_CIDR_MATCH, SAMS70Q20_EXID_MATCH,
+		 "sams70q20", "samx7"),
+	AT91_SOC(SAMS70Q19_CIDR_MATCH, SAMS70Q19_EXID_MATCH,
+		 "sams70q19", "samx7"),
+	AT91_SOC(SAMV71Q21_CIDR_MATCH, SAMV71Q21_EXID_MATCH,
+		 "samv71q21", "samx7"),
+	AT91_SOC(SAMV71Q20_CIDR_MATCH, SAMV71Q20_EXID_MATCH,
+		 "samv71q20", "samx7"),
+	AT91_SOC(SAMV71Q19_CIDR_MATCH, SAMV71Q19_EXID_MATCH,
+		 "samv71q19", "samx7"),
+	{ /* sentinel */ },
+};
+
+static void __init samx7_dt_device_init(void)
+{
+	struct soc_device *soc;
+	struct device *soc_dev = NULL;
+
+	soc = at91_soc_init(samx7_socs);
+	if (soc)
+		soc_dev = soc_device_to_device(soc);
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+}
+
+static const char *const samx7_dt_board_compat[] __initconst = {
+	"atmel,samx7",
+	NULL
+};
+
+DT_MACHINE_START(samx7_dt, "Atmel SAMx7")
+	.init_machine	= samx7_dt_device_init,
+	.dt_compat	= samx7_dt_board_compat,
+MACHINE_END
+
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 228efded5085..0f97e9c5da7e 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -88,4 +88,25 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA5D43_EXID_MATCH		0x00000003
 #define SAMA5D44_EXID_MATCH		0x00000004
 
+#define SAME70Q21_CIDR_MATCH		0x21020e00
+#define SAME70Q21_EXID_MATCH		0x00000002
+#define SAME70Q20_CIDR_MATCH		0x21020c00
+#define SAME70Q20_EXID_MATCH		0x00000002
+#define SAME70Q19_CIDR_MATCH		0x210d0a00
+#define SAME70Q19_EXID_MATCH		0x00000002
+
+#define SAMS70Q21_CIDR_MATCH		0x21120e00
+#define SAMS70Q21_EXID_MATCH		0x00000002
+#define SAMS70Q20_CIDR_MATCH		0x21120c00
+#define SAMS70Q20_EXID_MATCH		0x00000002
+#define SAMS70Q19_CIDR_MATCH		0x211d0a00
+#define SAMS70Q19_EXID_MATCH		0x00000002
+
+#define SAMV71Q21_CIDR_MATCH		0x21220e00
+#define SAMV71Q21_EXID_MATCH		0x00000002
+#define SAMV71Q20_CIDR_MATCH		0x21220c00
+#define SAMV71Q20_EXID_MATCH		0x00000002
+#define SAMV71Q19_CIDR_MATCH		0x212d0a00
+#define SAMV71Q19_EXID_MATCH		0x00000002
+
 #endif /* __AT91_SOC_H */
-- 
2.9.3
