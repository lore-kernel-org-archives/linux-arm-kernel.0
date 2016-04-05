From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:46 -0600
Subject: [PATCH 05/11] coresight: etm4x: unlocking tracers in default arch init
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As with the ETMv3.x driver, calling 'smp_call_function_single()'
twice in a row is highly ineffective.  As such moving function
'etm4_os_unlock()' before the default initialisation takes
place, which results in the same outcome.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 2744413dedb2..92524fe1aa6c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -44,12 +44,11 @@ module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 static int etm4_count;
 static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
 
-static void etm4_os_unlock(void *info)
+static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
-	struct etmv4_drvdata *drvdata = (struct etmv4_drvdata *)info;
-
 	/* Writing any value to ETMOSLAR unlocks the trace registers */
 	writel_relaxed(0x0, drvdata->base + TRCOSLAR);
+	drvdata->os_unlock = true;
 	isb();
 }
 
@@ -286,6 +285,9 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr5;
 	struct etmv4_drvdata *drvdata = info;
 
+	/* Make sure all registers are accessible */
+	etm4_os_unlock(drvdata);
+
 	CS_UNLOCK(drvdata->base);
 
 	/* find all capabilities of the tracing unit */
@@ -603,9 +605,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	get_online_cpus();
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	if (!smp_call_function_single(drvdata->cpu, etm4_os_unlock, drvdata, 1))
-		drvdata->os_unlock = true;
-
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
-- 
2.1.4
