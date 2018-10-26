From: john.garry@huawei.com (John Garry)
Date: Fri, 26 Oct 2018 21:57:47 +0800
Subject: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
Message-ID: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is acceptable to set the distance between 2 separate nodes to
LOCAL_DISTANCE.

Reject this as it is invalid.

This change avoids a crash reported in [1].

[1] https://www.spinics.net/lists/arm-kernel/msg683304.html

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 146c04c..6092e3d 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
 	}
 
 	if ((u8)distance != distance ||
-	    (from == to && distance != LOCAL_DISTANCE)) {
+	    (from == to && distance != LOCAL_DISTANCE) ||
+	    (from != to && distance == LOCAL_DISTANCE)) {
 		pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
 			     from, to, distance);
 		return;
-- 
1.9.1
