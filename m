From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:47 +0100
Subject: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv ptr to
 ahci_platform_data init method
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ahci_platform_data->init methods need access to the ahci_host_priv data.

Note:

When calling ahci_platform_data->init the ata_host has not been allocated yet,
so access to ahci_host_priv through the dev argument is not possible.

The hpriv->mmio argument may seem redundant, but it is useful for drivers
which live outside of drivers/ata and thus don't know the contents of the
ahci_platform_data data type.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 3 ++-
 arch/arm/mach-spear/spear1340.c       | 3 ++-
 drivers/ata/ahci_imx.c                | 3 ++-
 drivers/ata/ahci_platform.c           | 2 +-
 include/linux/ahci_platform.h         | 4 +++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 78829c5..81d0110 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1061,7 +1061,8 @@ static unsigned long da850_sata_xtal[] = {
 	KHZ_TO_HZ(60000),
 };
 
-static int da850_sata_init(struct device *dev, void __iomem *addr)
+static int da850_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
+			   void __iomem *addr)
 {
 	int i, ret;
 	unsigned int val;
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index c4cbbd2..9e4f70b 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -77,7 +77,8 @@
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
 
 /* SATA device registration */
-static int sata_miphy_init(struct device *dev, void __iomem *addr)
+static int sata_miphy_init(struct device *dev, struct ahci_host_priv *hpriv,
+			   void __iomem *addr)
 {
 	writel(SPEAR1340_SATA_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
 	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 30568d3..0051f29 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -91,7 +91,8 @@ static const struct ata_port_info ahci_imx_port_info = {
 	.port_ops	= &ahci_imx_ops,
 };
 
-static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
+static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
+			   void __iomem *mmio)
 {
 	int ret = 0;
 	unsigned int reg_val;
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 41720cb..33ac7a4 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -149,7 +149,7 @@ static int ahci_probe(struct platform_device *pdev)
 	 * returned successfully.
 	 */
 	if (pdata && pdata->init) {
-		rc = pdata->init(dev, hpriv->mmio);
+		rc = pdata->init(dev, hpriv, hpriv->mmio);
 		if (rc)
 			goto disable_unprepare_clk;
 	}
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index a641cb6..796dfb4 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -19,9 +19,11 @@
 
 struct device;
 struct ata_port_info;
+struct ahci_host_priv;
 
 struct ahci_platform_data {
-	int (*init)(struct device *dev, void __iomem *addr);
+	int (*init)(struct device *dev, struct ahci_host_priv *hpriv,
+		    void __iomem *addr);
 	void (*exit)(struct device *dev);
 	void (*suspend)(struct device *dev);
 	int (*resume)(struct device *dev);
-- 
1.8.4.2
