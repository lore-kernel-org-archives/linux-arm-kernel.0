From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 Oct 2018 20:42:51 +0800
Subject: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
Message-ID: <201810252040.HeepMDW1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux-sof-driver/master]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rafael-David-Tinoco/mm-zsmalloc-c-check-encoded-object-value-overflow-for-PAE/20181025-110258
base:   https://github.com/thesofproject/linux master
config: um-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from mm/zsmalloc.c:33:
   mm/zsmalloc.c: In function 'location_to_obj':
>> mm/zsmalloc.c:129:17: warning: left shift count >= width of type [-Wshift-count-overflow]
     ((_AC(1, ULL)) << MAX_POSSIBLE_PHYSMEM_BITS) ? 1 : 0)
                    ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
>> mm/zsmalloc.c:886:15: note: in expansion of macro 'OBJ_OVERFLOW'
     if (unlikely(OBJ_OVERFLOW(pfn)))
                  ^~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_write
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:set_bit
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:clear_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:clear_bit_unlock
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:test_and_set_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:test_and_set_bit_lock
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/linux/kernel.h:___might_sleep
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 1 include/linux/list.h:list_del_init
   Cyclomatic Complexity 1 include/linux/list.h:list_empty
   Cyclomatic Complexity 1 include/linux/list.h:__list_splice
   Cyclomatic Complexity 2 include/linux/list.h:list_splice_init
   Cyclomatic Complexity 1 arch/um/include/shared/mem.h:to_virt
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 arch/um/include/asm/thread_info.h:current_thread_info
   Cyclomatic Complexity 1 include/asm-generic/preempt.h:preempt_count
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_set
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_dec_and_test
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic64_64.h:arch_atomic64_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic64_64.h:arch_atomic64_add
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic64_64.h:arch_atomic64_sub
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic64_64.h:arch_atomic64_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic64_64.h:arch_atomic64_dec
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic64_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_set
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_inc
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic64_inc
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic64_dec
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic64_add
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic64_sub
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_dec_and_test
   Cyclomatic Complexity 1 include/asm-generic/atomic-long.h:atomic_long_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-long.h:atomic_long_inc
   Cyclomatic Complexity 1 include/asm-generic/atomic-long.h:atomic_long_dec
   Cyclomatic Complexity 1 include/asm-generic/atomic-long.h:atomic_long_add
   Cyclomatic Complexity 1 include/asm-generic/atomic-long.h:atomic_long_sub
   Cyclomatic Complexity 1 arch/x86/um/asm/processor.h:rep_nop
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
   Cyclomatic Complexity 1 include/linux/jump_label.h:static_key_count
   Cyclomatic Complexity 2 include/linux/jump_label.h:static_key_false
   Cyclomatic Complexity 1 include/linux/nodemask.h:node_state
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/workqueue.h:queue_work
   Cyclomatic Complexity 1 include/linux/workqueue.h:schedule_work
   Cyclomatic Complexity 1 include/linux/topology.h:numa_node_id
   Cyclomatic Complexity 1 include/linux/topology.h:numa_mem_id
   Cyclomatic Complexity 1 include/linux/gfp.h:__alloc_pages
   Cyclomatic Complexity 4 include/linux/gfp.h:__alloc_pages_node
   Cyclomatic Complexity 2 include/linux/gfp.h:alloc_pages_node
   Cyclomatic Complexity 4 include/linux/bit_spinlock.h:bit_spin_lock
   Cyclomatic Complexity 2 include/linux/bit_spinlock.h:bit_spin_trylock
   Cyclomatic Complexity 2 include/linux/bit_spinlock.h:bit_spin_unlock
   Cyclomatic Complexity 2 include/linux/bit_spinlock.h:bit_spin_is_locked
   Cyclomatic Complexity 1 include/linux/fs.h:mount_pseudo
   Cyclomatic Complexity 2 include/linux/page-flags.h:compound_head
   Cyclomatic Complexity 1 include/linux/page-flags.h:PagePoisoned
   Cyclomatic Complexity 1 include/linux/page-flags.h:PageLocked
   Cyclomatic Complexity 1 include/linux/page-flags.h:PagePrivate
   Cyclomatic Complexity 1 include/linux/page-flags.h:SetPagePrivate
   Cyclomatic Complexity 1 include/linux/page-flags.h:ClearPagePrivate
   Cyclomatic Complexity 1 include/linux/page-flags.h:PageOwnerPriv1
   Cyclomatic Complexity 1 include/linux/page-flags.h:SetPageOwnerPriv1
   Cyclomatic Complexity 1 include/linux/page-flags.h:ClearPageOwnerPriv1
   Cyclomatic Complexity 1 include/linux/page-flags.h:PageIsolated
   Cyclomatic Complexity 1 include/linux/page_ref.h:page_ref_count
   Cyclomatic Complexity 2 include/linux/page_ref.h:page_ref_inc
   Cyclomatic Complexity 2 include/linux/page_ref.h:page_ref_dec_and_test
   Cyclomatic Complexity 1 include/linux/mm.h:put_page_testzero
   Cyclomatic Complexity 1 include/linux/mm.h:page_mapcount_reset
   Cyclomatic Complexity 1 include/linux/mm.h:page_zonenum
   Cyclomatic Complexity 1 include/linux/mm.h:get_page
   Cyclomatic Complexity 2 include/linux/mm.h:put_page
   Cyclomatic Complexity 1 include/linux/mm.h:page_zone
   Cyclomatic Complexity 1 include/linux/vmstat.h:__inc_zone_state
   Cyclomatic Complexity 1 include/linux/vmstat.h:__dec_zone_state
   Cyclomatic Complexity 1 include/linux/vmstat.h:__inc_zone_page_state
   Cyclomatic Complexity 1 include/linux/vmstat.h:__dec_zone_page_state
   Cyclomatic Complexity 1 include/linux/mm.h:lowmem_page_address
   Cyclomatic Complexity 1 include/linux/uaccess.h:pagefault_disabled_inc
   Cyclomatic Complexity 1 include/linux/uaccess.h:pagefault_disabled_dec

