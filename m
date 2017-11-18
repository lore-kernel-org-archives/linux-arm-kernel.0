From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 15:03:46 +0530
Subject: [PATCH 4/6 v2] mmc: sdhci-spear: Handle return value of
 platform_get_irq
In-Reply-To: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
References: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
Message-ID: <d8fc48bacf7cc153d806e10bc39ab507534f4691.1510997223.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/mmc/host/sdhci-spear.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 8c0f884..900838b 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
 	host->hw_name = "sdhci";
 	host->ops = &sdhci_pltfm_ops;
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		ret = host->irq;
+		goto err_host;
+	}
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
 
 	sdhci = sdhci_priv(host);
-- 
2.7.4
