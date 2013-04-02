From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:00 +0900
Subject: [PATCH 04/30] ARM: shmobile: r8a73a4 PFC support
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a platform device for the r8a73a4 PFC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 17a59cd..0e4a820 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -20,6 +20,7 @@ config ARCH_SH73A0
 
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select ARM_ARCH_TIMER
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index 6db3495..f043103 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -3,5 +3,6 @@
 
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
+void r8a73a4_pinmux_init(void);
 
 #endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index da5ae16..c2d86f3 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
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
 	.type		= scif_type,				\
 	.mapbase	= baseaddr,				\
-- 
1.7.10.4
