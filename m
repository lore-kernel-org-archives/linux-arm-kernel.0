From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 11:15:53 +0100
Subject: [PATCH 4/7] ata: ahci: mvebu: add Armada 3700 initialization needed
 for S2RAM
In-Reply-To: <20181123101556.29888-1-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
Message-ID: <20181123101556.29888-5-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A3700 comphy initialization is done in the firmware (TF-A). Looking at
the SATA PHY initialization routine, there is a comment about "vendor
specific" registers. Two registers are mentioned. They are not
initialized there in the firmware because they are AHCI related, while
the firmware at this location does only PHY configuration. The
solution to avoid doing such initialization is relying on U-Boot.

While this work at boot time, U-Boot is definitely not going to run
during a resume after suspending to RAM.

Two possible solutions were considered:
* Fixing the firmware.
* Fixing the kernel driver.

The first solution would take ages to propagate, while the second
solution is easy to implement as the driver as been a little bit
reworked to prepare for such platform configuration. Hence, this patch
adds an Armada 3700 configuration function to set these two registers
both at boot time (in the probe) and after a suspend (in the resume
path).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index a1fce848bba9..902971bfe301 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -82,6 +82,19 @@ static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
 	return rc;
 }
 
+static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
+{
+	u32 reg;
+
+	writel(0, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_ADDR);
+
+	reg = readl(hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
+	reg |= BIT(6);
+	writel(reg, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
+
+	return 0;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -148,8 +161,7 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
 
-	if (pdata->plat_config)
-		pdata->plat_config(hpriv);
+	pdata->plat_config(hpriv);
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
@@ -190,11 +202,9 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	hpriv->stop_engine = ahci_mvebu_stop_engine;
 
 	pdata = hpriv->plat_data;
-	if (pdata->plat_config) {
-		rc = pdata->plat_config(hpriv);
-		if (rc)
-			goto disable_resources;
-	}
+	rc = pdata->plat_config(hpriv);
+	if (rc)
+		goto disable_resources;
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
 				     &ahci_platform_sht);
@@ -213,7 +223,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
 };
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
-	.plat_config = NULL,
+	.plat_config = ahci_mvebu_armada_3700_config,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
-- 
2.19.1
