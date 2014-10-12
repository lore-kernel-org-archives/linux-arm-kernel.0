From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Oct 2014 17:28:51 +0200
Subject: [PATCH v2 4/4] arm: pxa: add pxa27x device-tree support
In-Reply-To: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1413127731-1187-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device-tree machine entry (DT_MACHINE_START)  for pxa27x based
platforms.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/Kconfig  | 11 +++++++++++
 arch/arm/mach-pxa/Makefile |  1 +
 arch/arm/mach-pxa/pxa-dt.c | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index e6690a4..83efe91 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -4,6 +4,17 @@ menu "Intel PXA2xx/PXA3xx Implementations"
 
 comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
+config MACH_PXA27X_DT
+	bool "Support PXA27x platforms from device tree"
+	select CPU_PXA27x
+	select POWER_SUPPLY
+	select PXA27x
+	select USE_OF
+	help
+	  Include support for Marvell PXA27x based platforms using
+	  the device tree. Needn't select any other machine while
+	  MACH_PXA27X_DT is enabled.
+
 config MACH_PXA3XX_DT
 	bool "Support PXA3xx platforms from device tree"
 	select CPU_PXA300
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 2fe1824..eb0bf76 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
 # Device Tree support
 obj-$(CONFIG_MACH_PXA3XX_DT)	+= pxa-dt.o
+obj-$(CONFIG_MACH_PXA27X_DT)	+= pxa-dt.o
 
 # Intel/Marvell Dev Platforms
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index b070196..7e0e5bd 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -58,3 +58,18 @@ DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
 	.dt_compat	= pxa3xx_dt_board_compat,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_PXA27x
+static const char * const pxa27x_dt_board_compat[] __initconst = {
+	"marvell,pxa270",
+	NULL,
+};
+
+DT_MACHINE_START(PXA27X_DT, "Marvell PXA2xx (Device Tree Support)")
+	.map_io		= pxa27x_map_io,
+	.init_irq	= pxa27x_dt_init_irq,
+	.handle_irq	= pxa27x_handle_irq,
+	.restart	= pxa_restart,
+	.dt_compat	= pxa27x_dt_board_compat,
+MACHINE_END
+#endif
-- 
2.1.0
