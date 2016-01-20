From: eric.long@linaro.org (Eric Long)
Date: Wed, 20 Jan 2016 14:39:12 +0800
Subject: [RESEND PATCH 1/2] coresight: tmc/etm4x: Remove the mistakes detected
 by sparse tool
In-Reply-To: <cover.1453271738.git.eric.long@linaro.org>
References: <cover.1453271738.git.eric.long@linaro.org>
Message-ID: <f1edbe1023c54deaadf1ba944f606ab7b98f1de4.1453271739.git.eric.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_alloc_coherent return an "void *" not an "void __iomen *".
It uses the wrong parameters when calls dma_free coherent function,
and "DEVICE_ATTR_RO" should be defined as static.

The sparse tool output logs as the following:
coresight-etm4x.c:2224:1: warning: symbol 'dev_attr_trcoslsr' was
not declared. Should it be static?
coresight-etm4x.c:2225:1: warning: symbol 'dev_attr_trcpdcr' was
not declared. Should it be static?
coresight-etm4x.c:2226:1: warning: symbol 'dev_attr_trcpdsr' was
not declared. Should it be static?
coresight-tmc.c:199:23: warning: incorrect type in argument 1
(different address spaces)
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
 drivers/hwtracing/coresight/coresight-etm4x.c |    2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index a670764..1ec6798 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -2219,7 +2219,7 @@ static ssize_t name##_show(struct device *_dev,				\
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
 			 readl_relaxed(drvdata->base + offset));	\
 }									\
-DEVICE_ATTR_RO(name)
+static DEVICE_ATTR_RO(name)
 
 coresight_simple_func(trcoslsr, TRCOSLSR);
 coresight_simple_func(trcpdcr, TRCPDCR);
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
