From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Jun 2013 13:05:56 -0600
Subject: [PATCH] clk: tegra: fix ifdef for tegra_periph_reset_assert inline
Message-ID: <1372100756-10448-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 7064f6b "clk: tegra: provide tegra_periph_reset_assert
alternative" added ifdef'd static inline versions of some functions,
but tested ARCH_TEGRA rather than CONFIG_ARCH_TEGRA, thus disabling
these function in all cases. In some cases, this caused HW modules to
misbehave; for example, the Tegra I2C driver BUG()d during boot on
Seaboard.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/linux/clk/tegra.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index e3cc872..23a0cee 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -120,7 +120,7 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
 
-#ifdef ARCH_TEGRA
+#ifdef CONFIG_ARCH_TEGRA
 void tegra_periph_reset_deassert(struct clk *c);
 void tegra_periph_reset_assert(struct clk *c);
 #else
-- 
1.8.1.5
