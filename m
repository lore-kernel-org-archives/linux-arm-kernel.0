From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:20 -0600
Subject: [PATCH V2 03/30] coresight: etm3x: unlocking tracers in default arch
 init
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling function 'smp_call_function_single()' to unlock a
tracer and calling it right after to perform the default
initialisation doesn't make sense.

Moving 'etm_os_unlock()' just before making the default
initialisation results in the same outcome while saving
one call to 'smp_call_function_single()'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 2a1950d0753d..737b6164f4a5 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -47,11 +47,11 @@ static struct etm_drvdata *etmdrvdata[NR_CPUS];
  * and OS lock must be unlocked before any memory mapped access on such
  * processors, otherwise memory mapped reads/writes will be invalid.
  */
-static void etm_os_unlock(void *info)
+static void etm_os_unlock(struct etm_drvdata *drvdata)
 {
-	struct etm_drvdata *drvdata = (struct etm_drvdata *)info;
 	/* Writing any value to ETMOSLAR unlocks the trace registers */
 	etm_writel(drvdata, 0x0, ETMOSLAR);
+	drvdata->os_unlock = true;
 	isb();
 }
 
@@ -478,6 +478,9 @@ static void etm_init_arch_data(void *info)
 	u32 etmccr;
 	struct etm_drvdata *drvdata = info;
 
+	/* Make sure all registers are accessible */
+	etm_os_unlock(drvdata);
+
 	CS_UNLOCK(drvdata->base);
 
 	/* First dummy read */
@@ -602,9 +605,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
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
