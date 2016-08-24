From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 24 Aug 2016 15:44:52 +0800
Subject: [PATCH v7 13/14] of/numa: remove the constraint on the distances of
 node pairs
In-Reply-To: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472024693-12912-14-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present, the distances must equal in both direction for each node
pairs. For example: the distance of node B->A must the same to A->B.
But we really don't have to do this.

End up fill default distances as below:
1. If both direction specified, keep no change.
2. If only one direction specified, assign it to the other direction.
3. If none of the two direction specified, both are assigned to
   REMOTE_DISTANCE.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_numa.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 1234b4a..d0cdf29 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -127,15 +127,25 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
 		numa_set_distance(nodea, nodeb, distance);
 		pr_debug("distance[node%d -> node%d] = %d\n",
 			 nodea, nodeb, distance);
-
-		/* Set default distance of node B->A same as A->B */
-		if (nodeb > nodea)
-			numa_set_distance(nodeb, nodea, distance);
 	}

 	return 0;
 }

+static void __init fill_default_distances(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_node_ids; i++)
+		for (j = 0; j < nr_node_ids; j++)
+			if (i == j)
+				numa_set_distance(i, j, LOCAL_DISTANCE);
+			else if (!node_distance(i, j))
+				numa_set_distance(i, j,
+				    node_distance(j, i) ? : REMOTE_DISTANCE);
+
+}
+
 static int __init of_numa_parse_distance_map(void)
 {
 	int ret = 0;
@@ -145,8 +155,10 @@ static int __init of_numa_parse_distance_map(void)
 				     "numa-distance-map-v1");
 	if (np)
 		ret = of_numa_parse_distance_map_v1(np);
-
 	of_node_put(np);
+
+	fill_default_distances();
+
 	return ret;
 }

--
2.5.0
