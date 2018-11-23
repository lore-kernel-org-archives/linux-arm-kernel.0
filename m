From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 11:15:54 +0100
Subject: [PATCH 5/7] ata: ahci: mvebu: add clock support
In-Reply-To: <20181123101556.29888-1-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
Message-ID: <20181123101556.29888-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support to the ahci_mvebu.c driver. This is needed in order
to get suspend to RAM working.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 902971bfe301..cad35806c3c2 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -195,6 +195,16 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (!hpriv->plat_data)
 		return -EINVAL;
 
+	/* The clock property is absent in old bindings */
+	hpriv->clks[0] = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(hpriv->clks[0])) {
+		if (PTR_ERR(hpriv->clks[0]) == -EPROBE_DEFER)
+			return PTR_ERR(hpriv->clks[0]);
+
+		dev_warn(&pdev->dev, "no clock available\n");
+		hpriv->clks[0] = NULL;
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
-- 
2.19.1
