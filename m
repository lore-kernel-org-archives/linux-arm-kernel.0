From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 14 Jun 2011 21:03:20 +0530
Subject: [PATCH V2] davinci: da850: move input frequency to board
	specific	files
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D425AD7@dbde02.ent.ti.com>
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
	<1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
	<874o42wpec.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D383AA8@dbde02.ent.ti.com>
	<877h8xr4o0.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D425AD7@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D4CF84E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 17:38:25, Nori, Sekhar wrote:
> On Tue, Jun 07, 2011 at 21:53:59, Hilman, Kevin wrote:
> 
> > I don't expect this to be a big boot-time impact.
> 
> You are right. Using PRINTK_TIME on DM365 I saw no noticeable boot-time
> change. When I profiled the code using do_gettimeofday(), I saw it
> was taking ~95 usecs to complete the propagation. I was mainly worried
> about all the recursion and reading of PLL and sysclk registers. Seems
> its not so bad.
> 
> > However, some of the clock.c assumptions might need to be updated as it
> > currently is written from the perspective that the PLL clocks are the
> > "root" clocks.
> 
> Hmm, just calling clk_set_rate() on refclk propagated the rate
> nicely across the tree. It seems DaVinci clock code is not in
> such a bad shape :) Or did I miss the concern?
> 
> > Setting (and propagating) clock rates is what the clock framework is
> > for, so adding a new interface to set a custom clock rate just doesn't
> > seem right.  I understand that the reference oscillator might be
> > considered a special case, but if this can be done with the clock
> > framework, it is much preferred.
> 
> Okay. Will modify the DM6467/T EVM code to use this method
> instead.

So, here is the patch. I suspect reference clock information
should come from devicetree data when available. I hope it is
OK to take this approach till that time?

Thanks,
Sekhar

-----8<------------
From: Sekhar Nori <nsekhar@ti.com>
Date: Thu, 2 Jun 2011 14:10:50 +0530
Subject: [PATCH 1/1] davinci: dm6467/T EVM: fix setting up of reference clock rate

The DM6467 and DM6467T EVMs use different reference clock
frequencies. This difference is currently supported by having
the SoC code call a public board routine which sets up the reference
clock frequency. This does not scale as more boards are added.

Instead, use the clk_set_rate() API to setup the reference clock
frequency to a different value from the board file.

Suggested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c    |   17 ++++--------
 arch/arm/mach-davinci/clock.c               |   38 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/clock.h               |    2 +
 arch/arm/mach-davinci/dm646x.c              |    4 ++-
 arch/arm/mach-davinci/include/mach/dm646x.h |    2 -
 5 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f6ac9ba..9db9838 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -719,9 +719,15 @@ static void __init cdce_clk_init(void)
 	}
 }
 
+#define DM6467T_EVM_REF_FREQ		33000000
+
 static void __init davinci_map_io(void)
 {
 	dm646x_init();
+
+	if (machine_is_davinci_dm6467tevm())
+		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
+
 	cdce_clk_init();
 }
 
@@ -785,17 +791,6 @@ static __init void evm_init(void)
 	soc_info->emac_pdata->phy_id = DM646X_EVM_PHY_ID;
 }
 
-#define DM646X_EVM_REF_FREQ		27000000
-#define DM6467T_EVM_REF_FREQ		33000000
-
-void __init dm646x_board_setup_refclk(struct clk *clk)
-{
-	if (machine_is_davinci_dm6467tevm())
-		clk->rate = DM6467T_EVM_REF_FREQ;
-	else
-		clk->rate = DM646X_EVM_REF_FREQ;
-}
-
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.boot_params  = (0x80000100),
 	.map_io       = davinci_map_io,
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index e4e3af1..ae65319 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -368,6 +368,12 @@ static unsigned long clk_leafclk_recalc(struct clk *clk)
 	return clk->parent->rate;
 }
 
+int davinci_simple_set_rate(struct clk *clk, unsigned long rate)
+{
+	clk->rate = rate;
+	return 0;
+}
+
 static unsigned long clk_pllclk_recalc(struct clk *clk)
 {
 	u32 ctrl, mult = 1, prediv = 1, postdiv = 1;
@@ -506,6 +512,38 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 }
 EXPORT_SYMBOL(davinci_set_pllrate);
 
+/**
+ * davinci_set_refclk_rate() - Set the reference clock rate
+ * @rate:	The new rate.
+ *
+ * Sets the reference clock rate to a given value. This will most likely
+ * result in the entire clock tree getting updated.
+ *
+ * This is used to support boards which use a reference clock different
+ * than that used by default in <soc>.c file. The reference clock rate
+ * should be updated early in the boot process; ideally soon after the
+ * clock tree has been initialized once with the default reference clock
+ * rate (davinci_common_init()).
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int davinci_set_refclk_rate(unsigned long rate)
+{
+	struct clk *refclk;
+
+	refclk = clk_get(NULL, "ref");
+	if (IS_ERR(refclk)) {
+		pr_err("%s: failed to get reference clock.\n", __func__);
+		return PTR_ERR(refclk);
+	}
+
+	clk_set_rate(refclk, rate);
+
+	clk_put(refclk);
+
+	return 0;
+}
+
 int __init davinci_clk_init(struct clk_lookup *clocks)
   {
 	struct clk_lookup *c;
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 0dd2203..50b2482 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -123,6 +123,8 @@ int davinci_clk_init(struct clk_lookup *clocks);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
 int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
+int davinci_set_refclk_rate(unsigned long rate);
+int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
 
 extern struct platform_device davinci_wdt_device;
 extern void davinci_watchdog_reset(struct platform_device *);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 1e0f809..46739c9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -42,6 +42,7 @@
 /*
  * Device specific clocks
  */
+#define DM646X_REF_FREQ		27000000
 #define DM646X_AUX_FREQ		24000000
 
 static struct pll_data pll1_data = {
@@ -56,6 +57,8 @@ static struct pll_data pll2_data = {
 
 static struct clk ref_clk = {
 	.name = "ref_clk",
+	.rate = DM646X_REF_FREQ,
+	.set_rate = davinci_simple_set_rate,
 };
 
 static struct clk aux_clkin = {
@@ -901,7 +904,6 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 
 void __init dm646x_init(void)
 {
-	dm646x_board_setup_refclk(&ref_clk);
 	davinci_common_init(&davinci_soc_info_dm646x);
 }
 
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 7a27f3f..2a00fe5 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -15,7 +15,6 @@
 #include <mach/asp.h>
 #include <linux/i2c.h>
 #include <linux/videodev2.h>
-#include <linux/clk.h>
 #include <linux/davinci_emac.h>
 
 #define DM646X_EMAC_BASE		(0x01C80000)
@@ -31,7 +30,6 @@
 void __init dm646x_init(void);
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
-void __init dm646x_board_setup_refclk(struct clk *clk);
 int __init dm646x_init_edma(struct edma_rsv_info *rsv);
 
 void dm646x_video_init(void);
-- 
1.7.3.2
