From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 18 Jan 2017 14:19:52 +0100
Subject: [PATCH v3 04/13] sata: ahci-da850: get the sata clock using a
 connection id
In-Reply-To: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484745601-4769-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for using two clocks in the driver (the sysclk2-based
clock and the external REFCLK), check if we got a functional clock
after calling ahci_platform_get_resources(). If not, retry calling
clk_get() with con_id specified.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_da850.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 267a3d3..8cfdc86 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -71,12 +71,28 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
 	void __iomem *pwrdn_reg;
+	struct clk *clk;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	/*
+	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
+	 * when trying to obtain the first clock. This SATA controller uses
+	 * two clocks for which we specify two connection ids. If we don't
+	 * have a clock at this point - call clk_get() again with
+	 * con_id = "sata".
+	 */
+	if (!hpriv->clks[0]) {
+		clk = clk_get(dev, "sata");
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		hpriv->clks[0] = clk;
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
-- 
2.9.3
