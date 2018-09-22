From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Sat, 22 Sep 2018 21:09:56 +0530
Subject: [PATCH 5/5] arm64/numa: Unify common error path in numa_init()
In-Reply-To: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
References: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537630796-14756-6-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present numa_free_distance() is being called before numa_distance is
even initialized with numa_alloc_distance() which is really pointless.
Instead lets call numa_free_distance() on the common error path inside
numa_init() after numa_alloc_distance() has been successful.

Fixes: 1a2db30034 ("arm64, numa: Add NUMA support for arm64 platforms")
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/numa.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 54529b4..d7b66fc 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -391,7 +391,6 @@ static int __init numa_init(int (*init_func)(void))
 	nodes_clear(numa_nodes_parsed);
 	nodes_clear(node_possible_map);
 	nodes_clear(node_online_map);
-	numa_free_distance();
 
 	ret = numa_alloc_distance();
 	if (ret < 0)
@@ -399,20 +398,24 @@ static int __init numa_init(int (*init_func)(void))
 
 	ret = init_func();
 	if (ret < 0)
-		return ret;
+		goto out_free_distance;
 
 	if (nodes_empty(numa_nodes_parsed)) {
 		pr_info("No NUMA configuration found\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_free_distance;
 	}
 
 	ret = numa_register_nodes();
 	if (ret < 0)
-		return ret;
+		goto out_free_distance;
 
 	setup_node_to_cpumask_map();
 
 	return 0;
+out_free_distance:
+	numa_free_distance();
+	return ret;
 }
 
 /**
-- 
2.7.4
