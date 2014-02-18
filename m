From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 15:10:50 +0000
Subject: [PATCH RFC 21/31] mmc: sdhci-esdhc-imx: avoid runtime_pm_get_sync()
 in esdhc_prepare_tuning()
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Message-ID: <E1WFmJu-0006nG-MT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The caller will already have dealt with runtime PM, so there's no need
to get it here as well - moreover, this results in the runtime PM use
count becoming unbalanced, and preventing runtime PM from operating.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5acfe2fc4fe0..a9a20c856b0b 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -695,7 +695,6 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
 
-	pm_runtime_get_sync(host->mmc->parent);
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
-- 
1.8.3.1
