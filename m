From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 31 Jan 2012 23:26:15 +0530
Subject: [PATCH v3 5/6] mmc: sdhci-s3c: Keep a copy of platform data and use it
In-Reply-To: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1328032576-9269-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform data is copied into driver's private data and the copy is
used for all access to the platform data. This simpifies the addition
of device tree support for the sdhci-s3c driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a57d7a0..1760ba8 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -424,7 +424,7 @@ static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 {
-	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
+	struct s3c_sdhci_platdata *pdata;
 	struct sdhci_s3c_drv_data *drv_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
@@ -432,7 +432,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq, ptr, clks;
 
-	if (!pdata) {
+	if (!pdev->dev.platform_data) {
 		dev_err(dev, "no device data specified\n");
 		return -ENOENT;
 	}
@@ -455,6 +455,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 	}
 
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		ret = -ENOMEM;
+		goto err_io_clk;
+	}
+	memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
+
 	drv_data = sdhci_s3c_get_driver_data(pdev);
 	sc = sdhci_priv(host);
 
-- 
1.6.6.rc2
