From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 15 Apr 2016 19:48:29 +0900
Subject: [PATCH] ARM: uniphier: correct the call order of of_node_put()
Message-ID: <1460717309-3982-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put nodes after of_address_to_resource() in case the nodes might be
released while parsing in them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index db04142..e802ca8 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -99,16 +99,16 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
 	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
-	of_node_put(np);
 	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
 	if (!ret) {
 		rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_RSV2;
 	} else {
 		/* try old binding too */
 		np = of_find_compatible_node(NULL, NULL,
 					     "socionext,uniphier-system-bus-controller");
-		of_node_put(np);
 		ret = of_address_to_resource(np, 1, &res);
+		of_node_put(np);
 		if (ret) {
 			pr_err("failed to get resource of SMP control\n");
 			return ret;
-- 
1.9.1
