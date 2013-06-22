From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 22 Jun 2013 11:06:23 -0700
Subject: [PATCH] clk: tegra: provide tegra_periph_reset_assert alternative
In-Reply-To: <51C4C377.5090408@wwwdotorg.org>
References: <201306212232.27026.arnd@arndb.de> <51C4C377.5090408@wwwdotorg.org>
Message-ID: <20130622180623.20448.27045@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-06-21 14:19:51)
> On 06/21/2013 02:32 PM, Arnd Bergmann wrote:
> > We have some tegra device drivers that are written to be platform
> > independent but still use the tegra specific tegra_periph_reset_assert
> > function. In order to build and link them without errors,
> > this provides a static inline version of these functions that
> > does nothing when Tegra support is disabled.
> 
> Oh, I thought this had been applied already.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Hopefully we'll be replacing these custom APIs with the standard module
> reset APIs soon (post 3.11 though). I've seen internally the first round
> of patches from Prashant for this, so chances are good they'll be
> finalized and sent upstream in the not-too-distant future.

This fix has been taken into clk-next for 3.11. tegra_clocks_init() is
missing in the clock tree so the patch below is what actually got
merged.

Thanks,
Mike



commit 7064f6bd86278029348c36d30bd325e7e05b6fee
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jun 21 22:32:26 2013 +0200

    clk: tegra: provide tegra_periph_reset_assert alternative
    
    We have some tegra device drivers that are written to be platform
    independent but still use the tegra specific tegra_periph_reset_assert
    function. In order to build and link them without errors,
    this provides a static inline version of these functions that
    does nothing when Tegra support is disabled.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Stephen Warren <swarren@nvidia.com>
    Signed-off-by: Mike Turquette <mturquette@linaro.org>
    [mturquette at linaro.org: fixed up trivial merge issue]

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 3670a4f..e3cc872 100644
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
 void tegra_clocks_apply_init_table(void);
 
 #endif /* __LINUX_CLK_TEGRA_H_ */
