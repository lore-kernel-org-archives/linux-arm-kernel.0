From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 29 Nov 2016 09:47:19 -0700
Subject: [PATCH 9/9] coresight: perf: Add a missing call to etm_free_aux
In-Reply-To: <1480438039-24960-1-git-send-email-mathieu.poirier@linaro.org>
References: <1480438039-24960-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1480438039-24960-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Lambert <lambert.quentin@gmail.com>

Most error branches following the call to alloc_event_data contain a call
to etm_free_aux. This patch add a call to etm_free_aux to an error branch
that does not call it.

This issue was found with Hector.

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 5a346fc8ce06..17741969026e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -215,7 +215,7 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 	 */
 	sink = coresight_get_enabled_sink(true);
 	if (!sink)
-		return NULL;
+		goto err;
 
 	INIT_WORK(&event_data->work, free_event_data);
 
-- 
2.7.4
