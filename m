From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Tue, 11 Jun 2013 13:11:19 +0300
Subject: [PATCH 2/2] memory: tegra30-mc: Fix IRQ handler.
In-Reply-To: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
References: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1370945479-2917-3-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Tegra30 any memory controller interrupt would cause an infinite loop in the
IRQ handler. Additionally, a garbage pointer was used to read the MC
status registers, which causes wrong values to be printed if a MC error
occurred.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 drivers/memory/tegra30-mc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/tegra30-mc.c b/drivers/memory/tegra30-mc.c
index f4ae074..58d2979 100644
--- a/drivers/memory/tegra30-mc.c
+++ b/drivers/memory/tegra30-mc.c
@@ -218,7 +218,7 @@ static void tegra30_mc_decode(struct tegra30_mc *mc, int n)
 		return;
 	}
 
-	err = readl(mc + MC_ERR_STATUS);
+	err = mc_readl(mc, MC_ERR_STATUS);
 
 	type = (err & MC_ERR_TYPE_MASK) >> MC_ERR_TYPE_SHIFT;
 	perm = (err & MC_ERR_INVALID_SMMU_PAGE_MASK) >>
@@ -235,7 +235,7 @@ static void tegra30_mc_decode(struct tegra30_mc *mc, int n)
 	if (cid < ARRAY_SIZE(tegra30_mc_client))
 		client = tegra30_mc_client[cid];
 
-	addr = readl(mc + MC_ERR_ADR);
+	addr = mc_readl(mc, MC_ERR_ADR);
 
 	dev_err_ratelimited(mc->dev, "%s (0x%08x): 0x%08x %s (%s %s %s %s)\n",
 			   mc_int_err[idx], err, addr, client,
@@ -313,8 +313,11 @@ static irqreturn_t tegra30_mc_isr(int irq, void *data)
 	mask &= stat;
 	if (!mask)
 		return IRQ_NONE;
-	while ((bit = ffs(mask)) != 0)
+	while ((bit = ffs(mask)) != 0) {
 		tegra30_mc_decode(mc, bit - 1);
+		mask &= ~BIT(bit - 1);
+	}
+
 	mc_writel(mc, stat, MC_INTSTATUS);
 	return IRQ_HANDLED;
 }
-- 
1.8.1.5
