From: vinceh@nvidia.com (Vince Hsu)
Date: Thu, 12 Mar 2015 20:15:07 +0800
Subject: [PATCH v2 06/17] clk: tegra: remove TEGRA_PLL_USE_LOCK for PLLD/PLLD2
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Message-ID: <1426162518-7405-7-git-send-email-vinceh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra114 has a HW bug that the PLLD/PLLD2 lock bit cannot be asserted when
the DIS power domain is during up-powergating process but the clamp to this
domain is not removed yet. That causes a timeout and aborts the power
sequence, although the PLLD/PLLD2 has already locked. To remove the false
alarm, we don't use the lock for PLLD/PLLD2. Just wait 1ms and treat the
clocks as locked.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index d0766423a5d6..e6a480e0dcb6 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -456,8 +456,7 @@ static struct tegra_clk_pll_params pll_d_params = {
 	.lock_delay = 1000,
 	.div_nmp = &pllp_nmp,
 	.freq_table = pll_d_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
-		 TEGRA_PLL_USE_LOCK,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
 };
 
 static struct tegra_clk_pll_params pll_d2_params = {
@@ -474,8 +473,7 @@ static struct tegra_clk_pll_params pll_d2_params = {
 	.lock_delay = 1000,
 	.div_nmp = &pllp_nmp,
 	.freq_table = pll_d_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
-		 TEGRA_PLL_USE_LOCK,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
 };
 
 static struct pdiv_map pllu_p[] = {
-- 
2.1.4
