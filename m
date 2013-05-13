From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 13 May 2013 23:18:53 +0200
Subject: [PATCH V2 02/10] mmc: sh_mmcif: handle mmc_of_parse() errors during
 probe
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1368479941-10084-3-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ba76a53..6ded7fb 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1369,7 +1369,11 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto ealloch;
 	}
-	mmc_of_parse(mmc);
+
+	ret = mmc_of_parse(mmc);
+	if (ret < 0)
+		goto eofparse;
+
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->addr	= reg;
@@ -1464,6 +1468,7 @@ eclkupdate:
 	clk_put(host->hclk);
 eclkget:
 	pm_runtime_disable(&pdev->dev);
+eofparse:
 	mmc_free_host(mmc);
 ealloch:
 	iounmap(reg);
-- 
1.7.9.5
