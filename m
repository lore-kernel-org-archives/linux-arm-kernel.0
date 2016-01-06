From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jan 2016 11:55:57 +0800
Subject: [PATCH v2 04/12] mmc: sdhci-msm: use sdhci_pltfm_init for private
 allocation
In-Reply-To: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Message-ID: <1452052565-4232-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-msm
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-msm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ffac9b4..548ae58 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -442,16 +442,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	u32 core_version, caps;
 	u8 core_major;
 
-	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
-	if (!msm_host)
-		return -ENOMEM;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata,
+				sizeof(*msm_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = msm_host;
+	msm_host = sdhci_pltfm_priv(pltfm_host);
 	msm_host->mmc = host->mmc;
 	msm_host->pdev = pdev;
 
@@ -571,7 +568,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_msm_host *msm_host = pltfm_host->priv;
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int dead = (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) ==
 		    0xffffffff);
 
-- 
2.7.0.rc3
