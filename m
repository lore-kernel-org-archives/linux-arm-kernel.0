From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:09 +0200
Subject: [PATCH 03/12] mmc: tegra: restrict the voltage_switch() callback to
 the 1.8V case
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given its name the voltage_switch() should be called for any
voltage. However currently it is only called for the 1.8V case.

That means that the current implementation of the callback could have
made this assumption. In order to not adding a regression when the
voltage_switch() function will be called for the other voltage targets,
this patch ensure that the code of the current callback won't be executed
for the other case than 1.8V.

Cc: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bcc0de47fe7e..01f58296125e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -302,6 +302,10 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 
+	/* initially this function was called only for the 1.8V case */
+	if (host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180)
+		return;
+
 	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
 		tegra_host->pad_calib_required = true;
 }
-- 
2.5.0
