From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:08 +0200
Subject: [PATCH 02/12] mmc: sdhci_f_sdh30: restrict voltage_switch() callback
 to the 1.8V case
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given its name the voltage_switch() should be called for any
voltage. However currently it is only called for the 1.8V case.

That means that the current implementation of the callback could have
made this assumption. It seems the case for the f_sdh3 driver. In order
to not adding a regression when the voltage_switch() function will be
called for the other voltage targets, this patch ensure that the code of
the current callback won't be executed for the other case than 1.8V.

Cc: Vincent Yang <vincent.yang@tw.fujitsu.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 983b8b32ef96..09a341cbd572 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -54,6 +54,10 @@ static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 	struct f_sdhost_priv *priv = sdhci_priv(host);
 	u32 ctrl = 0;
 
+	/* Initially this function was called only for the 1.8V case */
+	if (host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180)
+		return;
+
 	usleep_range(2500, 3000);
 	ctrl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
 	ctrl |= F_SDH30_CRES_O_DN;
-- 
2.5.0
