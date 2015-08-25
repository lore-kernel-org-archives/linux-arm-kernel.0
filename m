From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Aug 2015 16:43:40 -0700
Subject: [GIT PULL 1/9] clk: tegra: Changes for v4.3-rc1
In-Reply-To: <1439563720-13189-2-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
 <1439563720-13189-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150825234340.GN19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14, Thierry Reding wrote:
> Hi Mike, Stephen,
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-clk
> 
> for you to fetch changes up to 79cf95c763a11d4b365cd5a627fd1ab4dca67890:
> 
>   clk: tegra: Add the DFLL as a possible parent of the cclk_g clock (2015-07-16 10:40:20 +0200)
> 

Pulled into clk-next. I had to apply this patch on top though.
Please check and be more careful next time.

Also, I don't understand why __raw_{readl,writel} is used. You
probably wanted the relaxed versions of the accessors, and not
the ones that don't do any byte swapping.

Finally, please Cc linux-clk at vger.kernel.org next time.

Thanks!

----8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: tegra: Fix some static checker problems

The latest Tegra clk pull had some problems. Fix them.

drivers/clk/tegra/clk-tegra124.c:1450:6: warning: symbol 'tegra124_clock_assert_dfll_dvco_reset' was not declared. Should it be static?
drivers/clk/tegra/clk-tegra124.c:1466:6: warning: symbol 'tegra124_clock_deassert_dfll_dvco_reset' was not declared. Should it be static?
drivers/clk/tegra/clk-tegra124.c:1476:5: warning: symbol 'tegra124_reset_assert' was not declared. Should it be static?
drivers/clk/tegra/clk-tegra124.c:1486:5: warning: symbol 'tegra124_reset_deassert' was not declared. Should it be static?
drivers/clk/tegra/clk-dfll.c:590 dfll_load_i2c_lut() warn: inconsistent indenting
drivers/clk/tegra/clk-dfll.c:1448 dfll_build_i2c_lut() warn: unsigned 'td->i2c_lut[0]' is never less than zero.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/tegra/clk-dfll.c     | 8 +++++---
 drivers/clk/tegra/clk-tegra124.c | 8 ++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 109a79b95238..c2ff859ee0e8 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -587,7 +587,7 @@ static void dfll_load_i2c_lut(struct tegra_dfll *td)
 		else
 			lut_index = i;
 
-		  val = regulator_list_hardware_vsel(td->vdd_reg,
+		val = regulator_list_hardware_vsel(td->vdd_reg,
 						     td->i2c_lut[lut_index]);
 		__raw_writel(val, td->lut_base + i * 4);
 	}
@@ -1432,6 +1432,7 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 	int selector;
 	unsigned long rate;
 	struct dev_pm_opp *opp;
+	int lut;
 
 	rcu_read_lock();
 
@@ -1444,9 +1445,10 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 	v_max = dev_pm_opp_get_voltage(opp);
 
 	v = td->soc->min_millivolts * 1000;
-	td->i2c_lut[0] = find_vdd_map_entry_exact(td, v);
-	if (td->i2c_lut[0] < 0)
+	lut = find_vdd_map_entry_exact(td, v);
+	if (lut < 0)
 		goto out;
+	td->i2c_lut[0] = lut;
 
 	for (j = 1, rate = 0; ; rate++) {
 		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index a9e2b30737ec..824d75883d2b 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1447,7 +1447,7 @@ static void tegra124_car_barrier(void)
  *
  * Assert the reset line of the DFLL's DVCO.  No return value.
  */
-void tegra124_clock_assert_dfll_dvco_reset(void)
+static void tegra124_clock_assert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1463,7 +1463,7 @@ void tegra124_clock_assert_dfll_dvco_reset(void)
  * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
  * operate.  No return value.
  */
-void tegra124_clock_deassert_dfll_dvco_reset(void)
+static void tegra124_clock_deassert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1473,7 +1473,7 @@ void tegra124_clock_deassert_dfll_dvco_reset(void)
 	tegra124_car_barrier();
 }
 
-int tegra124_reset_assert(unsigned long id)
+static int tegra124_reset_assert(unsigned long id)
 {
 	if (id == TEGRA124_RST_DFLL_DVCO)
 		tegra124_clock_assert_dfll_dvco_reset();
@@ -1483,7 +1483,7 @@ int tegra124_reset_assert(unsigned long id)
 	return 0;
 }
 
-int tegra124_reset_deassert(unsigned long id)
+static int tegra124_reset_deassert(unsigned long id)
 {
 	if (id == TEGRA124_RST_DFLL_DVCO)
 		tegra124_clock_deassert_dfll_dvco_reset();
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
