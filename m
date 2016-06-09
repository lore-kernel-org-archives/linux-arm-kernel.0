From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:11 +0200
Subject: [PATCH 05/12] mmc: sdhci: add a pre voltage switch callback function
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Gu <xigu@marvell.com>

Some host controller such as Xenon needs additional setting when
switching signal voltage in eMMC mode. They also need to re-enable
internal clock before a voltage switch.

This commit adds a callback routine "voltage_switch_pre" in the struct
sdhci_ops, which is used by some host controllers which need re-enable
the internal clock before a voltage switch.

[gregory.clement at free-electrons.com: split the initial commit and
reformulate the log]

Signed-off-by: Victor Gu <xigu@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b07219426d39..cad03ffa9d9b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1729,6 +1729,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
+	/* Some controller need to do more before switching */
+	if (host->ops->voltage_switch_pre)
+		host->ops->voltage_switch_pre(host);
+
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
 	switch (ios->signal_voltage) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 49c6c5b0e33b..6bec1b0368d2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -550,6 +550,7 @@ struct sdhci_ops {
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
 	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
+	void	(*voltage_switch_pre)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.5.0
