From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Tue, 11 Jun 2013 13:11:18 +0300
Subject: [PATCH 1/2] memory: tegra20-mc: Fix hang in IRQ handler.
In-Reply-To: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
References: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1370945479-2917-2-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Tegra20 any memory controller interrupt would cause an
infinite loop in the IRQ handler.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 drivers/memory/tegra20-mc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra20-mc.c b/drivers/memory/tegra20-mc.c
index 2ca5f28..0548eea 100644
--- a/drivers/memory/tegra20-mc.c
+++ b/drivers/memory/tegra20-mc.c
@@ -193,8 +193,11 @@ static irqreturn_t tegra20_mc_isr(int irq, void *data)
 	mask &= stat;
 	if (!mask)
 		return IRQ_NONE;
-	while ((bit = ffs(mask)) != 0)
+	while ((bit = ffs(mask)) != 0) {
 		tegra20_mc_decode(mc, bit - 1);
+		mask &= ~BIT(bit - 1);
+	}
+
 	mc_writel(mc, stat, MC_INTSTATUS);
 	return IRQ_HANDLED;
 }
-- 
1.8.1.5
