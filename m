From: hejianet@gmail.com (Jia He)
Date: Wed, 22 Aug 2018 11:07:14 +0800
Subject: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on arm
 and arm64
Message-ID: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But as suggested by Daniel Vacek, it is fine to using memblock to skip
gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.

More from what Daniel said:
"On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
not always return the next valid one but skips more resulting in some
valid frames to be skipped (as if they were invalid). And that's why
kernel was eventually crashing on some !arm machines."

About the performance consideration:
As said by James in b92df1de5,
"I have tested this patch on a virtual model of a Samurai CPU with a
sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.

Besides we can remain memblock_next_valid_pfn, there is still some room
for improvement. After this set, I can see the time overhead of memmap_init
is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
memory, pagesize 64k). I believe arm server will benefit more if memory is
larger than TBs

Patch 1 introduces new config to make codes more generic
Patch 2 remains the memblock_next_valid_pfn on arm and arm64,this patch is
        originated from b92df1de5
Patch 3 optimizes the memblock_next_valid_pfn()

Changelog:
V11:- drop patch#4-6, refine the codes
V10:- move codes to memblock.c, refine the performance consideration
V9: - rebase to mmotm master, refine the log description. No major changes
V8: - introduce new config and move generic code to early_pfn.h
    - optimize memblock_next_valid_pfn as suggested by Matthew Wilcox
V7: - fix i386 compilation error. refine the commit description
V6: - simplify the codes, move arm/arm64 common codes to one file.
    - refine patches as suggested by Danial Vacek and Ard Biesheuvel
V5: - further refining as suggested by Danial Vacek. Make codes
      arm/arm64 more arch specific
V4: - refine patches as suggested by Danial Vacek and Wei Yang
    - optimized on arm besides arm64
V3: - fix 2 issues reported by kbuild test robot
V2: - rebase to mmotm latest
    - remain memblock_next_valid_pfn on arm64
    - refine memblock_search_pfn_regions and pfn_valid_region

Jia He (3):
  arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
  mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
  mm: page_alloc: reduce unnecessary binary search in
    memblock_next_valid_pfn

 arch/arm/Kconfig       |  1 +
 arch/arm64/Kconfig     |  1 +
 include/linux/mmzone.h |  9 +++++++++
 mm/Kconfig             |  3 +++
 mm/memblock.c          | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c        |  5 ++++-
 6 files changed, 69 insertions(+), 1 deletion(-)

-- 
1.8.3.1
