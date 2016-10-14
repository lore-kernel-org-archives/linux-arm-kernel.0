From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 14 Oct 2016 20:51:25 +0800
Subject: [arm-soc:to-build 7/7] include/asm-generic/memory_model.h:33:53:
 warning: 'buddy' may be used uninitialized in this function
Message-ID: <201610142018.XeOegRBH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   3f5089cbac8f9e64f3f0b37fae0f15ac542c8d4a
commit: 3f5089cbac8f9e64f3f0b37fae0f15ac542c8d4a [7/7] Revert "Disable "maybe-uninitialized" warning globally"
config: ia64-tiger_defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3f5089cbac8f9e64f3f0b37fae0f15ac542c8d4a
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/page.h:110:0,
                    from arch/ia64/include/asm/ptrace.h:45,
                    from arch/ia64/include/asm/processor.h:19,
                    from arch/ia64/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:69,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/mm.h:9,
                    from mm/page_alloc.c:18:
   mm/page_alloc.c: In function '__free_pages_ok':
>> include/asm-generic/memory_model.h:33:53: warning: 'buddy' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define __page_to_pfn(page) ((unsigned long)((page) - mem_map) + \
                                                        ^
   mm/page_alloc.c:788:15: note: 'buddy' was declared here
     struct page *buddy;
                  ^~~~~
   In file included from arch/ia64/include/asm/page.h:110:0,
                    from arch/ia64/include/asm/ptrace.h:45,
                    from arch/ia64/include/asm/processor.h:19,
                    from arch/ia64/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:69,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/mm.h:9,
                    from mm/page_alloc.c:18:
   mm/page_alloc.c: In function 'free_pcppages_bulk':
>> include/asm-generic/memory_model.h:33:53: warning: 'buddy' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define __page_to_pfn(page) ((unsigned long)((page) - mem_map) + \
                                                        ^
   mm/page_alloc.c:788:15: note: 'buddy' was declared here
     struct page *buddy;
                  ^~~~~

vim +/buddy +33 include/asm-generic/memory_model.h

a117e66e KAMEZAWA Hiroyuki 2006-03-27  17  #define arch_pfn_to_nid(pfn)	pfn_to_nid(pfn)
a117e66e KAMEZAWA Hiroyuki 2006-03-27  18  #endif
a117e66e KAMEZAWA Hiroyuki 2006-03-27  19  
a117e66e KAMEZAWA Hiroyuki 2006-03-27  20  #ifndef arch_local_page_offset
a117e66e KAMEZAWA Hiroyuki 2006-03-27  21  #define arch_local_page_offset(pfn, nid)	\
a117e66e KAMEZAWA Hiroyuki 2006-03-27  22  	((pfn) - NODE_DATA(nid)->node_start_pfn)
a117e66e KAMEZAWA Hiroyuki 2006-03-27  23  #endif
a117e66e KAMEZAWA Hiroyuki 2006-03-27  24  
a117e66e KAMEZAWA Hiroyuki 2006-03-27  25  #endif /* CONFIG_DISCONTIGMEM */
a117e66e KAMEZAWA Hiroyuki 2006-03-27  26  
a117e66e KAMEZAWA Hiroyuki 2006-03-27  27  /*
a117e66e KAMEZAWA Hiroyuki 2006-03-27  28   * supports 3 memory models.
a117e66e KAMEZAWA Hiroyuki 2006-03-27  29   */
a117e66e KAMEZAWA Hiroyuki 2006-03-27  30  #if defined(CONFIG_FLATMEM)
a117e66e KAMEZAWA Hiroyuki 2006-03-27  31  
67de6482 Andy Whitcroft    2006-06-23  32  #define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
67de6482 Andy Whitcroft    2006-06-23 @33  #define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
a117e66e KAMEZAWA Hiroyuki 2006-03-27  34  				 ARCH_PFN_OFFSET)
a117e66e KAMEZAWA Hiroyuki 2006-03-27  35  #elif defined(CONFIG_DISCONTIGMEM)
a117e66e KAMEZAWA Hiroyuki 2006-03-27  36  
67de6482 Andy Whitcroft    2006-06-23  37  #define __pfn_to_page(pfn)			\
a117e66e KAMEZAWA Hiroyuki 2006-03-27  38  ({	unsigned long __pfn = (pfn);		\
c5d71243 Rafael J. Wysocki 2008-11-08  39  	unsigned long __nid = arch_pfn_to_nid(__pfn);  \
a117e66e KAMEZAWA Hiroyuki 2006-03-27  40  	NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
a117e66e KAMEZAWA Hiroyuki 2006-03-27  41  })

:::::: The code at line 33 was first introduced by commit
:::::: 67de648211fa041fe08a0c25241a4980bbb90698 [PATCH] squash duplicate page_to_pfn and pfn_to_page

:::::: TO: Andy Whitcroft <apw@shadowen.org>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16068 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161014/e0be2887/attachment-0001.gz>
