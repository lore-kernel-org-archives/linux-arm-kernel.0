From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 21 Oct 2010 23:20:27 +0200
Subject: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <4CC0A281.1010202@eukrea.com>
References: <4CC0A281.1010202@eukrea.com>
Message-ID: <1287696028-27854-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix timeout problems on i.MX's sdhci as suggested by
Richard Zhu.

Tested on :
- i.MX257 : not needed
- i.MX357 : needed
- i.MX515 : needed

more details can be found here :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029748.html

Signed-off-by: Eric B?nard <eric@eukrea.com>
Tested-by: Shawn Guo <shawn.gsc@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index afbac9a..11e1ae1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -130,6 +130,12 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		gpio_request(boarddata->wp_gpio, "SD_WP");
 		gpio_direction_input(boarddata->wp_gpio);
 	}
+
+	if (cpu_is_mx35() || cpu_is_mx51()) {
+		dev_info(mmc_dev(host->mmc), "using broken timeout quirk\n");
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	}
+
 	return 0;
 }
 
-- 
1.7.0.4
