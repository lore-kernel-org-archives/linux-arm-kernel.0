From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 18 Jan 2011 10:14:33 -0800
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
Message-ID: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe function adds the MMC host which can start accepting request
immediately. There is an assumption here that no requests happen
immediatly, but it's not always the case. This assumption can causes
a BUG() when the clocks are disabled. The fix is to just remove the
clock disable in the probe function.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index a46b9a8..36dbb71 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1370,9 +1370,6 @@ msmsdcc_probe(struct platform_device *pdev)
 	if (host->timer.function)
 		pr_info("%s: Polling status mode enabled\n", mmc_hostname(mmc));
 
-#if BUSCLK_PWRSAVE
-	msmsdcc_disable_clocks(host, 1);
-#endif
 	return 0;
  cmd_irq_free:
 	free_irq(cmd_irqres->start, host);
-- 
1.7.0.4

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
