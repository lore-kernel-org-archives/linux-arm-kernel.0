From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Nov 2015 22:16:52 +0000
Subject: [PATCH] ARM: l2c: tauros2: fix OF-enabled non-DT boot
Message-ID: <E1a24qS-0004Vj-RI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-tauros2.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 1e373d268c04..95eb524ce556 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -287,16 +287,15 @@ void __init tauros2_init(unsigned int features)
 	node = of_find_matching_node(NULL, tauros2_ids);
 	if (!node) {
 		pr_info("Not found marvell,tauros2-cache, disable it\n");
-		return;
+	} else {
+		ret = of_property_read_u32(node, "marvell,tauros2-cache-features", &f);
+		if (ret) {
+			pr_info("Not found marvell,tauros-cache-features property, "
+				"disable extra features\n");
+			features = 0;
+		} else
+			features = f;
 	}
-
-	ret = of_property_read_u32(node, "marvell,tauros2-cache-features", &f);
-	if (ret) {
-		pr_info("Not found marvell,tauros-cache-features property, "
-			"disable extra features\n");
-		features = 0;
-	} else
-		features = f;
 #endif
 	tauros2_internal_init(features);
 }
-- 
2.1.0
