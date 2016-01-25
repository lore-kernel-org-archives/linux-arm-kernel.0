From: eric.long@linaro.org (Eric Long)
Date: Mon, 25 Jan 2016 16:34:56 +0800
Subject: [PATCH v2 2/2] coresight: etm4x: Check every parameter used by
 dma_xx_coherent.
In-Reply-To: <cover.1453708131.git.eric.long@linaro.org>
References: <cover.1453708131.git.eric.long@linaro.org>
Message-ID: <00fb1f689658102676c338a2c4fd95046346f588.1453708131.git.eric.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_alloc_coherent return an "void *" not an "void __iomen *".
It uses the wrong parameters when calls dma_free_coherent function.

The sparse tool output logs as the following:
coresight-tmc.c:199:23:    expected void *<noident>
coresight-tmc.c:199:23:    got void [noderef] <asn:2>*vaddr
coresight-tmc.c:336:30: warning: incorrect type in assignment
(different address spaces)
coresight-tmc.c:336:30:    expected char *buf
coresight-tmc.c:336:30:    got void [noderef] <asn:2>*
coresight-tmc.c:769:50: warning: incorrect type in argument 4
(different base types)
coresight-tmc.c:769:50:    expected unsigned long long
[unsigned] [usertype] dma_handle
coresight-tmc.c:769:50:    got restricted gfp_t

Signed-off-by: Eric Long <eric.long@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index a57c7ec..5b052d1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -124,7 +124,7 @@ struct tmc_drvdata {
 	bool			reading;
 	char			*buf;
 	dma_addr_t		paddr;
-	void __iomem		*vaddr;
+	void			*vaddr;
 	u32			size;
 	bool			enable;
 	enum tmc_config_type	config_type;
@@ -766,7 +766,7 @@ err_misc_register:
 err_devm_kzalloc:
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
 		dma_free_coherent(dev, drvdata->size,
-				&drvdata->paddr, GFP_KERNEL);
+				drvdata->vaddr, drvdata->paddr);
 	return ret;
 }
 
@@ -778,7 +778,7 @@ static int tmc_remove(struct amba_device *adev)
 	coresight_unregister(drvdata->csdev);
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
 		dma_free_coherent(drvdata->dev, drvdata->size,
-				  &drvdata->paddr, GFP_KERNEL);
+				  drvdata->vaddr, drvdata->paddr);
 
 	return 0;
 }
-- 
1.7.9.5
