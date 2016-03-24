From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Mar 2016 17:54:15 +0000
Subject: [GIT PULL] arm64 updates (2nd set) for 4.6
Message-ID: <20160324175411.GA14400@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates below, based on the arm64 for-next/core
branch I sent earlier during this merging window (on top of 4.5-rc4).
I'll be on holiday for two weeks but Will Deacon is going to take care
of the arm64 tree and any subsequent updates/fixes.

There is a minor conflict between the pr_notice() patch in this pull
request and commit dfd55ad85e4a ("arm64: vmemmap: use virtual projection
of linear region") in 4.5. The fix is already in -next but I include it
below FYI, basically s/vmmemap/VMEMMAP_START/ on top of these patches.

Thanks.

The following changes since commit 2776e0e8ef683a42fe3e9a5facf576b73579700e:

  arm64: kasan: Fix zero shadow mapping overriding kernel image shadow (2016-03-11 11:03:35 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 691b1e2ebf727167a2e3cdcd1ea0851dee10247b:

  arm64: mm: allow preemption in copy_to_user_page (2016-03-24 16:32:54 +0000)

----------------------------------------------------------------
2nd set of arm64 updates for 4.6:

- KASLR bug fixes: use callee-saved register, boot-time I-cache
  maintenance
- inv_entry asm macro fix (EL0 check typo)
- pr_notice("Virtual kernel memory layout...") splitting
- Clean-ups: use p?d_set_huge consistently, allow preemption around
  copy_to_user_page, remove unused __local_flush_icache_all()

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64/kernel: fix incorrect EL0 check in inv_entry macro
      arm64: kaslr: use callee saved register to preserve SCTLR across C call

Catalin Marinas (1):
      arm64: Split pr_notice("Virtual kernel memory layout...") into multiple pr_cont()

Kefeng Wang (1):
      arm64: drop unused __local_flush_icache_all()

Mark Rutland (3):
      arm64: fix KASLR boot-time I-cache maintenance
      arm64: consistently use p?d_set_huge
      arm64: mm: allow preemption in copy_to_user_page

 arch/arm64/include/asm/cacheflush.h |  7 -----
 arch/arm64/kernel/entry.S           |  2 +-
 arch/arm64/kernel/head.S            |  9 +++---
 arch/arm64/mm/flush.c               |  4 ---
 arch/arm64/mm/init.c                | 60 +++++++++++++++++--------------------
 arch/arm64/mm/mmu.c                 |  6 ++--
 6 files changed, 36 insertions(+), 52 deletions(-)

-----------------------8<------------------

commit 855f18ac50b7046b818ced76518faa917060fbc4
Merge: aca04ce5dbda 691b1e2ebf72
Author:     Catalin Marinas <catalin.marinas@arm.com>
AuthorDate: Thu Mar 24 17:44:35 2016 +0000
Commit:     Catalin Marinas <catalin.marinas@arm.com>
CommitDate: Thu Mar 24 17:44:35 2016 +0000

    Merge branch 'for-next/core' into HEAD
    
    * for-next/core:
      arm64: mm: allow preemption in copy_to_user_page
      arm64: consistently use p?d_set_huge
      arm64: kaslr: use callee saved register to preserve SCTLR across C call
      arm64: Split pr_notice("Virtual kernel memory layout...") into multiple pr_cont()
      arm64: drop unused __local_flush_icache_all()
      arm64: fix KASLR boot-time I-cache maintenance
      arm64/kernel: fix incorrect EL0 check in inv_entry macro
    
    Conflicts:
    	arch/arm64/mm/init.c

diff --cc arch/arm64/mm/init.c
index 61a38eaf0895,d09603d0e5e9..ea989d83ea9b
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@@ -362,42 -362,38 +362,38 @@@ void __init mem_init(void
  #define MLG(b, t) b, t, ((t) - (b)) >> 30
  #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
  
- 	pr_notice("Virtual kernel memory layout:\n"
+ 	pr_notice("Virtual kernel memory layout:\n");
  #ifdef CONFIG_KASAN
- 		  "    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n"
+ 	pr_cont("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+ 		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
  #endif
- 		  "    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n"
- 		  "    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n"
- 		  "      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
- 		  "    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
- 		  "      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
- 		  "      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n"
+ 	pr_cont("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+ 		MLM(MODULES_VADDR, MODULES_END));
+ 	pr_cont("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+ 		MLG(VMALLOC_START, VMALLOC_END));
+ 	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
+ 		"    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
+ 		"      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
+ 		"      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+ 		MLK_ROUNDUP(_text, __start_rodata),
+ 		MLK_ROUNDUP(__start_rodata, _etext),
+ 		MLK_ROUNDUP(__init_begin, __init_end),
+ 		MLK_ROUNDUP(_sdata, _edata));
  #ifdef CONFIG_SPARSEMEM_VMEMMAP
- 		  "    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n"
- 		  "              0x%16lx - 0x%16lx   (%6ld MB actual)\n"
+ 	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n"
+ 		"              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
 -		MLG((unsigned long)vmemmap,
 -		    (unsigned long)vmemmap + VMEMMAP_SIZE),
++		MLG(VMEMMAP_START,
++		    VMEMMAP_START + VMEMMAP_SIZE),
+ 		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
+ 		    (unsigned long)virt_to_page(high_memory)));
  #endif
- 		  "    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n"
- 		  "    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n"
- 		  "    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
- #ifdef CONFIG_KASAN
- 		  MLG(KASAN_SHADOW_START, KASAN_SHADOW_END),
- #endif
- 		  MLM(MODULES_VADDR, MODULES_END),
- 		  MLG(VMALLOC_START, VMALLOC_END),
- 		  MLK_ROUNDUP(_text, __start_rodata),
- 		  MLK_ROUNDUP(__start_rodata, _etext),
- 		  MLK_ROUNDUP(__init_begin, __init_end),
- 		  MLK_ROUNDUP(_sdata, _edata),
- #ifdef CONFIG_SPARSEMEM_VMEMMAP
- 		  MLG(VMEMMAP_START,
- 		      VMEMMAP_START + VMEMMAP_SIZE),
- 		  MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
- 		      (unsigned long)virt_to_page(high_memory)),
- #endif
- 		  MLK(FIXADDR_START, FIXADDR_TOP),
- 		  MLM(PCI_IO_START, PCI_IO_END),
- 		  MLM(__phys_to_virt(memblock_start_of_DRAM()),
- 		      (unsigned long)high_memory));
+ 	pr_cont("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
+ 		MLK(FIXADDR_START, FIXADDR_TOP));
+ 	pr_cont("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+ 		MLM(PCI_IO_START, PCI_IO_END));
+ 	pr_cont("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+ 		MLM(__phys_to_virt(memblock_start_of_DRAM()),
+ 		    (unsigned long)high_memory));
  
  #undef MLK
  #undef MLM
