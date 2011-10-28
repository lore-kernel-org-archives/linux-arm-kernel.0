From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:47 +0100
Subject: [PATCH 19/51] ARM: mach-ixp23xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-20-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-ixp23xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ixp23xx/core.c                |   15 +++++++++++++++
 arch/arm/mach-ixp23xx/include/mach/system.h |   12 ------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index a1bee33..e72c089 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -32,6 +32,7 @@
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
+#include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -439,8 +440,22 @@ static struct platform_device *ixp23xx_devices[] __initdata = {
 	&ixp23xx_uart,
 };
 
+static void ixp23xx_arch_reset(char mode, const char *cmd)
+{
+	/* First try machine specific support */
+	if (machine_is_ixdp2351()) {
+		*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_MAGIC;
+		(void) *IXDP2351_CPLD_RESET1_REG;
+		*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_ENABLE;
+	}
+
+	/* Use on-chip reset capability */
+	*IXP23XX_RESET0 |= IXP23XX_RST_ALL;
+}
+
 void __init ixp23xx_sys_init(void)
 {
 	*IXP23XX_EXP_UNIT_FUSE |= 0xf;
 	platform_add_devices(ixp23xx_devices, ARRAY_SIZE(ixp23xx_devices));
+	arm_arch_reset = ixp23xx_arch_reset;
 }
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
index 8920ff2..4569003 100644
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ b/arch/arm/mach-ixp23xx/include/mach/system.h
@@ -8,9 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-
 static inline void arch_idle(void)
 {
 #if 0
@@ -21,13 +18,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/* First try machine specific support */
-	if (machine_is_ixdp2351()) {
-		*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_MAGIC;
-		(void) *IXDP2351_CPLD_RESET1_REG;
-		*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_ENABLE;
-	}
-
-	/* Use on-chip reset capability */
-	*IXP23XX_RESET0 |= IXP23XX_RST_ALL;
 }
-- 
1.7.4.1
