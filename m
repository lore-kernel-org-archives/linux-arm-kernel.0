From: ddaney.cavm@gmail.com (David Daney)
Date: Tue,  8 Mar 2016 11:03:12 -0800
Subject: [PATCH] Revert "arm64: vmemmap: use virtual projection of linear
 region"
Message-ID: <1457463792-6852-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

This reverts commit dfd55ad85e4a7fbaa82df12467515ac3c81e8a3e.

Commit dfd55ad85e4a ("arm64: vmemmap: use virtual projection of linear
region") causes this failure on Cavium Thunder systems:

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc7-numa+ (ddaney at localhost.localdomain) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-4) (GCC) ) #125 SMP PREEMPT Tue Mar 8 09:59:40 PST 2016
[    0.000000] Boot CPU: AArch64 Processor [431f0a10]
[    0.000000] earlycon: Early serial console at MMIO 0x87e024000000 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] EFI v2.40 by Cavium Thunder cn88xx EFI jenkins_weekly_build_6-1-g188619c-dirty Feb 19 2016 13:32:48
[    0.000000] efi:  ACPI=0xfffff000  ACPI 2.0=0xfffff014  SMBIOS 3.0=0x3faa62000
[    0.000000] Unable to handle kernel paging request at virtual address fffffdff60ff0000
[    0.000000] pgd = fffffe0000df0000
[    0.000000] [fffffdff60ff0000] *pgd=00000003ffda0003, *pud=00000003ffda0003, *pmd=00000003ffda0003, *pte=0000000000000000
[    0.000000] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc7-numa+ #125
[    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
[    0.000000] task: fffffe0000b29800 ti: fffffe0000af0000 task.ti: fffffe0000af0000
[    0.000000] PC is at memmap_init_zone+0xd4/0x11c
[    0.000000] LR is at memmap_init_zone+0xb4/0x11c
[    0.000000] pc : [<fffffe0000a73c94>] lr : [<fffffe0000a73c74>] pstate: 800002c5
[    0.000000] sp : fffffe0000af3d50
[    0.000000] x29: fffffe0000af3d50 x28: 0000000000000001
[    0.000000] x27: fffffe000092c2c0 x26: fffffe0000a90fc0
[    0.000000] x25: fffffe0000b20000 x24: 0000000000040000
[    0.000000] x23: 0000000000000000 x22: 4000000000000000
[    0.000000] x21: 0000000000000001 x20: 00000000ffffffff
[    0.000000] x19: 000000000003fd40 x18: 0000000000000008
[    0.000000] x17: 0000000400000000 x16: 0000000000000008
[    0.000000] x15: 0000000000000018 x14: 00000003ffaa0000
[    0.000000] x13: fffffe0000d6ccc0 x12: 0000000000000080
[    0.000000] x11: 0000000600000008 x10: 00000003fffd8800
[    0.000000] x9 : 0000000000000000 x8 : fffffe03febde800
[    0.000000] x7 : 0000000004fb0000 x6 : fffffe0000d6c0c0
[    0.000000] x5 : 0000000000001d40 x4 : 0000000000000007
[    0.000000] x3 : fffffdff60000000 x2 : 0000000000ff0000
[    0.000000] x1 : 0000000000000001 x0 : 0000000000000001
[    0.000000]
[    0.000000] Process swapper (pid: 0, stack limit = 0xfffffe0000af0020)
[    0.000000] Stack: (0xfffffe0000af3d50 to 0xfffffe0000af4000)
[    0.000000] 3d40:                                   fffffe0000af3da0 fffffe0000a73f50
[    0.000000] 3d60: fffffe0000bf8080 000000000002ff40 fffffe0000bf8688 fffffe0000bf7000
.
.
.
[    0.000000] [<fffffe0000a73c94>] memmap_init_zone+0xd4/0x11c
[    0.000000] [<fffffe0000a73f50>] free_area_init_node+0x274/0x2bc
[    0.000000] [<fffffe0000a34ec0>] bootmem_init+0x158/0x198
[    0.000000] [<fffffe0000a352d0>] paging_init+0xec/0x1a4
[    0.000000] [<fffffe0000a32ed0>] setup_arch+0x110/0x5a0
[    0.000000] [<fffffe0000a30680>] start_kernel+0xa8/0x3dc
[    0.000000] [<fffffe00000811b4>] 0xfffffe00000811b4
[    0.000000] Code: cb424262 f2dfbfe3 d37ae442 f2ffffe3 (f8636840)
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception
[    0.000000] ---[ end Kernel panic - not syncing: Fatal exception

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/pgtable.h | 7 +++----
 arch/arm64/mm/init.c             | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f506086..bf464de 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -34,13 +34,13 @@
 /*
  * VMALLOC and SPARSEMEM_VMEMMAP ranges.
  *
- * VMEMAP_SIZE: allows the whole linear region to be covered by a struct page array
+ * VMEMAP_SIZE: allows the whole VA space to be covered by a struct page array
  *	(rounded up to PUD_SIZE).
  * VMALLOC_START: beginning of the kernel VA space
  * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
  *	fixed mappings and modules
  */
-#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
+#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
 
 #ifndef CONFIG_KASAN
 #define VMALLOC_START		(VA_START)
@@ -51,8 +51,7 @@
 
 #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
 
-#define VMEMMAP_START		(VMALLOC_END + SZ_64K)
-#define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
+#define vmemmap			((struct page *)(VMALLOC_END + SZ_64K))
 
 #define FIRST_USER_ADDRESS	0UL
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7802f21..f3b061e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -319,8 +319,8 @@ void __init mem_init(void)
 #endif
 		  MLG(VMALLOC_START, VMALLOC_END),
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-		  MLG(VMEMMAP_START,
-		      VMEMMAP_START + VMEMMAP_SIZE),
+		  MLG((unsigned long)vmemmap,
+		      (unsigned long)vmemmap + VMEMMAP_SIZE),
 		  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
 		      (unsigned long)virt_to_page(high_memory)),
 #endif
-- 
1.8.3.1
