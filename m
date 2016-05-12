From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:05 +0800
Subject: [PATCH v4 08/18] mips: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-9-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/mips/ath79/setup.c           |  2 --
 arch/mips/jz4740/setup.c          |  8 --------
 arch/mips/mti-sead3/sead3-setup.c |  8 --------
 arch/mips/pistachio/init.c        | 13 -------------
 arch/mips/xilfpga/init.c          | 13 -------------
 5 files changed, 44 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index be451ee4a..c221506 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -17,7 +17,6 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/clk.h>
-#include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
@@ -248,7 +247,6 @@ void __init plat_time_init(void)
 
 static int __init ath79_setup(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	if  (mips_machtype == ATH79_MACH_GENERIC_OF)
 		return 0;
 
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 510fc0d..0914ef7 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/libfdt.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #include <asm/bootinfo.h>
 #include <asm/prom.h>
@@ -74,13 +73,6 @@ void __init device_tree_init(void)
 	unflatten_and_copy_device_tree();
 }
 
-static int __init populate_machine(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	return 0;
-}
-arch_initcall(populate_machine);
-
 const char *get_system_type(void)
 {
 	if (config_enabled(CONFIG_MACH_JZ4780))
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index e43f480..9f85854 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -8,7 +8,6 @@
  */
 #include <linux/init.h>
 #include <linux/libfdt.h>
-#include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 
 #include <asm/prom.h>
@@ -102,10 +101,3 @@ void __init device_tree_init(void)
 
 	unflatten_and_copy_device_tree();
 }
-
-static int __init customize_machine(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	return 0;
-}
-arch_initcall(customize_machine);
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 96ba2cc..8b730fe 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #include <asm/cacheflush.h>
 #include <asm/dma-coherence.h>
@@ -122,15 +121,3 @@ void __init device_tree_init(void)
 
 	unflatten_and_copy_device_tree();
 }
-
-static int __init plat_of_setup(void)
-{
-	if (!of_have_populated_dt())
-		panic("Device tree not present");
-
-	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
-		panic("Failed to populate DT");
-
-	return 0;
-}
-arch_initcall(plat_of_setup);
diff --git a/arch/mips/xilfpga/init.c b/arch/mips/xilfpga/init.c
index ce2aee2..602e384 100644
--- a/arch/mips/xilfpga/init.c
+++ b/arch/mips/xilfpga/init.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #include <asm/prom.h>
 
@@ -43,15 +42,3 @@ void __init device_tree_init(void)
 
 	unflatten_and_copy_device_tree();
 }
-
-static int __init plat_of_setup(void)
-{
-	if (!of_have_populated_dt())
-		panic("Device tree not present");
-
-	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
-		panic("Failed to populate DT");
-
-	return 0;
-}
-arch_initcall(plat_of_setup);
-- 
1.7.12.4
