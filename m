From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 13 Jan 2017 13:38:01 +0100
Subject: [PATCH 07/10] sata: ahci_da850: add support for the da850,
 clk_multiplier DT property
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484311084-31547-8-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the clock multiplier is hardcoded in the driver for
the da850-evm board. Make it configurable over DT, but keep the
previous value as default in case the property is missing.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_da850.c | 83 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index bb9eb4c..cd04caf 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -28,17 +28,70 @@
 #define SATA_PHY_TXSWING(x)	((x) << 19)
 #define SATA_PHY_ENPLL(x)	((x) << 31)
 
+struct da850_sata_mpy_mapping {
+	unsigned int multiplier;
+	unsigned int regval;
+};
+
+static const struct da850_sata_mpy_mapping da850_sata_mpy_table[] = {
+	{
+		.multiplier	= 5,
+		.regval		= 0x01,
+	},
+	{
+		.multiplier	= 6,
+		.regval		= 0x02,
+	},
+	{
+		.multiplier	= 8,
+		.regval		= 0x04,
+	},
+	{
+		.multiplier	= 10,
+		.regval		= 0x05,
+	},
+	{
+		.multiplier	= 12,
+		.regval		= 0x06,
+	},
+	/* TODO Add 12.5 multiplier. */
+	{
+		.multiplier	= 15,
+		.regval		= 0x08,
+	},
+	{
+		.multiplier	= 20,
+		.regval		= 0x09,
+	},
+	{
+		.multiplier	= 25,
+		.regval		= 0x0a,
+	}
+};
+
+static const struct da850_sata_mpy_mapping *
+da850_sata_get_mpy(unsigned int multiplier)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(da850_sata_mpy_table); i++)
+		if (da850_sata_mpy_table[i].multiplier == multiplier)
+			return &da850_sata_mpy_table[i];
+
+	return NULL;
+}
+
 /*
  * The multiplier needed for 1.5GHz PLL output.
  *
- * NOTE: This is currently hardcoded to be suitable for 100MHz crystal
- * frequency (which is used by DA850 EVM board) and may need to be changed
- * if you would like to use this driver on some other board.
+ * This is the default value suitable for the 100MHz crystal frequency
+ * used by DA850 EVM board, which doesn't use DT.
  */
-#define DA850_SATA_CLK_MULTIPLIER	7
+#define DA850_SATA_CLK_MULTIPLIER_DEFAULT	15
 
 static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
-			    void __iomem *ahci_base)
+			    void __iomem *ahci_base,
+			    const struct da850_sata_mpy_mapping *mpy)
 {
 	unsigned int val;
 
@@ -47,7 +100,7 @@ static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
 	val &= ~BIT(0);
 	writel(val, pwrdn_reg);
 
-	val = SATA_PHY_MPY(DA850_SATA_CLK_MULTIPLIER + 1) | SATA_PHY_LOS(1) |
+	val = SATA_PHY_MPY(mpy->regval) | SATA_PHY_LOS(1) |
 	      SATA_PHY_RXCDR(4) | SATA_PHY_RXEQ(1) | SATA_PHY_TXSWING(3) |
 	      SATA_PHY_ENPLL(1);
 
@@ -87,10 +140,12 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int ahci_da850_probe(struct platform_device *pdev)
 {
+	const struct da850_sata_mpy_mapping *mpy;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct resource *res;
+	unsigned int multiplier;
 	void __iomem *pwrdn_reg;
+	struct resource *res;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
@@ -109,7 +164,19 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	if (!pwrdn_reg)
 		goto disable_resources;
 
-	da850_sata_init(dev, pwrdn_reg, hpriv->mmio);
+	rc = of_property_read_u32(dev->of_node,
+				  "da850,clk_multiplier", &multiplier);
+	if (rc)
+		multiplier = DA850_SATA_CLK_MULTIPLIER_DEFAULT;
+
+	mpy = da850_sata_get_mpy(multiplier);
+	if (!mpy) {
+		dev_err(dev, "invalid multiplier value: %u\n", multiplier);
+		rc = -EINVAL;
+		goto disable_resources;
+	}
+
+	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
 				     &ahci_platform_sht);
-- 
2.9.3
