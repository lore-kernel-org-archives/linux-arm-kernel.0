From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 25 Mar 2013 13:11:08 +0900
Subject: [RFC PATCH 0/6] ARM: use NO_BOOTMEM on default configuration
Message-ID: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, ARM use traditional 'bootmem' allocator. It use a bitmap for
managing memory space, so initialize a bitmap at first step. It is
a needless overhead if we use 'nobootmem'. 'nobootmem' use a memblock
allocator internally, so there is no additional initializing overhead.
In addition, if we use 'nobootmem', we can save small amount of memory,
because 'nobootmem' manage memory space as byte unit. However, 
'bootmem' manage it as page unit, so some space is wasted,
although it is very small. On my system, 20 KB memories can be saved. :)
Using 'nobootmem' have another advantage. Before initializing 'bootmem'
allocator, we use memblock allocator. If we use memblock allocator
after initializing 'bootmem' by mistake, there is possible problem.
Patch '1/6' is good example of this case. 'nobootmem' use memblock
allocator internally, so these risk will be disappeared.

There is one stopper to enable NO_BOOTMEM, it is max_low_pfn.
nobootmem use max_low_pfn for computing boundary in free_all_bootmem()
So we need proper value to max_low_pfn.
But, there is some difficulty related to max_low_pfn. max_low_pfn is used
for two meanings in various architectures. One is for number of pages
in lowmem and the other is for maximum lowmem pfn. Now, in ARM, it is used
as number of pages in lowmem. You can get more information in below link.
http://lwn.net/Articles/543408/
http://lwn.net/Articles/543424/
    
As I investigated, architectures which use max_low_pfn as maximum pfn are
more than others, so IMHO, to change meaning of max_low_pfn to maximum pfn
is preferable solution to me. This patchset change max_low_pfn as maximum
lowmem pfn in ARM. In addition, min_low_pfn, max_pfn is assigned according
to this criteria.

AFAIK, there is no real user for max_low_pfn except block/blk-setting.c
and blk-setting.c assume that max_low_pfn is maximum lowmem pfn,
so this patch may not harm anything. But, I'm not expert about this,
so please let me know what I am missing.

I did some working test on my android device and it worked. :)
Feel free to give me some opinion about this patset.
This patchset is based on v3.9-rc4.

Thanks.

Joonsoo Kim (6):
  ARM, TCM: initialize TCM in paging_init(), instead of setup_arch()
  ARM, crashkernel: use ___alloc_bootmem_node_nopanic() for reserving
    memory
  ARM, crashkernel: correct total_mem size in reserve_crashkernel()
  ARM, mm: don't do arm_bootmem_init() if CONFIG_NO_BOOTMEM
  ARM, mm: change meaning of max_low_pfn to maximum pfn for nobootmem
  ARM, mm: enable NO_BOOTMEM for default ARM build

 arch/arm/Kconfig        |    1 +
 arch/arm/kernel/setup.c |   22 ++++++++--------------
 arch/arm/kernel/tcm.c   |    1 -
 arch/arm/kernel/tcm.h   |   17 -----------------
 arch/arm/mm/init.c      |   19 ++++++++++++-------
 arch/arm/mm/mmu.c       |    2 ++
 arch/arm/mm/tcm.h       |   17 +++++++++++++++++
 7 files changed, 40 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/kernel/tcm.h
 create mode 100644 arch/arm/mm/tcm.h

-- 
1.7.9.5
