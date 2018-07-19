From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Jul 2018 11:55:08 +0100
Subject: [PATCH v2 04/10] coresight: platform: Fix leaking device reference
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531997715-6767-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't drop the reference on the remote device while parsing the
connection, held by bus_find_device(). Fix this by duplicating the
device name and dropping the reference.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 - New in v2
---
 drivers/hwtracing/coresight/of_coresight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 6c2f95a..c5f664c 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -161,7 +161,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		pdata->outports[*i] = endpoint.port;
-		pdata->child_names[*i] = dev_name(rdev);
+		pdata->child_names[*i] = devm_kstrdup(dev,
+						      dev_name(rdev),
+						      GFP_KERNEL);
 		pdata->child_ports[*i] = rendpoint.id;
 		/* Move the index */
 		(*i)++;
@@ -171,6 +173,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		of_node_put(rparent);
 	if (rport)
 		of_node_put(rport);
+	if (rdev)
+		put_device(rdev);
 
 	return ret;
 }
-- 
2.7.4
