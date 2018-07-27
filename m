From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 27 Jul 2018 11:15:32 +0100
Subject: [PATCH v3 4/9] coresight: platform: Fix leaking device reference
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1532686537-12380-5-git-send-email-suzuki.poulose@arm.com>
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
index 28d3aef..4b279f8 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -162,7 +162,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		pdata->outports[i] = endpoint.port;
-		pdata->child_names[i] = dev_name(rdev);
+		pdata->child_names[i] = devm_kstrdup(dev,
+						     dev_name(rdev),
+						     GFP_KERNEL);
 		pdata->child_ports[i] = rendpoint.id;
 		/* Connection record updated */
 		ret = 1;
@@ -172,6 +174,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		of_node_put(rparent);
 	if (rport)
 		of_node_put(rport);
+	if (rdev)
+		put_device(rdev);
 
 	return ret;
 }
-- 
2.7.4
