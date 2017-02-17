From: mike.leach@linaro.org (Mike Leach)
Date: Fri, 17 Feb 2017 19:10:11 +0000
Subject: [PATCH] hwtracing: coresight: Fixes coresight DT parse to get correct
 output port ID.
Message-ID: <1487358611-2537-1-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 629e031..09142e9 100644
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
