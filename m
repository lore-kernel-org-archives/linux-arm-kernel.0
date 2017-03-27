From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 27 Mar 2017 11:09:33 -0600
Subject: [PATCH 3/3] coresight: Fixes coresight DT parse to get correct output
 port ID.
In-Reply-To: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
References: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1490634573-11068-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Leach <mike.leach@linaro.org>

Corrected to get the port numbering to allow programmable replicator driver
to operate correctly.

By convention, CoreSight devices number ports, not endpoints in
the .dts files:-

port {
     reg<N>
     endpoint {
     }
}

Existing code read endpoint number - always 0x0, rather than the correct
port number.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 629e031b7456..09142e99e915 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -149,7 +149,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 				continue;
 
 			/* The local out port number */
-			pdata->outports[i] = endpoint.id;
+			pdata->outports[i] = endpoint.port;
 
 			/*
 			 * Get a handle on the remote port and parent
-- 
2.7.4
