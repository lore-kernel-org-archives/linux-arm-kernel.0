From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Jul 2013 14:53:57 +0100
Subject: [PATCH] constify machine_desc structure uses
Message-ID: <20130726135356.GO24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct machine_desc records are defined everywhere as a 'const'
structure, but unfortuantely it loses its const-ness through the use of
linker magic - the symbols which surround the section are not declared
const so it becomes possible not to use 'const' for pointers to these
const structures.

Let's fix this oversight - all pointers to these structures should be
marked const too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/arch.h |    4 ++--
 arch/arm/include/asm/memblock.h  |    3 +--
 arch/arm/include/asm/prom.h      |    4 ++--
 arch/arm/kernel/atags.h          |    5 +++--
 arch/arm/kernel/atags_parse.c    |    6 +++---
 arch/arm/kernel/devtree.c        |    6 +++---
 arch/arm/kernel/setup.c          |   12 ++++++------
 arch/arm/mm/init.c               |    5 +++--
 arch/arm/mm/mmu.c                |    4 ++--
 arch/arm/mm/nommu.c              |    2 +-
 10 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 441efc4..69b879a 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -65,12 +65,12 @@ struct machine_desc {
 /*
  * Current machine - only accessible during boot.
  */
-extern struct machine_desc *machine_desc;
+extern const struct machine_desc *machine_desc;
 
 /*
  * Machine type table - also only accessible during boot
  */
-extern struct machine_desc __arch_info_begin[], __arch_info_end[];
+extern const struct machine_desc __arch_info_begin[], __arch_info_end[];
 #define for_each_machine_desc(p)			\
 	for (p = __arch_info_begin; p < __arch_info_end; p++)
 
diff --git a/arch/arm/include/asm/memblock.h b/arch/arm/include/asm/memblock.h
index 00ca5f9..c2f5102 100644
--- a/arch/arm/include/asm/memblock.h
+++ b/arch/arm/include/asm/memblock.h
@@ -4,8 +4,7 @@
 struct meminfo;
 struct machine_desc;
 
-extern void arm_memblock_init(struct meminfo *, struct machine_desc *);
-
+void arm_memblock_init(struct meminfo *, const struct machine_desc *);
 phys_addr_t arm_memblock_steal(phys_addr_t size, phys_addr_t align);
 
 #endif
diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index a219227..4a2985e 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -15,13 +15,13 @@
 
 #ifdef CONFIG_OF
 
-extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
+extern const struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
 extern void arm_dt_memblock_reserve(void);
 extern void __init arm_dt_init_cpu_maps(void);
 
 #else /* CONFIG_OF */
 
-static inline struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
+static inline const struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
 {
 	return NULL;
 }
diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 9edc969..ec4164d 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -7,9 +7,10 @@ static inline void save_atags(struct tag *tags) { }
 void convert_to_tag_list(struct tag *tags);
 
 #ifdef CONFIG_ATAGS
-struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr);
+const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
+	unsigned int machine_nr);
 #else
-static inline struct machine_desc *
+static inline const struct machine_desc *
 setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
 	early_print("no ATAGS support: can't continue\n");
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 14512e6..8c14de8 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -178,11 +178,11 @@ static void __init squash_mem_tags(struct tag *tag)
 			tag->hdr.tag = ATAG_NONE;
 }
 
-struct machine_desc * __init setup_machine_tags(phys_addr_t __atags_pointer,
-						unsigned int machine_nr)
+const struct machine_desc * __init
+setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
 	struct tag *tags = (struct tag *)&default_tags;
-	struct machine_desc *mdesc = NULL, *p;
+	const struct machine_desc *mdesc = NULL, *p;
 	char *from = default_command_line;
 
 	default_tags.mem.start = PHYS_OFFSET;
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5859c8b..eae1976 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -176,10 +176,10 @@ void __init arm_dt_init_cpu_maps(void)
  * If a dtb was passed to the kernel in r2, then use it to choose the
  * correct machine_desc and to setup the system.
  */
-struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
+const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
 	struct boot_param_header *devtree;
-	struct machine_desc *mdesc, *mdesc_best = NULL;
+	const struct machine_desc *mdesc, *mdesc_best = NULL;
 	unsigned int score, mdesc_score = ~1;
 	unsigned long dt_root;
 	const char *model;
@@ -188,7 +188,7 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
 	MACHINE_END
 
-	mdesc_best = (struct machine_desc *)&__mach_desc_GENERIC_DT;
+	mdesc_best = &__mach_desc_GENERIC_DT;
 #endif
 
 	if (!dt_phys)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 63af9a7..8636299 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -72,10 +72,10 @@ static int __init fpe_setup(char *line)
 __setup("fpe=", fpe_setup);
 #endif
 
-extern void paging_init(struct machine_desc *desc);
+extern void paging_init(const struct machine_desc *desc);
 extern void sanity_check_meminfo(void);
 extern enum reboot_mode reboot_mode;
-extern void setup_dma_zone(struct machine_desc *desc);
+extern void setup_dma_zone(const struct machine_desc *desc);
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
@@ -139,7 +139,7 @@ EXPORT_SYMBOL(elf_platform);
 static const char *cpu_name;
 static const char *machine_name;
 static char __initdata cmd_line[COMMAND_LINE_SIZE];
-struct machine_desc *machine_desc __initdata;
+const struct machine_desc *machine_desc __initdata;
 
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
 #define ENDIANNESS ((char)endian_test.l)
@@ -607,7 +607,7 @@ static void __init setup_processor(void)
 
 void __init dump_machine_table(void)
 {
-	struct machine_desc *p;
+	const struct machine_desc *p;
 
 	early_print("Available machine support:\n\nID (hex)\tNAME\n");
 	for_each_machine_desc(p)
@@ -694,7 +694,7 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
-static void __init request_standard_resources(struct machine_desc *mdesc)
+static void __init request_standard_resources(const struct machine_desc *mdesc)
 {
 	struct memblock_region *region;
 	struct resource *res;
@@ -850,7 +850,7 @@ void __init hyp_mode_check(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	struct machine_desc *mdesc;
+	const struct machine_desc *mdesc;
 
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 15225d8..2958e74 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -231,7 +231,7 @@ static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
 }
 #endif
 
-void __init setup_dma_zone(struct machine_desc *mdesc)
+void __init setup_dma_zone(const struct machine_desc *mdesc)
 {
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
@@ -335,7 +335,8 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	return phys;
 }
 
-void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
+void __init arm_memblock_init(struct meminfo *mi,
+	const struct machine_desc *mdesc)
 {
 	int i;
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4f56617..56054ac 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1151,7 +1151,7 @@ void __init arm_mm_memblock_reserve(void)
  * called function.  This means you can't use any function or debugging
  * method which may touch any device, otherwise the kernel _will_ crash.
  */
-static void __init devicemaps_init(struct machine_desc *mdesc)
+static void __init devicemaps_init(const struct machine_desc *mdesc)
 {
 	struct map_desc map;
 	unsigned long addr;
@@ -1272,7 +1272,7 @@ static void __init map_lowmem(void)
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
  */
-void __init paging_init(struct machine_desc *mdesc)
+void __init paging_init(const struct machine_desc *mdesc)
 {
 	void *zero_page;
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 1fa5010..34d4ab2 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -299,7 +299,7 @@ void __init sanity_check_meminfo(void)
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
  */
-void __init paging_init(struct machine_desc *mdesc)
+void __init paging_init(const struct machine_desc *mdesc)
 {
 	early_trap_init((void *)CONFIG_VECTORS_BASE);
 	mpu_setup();
