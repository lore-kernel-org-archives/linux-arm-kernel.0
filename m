From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:09:07 -0800
Subject: [PATCH 20/21] ARM: tegra: Allow overriding arch_reset
In-Reply-To: <1291590548-7341-1-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
Message-ID: <1291590548-7341-21-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@google.com>

Signed-off-by: Colin Cross <ccross@google.com>
---
 arch/arm/mach-tegra/common.c              |    3 +++
 arch/arm/mach-tegra/include/mach/system.h |   18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 64ea415..c8e9bdb 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -26,12 +26,15 @@
 
 #include <mach/iomap.h>
 #include <mach/dma.h>
+#include <mach/system.h>
 
 #include "board.h"
 #include "clock.h"
 #include "fuse.h"
 #include "power.h"
 
+void (*tegra_reset)(char mode, const char *cmd);
+
 static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
 	/* name		parent		rate		enabled */
 	{ "clk_m",	NULL,		0,		true },
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index 84d5d46..70c95ac 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -24,16 +24,30 @@
 #include <mach/hardware.h>
 #include <mach/iomap.h>
 
+extern void (*tegra_reset)(char mode, const char *cmd);
+
 static inline void arch_idle(void)
 {
 }
 
-static inline void arch_reset(char mode, const char *cmd)
+static inline void tegra_assert_system_reset(void)
 {
 	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
-	u32 reg = readl(reset);
+	u32 reg;
+
+	reg = readl(reset);
 	reg |= 0x04;
 	writel(reg, reset);
 }
 
+static inline void arch_reset(char mode, const char *cmd)
+{
+	if (tegra_reset)
+		tegra_reset(mode, cmd);
+	else
+		tegra_assert_system_reset();
+
+	do { } while (1);
+}
+
 #endif
-- 
1.7.3.1
