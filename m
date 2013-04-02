From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:24 +0900
Subject: [PATCH 28/30] ARM: shmobile: r8a7790 PFC support
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-29-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a platform device for the r8a7790 PFC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ccaea6a..ff674c5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -53,6 +53,7 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select ARM_ARCH_TIMER
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index f38ded6..9bd6f5c 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -3,5 +3,6 @@
 
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
+void r8a7790_pinmux_init(void);
 
 #endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 9b4ccd7..481201a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
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
-- 
1.7.10.4
