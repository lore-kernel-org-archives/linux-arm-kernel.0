From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 16:47:18 -0700
Subject: [PATCH 1/5] clk: tegra: fix blink clock rate
Message-ID: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The blink clock rate needs to be configured, or it will run at ~1Hz
rather than the desired 32KHz. If it runs at the wrong rate, e.g. the
SDIO WiFi on Seaboard and Cardhu will fail to be detected.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This probably needs to be squashed into commit 32721a734a3d "clk: tegra:
move PMC, fixed clocks to common files".
---
 drivers/clk/tegra/clk-tegra-pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-tegra-pmc.c
index 00e8275a7178..08b21c1ee867 100644
--- a/drivers/clk/tegra/clk-tegra-pmc.c
+++ b/drivers/clk/tegra/clk-tegra-pmc.c
@@ -114,6 +114,7 @@ void __init tegra_pmc_clk_init(void __iomem *pmc_base,
 	}
 
 	/* blink */
+	writel_relaxed(0, pmc_base + PMC_BLINK_TIMER);
 	clk = clk_register_gate(NULL, "blink_override", "clk_32k", 0,
 				pmc_base + PMC_DPD_PADS_ORIDE,
 				PMC_DPD_PADS_ORIDE_BLINK_ENB, 0, NULL);
-- 
1.8.1.5
