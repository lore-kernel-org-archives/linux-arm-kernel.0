From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Sep 2018 12:01:58 +0200
Subject: [PATCH v5 6/9] ata: ahci_sunxi: add support for r40
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Message-ID: <20180903100201.23131-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the r40 compatible to the ahci_sunxi's supported list of
compatible.

Since R40 need ahci_platform to handle the reset controller, we also add
the new AHCI_PLATFORM_GET_RESETS flag for ahci_platform_get_resources().
This has no consequence for older platform (a10, a20) since the reset is
optional.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci_sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 631610b72aa5..911710643305 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -181,7 +181,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	hpriv = ahci_platform_get_resources(pdev, AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
@@ -250,6 +250,7 @@ static SIMPLE_DEV_PM_OPS(ahci_sunxi_pm_ops, ahci_platform_suspend,
 
 static const struct of_device_id ahci_sunxi_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-ahci", },
+	{ .compatible = "allwinner,sun8i-r40-ahci", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
-- 
2.16.4
