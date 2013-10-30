From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 30 Oct 2013 22:10:41 +0800
Subject: [PATCH 1/2] mmc: sdhci: replace msleep with mdelay for tuning
In-Reply-To: <1383142242-24989-1-git-send-email-b29396@freescale.com>
References: <1383142242-24989-1-git-send-email-b29396@freescale.com>
Message-ID: <1383142242-24989-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The former patch 404aceb may break the tuning process of SD3.0/eMMC4.5 cards.
It changed the mdelay in tuning process to msleep,
However, because the more delay of msleep(1) than mdelay(1), it will
easily lead to a 150ms timeout as limited by the spec.

We oberved tuning failed due to timeout on a Toshiba UHS and eMMC4.5 card
after this change. Thus, for the time sensitive tuning process, change it
back to mdelay as before.

The breaking patch is:
404aceb mmc: sdhci: Get rid of mdelay()s where it is safe and makes sense

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22eab3a..2ef5314 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1981,7 +1981,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
-		msleep(1);
+		mdelay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.2.rc3
