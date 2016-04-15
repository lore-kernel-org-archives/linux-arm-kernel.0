From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:38 +0800
Subject: [PATCH 14/23] mmc: sdhci-esdhci-imx: disable DLL delay line settings
 explicitly
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-15-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@freescale.com>

Disable DLL delay line settings explicitly during driver initialization
in case ROM/uBoot had set an invalid delay.
e.g. MX6DL ROM has set the default delay line(DLLCTRL) to 0x1000021,
the uSDHC clock timing will become marginal when works on DDR mode
due to default delay and will possibly see CRC errors in case the board
is not perfectly designed on the eMMC chip layout.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4c28fbb..d02db66 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1186,6 +1186,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		*/
 		writel(readl(host->ioaddr + 0x6c) | BIT(7),
 			host->ioaddr + 0x6c);
+
+		/* disable DLL_CTRL delay line settings */
+		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
1.9.1
