From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Mar 2013 00:50:03 +0900
Subject: [PATCH 04/04] ARM: shmobile: r8a7790 PFC support
In-Reply-To: <20130327154925.10876.40575.sendpatchset@w520>
References: <20130327154925.10876.40575.sendpatchset@w520>
Message-ID: <20130327155003.10876.51231.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a platform device for the r8a7790 PFC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   10 ++++++++++
 3 files changed, 12 insertions(+)

--- 0019/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-27 23:11:38.000000000 +0900
@@ -45,6 +45,7 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select ARM_ARCH_TIMER
--- 0017/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-03-27 23:12:02.000000000 +0900
@@ -3,5 +3,6 @@
 
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
+void r8a7790_pinmux_init(void);
 
 #endif /* __ASM_R8A7790_H__ */
--- 0019/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-03-27 23:12:58.000000000 +0900
@@ -29,6 +29,16 @@
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+static const struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xe6060000, 0x250),
+};
+
+void __init r8a7790_pinmux_init(void)
+{
+	platform_device_register_simple("pfc-r8a7790", -1, pfc_resources,
+					ARRAY_SIZE(pfc_resources));
+}
+
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
 	.type		= scif_type,				\
 	.mapbase	= baseaddr,				\
