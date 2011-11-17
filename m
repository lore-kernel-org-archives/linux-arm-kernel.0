From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 16:55:51 +0000
Subject: [PATCH 04/10] arm/tegra: prepare early init for multiple tegra
 variants
In-Reply-To: <1321546766-26770-5-git-send-email-pdeschrijver@nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111117165551.GV9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 06:19:18PM +0200, Peter De Schrijver wrote:
> This patch splits the early init code in a common and a tegra20 specific part.
> L2 cache initialization is generalized and discovers the cache associativity
> at runtime. Also use arm_pm_restart instead of arm_arch_reset and reset the
> the system using the PMC reset feature rather then the CAR system reset.

I'm already carrying this, and the follow-on patch to remove the
arch_reset() from tegra entirely.

8<===
ARM: restart: tegra: use new restart hook

Hook these platforms restart code into the arm_pm_restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tegra/common.c              |    5 ++---
 arch/arm/mach-tegra/include/mach/system.h |    6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 690b888..1374d10 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -31,9 +31,7 @@
 #include "clock.h"
 #include "fuse.h"
 
-void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
-
-void tegra_assert_system_reset(char mode, const char *cmd)
+static void tegra_assert_system_reset(char mode, const char *cmd)
 {
 	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
 	u32 reg;
@@ -76,6 +74,7 @@ static void __init tegra_init_cache(void)
 
 void __init tegra_init_early(void)
 {
+	arm_pm_restart = tegra_assert_system_reset;
 	tegra_init_fuse();
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
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
1.7.4.4
