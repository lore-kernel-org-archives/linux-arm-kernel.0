From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:36 +0100
Subject: [PATCH 08/51] ARM: mach-ebsa110: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-ebsa110 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ebsa110/core.c                |    6 ++++++
 arch/arm/mach-ebsa110/include/mach/system.h |    4 +++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 087bc77..c4d243f 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -271,8 +271,14 @@ static struct platform_device *ebsa110_devices[] = {
 	&am79c961_device,
 };
 
+static void ebsa110_arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0x80000000);
+}
+
 static int __init ebsa110_init(void)
 {
+	arm_arch_reset = ebsa110_arch_reset;
 	return platform_add_devices(ebsa110_devices, ARRAY_SIZE(ebsa110_devices));
 }
 
diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
index 9a26245..574e633 100644
--- a/arch/arm/mach-ebsa110/include/mach/system.h
+++ b/arch/arm/mach-ebsa110/include/mach/system.h
@@ -34,6 +34,8 @@ static inline void arch_idle(void)
 	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
 }
 
-#define arch_reset(mode, cmd)	cpu_reset(0x80000000)
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 #endif
-- 
1.7.4.1
