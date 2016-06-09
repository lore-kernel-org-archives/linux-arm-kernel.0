From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:10 +0200
Subject: [PATCH 04/12] mmc: sdhci: call voltage_switch callback also for the
 3.3V case
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Gu <xigu@marvell.com>

Currently the voltage switch callback function is only called in the 1.8V
case. However, given the name this callback should be called in the 3.3V
case too. It is needed for the Xenon controller.

[gregory.clement at free-electrons.com: split the initial commit and
modify the log]

Signed-off-by: Victor Gu <xigu@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fd4e9a84f739..b07219426d39 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1749,6 +1749,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
 
+		/* Some controller need to do more when switching */
+		if (host->ops->voltage_switch)
+			host->ops->voltage_switch(host);
+
 		/* 3.3V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl & SDHCI_CTRL_VDD_180))
-- 
2.5.0
