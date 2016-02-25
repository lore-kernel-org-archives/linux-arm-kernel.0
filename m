From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 26 Feb 2016 00:31:16 +0300
Subject: [patch] soc: ti: wkup_m3_ipc: Fix an error code
Message-ID: <20160225213116.GB18267@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We accidentally return success if we can't load firmware but we intended
to return a negative error code.

Fixes: cdd5de500b2c ('soc: ti: Add wkup_m3_ipc driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 8823cc8..5bb3760 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -459,6 +459,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
 	if (IS_ERR(task)) {
 		dev_err(dev, "can't create rproc_boot thread\n");
+		ret = PTR_ERR(task);
 		goto err_put_rproc;
 	}
 
