From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  8 Aug 2015 21:13:44 +0900
Subject: [PATCH] ARM: UniPhier: drop v7_invalidate_l1 call at secondary entry
Message-ID: <1439036024-1933-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is unnecessary since commit 02b4e2756e01 ("ARM: v7 setup
function should invalidate L1 cache").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index 5943e1c..4b784f7 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -60,12 +60,6 @@ err:
 	sbcm_regmap = NULL;
 }
 
-static void __naked uniphier_secondary_startup(void)
-{
-	asm("bl		v7_invalidate_l1\n"
-	    "b		secondary_startup\n");
-};
-
 static int uniphier_boot_secondary(unsigned int cpu,
 				   struct task_struct *idle)
 {
@@ -75,7 +69,7 @@ static int uniphier_boot_secondary(unsigned int cpu,
 		return -ENODEV;
 
 	ret = regmap_write(sbcm_regmap, 0x1208,
-			   virt_to_phys(uniphier_secondary_startup));
+			   virt_to_phys(secondary_startup));
 	if (!ret)
 		asm("sev"); /* wake up secondary CPU */
 
-- 
1.9.1
