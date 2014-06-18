From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 18 Jun 2014 15:15:37 +0800
Subject: [PATCH RFC 2/2] ahci: remove AHCI_HFLAG_NO_FBS setting
In-Reply-To: <1403067249-8021-3-git-send-email-zhangfei.gao@linaro.org>
References: <1403067249-8021-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1403075737-19853-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AHCI_HFLAG can be set directly in dts.

For example
ahci:sata at f9900000 {
	no-fbs;
	no-ncq;
};

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/ata/ahci_platform.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ebe505c17763..c29fa4a553f4 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -34,7 +34,6 @@ static int ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ahci_host_priv *hpriv;
-	unsigned long hflags = 0;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
@@ -57,11 +56,7 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_resources;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
-		hflags |= AHCI_HFLAG_NO_FBS;
-
-	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
-				     hflags, 0, 0);
+	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info, 0, 0, 0);
 	if (rc)
 		goto pdata_exit;
 
-- 
1.7.9.5
