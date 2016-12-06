From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Dec 2016 11:53:10 -0800
Subject: [PATCH 1/3] ARM: Define KERNEL_START and KERNEL_END
In-Reply-To: <20161206195312.22354-1-f.fainelli@gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <20161206195312.22354-1-f.fainelli@gmail.com>
Message-ID: <20161206195312.22354-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding CONFIG_DEBUG_VIRTUAL support, define a set of
common constants: KERNEL_START and KERNEL_END which abstract
CONFIG_XIP_KERNEL vs. !CONFIG_XIP_KERNEL. Update the code where
relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/memory.h | 7 +++++++
 arch/arm/mm/init.c            | 7 ++-----
 arch/arm/mm/mmu.c             | 8 ++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 76cbd9c674df..bee7511c5098 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -111,6 +111,13 @@
 
 #endif /* !CONFIG_MMU */
 
+#ifdef CONFIG_XIP_KERNEL
+#define KERNEL_START		_sdata
+#else
+#define KERNEL_START		_stext
+#endif
+#define KERNEL_END		_end
+
 /*
  * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
  * locations
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 370581aeb871..c87d0d5b65f2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -230,11 +230,8 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 void __init arm_memblock_init(const struct machine_desc *mdesc)
 {
 	/* Register the kernel text, kernel data and initrd with memblock. */
-#ifdef CONFIG_XIP_KERNEL
-	memblock_reserve(__pa(_sdata), _end - _sdata);
-#else
-	memblock_reserve(__pa(_stext), _end - _stext);
-#endif
+	memblock_reserve(__pa(KERNEL_START), _end - KERNEL_START);
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* FDT scan will populate initrd_start */
 	if (initrd_start && !phys_initrd_size) {
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4001dd15818d..18ef688a796e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1437,12 +1437,8 @@ static void __init kmap_init(void)
 static void __init map_lowmem(void)
 {
 	struct memblock_region *reg;
-#ifdef CONFIG_XIP_KERNEL
-	phys_addr_t kernel_x_start = round_down(__pa(_sdata), SECTION_SIZE);
-#else
-	phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
-#endif
-	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+	phys_addr_t kernel_x_start = round_down(__pa(KERNEL_START), SECTION_SIZE);
+	phys_addr_t kernel_x_end = round_down(__pa(_end), SECTION_SIZE);
 
 	/* Map all the lowmem memory banks. */
 	for_each_memblock(memory, reg) {
-- 
2.9.3
