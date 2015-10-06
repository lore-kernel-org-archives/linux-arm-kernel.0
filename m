From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  6 Oct 2015 03:22:37 +0200
Subject: [PATCH 3/8] mmc: sdhci-pxav3: fix error handling of armada_38x_quirks
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Message-ID: <1444094562-31165-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of armada_38x_quirks error, all clocks should be cleaned-up, same
as after mv_conf_mbus_windows failure.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: <stable@vger.kernel.org> # v4.2
---
 drivers/mmc/host/sdhci-pxav3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 89a9e49..f5edf9d 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -402,7 +402,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
 		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
-			goto err_clk_get;
+			goto err_mbus_win;
 		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
 		if (ret < 0)
 			goto err_mbus_win;
-- 
1.8.3.1
