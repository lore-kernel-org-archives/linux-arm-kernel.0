From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Feb 2016 17:51:43 -0700
Subject: [PATCH 01/21] coresight: "DEVICE_ATTR_RO" should defined as static.
In-Reply-To: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
References: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1455756723-8456-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Long <eric.long@linaro.org>

"DEVICE_ATTR_RO(name)" should be defined as static. And
there is an unnecessary space at the front of the code.

The sparse tool output logs as the following:
coresight-etm4x.c:2224:1: warning: symbol 'dev_attr_trcoslsr' was
not declared. Should it be static?
coresight-etm4x.c:2225:1: warning: symbol 'dev_attr_trcpdcr' was
not declared. Should it be static?
coresight-etm4x.c:2226:1: warning: symbol 'dev_attr_trcpdsr' was
not declared. Should it be static?
And the smatch tool output logs as the following:
of_coresight.c:89 of_coresight_alloc_memory() warn:
inconsistent indenting

Signed-off-by: Eric Long <eric.long@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
 drivers/hwtracing/coresight/of_coresight.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index b6ae9cb6ff57..d6a92c6d3a66 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -2227,7 +2227,7 @@ static ssize_t name##_show(struct device *_dev,				\
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
 			 readl_relaxed(drvdata->base + offset));	\
 }									\
-DEVICE_ATTR_RO(name)
+static DEVICE_ATTR_RO(name)
 
 coresight_simple_func(trcoslsr, TRCOSLSR);
 coresight_simple_func(trcpdcr, TRCPDCR);
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index b0973617826f..3cc57c1e3b5d 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -86,7 +86,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 		return -ENOMEM;
 
 	/* Children connected to this component via @outports */
-	 pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
+	pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
 					  sizeof(*pdata->child_names),
 					  GFP_KERNEL);
 	if (!pdata->child_names)
-- 
2.1.4
