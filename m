From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 13 May 2016 14:26:27 +0300
Subject: [PATCH 2/3] ARM: clps711x: Add basic DT support
In-Reply-To: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
References: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
Message-ID: <1463138788-5390-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support to run Cirrus Logic ARMv4T CPUs
with device-tree support.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                 |  2 ++
 arch/arm/mach-clps711x/Kconfig   |  7 +++++++
 arch/arm/mach-clps711x/common.c  | 14 ++++++++++++++
 arch/arm/mach-clps711x/devices.c |  6 ++++++
 arch/arm/mach-clps711x/devices.h |  1 +
 5 files changed, 30 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2..afc1eaf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -357,10 +357,12 @@ config ARCH_CLPS711X
 	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
 	select CLKSRC_MMIO
+	select CLKSRC_OF if OF
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
 	select MFD_SYSCON
+	select OF_IRQ if OF
 	select SOC_BUS
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index f711498..3e11390 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -2,6 +2,13 @@ if ARCH_CLPS711X
 
 menu "CLPS711X/EP721X/EP731X Implementations"
 
+config MACH_CLPS711X_DT
+	bool "Device-tree support"
+	select USE_OF
+	help
+	  Select this if you want to experiment device-tree with
+	  ARMv4T Cirrus Logic chips.
+
 config ARCH_AUTCPU12
 	bool "AUTCPU12"
 	help
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index bf62211..df0fdf8 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -23,12 +23,14 @@
 #include <linux/init.h>
 #include <linux/sizes.h>
 
+#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 
 #include <mach/hardware.h>
 
 #include "common.h"
+#include "devices.h"
 
 /*
  * This maps the generic CLPS711x registers
@@ -63,3 +65,15 @@ void clps711x_restart(enum reboot_mode mode, const char *cmd)
 {
 	soft_restart(0);
 }
+
+static const char *clps711x_dt_compat[] __initconst = {
+	"cirrus,clps711x",
+	NULL
+};
+
+DT_MACHINE_START(CLPS711X_DT, "Cirrus Logic CLPS711X (Device Tree Support)")
+	.dt_compat	= clps711x_dt_compat,
+	.map_io		= clps711x_map_io,
+	.init_late	= clps711x_devices_init_dt,
+	.restart	= clps711x_restart,
+MACHINE_END
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 77a9617..9ba5095 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -147,3 +147,9 @@ void __init clps711x_devices_init(void)
 	clps711x_add_uart();
 	clps711x_soc_init();
 }
+
+void __init clps711x_devices_init_dt(void)
+{
+	clps711x_add_cpuidle();
+	clps711x_soc_init();
+};
diff --git a/arch/arm/mach-clps711x/devices.h b/arch/arm/mach-clps711x/devices.h
index a5efc17..47378cd 100644
--- a/arch/arm/mach-clps711x/devices.h
+++ b/arch/arm/mach-clps711x/devices.h
@@ -10,3 +10,4 @@
  */
 
 void clps711x_devices_init(void);
+void clps711x_devices_init_dt(void);
-- 
2.4.9
