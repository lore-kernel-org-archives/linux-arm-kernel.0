From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jan 2014 17:45:01 +0100
Subject: [PATCH RFC v4 08/10] ahci-platform: "Library-ise" suspend / resume
 functionality
In-Reply-To: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390236303-22538-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split suspend / resume code into host suspend / resume functionality and
resource enable / disabling phases, and export the new suspend_ / resume_host
functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_platform.c   | 55 +++++++++++++++++++++++++++++++------------
 include/linux/ahci_platform.h |  7 ++++++
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index b260ebe..ba93930 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -353,14 +353,12 @@ static void ahci_host_stop(struct ata_host *host)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int ahci_suspend(struct device *dev)
+int ahci_platform_suspend_host(struct device *dev)
 {
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 ctl;
-	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
 		dev_err(dev, "firmware update required for suspend/resume\n");
@@ -377,7 +375,37 @@ static int ahci_suspend(struct device *dev)
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
-	rc = ata_host_suspend(host, PMSG_SUSPEND);
+	return ata_host_suspend(host, PMSG_SUSPEND);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
+
+int ahci_platform_resume_host(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	int rc;
+
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
+		rc = ahci_reset_controller(host);
+		if (rc)
+			return rc;
+
+		ahci_init_controller(host);
+	}
+
+	ata_host_resume(host);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_resume_host);
+
+int ahci_platform_suspend(struct device *dev)
+{
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	int rc;
+
+	rc = ahci_platform_suspend_host(dev);
 	if (rc)
 		return rc;
 
@@ -388,8 +416,9 @@ static int ahci_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ahci_platform_suspend);
 
-static int ahci_resume(struct device *dev)
+int ahci_platform_resume(struct device *dev)
 {
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -406,15 +435,9 @@ static int ahci_resume(struct device *dev)
 			goto disable_resources;
 	}
 
-	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(host);
-		if (rc)
-			goto disable_resources;
-
-		ahci_init_controller(host);
-	}
-
-	ata_host_resume(host);
+	rc = ahci_platform_resume_host(dev);
+	if (rc)
+		goto disable_resources;
 
 	return 0;
 
@@ -423,9 +446,11 @@ disable_resources:
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_platform_resume);
 #endif
 
-static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
+static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
+			 ahci_platform_resume);
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 1dc7602..b484ac0 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -50,4 +50,11 @@ int ahci_platform_init_host(struct platform_device *pdev,
 			    unsigned int force_port_map,
 			    unsigned int mask_port_map);
 
+#ifdef CONFIG_PM_SLEEP
+int ahci_platform_suspend_host(struct device *dev);
+int ahci_platform_resume_host(struct device *dev);
+int ahci_platform_suspend(struct device *dev);
+int ahci_platform_resume(struct device *dev);
+#endif
+
 #endif /* _AHCI_PLATFORM_H */
-- 
1.8.5.3
