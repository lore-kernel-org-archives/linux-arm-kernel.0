From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:22:09 +0100
Subject: [PATCH 4/4] RealView: Add sparsemem support for the RealView PBX
	platform
In-Reply-To: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RealView PBX board has two 512MB blocks of memory - one at
0x70000000 (with 256MB mirror at 0) and another at 0x20000000. Only the
block at 0x70000000 (or the mirror at 0) may be used for DMA (e.g.
framebuffer). This patch adds the sparsemem definitions to allow the use
of all the memory split as follows:

  256MB @ 0x00000000 (ZONE_DMA)
  512MB @ 0x20000000 (ZONE_NORMAL)
  256MB @ 0x80000000 (ZONE_NORMAL)

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/Kconfig               |    8 ++++-
 arch/arm/mach-realview/core.c                |   21 +++++++++++-
 arch/arm/mach-realview/include/mach/memory.h |   46 ++++++++++++++++++++++++++
 arch/arm/mach-realview/realview_pbx.c        |   22 ++++++++++++
 4 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index dfc9b0b..ba548ab 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -70,12 +70,14 @@ config MACH_REALVIEW_PBX
 	bool "Support RealView/PBX platform"
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select ARCH_SPARSEMEM_ENABLE if CPU_V7
+	select ZONE_DMA if SPARSEMEM
 	help
 	  Include support for the ARM(R) RealView PBX platform.
 
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
-	depends on MMU && !MACH_REALVIEW_PB1176
+	depends on MMU && !MACH_REALVIEW_PB1176 && !SPARSEMEM
 	default y
 	help
 	  RealView boards other than PB1176 have the RAM available at
@@ -84,4 +86,8 @@ config REALVIEW_HIGH_PHYS_OFFSET
 	  memory to be accessed contiguously at the high physical
 	  offset.
 
+config ARCH_FLATMEM_ENABLE
+	bool
+	default y if ARCH_SPARSEMEM_ENABLE
+
 endmenu
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index c21b0fd..9f29343 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -59,6 +59,25 @@
 /* used by entry-macro.S and platsmp.c */
 void __iomem *gic_cpu_base_addr;
 
+#ifdef CONFIG_ZONE_DMA
+/*
+ * Adjust the zones if there are restrictions for DMA access.
+ */
+void __init realview_adjust_zones(int node, unsigned long *size,
+				  unsigned long *hole)
+{
+	unsigned long dma_size = SZ_256M >> PAGE_SHIFT;
+
+	if (!machine_is_realview_pbx() || node || (size[0] <= dma_size))
+		return;
+
+	size[ZONE_NORMAL] = size[0] - dma_size;
+	size[ZONE_DMA] = dma_size;
+	hole[ZONE_NORMAL] = hole[0];
+	hole[ZONE_DMA] = 0;
+}
+#endif
+
 /*
  * This is the RealView sched_clock implementation.  This has
  * a resolution of 41.7ns, and a maximum value of about 179s.
@@ -543,7 +562,7 @@ static int realview_clcd_setup(struct clcd_fb *fb)
 	fb->panel		= realview_clcd_panel();
 
 	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-						    &dma, GFP_KERNEL);
+						    &dma, GFP_KERNEL | GFP_DMA);
 	if (!fb->fb.screen_base) {
 		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
 		return -ENOMEM;
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index 293c300..bbf7e3b 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -29,4 +29,50 @@
 #define PHYS_OFFSET		UL(0x00000000)
 #endif
 
+#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
+extern void realview_adjust_zones(int node, unsigned long *size,
+				  unsigned long *hole);
+#define arch_adjust_zones(node, size, hole) \
+	realview_adjust_zones(node, size, hole)
+#endif
+
+#ifdef CONFIG_SPARSEMEM
+
+/*
+ * Sparsemem definitions for RealView PBX.
+ *
+ * The RealView PBX board has another block of 512MB of RAM at 0x20000000,
+ * however only the block at 0x70000000 (or the 256MB mirror at 0x00000000)
+ * may be used for DMA.
+ *
+ * The macros below define a section size of 256MB and a non-linear virtual to
+ * physical mapping:
+ *
+ * 256MB @ 0x00000000 -> PAGE_OFFSET
+ * 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
+ * 256MB @ 0x80000000 -> PAGE_OFFSET + 0x30000000
+ */
+#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
+#error "SPARSEMEM not available with REALVIEW_HIGH_PHYS_OFFSET"
+#endif
+
+#define MAX_PHYSMEM_BITS	32
+#define SECTION_SIZE_BITS	28
+
+/* bank page offsets */
+#define PAGE_OFFSET1	(PAGE_OFFSET + 0x10000000)
+#define PAGE_OFFSET2	(PAGE_OFFSET + 0x30000000)
+
+#define __phys_to_virt(phys)						\
+	((phys) >= 0x80000000 ?	(phys) - 0x80000000 + PAGE_OFFSET2 :	\
+	 (phys) >= 0x20000000 ?	(phys) - 0x20000000 + PAGE_OFFSET1 :	\
+	 (phys) + PAGE_OFFSET)
+
+#define __virt_to_phys(virt)						\
+	 ((virt) >= PAGE_OFFSET2 ? (virt) - PAGE_OFFSET2 + 0x80000000 :	\
+	  (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 :	\
+	  (virt) - PAGE_OFFSET)
+
+#endif	/* CONFIG_SPARSEMEM */
+
 #endif
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 5d09d8b..ec39488 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -304,6 +304,26 @@ static struct sys_timer realview_pbx_timer = {
 	.init		= realview_pbx_timer_init,
 };
 
+static void realview_pbx_fixup(struct machine_desc *mdesc, struct tag *tags,
+			       char **from, struct meminfo *meminfo)
+{
+#ifdef CONFIG_SPARSEMEM
+	/*
+	 * Memory configuration with SPARSEMEM enabled on RealView PBX (see
+	 * asm/mach/memory.h for more information).
+	 */
+	meminfo->bank[0].start = 0;
+	meminfo->bank[0].size = SZ_256M;
+	meminfo->bank[1].start = 0x20000000;
+	meminfo->bank[1].size = SZ_512M;
+	meminfo->bank[2].start = 0x80000000;
+	meminfo->bank[2].size = SZ_256M;
+	meminfo->nr_banks = 3;
+#else
+	realview_fixup(mdesc, tags, from, meminfo);
+#endif
+}
+
 static void __init realview_pbx_init(void)
 {
 	int i;
@@ -345,7 +365,7 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.phys_io	= REALVIEW_PBX_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBX_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
-	.fixup		= realview_fixup,
+	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pbx_timer,
