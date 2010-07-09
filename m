From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 10 Jul 2010 01:16:29 +0200
Subject: [PATCH] ARM: make TCM allocation static and common for all archs
Message-ID: <1278717389-8964-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the TCM handling so that a fixed area is reserved at
0xfffe0000-0xfffeffff for TCM. This areas is used by XScale but
XScale does not have TCM so the mechanisms are mutually exclusive.

This change is needed to make TCM detection more dynamic while
still being able to compile code into it, and is a must for the
unified ARM goals: the current TCM allocation at different places
in memory for each machine would be a nightmare if you want to
compile a single image for more than one machine with TCM so it
has to be nailed down in one place.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This is another TCM patch, to be applied on top of the other
stuff I've sent so far. This has been tested on U300 and PB1176
however I haven't sent a patch for activating TCM on the RealViews
just yet, because I want to check the potential SMP issues that
would affect some of them. It would probably be possible to add
it on the mach-versatile though. (I don't have one.)
---
 Documentation/arm/memory.txt             |    8 ++-
 Documentation/arm/tcm.txt                |   30 ++++++----
 arch/arm/include/asm/memory.h            |    9 +++
 arch/arm/kernel/tcm.c                    |   91 ++++++++++++++++--------------
 arch/arm/mach-u300/include/mach/memory.h |    8 ---
 arch/arm/mm/init.c                       |   18 +++---
 6 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index eb0fae1..771d48d 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -33,7 +33,13 @@ ffff0000	ffff0fff	CPU vector page.
 
 fffe0000	fffeffff	XScale cache flush area.  This is used
 				in proc-xscale.S to flush the whole data
-				cache.  Free for other usage on non-XScale.
+				cache. (XScale does not have TCM.)
+
+fffe8000	fffeffff	DTCM mapping area for platforms with
+				DTCM mounted inside the CPU.
+
+fffe0000	fffe7fff	ITCM mapping area for platforms with
+				ITCM mounted inside the CPU.
 
 fff00000	fffdffff	Fixmap mapping region.  Addresses provided
 				by fix_to_virt() will be located here.
diff --git a/Documentation/arm/tcm.txt b/Documentation/arm/tcm.txt
index 77fd937..7c15871 100644
--- a/Documentation/arm/tcm.txt
+++ b/Documentation/arm/tcm.txt
@@ -19,8 +19,8 @@ defines a CPUID_TCM register that you can read out from the
 system control coprocessor. Documentation from ARM can be found
 at http://infocenter.arm.com, search for "TCM Status Register"
 to see documents for all CPUs. Reading this register you can
-determine if ITCM (bit 0) and/or DTCM (bit 16) is present in the
-machine.
+determine if ITCM (bits 1-0) and/or DTCM (bit 17-16) is present
+in the machine.
 
 There is further a TCM region register (search for "TCM Region
 Registers" at the ARM site) that can report and modify the location
@@ -35,7 +35,15 @@ The TCM memory can then be remapped to another address again using
 the MMU, but notice that the TCM if often used in situations where
 the MMU is turned off. To avoid confusion the current Linux
 implementation will map the TCM 1 to 1 from physical to virtual
-memory in the location specified by the machine.
+memory in the location specified by the kernel. Currently Linux
+will map ITCM to 0xfffe0000 and on, and DTCM to 0xfffe8000 and
+on, supporting a maximum of 32KiB of ITCM and 32KiB of DTCM.
+
+Newer versions of the region registers also support dividing these
+TCMs in two separate banks, so for example an 8KiB ITCM is divided
+into two 4KiB banks with its own control registers. The idea is to
+be able to lock and hide one of the banks for use by the secure
+world (TrustZone).
 
 TCM is used for a few things:
 
@@ -65,18 +73,18 @@ in <asm/tcm.h>. Using this interface it is possible to:
   memory. Such a heap is great for things like saving
   device state when shutting off device power domains.
 
-A machine that has TCM memory shall select HAVE_TCM in
-arch/arm/Kconfig for itself, and then the
-rest of the functionality will depend on the physical
-location and size of ITCM and DTCM to be defined in
-mach/memory.h for the machine. Code that needs to use
-TCM shall #include <asm/tcm.h> If the TCM is not located
-at the place given in memory.h it will be moved using
-the TCM Region registers.
+A machine that has TCM memory shall select HAVE_TCM from
+arch/arm/Kconfig for itself. Code that needs to use TCM shall
+#include <asm/tcm.h>
 
 Functions to go into itcm can be tagged like this:
 int __tcmfunc foo(int bar);
 
+Since these are marked to become long_calls and you may want
+to have functions called locally inside the TCM without
+wasting space, there is also the __tcmlocalfunc prefix that
+will make the call relative.
+
 Variables to go into dtcm can be tagged like this:
 int __tcmdata foo;
 
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 82df0ae..23c2e8e 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -124,6 +124,15 @@
 #endif /* !CONFIG_MMU */
 
 /*
+ * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
+ * locations
+ */
+#ifdef CONFIG_HAVE_TCM
+#define ITCM_OFFSET	UL(0xfffe0000)
+#define DTCM_OFFSET	UL(0xfffe8000)
+#endif
+
+/*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index f2ead32..26685c2 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -18,32 +18,30 @@
 #include <mach/memory.h>
 #include "tcm.h"
 
-/* Scream and warn about misuse */
-#if !defined(ITCM_OFFSET) || !defined(ITCM_END) || \
-    !defined(DTCM_OFFSET) || !defined(DTCM_END)
-#error "TCM support selected but offsets not defined!"
-#endif
-
 static struct gen_pool *tcm_pool;
 
 /* TCM section definitions from the linker */
 extern char __itcm_start, __sitcm_text, __eitcm_text;
 extern char __dtcm_start, __sdtcm_data, __edtcm_data;
 
+/* These will be increased as we run */
+u32 dtcm_end = DTCM_OFFSET;
+u32 itcm_end = ITCM_OFFSET;
+
 /*
  * TCM memory resources
  */
 static struct resource dtcm_res = {
 	.name = "DTCM RAM",
 	.start = DTCM_OFFSET,
-	.end = DTCM_END,
+	.end = DTCM_OFFSET,
 	.flags = IORESOURCE_MEM
 };
 
 static struct resource itcm_res = {
 	.name = "ITCM RAM",
 	.start = ITCM_OFFSET,
-	.end = ITCM_END,
+	.end = ITCM_OFFSET,
 	.flags = IORESOURCE_MEM
 };
 
@@ -51,7 +49,7 @@ static struct map_desc dtcm_iomap[] __initdata = {
 	{
 		.virtual	= DTCM_OFFSET,
 		.pfn		= __phys_to_pfn(DTCM_OFFSET),
-		.length		= (DTCM_END - DTCM_OFFSET + 1),
+		.length		= 0,
 		.type		= MT_MEMORY_DTCM
 	}
 };
@@ -60,7 +58,7 @@ static struct map_desc itcm_iomap[] __initdata = {
 	{
 		.virtual	= ITCM_OFFSET,
 		.pfn		= __phys_to_pfn(ITCM_OFFSET),
-		.length		= (ITCM_END - ITCM_OFFSET + 1),
+		.length		= 0,
 		.type		= MT_MEMORY_ITCM
 	}
 };
@@ -92,8 +90,8 @@ void tcm_free(void *addr, size_t len)
 }
 EXPORT_SYMBOL(tcm_free);
 
-static void __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
-				  u32 offset, u32 expected_size)
+static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
+				  u32 *offset)
 {
 	const int tcm_sizes[16] = { 0, -1, -1, 4, 8, 16, 32, 64, 128,
 				    256, 512, 1024, -1, -1, -1, -1 };
@@ -120,8 +118,13 @@ static void __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
 
 	tcm_size = tcm_sizes[(tcm_region >> 2) & 0x0f];
 	if (tcm_size < 0) {
-		pr_err("CPU: %sTCM%d of unknown size!\n",
+		pr_err("CPU: %sTCM%d of unknown size\n",
 		       type ? "I" : "D", bank);
+		return -EINVAL;
+	} else if (tcm_size > 32) {
+		pr_err("CPU: %sTCM%d larger than 32k found\n",
+		       type ? "I" : "D", bank);
+		return -EINVAL;
 	} else {
 		pr_info("CPU: found %sTCM%d %dk @ %08x, %senabled\n",
 			type ? "I" : "D",
@@ -131,17 +134,8 @@ static void __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
 			(tcm_region & 1) ? "" : "not ");
 	}
 
-	if (tcm_size != (expected_size >> 10)) {
-		pr_crit("CPU: %sTCM%d was detected %dk but expected %dk!\n",
-			type ? "I" : "D",
-			bank,
-			tcm_size,
-			(expected_size >> 10));
-		/* Adjust to the expected size? what can we do... */
-	}
-
 	/* Force move the TCM bank to where we want it, enable */
-	tcm_region = offset | (tcm_region & 0x00000ffeU) | 1;
+	tcm_region = *offset | (tcm_region & 0x00000ffeU) | 1;
 
 	if (!type)
 		asm("mcr	p15, 0, %0, c9, c1, 0"
@@ -152,17 +146,17 @@ static void __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
 		    : /* No output operands */
 		    : "r" (tcm_region));
 
+	/* Increase offset */
+	*offset += (tcm_size << 10);
+
 	pr_info("CPU: moved %sTCM%d %dk to %08x, enabled\n",
 		type ? "I" : "D",
 		bank,
 		tcm_size,
 		(tcm_region & 0xfffff000U));
+	return 0;
 }
 
-/* We expect to find what is configured for the platform */
-#define DTCM_EXPECTED (DTCM_END - DTCM_OFFSET + 1)
-#define ITCM_EXPECTED (ITCM_END - ITCM_OFFSET + 1)
-
 /*
  * This initializes the TCM memory
  */
@@ -170,40 +164,51 @@ void __init tcm_init(void)
 {
 	u32 tcm_status = read_cpuid_tcmstatus();
 	u8 dtcm_banks = (tcm_status >> 16) & 0x03;
-	u32 dtcm_banksize = DTCM_EXPECTED / dtcm_banks;
 	u8 itcm_banks = (tcm_status & 0x03);
-	u32 itcm_banksize = ITCM_EXPECTED / itcm_banks;
 	char *start;
 	char *end;
 	char *ram;
+	int ret;
 	int i;
 
 	/* Setup DTCM if present */
-	for (i = 0; i < dtcm_banks; i++) {
-		setup_tcm_bank(0, i, dtcm_banks,
-			       DTCM_OFFSET + (i * dtcm_banksize),
-			       dtcm_banksize);
+	if (dtcm_banks > 0) {
+		for (i = 0; i < dtcm_banks; i++) {
+			ret = setup_tcm_bank(0, i, dtcm_banks, &dtcm_end);
+			if (ret)
+				return;
+		}
+		dtcm_res.end = dtcm_end - 1;
 		request_resource(&iomem_resource, &dtcm_res);
+		dtcm_iomap[0].length = dtcm_end - DTCM_OFFSET;
 		iotable_init(dtcm_iomap, 1);
 		/* Copy data from RAM to DTCM */
 		start = &__sdtcm_data;
 		end   = &__edtcm_data;
 		ram   = &__dtcm_start;
+		/* This means you compiled more code than fits into DTCM */
+		BUG_ON((end - start) > (dtcm_end - DTCM_OFFSET));
 		memcpy(start, ram, (end-start));
 		pr_debug("CPU DTCM: copied data from %p - %p\n", start, end);
 	}
 
 	/* Setup ITCM if present */
-	for (i = 0; i < itcm_banks; i++) {
-		setup_tcm_bank(1, i, itcm_banks,
-			       ITCM_OFFSET + (i * itcm_banksize),
-			       itcm_banksize);
+	if (itcm_banks > 0) {
+		for (i = 0; i < itcm_banks; i++) {
+			ret = setup_tcm_bank(1, i, itcm_banks, &itcm_end);
+			if (ret)
+				return;
+		}
+		itcm_res.end = itcm_end - 1;
 		request_resource(&iomem_resource, &itcm_res);
+		itcm_iomap[0].length = itcm_end - ITCM_OFFSET;
 		iotable_init(itcm_iomap, 1);
 		/* Copy code from RAM to ITCM */
 		start = &__sitcm_text;
 		end   = &__eitcm_text;
 		ram   = &__itcm_start;
+		/* This means you compiled more code than fits into ITCM */
+		BUG_ON((end - start) > (itcm_end - ITCM_OFFSET));
 		memcpy(start, ram, (end-start));
 		pr_debug("CPU ITCM: copied code from %p - %p\n", start, end);
 	}
@@ -232,9 +237,9 @@ static int __init setup_tcm_pool(void)
 
 	/* Add the rest of DTCM to the TCM pool */
 	if (tcm_status & (0x03 << 16)) {
-		if (dtcm_pool_start < DTCM_END) {
+		if (dtcm_pool_start < dtcm_end) {
 			ret = gen_pool_add(tcm_pool, dtcm_pool_start,
-					   DTCM_END - dtcm_pool_start + 1, -1);
+					   dtcm_end - dtcm_pool_start, -1);
 			if (ret) {
 				pr_err("CPU DTCM: could not add DTCM " \
 				       "remainder to pool!\n");
@@ -242,16 +247,16 @@ static int __init setup_tcm_pool(void)
 			}
 			pr_debug("CPU DTCM: Added %08x bytes @ %08x to " \
 				 "the TCM memory pool\n",
-				 DTCM_END - dtcm_pool_start + 1,
+				 dtcm_end - dtcm_pool_start,
 				 dtcm_pool_start);
 		}
 	}
 
 	/* Add the rest of ITCM to the TCM pool */
 	if (tcm_status & 0x03) {
-		if (itcm_pool_start < ITCM_END) {
+		if (itcm_pool_start < itcm_end) {
 			ret = gen_pool_add(tcm_pool, itcm_pool_start,
-					   ITCM_END - itcm_pool_start + 1, -1);
+					   itcm_end - itcm_pool_start, -1);
 			if (ret) {
 				pr_err("CPU ITCM: could not add ITCM " \
 				       "remainder to pool!\n");
@@ -259,7 +264,7 @@ static int __init setup_tcm_pool(void)
 			}
 			pr_debug("CPU ITCM: Added %08x bytes @ %08x to " \
 				 "the TCM memory pool\n",
-				 ITCM_END - itcm_pool_start + 1,
+				 itcm_end - itcm_pool_start,
 				 itcm_pool_start);
 		}
 	}
diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
index ab000df..bf134bc 100644
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ b/arch/arm/mach-u300/include/mach/memory.h
@@ -35,14 +35,6 @@
 #endif
 
 /*
- * TCM memory whereabouts
- */
-#define ITCM_OFFSET	0xffff2000
-#define ITCM_END	0xffff3fff
-#define DTCM_OFFSET	0xffff4000
-#define DTCM_END	0xffff5fff
-
-/*
  * We enable a real big DMA buffer if need be.
  */
 #define CONSISTENT_DMA_SIZE SZ_4M
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b7ec94b..c70c5b3 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -432,6 +432,12 @@ void __init mem_init(void)
 {
 	unsigned long reserved_pages, free_pages;
 	int i;
+#ifdef CONFIG_HAVE_TCM
+	/* These pointers are filled in on TCM detection */
+	extern u32 dtcm_end;
+	extern u32 itcm_end;
+#endif
+
 
 #ifdef CONFIG_SA1111
 	lmb_free(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
@@ -505,13 +511,9 @@ void __init mem_init(void)
 	printk(KERN_NOTICE "Virtual kernel memory layout:\n"
 			"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 #ifdef CONFIG_HAVE_TCM
-#ifdef DTCM_OFFSET
 			"    DTCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
-#ifdef ITCM_OFFSET
 			"    ITCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 #endif
-#endif
 			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 #ifdef CONFIG_MMU
 			"    DMA     : 0x%08lx - 0x%08lx   (%4ld MB)\n"
@@ -529,12 +531,8 @@ void __init mem_init(void)
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
 #ifdef CONFIG_HAVE_TCM
-#ifdef DTCM_OFFSET
-			MLK(UL(DTCM_OFFSET), UL(DTCM_END + 1)),
-#endif
-#ifdef ITCM_OFFSET
-			MLK(UL(ITCM_OFFSET), UL(ITCM_END + 1)),
-#endif
+			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
+			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
 #endif
 			MLK(FIXADDR_START, FIXADDR_TOP),
 #ifdef CONFIG_MMU
-- 
1.7.1
