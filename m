From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 13 Apr 2017 13:17:47 +0100
Subject: [PATCH 1/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 user-visible messages
In-Reply-To: <20170404092604.GB14898@arm.com>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org> <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org> <20170404092604.GB14898@arm.com>
Message-ID: <1492085867.20068.4.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IEC binary prefixes (Ki, Mi, Gi, etc.) were published over twenty
years ago. We should use them consistently, especially in user-visible
messages.

Sure, it doesn't often matter, just as *most* typos and spelling or
grammar mistakes don't often matter. But sometimes, such misuse really
do actually introduce ambiguity, and we should avoid that.

Conversely, there is absolutely no good reason *not* to be using the
binary prefixes. Some people once claimed to find them "ugly", or that
they would cause confusion. But those are purely down to unfamiliarity.

The perceived ugliness, and the alleged confusion, will pass with use.

The correctness, and the lack of ambiguity, will not.

ARM64 in particular, as a new platform, has no excuse for not using the
IEC prefixes which predate its existence by a decade and a half.

What's worse is that some people are pointing at the existing errors and
actually claiming that they want their *new* code to be deliberately
wrong in order to be "consistent" with what's there.

So let's fix the user-visible messages in all of arch/arm64 and nip
*that* particular stupidity in the bud...

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/Kconfig        | 22 +++++++++++-----------
 arch/arm64/kernel/efi.c   |  2 +-
 arch/arm64/kernel/setup.c |  2 +-
 arch/arm64/mm/init.c      | 36 ++++++++++++++++++------------------
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3741859..9643223 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -442,7 +442,7 @@ config CAVIUM_ERRATUM_22375
 	  This implements two gicv3-its errata workarounds for ThunderX. Both
 	  with small impact affecting only ITS table allocation.
 
-	    erratum 22375: only alloc 8MB table size
+	    erratum 22375: only alloc 8MiB table size
 	    erratum 24313: ignore memory access type
 
 	  The fixes are in ITS initialization and basically ignore memory access
@@ -528,21 +528,21 @@ choice
 	  Page size (translation granule) configuration.
 
 config ARM64_4K_PAGES
-	bool "4KB"
+	bool "4KiB"
 	help
-	  This feature enables 4KB pages support.
+	  This feature enables 4KiB pages support.
 
 config ARM64_16K_PAGES
-	bool "16KB"
+	bool "16KiB"
 	help
-	  The system will use 16KB pages support. AArch32 emulation
-	  requires applications compiled with 16K (or a multiple of 16K)
+	  The system will use 16KiB pages support. AArch32 emulation
+	  requires applications compiled with 16KiB (or a multiple of 16KiB)
 	  aligned segments.
 
 config ARM64_64K_PAGES
-	bool "64KB"
+	bool "64KiB"
 	help
-	  This feature enables 64KB pages support (4KB by default)
+	  This feature enables 64KiB pages support (4KiB by default)
 	  allowing only two levels of page tables and faster TLB
 	  look-up. AArch32 emulation requires applications compiled
 	  with 64K aligned segments.
@@ -1063,9 +1063,9 @@ config COMPAT
 	  the user helper functions, VFP support and the ptrace interface are
 	  handled appropriately by the kernel.
 
-	  If you use a page size other than 4KB (i.e, 16KB or 64KB), please be aware
-	  that you will only be able to execute AArch32 binaries that were compiled
-	  with page size aligned segments.
+	  If you use a page size other than 4KiB (i.e, 16KiB or 64KiB), please be
+	  aware that you will only be able to execute AArch32 binaries that were
+	  compiled with page size aligned segments.
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 5d17f37..d80c11f 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -31,7 +31,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 		return PROT_DEVICE_nGnRE;
 
 	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
-		      "UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?"))
+		      "UEFI Runtime regions are not aligned to 64 KiB -- buggy firmware?"))
 		/*
 		 * If the region is not aligned to the page size of the OS, we
 		 * can not use strict permissions, since that would also affect
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42274bd..86de05d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -185,7 +185,7 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
 		pr_crit("\n"
 			"Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
-			"The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
+			"The dtb must be 8-byte aligned and must not exceed 2 MiB in size\n"
 			"\nPlease check your bootloader.",
 			&dt_phys, dt_virt);
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e19e065..85481b9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -111,7 +111,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 
 	memset(zone_size, 0, sizeof(zone_size));
 
-	/* 4GB maximum for 32-bit only capable devices */
+	/* 4GiB maximum for 32-bit only capable devices */
 #ifdef CONFIG_ZONE_DMA
 	max_dma = PFN_DOWN(arm64_dma_phys_limit);
 	zone_size[ZONE_DMA] = max_dma - min;
@@ -182,7 +182,7 @@ static int __init early_mem(char *p)
 		return 1;
 
 	memory_limit = memparse(p, &p) & PAGE_MASK;
-	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
+	pr_notice("Memory limited to %lldMiB\n", memory_limit >> 20);
 
 	return 0;
 }
@@ -242,7 +242,7 @@ void __init arm64_memblock_init(void)
 		 * We can only add back the initrd memory if we don't end up
 		 * with more memory than we can address via the linear mapping.
 		 * It is up to the bootloader to position the kernel and the
-		 * initrd reasonably close to each other (i.e., within 32 GB of
+		 * initrd reasonably close to each other (i.e., within 32 GiB of
 		 * each other) so that all granule/#levels combinations can
 		 * always access both.
 		 */
@@ -292,7 +292,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	/* 4GB maximum for 32-bit only capable devices */
+	/* 4GiB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		arm64_dma_phys_limit = max_zone_dma_phys();
 	else
@@ -425,35 +425,35 @@ void __init mem_init(void)
 
 	pr_notice("Virtual kernel memory layout:\n");
 #ifdef CONFIG_KASAN
-	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GiB)\n",
 		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
 #endif
-	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MiB)\n",
 		MLM(MODULES_VADDR, MODULES_END));
-	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GiB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
-	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(_text, _etext));
-	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(__start_rodata, __init_begin));
-	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(__init_begin, __init_end));
-	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(_sdata, _edata));
-	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(__bss_start, __bss_stop));
-	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
+	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KiB)\n",
 		MLK(FIXADDR_START, FIXADDR_TOP));
-	pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MiB)\n",
 		MLM(PCI_IO_START, PCI_IO_END));
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
+	pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GiB maximum)\n",
 		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
-	pr_notice("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
+	pr_notice("              0x%16lx - 0x%16lx   (%6ld MiB actual)\n",
 		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
 		    (unsigned long)virt_to_page(high_memory)));
 #endif
-	pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MiB)\n",
 		MLM(__phys_to_virt(memblock_start_of_DRAM()),
 		    (unsigned long)high_memory));
 
@@ -523,7 +523,7 @@ __setup("keepinitrd", keepinitrd_setup);
 static int dump_mem_limit(struct notifier_block *self, unsigned long v, void *p)
 {
 	if (memory_limit != (phys_addr_t)ULLONG_MAX) {
-		pr_emerg("Memory Limit: %llu MB\n", memory_limit >> 20);
+		pr_emerg("Memory Limit: %llu MiB\n", memory_limit >> 20);
 	} else {
 		pr_emerg("Memory Limit: none\n");
 	}
-- 
2.9.3

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170413/3df3fc9e/attachment-0001.bin>
