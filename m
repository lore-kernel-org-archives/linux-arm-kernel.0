From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2018 15:36:09 +0200
Subject: [PATCH 02/10] mm: workingset: tell cache transitions from
 workingset thrashing
In-Reply-To: <20180712172942.10094-3-hannes@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-3-hannes@cmpxchg.org>
Message-ID: <CAK8P3a3Nsmt54-ed_gWNev3CBS6_Sv5QGOw4G0sY4ZXOi1R4_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 7:29 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> How many page->flags does this leave us with on 32-bit?
>
>         20 bits are always page flags
>
>         21 if you have an MMU
>
>         23 with the zone bits for DMA, Normal, HighMem, Movable
>
>         29 with the sparsemem section bits
>
>         30 if PAE is enabled
>
>         31 with this patch.
>
> So on 32-bit PAE, that leaves 1 bit for distinguishing two NUMA
> nodes. If that's not enough, the system can switch to discontigmem and
> re-gain the 6 or 7 sparsemem section bits.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

It seems we ran out of bits on arm64 in randconfig builds:

In file included from /git/arm-soc/include/linux/kernel.h:10,
                 from /git/arm-soc/arch/arm64/mm/init.c:20:
/git/arm-soc/arch/arm64/mm/init.c: In function 'mem_init':
/git/arm-soc/include/linux/compiler.h:357:38: error: call to
'__compiletime_assert_618' declared with attribute error: BUILD_BUG_ON
failed: sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT)
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
/git/arm-soc/include/linux/compiler.h:337:4: note: in definition of
macro '__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
/git/arm-soc/include/linux/compiler.h:357:2: note: in expansion of
macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
/git/arm-soc/include/linux/build_bug.h:45:37: note: in expansion of
macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
/git/arm-soc/include/linux/build_bug.h:69:2: note: in expansion of
macro 'BUILD_BUG_ON_MSG'
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
/git/arm-soc/arch/arm64/mm/init.c:618:2: note: in expansion of macro
'BUILD_BUG_ON'
  BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
  ^~~~~~~~~~~~
/git/arm-soc/scripts/Makefile.build:317: recipe for target
'arch/arm64/mm/init.o' failed

Apparently this triggered

#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT <=
BITS_PER_LONG - NR_PAGEFLAGS
#define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
#else
#define LAST_CPUPID_WIDTH 0
#endif

and in turn

#if defined(CONFIG_NUMA_BALANCING) && LAST_CPUPID_WIDTH == 0
#define LAST_CPUPID_NOT_IN_PAGE_FLAGS
#endif

and that _last_cpupid in struct page made sizeof(struct page) larger than 64.

This is for a randconfig build, see https://pastebin.com/YuwSTah3
for the configuration file, some of the relevant options are

CONFIG_64BIT=y
CONFIG_MEMCG=y
CONFIG_SPARSEMEM=y
CONFIG_ARM64_PA_BITS=52
CONFIG_ARM64_64K_PAGES=y
CONFIG_NR_CPUS=64
CONFIG_NUMA_BALANCING=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_NODES_SHIFT=2
# CONFIG_ARCH_USES_PG_UNCACHED is not set
CONFIG_MEMORY_FAILURE=y
CONFIG_IDLE_PAGE_TRACKING=y

#define MAX_NR_ZONES 3
#define ZONES_SHIFT 2
#define MAX_PHYSMEM_BITS 52
#define SECTION_SIZE_BITS 30
#define SECTIONS_WIDTH 22
#define ZONES_WIDTH 2
#define NODES_SHIFT 2
#define LAST__PID_SHIFT 8
#define NR_CPUS_BITS 6
#define LAST_CPUPID_SHIFT 14
#define NR_PAGEFLAGS 25

With the extra page flag, the sum of SECTIONS_WIDTH, NODES_SHIFT,  ZONES_WIDTH,
LAST_CPUPID_SHIFT, and NR_PAGEFLAGS is now 65. Before this change, I could
not trigger that error in randconfig builds. However, setting CONFIG_NR_CPUS or
CONFIG_NODES_SHIFT higher than the defaults would trigger it as well (randconfig
does not randomize those options).

       Arnd
