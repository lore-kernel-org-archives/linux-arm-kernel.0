From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:16:08 +0900
Subject: [PATCH 2/2] ARM: uniphier: rework SMP code to support new System Bus
 binding
In-Reply-To: <1456470968-7900-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456470968-7900-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456470968-7900-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the review process of the UniPhier System Bus driver
(drivers/bus/uniphier.c), the current binding of the System Bus
Controller turned out to be no good.  In order to use the driver,
some nodes in the device trees must be tweaked.  It would also have
impacts on the SMP code because the SMP related registers are
located in the System Bus Controller block.  This commit reworks
the smp_operations to support the new binding, but still supports
the old binding, too.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index 8d988f5..6914135 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -30,7 +30,7 @@
  * The secondary CPUs check this register from the boot ROM for the jump
  * destination.  After that, it can be reused as a scratch register.
  */
-#define UNIPHIER_SBC_ROM_BOOT_RSV2	0x1208
+#define UNIPHIER_SMPCTRL_ROM_RSV2	0x208
 
 static void __iomem *uniphier_smp_rom_boot_rsv2;
 static unsigned int uniphier_smp_max_cpus;
@@ -98,17 +98,24 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
 	phys_addr_t rom_rsv2_phys;
 	int ret;
 
-	np = of_find_compatible_node(NULL, NULL,
-				"socionext,uniphier-system-bus-controller");
+	np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
 	of_node_put(np);
-	ret = of_address_to_resource(np, 1, &res);
-	if (ret) {
-		pr_err("failed to get resource of system-bus-controller\n");
-		return ret;
+	ret = of_address_to_resource(np, 0, &res);
+	if (!ret) {
+		rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_RSV2;
+	} else {
+		/* try old binding too */
+		np = of_find_compatible_node(NULL, NULL,
+					     "socionext,uniphier-system-bus-controller");
+		of_node_put(np);
+		ret = of_address_to_resource(np, 1, &res);
+		if (ret) {
+			pr_err("failed to get resource of SMP control\n");
+			return ret;
+		}
+		rom_rsv2_phys = res.start + 0x1000 + UNIPHIER_SMPCTRL_ROM_RSV2;
 	}
 
-	rom_rsv2_phys = res.start + UNIPHIER_SBC_ROM_BOOT_RSV2;
-
 	ret = uniphier_smp_copy_trampoline(rom_rsv2_phys);
 	if (ret)
 		return ret;
-- 
1.9.1
