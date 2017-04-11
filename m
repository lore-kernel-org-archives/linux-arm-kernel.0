From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 11 Apr 2017 17:10:28 +0800
Subject: [PATCH RFC 3/4] coresight: tmc: dump RAM when device is disabled
In-Reply-To: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
References: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1491901829-18477-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coresight framework creates /dev nodes for ETB/ETF devices, these nodes
cannot read out data if without enable the coresight path. Finally we
lose chance to dump RAM if there have some old data kept in it.

So this patch is to add support to dump RAM when device is disabled,
with this small change we can easily read out ETB RAM data before there
have new data has been sent to it. These dump data may come from the
previous system running, so it will be very helpful to analyze some hang
issue before system dead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 43cfeaa..5e709af 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -95,7 +95,7 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (drvdata->mode != CS_MODE_PERF)
 		tmc_etb_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
@@ -557,6 +557,10 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
+	/* Try to dump RAM even for disabled state */
+	if (drvdata->mode == CS_MODE_DISABLED)
+		drvdata->buf = kzalloc(drvdata->size, GFP_KERNEL);
+
 	/* If drvdata::buf is NULL the trace data has been read already */
 	if (drvdata->buf == NULL) {
 		ret = -EINVAL;
@@ -564,8 +568,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etb_disable_hw(drvdata);
+	tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
-- 
2.7.4
