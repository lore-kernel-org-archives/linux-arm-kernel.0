From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 26 Mar 2013 10:34:52 +0900
Subject: [PATCH 04/04] ARM: shmobile: r8a73a4 PFC support
In-Reply-To: <20130326013414.11796.9937.sendpatchset@w520>
References: <20130326013414.11796.9937.sendpatchset@w520>
Message-ID: <20130326013452.11796.62159.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a platform device for the r8a73a4 PFC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 No build time dependency, but requires PFC tables
 in separate patch series to actually do something.

 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   10 ++++++++++
 3 files changed, 12 insertions(+)

--- 0005/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-18 18:51:13.000000000 +0900
@@ -20,6 +20,7 @@ config ARCH_SH73A0
 
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select ARM_ARCH_TIMER
--- 0003/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h	2013-03-18 18:51:13.000000000 +0900
@@ -3,5 +3,6 @@
 
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
+void r8a73a4_pinmux_init(void);
 
 #endif /* __ASM_R8A73A4_H__ */
--- 0005/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-03-18 18:53:50.000000000 +0900
@@ -28,6 +28,16 @@
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
 
+static const struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xe6050000, 0x9000),
+};
+
+void __init r8a73a4_pinmux_init(void)
+{
+	platform_device_register_simple("pfc-r8a73a4", -1, pfc_resources,
+					ARRAY_SIZE(pfc_resources));
+}
+
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
 	.type		= PORT_SCIFA,				\
 	.mapbase	= baseaddr,				\
