From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 22:32:26 +0200
Subject: [PATCH] clk: tegra: provide tegra_periph_reset_assert alternative
Message-ID: <201306212232.27026.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have some tegra device drivers that are written to be platform
independent but still use the tegra specific tegra_periph_reset_assert
function. In order to build and link them without errors,
this provides a static inline version of these functions that
does nothing when Tegra support is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 642789b..1397190 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -120,8 +120,13 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
 
+#ifdef ARCH_TEGRA
 void tegra_periph_reset_deassert(struct clk *c);
 void tegra_periph_reset_assert(struct clk *c);
+#else
+static inline void tegra_periph_reset_deassert(struct clk *c) {}
+static inline void tegra_periph_reset_assert(struct clk *c) {}
+#endif
 void tegra_clocks_init(void);
 void tegra_clocks_apply_init_table(void);
 
