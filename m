From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:57 +0100
Subject: [PATCH 29/51] ARM: mach-nomadik: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-30-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-nomadik to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-nomadik/cpu-8815.c            |   12 ++++++++++++
 arch/arm/mach-nomadik/include/mach/system.h |    9 ---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index ac58e3b..a9c2406 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -18,6 +18,7 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
@@ -113,6 +114,16 @@ static struct amba_device *amba_devs[] __initdata = {
 	&cpu8815_amba_rng
 };
 
+static void nmk_arch_reset(char mode, const char *cmd)
+{
+	void __iomem *src_rstsr = io_p2v(NOMADIK_SRC_BASE + 0x18);
+
+	/* FIXME: use egpio when implemented */
+
+	/* Write anything to Reset status register */
+	writel(1, src_rstsr);
+}
+
 static int __init cpu8815_init(void)
 {
 	int i;
@@ -120,6 +131,7 @@ static int __init cpu8815_init(void)
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+	arm_arch_reset = nmk_arch_reset;
 	return 0;
 }
 arch_initcall(cpu8815_init);
diff --git a/arch/arm/mach-nomadik/include/mach/system.h b/arch/arm/mach-nomadik/include/mach/system.h
index 7119f68..16f59f6 100644
--- a/arch/arm/mach-nomadik/include/mach/system.h
+++ b/arch/arm/mach-nomadik/include/mach/system.h
@@ -20,9 +20,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-
 static inline void arch_idle(void)
 {
 	/*
@@ -34,12 +31,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	void __iomem *src_rstsr = io_p2v(NOMADIK_SRC_BASE + 0x18);
-
-	/* FIXME: use egpio when implemented */
-
-	/* Write anything to Reset status register */
-	writel(1, src_rstsr);
 }
 
 #endif
-- 
1.7.4.1
