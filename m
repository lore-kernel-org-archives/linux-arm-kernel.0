From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:52 +0100
Subject: [PATCH 24/51] ARM: mach-mmp: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-25-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-mmp to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-mmp/common.c              |   16 ++++++++++++++++
 arch/arm/mach-mmp/include/mach/system.h |    4 ----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 0ec0ca8..1d3df64 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 
 #include <asm/page.h>
+#include <asm/proc-fns.h>
 #include <asm/mach/map.h>
 #include <mach/addr-map.h>
 #include <mach/cputype.h>
@@ -45,3 +46,18 @@ void __init mmp_map_io(void)
 	/* this is early, initialize mmp_chip_id here */
 	mmp_chip_id = __raw_readl(MMP_CHIPID);
 }
+
+static void mmp_arch_reset(char mode, const char *cmd)
+{
+	if (cpu_is_pxa168())
+		cpu_reset(0xffff0000);
+	else
+		cpu_reset(0);
+}
+
+static int __init mmp_arch_reset_init(void)
+{
+	arm_arch_reset = mmp_arch_reset;
+	return 0;
+}
+arch_initcall(mmp_arch_reset_init);
diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
index 1a8a25e..b09c19a 100644
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ b/arch/arm/mach-mmp/include/mach/system.h
@@ -18,9 +18,5 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (cpu_is_pxa168())
-		cpu_reset(0xffff0000);
-	else
-		cpu_reset(0);
 }
 #endif /* __ASM_MACH_SYSTEM_H */
-- 
1.7.4.1
