From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:17:08 +0900
Subject: [PATCH] ARM: uniphier: drop code for old DT binding
Message-ID: <1464682628-12163-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 307d40c56b0c ("ARM: uniphier: rework SMP code to support new
System Bus binding") added a new DT binding for SMP code, but still
kept old code for the backward compatibility.

Linux 4.6 was out with both bindings supported, so it should not
hurt to drop the old code now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index e802ca8..9978c41 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -101,21 +101,13 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
 	np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
 	ret = of_address_to_resource(np, 0, &res);
 	of_node_put(np);
-	if (!ret) {
-		rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_RSV2;
-	} else {
-		/* try old binding too */
-		np = of_find_compatible_node(NULL, NULL,
-					     "socionext,uniphier-system-bus-controller");
-		ret = of_address_to_resource(np, 1, &res);
-		of_node_put(np);
-		if (ret) {
-			pr_err("failed to get resource of SMP control\n");
-			return ret;
-		}
-		rom_rsv2_phys = res.start + 0x1000 + UNIPHIER_SMPCTRL_ROM_RSV2;
+	if (ret) {
+		pr_err("failed to get resource of SMP control\n");
+		return ret;
 	}
 
+	rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_RSV2;
+
 	ret = uniphier_smp_copy_trampoline(rom_rsv2_phys);
 	if (ret)
 		return ret;
-- 
1.9.1
