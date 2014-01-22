From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Jan 2014 20:04:47 +0100
Subject: [PATCH v5 12/14] ahci-imx: Fix link not coming back up after suspend
 / resume
In-Reply-To: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390417489-5354-13-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy needs to be re-initialized on resume for the link to properly come
back up.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_imx.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index e58e062..68d89fa 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -265,27 +265,11 @@ static int imx_ahci_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	int ret;
 
-	if (hpriv->target_pwr) {
-		ret = regulator_enable(hpriv->target_pwr);
-		if (ret)
-			return ret;
-	}
-
-	if (!imxpriv->no_device) {
-		ret = ahci_platform_enable_clks(hpriv);
-		if (ret < 0) {
-			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);
-			return ret;
-		}
-
-		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-				IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-		usleep_range(1000, 2000);
-	}
+	ret = imx_ahci_phy_init(hpriv);
+	if (ret)
+		return ret;
 
 	return ahci_platform_resume_host(dev);
 }
-- 
1.8.5.3
