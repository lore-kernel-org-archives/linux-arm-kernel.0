From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 12:24:53 +0100
Subject: [PATCH] arm64: remove pr_cont abuse from mem_init
Message-ID: <1476962693-21177-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the lines printed by mem_init are independent, with each ending with
a newline. While they logically form a large block, none are actually
continuations of previous lines.

The kernel-side printk code and the userspace demsg tool differ in their
handling of KERN_CONT following a newline, and while this isn't always a
problem kernel-side, it does cause difficulty for userspace. Using
pr_cont causes the userspace tool to not print line prefix (e.g.
timestamps) even when following a newline, mis-aligning the output and
making it harder to read, e.g.

[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
    vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
      .text : 0xffff000008080000 - 0xffff0000088b0000   (  8384 KB)
    .rodata : 0xffff0000088b0000 - 0xffff000008c50000   (  3712 KB)
      .init : 0xffff000008c50000 - 0xffff000008d50000   (  1024 KB)
      .data : 0xffff000008d50000 - 0xffff000008e25200   (   853 KB)
       .bss : 0xffff000008e25200 - 0xffff000008e6bec0   (   284 KB)
    fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
    PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
    vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
              0xffff7e0000000000 - 0xffff7e0026000000   (   608 MB actual)
    memory  : 0xffff800000000000 - 0xffff800980000000   ( 38912 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1

Fix this by using pr_notice consistently for all lines, which both the
kernel and userspace are happy with.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/init.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 21c489b..212c4d1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -421,35 +421,35 @@ void __init mem_init(void)
 
 	pr_notice("Virtual kernel memory layout:\n");
 #ifdef CONFIG_KASAN
-	pr_cont("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
 #endif
-	pr_cont("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
 		MLM(MODULES_VADDR, MODULES_END));
-	pr_cont("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
-	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(_text, _etext));
-	pr_cont("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(__start_rodata, __init_begin));
-	pr_cont("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(__init_begin, __init_end));
-	pr_cont("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(_sdata, _edata));
-	pr_cont("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(__bss_start, __bss_stop));
-	pr_cont("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
+	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
 		MLK(FIXADDR_START, FIXADDR_TOP));
-	pr_cont("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
 		MLM(PCI_IO_START, PCI_IO_END));
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
+	pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
 		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
-	pr_cont("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
+	pr_notice("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
 		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
 		    (unsigned long)virt_to_page(high_memory)));
 #endif
-	pr_cont("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
 		MLM(__phys_to_virt(memblock_start_of_DRAM()),
 		    (unsigned long)high_memory));
 
-- 
1.9.1
