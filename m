From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Feb 2016 17:51:44 -0700
Subject: [PATCH 02/21] coresight: etm4x: Check every parameter used by
 dma_xx_coherent.
In-Reply-To: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
References: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1455756723-8456-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Long <eric.long@linaro.org>

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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 570d96815f78..c4fa70ed14ce 100644
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
 
-- 
2.1.4
