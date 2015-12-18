From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:35:06 +0100
Subject: [PATCH] memcg: fix SLOB build regression
Message-ID: <13705081.IYJlPWfILN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent cleanup broke the build when CONFIG_SLOB is used:

mm/memcontrol.c: In function 'memcg_update_kmem_limit':
mm/memcontrol.c:2974:9: error: implicit declaration of function 'memcg_online_kmem' [-Werror=implicit-function-declaration]
mm/memcontrol.c: In function 'mem_cgroup_css_alloc':
mm/memcontrol.c:4229:10: error: too many arguments to function 'memcg_propagate_kmem'
mm/memcontrol.c:2949:12: note: declared here

This fixes the memcg_propagate_kmem prototype to match the normal
implementation and adds the respective memcg_online_kmem helper
function that was needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a5ed904c5039 ("mm: memcontrol: clean up alloc, online, offline, free functions")
---
This just showed up on ARM randconfig builds with linux-next, please apply
or fold into the original patch

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48b22c3545b1..4637199e69d6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2946,7 +2946,11 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
 	}
 }
 #else
-static int memcg_propagate_kmem(struct mem_cgroup *memcg)
+static int memcg_propagate_kmem(struct mem_cgroup *parent, struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	return 0;
 }
