From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 15:03:45 +0530
Subject: [PATCH 3/6 v2] mmc: sdhci-acpi: Handle return value of
 platform_get_irq
In-Reply-To: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
References: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
Message-ID: <293914dcf01ddafb7669ab0212c8651071be95c9.1510997223.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/mmc/host/sdhci-acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b988997..dd8129e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -566,6 +566,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->hw_name	= "ACPI";
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		err = host->irq;
+		goto err_free;
+	}
 
 	host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
 					    resource_size(iomem));
-- 
2.7.4
