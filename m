From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sun, 22 Jan 2017 08:49:47 +0530
Subject: [PATCH v2 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig
In-Reply-To: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
References: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170122031947.13242-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MMU configurations, VECTORS_BASE is always 0xffff0000, a macro
definition will suffice.

For no-MMU, exception base address is dynamically determined in
subsequent patches. To preserve bisectability, now make the
macro applicable for no-MMU scenario too.

Thanks to 0-DAY kernel test infrastructure that found the
bisectability issue. This macro will be restricted to MMU case upon
dynamically determining exception base address for no-MMU.

Once exception address is handled dynamically for no-MMU,
VECTORS_BASE can be removed from Kconfig.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v2: 
 Fix bisectability issue on !MMU builds
 UL suffix on VECTORS_BASE definition

 arch/arm/include/asm/memory.h  | 2 ++
 arch/arm/mach-berlin/platsmp.c | 3 ++-
 arch/arm/mm/dump.c             | 5 +++--
 arch/arm/mm/init.c             | 4 ++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 76cbd9c674df..0b5416fe7709 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -111,6 +111,8 @@
 
 #endif /* !CONFIG_MMU */
 
+#define VECTORS_BASE		UL(0xffff0000)
+
 /*
  * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
  * locations
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 93f90688db18..578d41031abf 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -15,6 +15,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/memory.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
@@ -75,7 +76,7 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
 	if (!cpu_ctrl)
 		goto unmap_scu;
 
-	vectors_base = ioremap(CONFIG_VECTORS_BASE, SZ_32K);
+	vectors_base = ioremap(VECTORS_BASE, SZ_32K);
 	if (!vectors_base)
 		goto unmap_scu;
 
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 9fe8e241335c..21192d6eda40 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/fixmap.h>
+#include <asm/memory.h>
 #include <asm/pgtable.h>
 
 struct addr_marker {
@@ -31,8 +32,8 @@ static struct addr_marker address_markers[] = {
 	{ 0,			"vmalloc() Area" },
 	{ VMALLOC_END,		"vmalloc() End" },
 	{ FIXADDR_START,	"Fixmap Area" },
-	{ CONFIG_VECTORS_BASE,	"Vectors" },
-	{ CONFIG_VECTORS_BASE + PAGE_SIZE * 2, "Vectors End" },
+	{ VECTORS_BASE,	"Vectors" },
+	{ VECTORS_BASE + PAGE_SIZE * 2, "Vectors End" },
 	{ -1,			NULL },
 };
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 370581aeb871..823e119a5daa 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -27,6 +27,7 @@
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
 #include <asm/memblock.h>
+#include <asm/memory.h>
 #include <asm/prom.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -521,8 +522,7 @@ void __init mem_init(void)
 			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
 
-			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
-				(PAGE_SIZE)),
+			MLK(VECTORS_BASE, VECTORS_BASE + PAGE_SIZE),
 #ifdef CONFIG_HAVE_TCM
 			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
 			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
-- 
2.11.0
