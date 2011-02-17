From: sjg@chromium.org (Simon Glass)
Date: Thu, 17 Feb 2011 08:13:57 -0800
Subject: [PATCH] Fix hang on reboot with Tegra2
Message-ID: <1297959237-8277-1-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This seems to be a regression in 2.6.37.

We cannot use writel() here since the resulting wmb() calls l2x0_cache_sync()
which uses a spinlock and L1 cache may be off at this point.

Change-Id: Ia23b317dee919055ff4abba1484735ea3165fd99
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041909.html

Signed-off-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-tegra/include/mach/system.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index 84d5d46..f1c0a79 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -33,7 +33,9 @@ static inline void arch_reset(char mode, const char *cmd)
 	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
 	u32 reg = readl(reset);
 	reg |= 0x04;
-	writel(reg, reset);
+
+	/* use writel_related to avoid spinlock since L1 cache may be off */
+	writel_relaxed(reg, reset);
 }
 
 #endif
-- 
1.7.3.1
