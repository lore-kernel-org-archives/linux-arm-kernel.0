From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:52 +0100
Subject: [PATCH 10/13] coresight: funnel: Claim devices before use
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CLAIM protocol to grab the ownership of the component.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ee7a30b..9279251 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -25,6 +25,7 @@
 #define FUNNEL_HOLDTIME_MASK	0xf00
 #define FUNNEL_HOLDTIME_SHFT	0x8
 #define FUNNEL_HOLDTIME		(0x7 << FUNNEL_HOLDTIME_SHFT)
+#define FUNNEL_ENSx_MASK	0xff
 
 /**
  * struct funnel_drvdata - specifics associated to a funnel component
@@ -42,31 +43,42 @@ struct funnel_drvdata {
 	unsigned long		priority;
 };
 
-static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
+static int funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 {
 	u32 functl;
+	int rc = 0;
 
 	CS_UNLOCK(drvdata->base);
 
 	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
+	/* Claim the device only when we enable the first slave */
+	if (!(functl & FUNNEL_ENSx_MASK)) {
+		rc = coresight_claim_device_unlocked(drvdata->base);
+		if (rc)
+			goto done;
+	}
+
 	functl &= ~FUNNEL_HOLDTIME_MASK;
 	functl |= FUNNEL_HOLDTIME;
 	functl |= (1 << port);
 	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
 	writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);
-
+done:
 	CS_LOCK(drvdata->base);
+	return rc;
 }
 
 static int funnel_enable(struct coresight_device *csdev, int inport,
 			 int outport)
 {
+	int rc;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	funnel_enable_hw(drvdata, inport);
+	rc = funnel_enable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
-	return 0;
+	if (!rc)
+		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	return rc;
 }
 
 static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
@@ -79,6 +91,10 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
 	functl &= ~(1 << inport);
 	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
 
+	/* Disclaim the device if none of the slaves are now active */
+	if (!(functl & FUNNEL_ENSx_MASK))
+		coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 }
 
-- 
2.7.4
