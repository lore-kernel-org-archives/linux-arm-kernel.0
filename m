From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:49 +0100
Subject: [RFC v3 07/13] ahci-platform: Add support for an optional regulator
 for sata-target power
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci.h                                 |  2 ++
 drivers/ata/ahci_platform.c                        | 39 +++++++++++++++++++---
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 3ced07d..1ac807f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -11,6 +11,7 @@ Required properties:
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
+- target-supply     : regulator for SATA target power
 
 Example:
         sata at ffe08000 {
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7950b3a..c3e0c49 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -36,6 +36,7 @@
 #define _AHCI_H
 
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/libata.h>
 
 /* Enclosure Management Control */
@@ -323,6 +324,7 @@ struct ahci_host_priv {
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	struct regulator	*target_pwr;	/* Optional */
 	void			*plat_data;	/* Other platform data */
 	/* Optional ahci_start_engine override */
 	void			(*start_engine)(struct ata_port *ap);
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 75a3d47..3bc2dab 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -181,6 +181,13 @@ static int ahci_probe(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->target_pwr = devm_regulator_get_optional(dev, "target");
+	if (IS_ERR(hpriv->target_pwr)) {
+		if (PTR_ERR(hpriv->target_pwr) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		hpriv->target_pwr = NULL;
+	}
+
 	rc = ahci_enable_clks(dev, hpriv);
 	if (rc)
 		goto free_clk;
@@ -197,6 +204,12 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_unprepare_clk;
 	}
 
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			goto pdata_exit;
+	}
+
 	ahci_save_initial_config(dev, hpriv,
 		pdata ? pdata->force_port_map : 0,
 		pdata ? pdata->mask_port_map  : 0);
@@ -220,7 +233,7 @@ static int ahci_probe(struct platform_device *pdev)
 	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
 	if (!host) {
 		rc = -ENOMEM;
-		goto pdata_exit;
+		goto disable_regulator;
 	}
 
 	host->private_data = hpriv;
@@ -250,7 +263,7 @@ static int ahci_probe(struct platform_device *pdev)
 
 	rc = ahci_reset_controller(host);
 	if (rc)
-		goto pdata_exit;
+		goto disable_regulator;
 
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
@@ -258,9 +271,12 @@ static int ahci_probe(struct platform_device *pdev)
 	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
 			       &ahci_platform_sht);
 	if (rc)
-		goto pdata_exit;
+		goto disable_regulator;
 
 	return 0;
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
@@ -277,6 +293,9 @@ static void ahci_host_stop(struct ata_host *host)
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
@@ -313,6 +332,9 @@ static int ahci_suspend(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
 
@@ -338,10 +360,16 @@ static int ahci_resume(struct device *dev)
 			goto disable_unprepare_clk;
 	}
 
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			goto pdata_suspend;
+	}
+
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
-			goto pdata_suspend;
+			goto disable_regulator;
 
 		ahci_init_controller(host);
 	}
@@ -350,6 +378,9 @@ static int ahci_resume(struct device *dev)
 
 	return 0;
 
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 pdata_suspend:
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
-- 
1.8.4.2
