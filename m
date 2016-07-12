From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 12 Jul 2016 15:46:20 +0800
Subject: [PATCH V2 11/15] mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong
 clock issue
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1468309584-3591-12-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enable DDR, the clock factor definition is changed.
e.g. original 200Mhz will become 100Mhz once MIX_CTRL_DDREN bit is set
So we need to update the clock setting then the strobe dll can lock
the correct clock rate.

Additionally we also need disable the clock before locking strobe dll.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ac2c83af7440..bbb0bd4eac28 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -853,6 +853,11 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	u32 v;
 
 	if (host->mmc->actual_clock > ESDHC_STROBE_DLL_CLK_FREQ) {
+		/* disable clock before enabling strobe dll */
+		writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
+		       ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+		       host->ioaddr + ESDHC_VENDOR_SPEC);
+
 		/* force a reset on strobe dll */
 		writel(ESDHC_STROBE_DLL_CTRL_RESET,
 			host->ioaddr + ESDHC_STROBE_DLL_CTRL);
@@ -914,6 +919,8 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
+		/* update clock after enable DDR for strobe DLL lock */
+		host->ops->set_clock(host, host->clock);
 		esdhc_set_strobe_dll(host);
 		break;
 	}
-- 
1.9.1
