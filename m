From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:40 +0100
Subject: [PATCH 12/51] ARM: mach-h720x: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-13-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-h720x to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-h720x/common.c              |   12 ++++++++++++
 arch/arm/mach-h720x/include/mach/system.h |    1 -
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index 51d4e44..1ad66f2 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -242,3 +242,15 @@ void __init h720x_map_io(void)
 {
 	iotable_init(h720x_io_desc,ARRAY_SIZE(h720x_io_desc));
 }
+
+static void h720x_arch_reset(char mode, const char *cmd)
+{
+	CPU_REG (PMU_BASE, PMU_STAT) |= PMU_WARMRESET;
+}
+
+static int __init h720x_arch_reset_init(void)
+{
+	arm_arch_reset = h720x_arch_reset;
+	return 0;
+}
+arch_initcall(h720x_arch_reset_init);
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index a708d24..4c2fba9 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -27,7 +27,6 @@ static void arch_idle(void)
 
 static __inline__ void arch_reset(char mode, const char *cmd)
 {
-	CPU_REG (PMU_BASE, PMU_STAT) |= PMU_WARMRESET;
 }
 
 #endif
-- 
1.7.4.1
