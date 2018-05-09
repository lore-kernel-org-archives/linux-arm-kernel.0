From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  9 May 2018 12:06:05 -0600
Subject: [PATCH 3/6] coresight tmc etr: Make memory check consistent in the
 same function
In-Reply-To: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
References: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1525889168-20574-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While operating from sysFS the TMC-ETR driver needs to make sure it has
memory to work with but doesn't allocate memory uselessly either.  Since
the main memory handle for this driver is drvdata::vaddr, use it throughout
function tmc_enable_etr_sink_sysfs() so that things are consistent.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index cce2ff42e8e2..8ee8c66f4002 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -153,11 +153,11 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		goto out;
 
 	/*
-	 * If drvdata::buf == NULL, use the memory allocated above.
+	 * If drvdata::vaddr == NULL, use the memory allocated above.
 	 * Otherwise a buffer still exists from a previous session, so
 	 * simply use that.
 	 */
-	if (drvdata->buf == NULL) {
+	if (drvdata->vaddr == NULL) {
 		used = true;
 		drvdata->vaddr = vaddr;
 		drvdata->paddr = paddr;
-- 
2.7.4
