From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 18 Oct 2013 18:54:16 +0800
Subject: [PATCH v2 3/8] mmc: sdhci: report error once the maximum tuning loops
 exhausted or timeout
In-Reply-To: <1382093661-4074-1-git-send-email-b29396@freescale.com>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Message-ID: <1382093661-4074-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original code missed to report an error when the maximum tuning loops exhausted
or timeout, it will cause the upper layer to wrongly think the tuning process
is passed.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 66bce7a..cbde17d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1989,6 +1989,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!tuning_loop_counter || !timeout) {
 		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		err = -EIO;
 	} else {
 		if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
 			pr_info(DRIVER_NAME ": Tuning procedure"
-- 
1.7.2.rc3