vim +129 mm/zsmalloc.c

    32	
  > 33	#include <linux/module.h>
    34	#include <linux/kernel.h>
    35	#include <linux/sched.h>
    36	#include <linux/magic.h>
    37	#include <linux/bitops.h>
    38	#include <linux/errno.h>
    39	#include <linux/highmem.h>
    40	#include <linux/string.h>
    41	#include <linux/slab.h>
    42	#include <asm/tlbflush.h>
    43	#include <asm/pgtable.h>
    44	#include <linux/cpumask.h>
    45	#include <linux/cpu.h>
    46	#include <linux/vmalloc.h>
    47	#include <linux/preempt.h>
    48	#include <linux/spinlock.h>
    49	#include <linux/shrinker.h>
    50	#include <linux/types.h>
    51	#include <linux/debugfs.h>
    52	#include <linux/zsmalloc.h>
    53	#include <linux/zpool.h>
    54	#include <linux/mount.h>
    55	#include <linux/migrate.h>
    56	#include <linux/pagemap.h>
    57	#include <linux/fs.h>
    58	
    59	#define ZSPAGE_MAGIC	0x58
    60	
    61	/*
    62	 * This must be power of 2 and greater than of equal to sizeof(link_free).
    63	 * These two conditions ensure that any 'struct link_free' itself doesn't
    64	 * span more than 1 page which avoids complex case of mapping 2 pages simply
    65	 * to restore link_free pointer values.
    66	 */
    67	#define ZS_ALIGN		8
    68	
    69	/*
    70	 * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
    71	 * pages. ZS_MAX_ZSPAGE_ORDER defines upper limit on N.
    72	 */
    73	#define ZS_MAX_ZSPAGE_ORDER 2
    74	#define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
    75	
    76	#define ZS_HANDLE_SIZE (sizeof(unsigned long))
    77	
    78	/*
    79	 * Object location (<PFN>, <obj_idx>) is encoded as
    80	 * as single (unsigned long) handle value.
    81	 *
    82	 * Note that object index <obj_idx> starts from 0.
    83	 *
    84	 * This is made more complicated by various memory models and PAE.
    85	 */
    86	
    87	#ifndef MAX_POSSIBLE_PHYSMEM_BITS
    88	#ifdef MAX_PHYSMEM_BITS
    89	#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
    90	#else
    91	/*
    92	 * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
    93	 * be PAGE_SHIFT
    94	 */
    95	#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
    96	#endif
    97	#endif
    98	
    99	#define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
   100	
   101	/*
   102	 * Memory for allocating for handle keeps object position by
   103	 * encoding <page, obj_idx> and the encoded value has a room
   104	 * in least bit(ie, look at obj_to_location).
   105	 * We use the bit to synchronize between object access by
   106	 * user and migration.
   107	 */
   108	#define HANDLE_PIN_BIT	0
   109	
   110	/*
   111	 * Head in allocated object should have OBJ_ALLOCATED_TAG
   112	 * to identify the object was allocated or not.
   113	 * It's okay to add the status bit in the least bit because
   114	 * header keeps handle which is 4byte-aligned address so we
   115	 * have room for two bit at least.
   116	 */
   117	#define OBJ_ALLOCATED_TAG 1
   118	#define OBJ_TAG_BITS 1
   119	#define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
   120	#define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
   121	
   122	/*
   123	 * When using PAE, the obj encoding might overflow if arch does
   124	 * not re-define MAX_PHYSMEM_BITS, since zsmalloc uses HIGHMEM.
   125	 * This checks for a future bad page access, when de-coding obj.
   126	 */
   127	#define OBJ_OVERFLOW(_pfn) \
   128		(((unsigned long long) _pfn << (OBJ_INDEX_BITS + OBJ_TAG_BITS)) >= \
 > 129		((_AC(1, ULL)) << MAX_POSSIBLE_PHYSMEM_BITS) ? 1 : 0)
   130	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19285 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181025/ef2ac693/attachment-0001.gz>
