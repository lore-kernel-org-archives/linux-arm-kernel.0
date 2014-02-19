From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 19 Feb 2014 13:01:56 +0100
Subject: [PATCH v6 14/18] ata: ahci_platform: Add 'struct device' argument to
 ahci_platform_put_resources()
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392811320-3132-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

There is no easy way to access 'struct device' from 'struct ahci_host_priv'
so add an explicit argument for 'struct device'. We will need it
to call Runtime PM APIs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_imx.c        | 5 +++--
 drivers/ata/ahci_platform.c   | 7 ++++---
 drivers/ata/ahci_sunxi.c      | 2 +-
 include/linux/ahci_platform.h | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 7d51ee2..5cdaf0b 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -276,16 +276,17 @@ static int imx_ahci_probe(struct platform_device *pdev)
 disable:
 	imx_sata_disable(hpriv);
 put_resources:
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 	return ret;
 }
 
 static void ahci_imx_host_stop(struct ata_host *host)
 {
+	struct device *dev = host->dev;
 	struct ahci_host_priv *hpriv = host->private_data;
 
 	imx_sata_disable(hpriv);
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 }
 
 static int imx_ahci_suspend(struct device *dev)
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 073931a..f8ef780 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -243,7 +243,8 @@ free_clk:
 }
 EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
 
-void ahci_platform_put_resources(struct ahci_host_priv *hpriv)
+void ahci_platform_put_resources(struct device *dev,
+				 struct ahci_host_priv *hpriv)
 {
 	int c;
 
@@ -375,7 +376,7 @@ pdata_exit:
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
 put_resources:
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 	return rc;
 }
 
@@ -389,7 +390,7 @@ static void ahci_host_stop(struct ata_host *host)
 		pdata->exit(dev);
 
 	ahci_platform_disable_resources(hpriv);
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 568a211..219d77f 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -194,7 +194,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
 put_resources:
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 	return rc;
 }
 
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 7c683c7..719678c 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -43,7 +43,8 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
 struct ahci_host_priv *ahci_platform_get_resources(
 	struct platform_device *pdev);
-void ahci_platform_put_resources(struct ahci_host_priv *hpriv);
+void ahci_platform_put_resources(struct device *dev,
+				 struct ahci_host_priv *hpriv);
 int ahci_platform_init_host(struct platform_device *pdev,
 			    struct ahci_host_priv *hpriv,
 			    const struct ata_port_info *pi_template,
-- 
1.8.5.3
