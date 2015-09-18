From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:20 -0600
Subject: [RFC PATCH 06/20] coresight: etm3x: unlocking tracer in default arch
 init
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling function 'smp_call_function_single()' to unlock the
tracer and calling it right after to perform the default
initialisation doesn't make sense.

Moving 'etm_os_unlock()' just before making the default
initialisation results in the same outcome while saving
one call to 'smp_call_function_single()'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index c6880c1ade55..a4c158df0fef 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1867,6 +1867,11 @@ static void etm_init_arch_data(void *info)
 	 * certain registers might be ignored.
 	 */
 	etm_clr_pwrdwn(drvdata);
+
+	/* Make sure all registers are accessible */
+	etm_os_unlock(drvdata);
+	drvdata->os_unlock = true;
+
 	/*
 	 * Set prog bit. It will be set from reset but this is included to
 	 * ensure it is set
@@ -1961,9 +1966,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	get_online_cpus();
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	if (!smp_call_function_single(drvdata->cpu, etm_os_unlock, drvdata, 1))
-		drvdata->os_unlock = true;
-
 	if (smp_call_function_single(drvdata->cpu,
 				     etm_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
-- 
1.9.1
