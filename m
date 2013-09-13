From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 13 Sep 2013 19:11:37 +0800
Subject: [PATCH v2 8/9] mmc: sdhci-esdhc-imx: set actual_clock in clock setting
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Message-ID: <1379070698-7344-9-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables access the actual_clock via sys.
root at imx6qsabreauto:~# cat /sys/kernel/debug/mmc0/ios
clock:          198000000 Hz
actual clock:   198000000 Hz
vdd:            17 (2.9 ~ 3.0 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 0 (1.80 V)

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fe48ec3..b9899e9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -524,8 +524,9 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	while (host_clock / pre_div / div > clock && div < 16)
 		div++;
 
+	host->mmc->actual_clock = host_clock / pre_div / div;
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
-		clock, host_clock / pre_div / div);
+		clock, host->mmc->actual_clock);
 
 	pre_div >>= 1;
 	div--;
-- 
1.7.1
