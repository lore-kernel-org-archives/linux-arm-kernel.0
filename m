From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:09 +0100
Subject: [PATCH 41/51] ARM: mach-tegra: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-42-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-tegra to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-tegra/common.c              |    4 ++--
 arch/arm/mach-tegra/include/mach/system.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d5e3f89..aaf85c6 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -31,8 +31,6 @@
 #include "clock.h"
 #include "fuse.h"
 
-void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
-
 void tegra_assert_system_reset(char mode, const char *cmd)
 {
 	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
@@ -80,4 +78,6 @@ void __init tegra_init_early(void)
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
 	tegra_init_cache();
+
+	arm_arch_reset = tegra_assert_system_reset;
 }
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index 027c421..b87b8a4 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -21,9 +21,9 @@
 #ifndef __MACH_TEGRA_SYSTEM_H
 #define __MACH_TEGRA_SYSTEM_H
 
-#include <mach/iomap.h>
-
-extern void (*arch_reset)(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 static inline void arch_idle(void)
 {
-- 
1.7.4.1
