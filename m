From: david@lechnology.com (David Lechner)
Date: Wed,  9 Mar 2016 17:50:04 -0600
Subject: [PATCH 3/4] mmc: davinci: prepare clock
In-Reply-To: <1457567405-30475-1-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
Message-ID: <1457567405-30475-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When trying to use this driver with the common clock framework, enabling
the clock fails because it was not prepared. This fixes the problem by
calling clk_prepare and clk_enable in a single function.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index f571549..b160feb 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1283,9 +1283,9 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		ret = PTR_ERR(host->clk);
 		goto clk_get_fail;
 	}
-	ret = clk_enable(host->clk);
+	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		goto clk_enable_fail;
+		goto clk_prepare_enable_fail;
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
@@ -1384,7 +1384,7 @@ mmc_add_host_fail:
 cpu_freq_fail:
 	davinci_release_dma_channels(host);
 	clk_disable(host->clk);
-clk_enable_fail:
+clk_prepare_enable_fail:
 	clk_put(host->clk);
 clk_get_fail:
 	iounmap(host->base);
-- 
1.9.1
