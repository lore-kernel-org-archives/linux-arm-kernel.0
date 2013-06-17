From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Jun 2013 10:43:11 -0700
Subject: [PATCH/RESEND 04/12] msm_sdcc: Convert to clk_prepare/unprepare
In-Reply-To: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371490999-15501-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add calls to clk_prepare and unprepare so that MSM can migrate to
the common clock framework.

Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 0ee4a57..b900de4 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1268,10 +1268,18 @@ msmsdcc_probe(struct platform_device *pdev)
 		goto clk_put;
 	}
 
+	ret = clk_prepare(host->pclk);
+	if (ret)
+		goto clk_put;
+
+	ret = clk_prepare(host->clk);
+	if (ret)
+		goto clk_unprepare_p;
+
 	/* Enable clocks */
 	ret = msmsdcc_enable_clocks(host);
 	if (ret)
-		goto clk_put;
+		goto clk_unprepare;
 
 	host->pclk_rate = clk_get_rate(host->pclk);
 	host->clk_rate = clk_get_rate(host->clk);
@@ -1386,6 +1394,10 @@ msmsdcc_probe(struct platform_device *pdev)
 		free_irq(host->stat_irq, host);
  clk_disable:
 	msmsdcc_disable_clocks(host, 0);
+ clk_unprepare:
+	clk_unprepare(host->clk);
+ clk_unprepare_p:
+	clk_unprepare(host->pclk);
  clk_put:
 	clk_put(host->clk);
  pclk_put:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
