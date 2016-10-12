From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 12 Oct 2016 12:23:40 +0100
Subject: [PATCH v3 0/5] arm64/mm: use the contiguous attribute for kernel
 mappings
Message-ID: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This 5-piece series is a followup to the single patch 'arm64: mmu: set the
contiguous for kernel mappings when appropriate' sent out on the 10th [0].

Changes in v3:
- add support for contiguous PMDs for all granule sizes (not just 16k)
- add a separate patch to deal with contiguous PUDs (4k granule only), and
  contiguous PMDs for 2 levels of translation (which requires special handling)
- avoid pmd_none/pud_none in the BUG() statements in patch #1, since they
  may resolve in unexpected ways with folded PMDs/PUDs

Version v2 [1] addressed the following issues:
- the contiguous attribute is also useful for contigous PMD mappings on 16k
  granule kernels (i.e., 1 GB blocks)
- the function parameter 'block_mappings_allowed' does not clearly convey
  whether contiguous page mappings should be used, so it is renamed to
  'page_mappings_only', and its meaning inverted
- instead of BUGging on changes in the PTE_CONT attribute in PMD or PTE entries
  that have been populated already, BUG on any modification except for
  permission attributes, which don't require break-before-make when changed.

[0] http://marc.info/?l=linux-arm-kernel&m=147612332130714
[1] http://marc.info/?l=linux-arm-kernel&m=147618975314593

An example memory map from a Seattle system with 64 GB running a 4k/3 levels
kernel with KASLR enabled is included below.

Ard Biesheuvel (5):
  arm64: mm: BUG on unsupported manipulations of live kernel mappings
  arm64: mm: replace 'block_mappings_allowed' with 'page_mappings_only'
  arm64: mm: set the contiguous bit for kernel mappings where
    appropriate
  arm64: mm: support additional contiguous kernel mapping region sizes
  arm64: mm: round memstart_addr to contiguous PUD/PMD size

 arch/arm64/include/asm/kernel-pgtable.h |  11 +-
 arch/arm64/include/asm/mmu.h            |   2 +-
 arch/arm64/include/asm/pgtable-hwdef.h  |   6 +
 arch/arm64/kernel/efi.c                 |   8 +-
 arch/arm64/mm/mmu.c                     | 173 ++++++++++++++------
 5 files changed, 140 insertions(+), 60 deletions(-)

-- 
2.7.4

// Kernel mapping

0xffffff8a70100000-0xffffff8a70200000      1M PTE ro x  SHD AF    CON    
0xffffff8a70200000-0xffffff8a70600000      4M PMD ro x  SHD AF        BLK
0xffffff8a70600000-0xffffff8a706d0000    832K PTE ro x  SHD AF    CON    
0xffffff8a706d0000-0xffffff8a70920000   2368K PTE ro NX SHD AF    CON    
0xffffff8a70a90000-0xffffff8a70b40000    704K PTE RW NX SHD AF    CON    
0xffffff8a70b40000-0xffffff8a70b44000     16K PTE RW NX SHD AF           
...

---[ Linear Mapping ]---
0xffffffcc00e80000-0xffffffcc01000000   1536K PTE RW NX SHD AF    CON    
0xffffffcc01000000-0xffffffcc02000000     16M PMD RW NX SHD AF        BLK
0xffffffcc02000000-0xffffffcc40000000    992M PMD RW NX SHD AF    CON BLK
0xffffffcc40000000-0xffffffd180000000     21G PGD RW NX SHD AF        BLK
0xffffffd180000000-0xffffffd198000000    384M PMD RW NX SHD AF    CON BLK
0xffffffd198000000-0xffffffd199200000     18M PMD RW NX SHD AF        BLK
0xffffffd199200000-0xffffffd199300000      1M PTE RW NX SHD AF    CON    
0xffffffd199300000-0xffffffd199400000      1M PTE ro NX SHD AF    CON    
0xffffffd199400000-0xffffffd199a00000      6M PMD ro NX SHD AF        BLK
0xffffffd199a00000-0xffffffd199b20000   1152K PTE ro NX SHD AF    CON    
0xffffffd199b20000-0xffffffd199c00000    896K PTE RW NX SHD AF    CON    
0xffffffd199c00000-0xffffffd19a000000      4M PMD RW NX SHD AF        BLK
0xffffffd19a000000-0xffffffd1c0000000    608M PMD RW NX SHD AF    CON BLK
0xffffffd1c0000000-0xffffffd400000000      9G PGD RW NX SHD AF        BLK
0xffffffd400000000-0xffffffd800000000     16G PGD RW NX SHD AF    CON BLK
0xffffffd800000000-0xffffffdbc0000000     15G PGD RW NX SHD AF        BLK
0xffffffdbc0000000-0xffffffdbf8000000    896M PMD RW NX SHD AF    CON BLK
0xffffffdbf8000000-0xffffffdbf8600000      6M PMD RW NX SHD AF        BLK
0xffffffdbf8600000-0xffffffdbf8700000      1M PTE RW NX SHD AF    CON    
0xffffffdbf87a0000-0xffffffdbf8800000    384K PTE RW NX SHD AF    CON    
0xffffffdbf8800000-0xffffffdbfb800000     48M PMD RW NX SHD AF        BLK
0xffffffdbfb800000-0xffffffdbfb830000    192K PTE RW NX SHD AF    CON    
0xffffffdbfbc10000-0xffffffdbfbcd0000    768K PTE RW NX SHD AF    CON    
0xffffffdbfc000000-0xffffffdbfe000000     32M PMD RW NX SHD AF    CON BLK
0xffffffdbfe000000-0xffffffdbffe00000     30M PMD RW NX SHD AF        BLK
0xffffffdbffe00000-0xffffffdbfffd0000   1856K PTE RW NX SHD AF    CON    
0xffffffdbffff0000-0xffffffdc00000000     64K PTE RW NX SHD AF    CON    
