From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sat, 23 Oct 2010 01:57:21 +0200
Subject: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <20101022231203.GA6502@void.printf.net>
References: <20101022231203.GA6502@void.printf.net>
Message-ID: <1287791842-706-1-git-send-email-eric@eukrea.com>
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
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2e9cca1..28e63ef 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
+#include <mach/hardware.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -112,6 +113,9 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
+	if (cpu_is_mx35() || cpu_is_mx51())
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 	return 0;
 }
 
-- 
1.7.0.4
