From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Jun 2017 10:29:15 +0800
Subject: [PATCH v4] mm: huge-vmap: fail gracefully on unexpected huge
 vmap mappings
In-Reply-To: <20170608192219.8338-1-ard.biesheuvel@linaro.org>
Message-ID: <201706091025.amevF8F1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test WARNING on mmotm/master]
[also build test WARNING on v4.12-rc4 next-20170608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-huge-vmap-fail-gracefully-on-unexpected-huge-vmap-mappings/20170609-093236
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: x86_64-randconfig-x015-201723 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   mm/vmalloc.c: In function 'vmalloc_to_page':
   mm/vmalloc.c:2775:0: error: unterminated argument list invoking macro "WARN_ON_ONCE"
    
    
   mm/vmalloc.c:303:2: error: 'WARN_ON_ONCE' undeclared (first use in this function)
     WARN_ON_ONCE(pmd_bad(*pmd);
     ^~~~~~~~~~~~
   mm/vmalloc.c:303:2: note: each undeclared identifier is reported only once for each function it appears in
   mm/vmalloc.c:303:2: error: expected ';' at end of input
   mm/vmalloc.c:303:2: error: expected declaration or statement at end of input
   mm/vmalloc.c:276:15: warning: unused variable 'pte' [-Wunused-variable]
     pte_t *ptep, pte;
                  ^~~
   mm/vmalloc.c:276:9: warning: unused variable 'ptep' [-Wunused-variable]
     pte_t *ptep, pte;
            ^~~~
   mm/vmalloc.c:271:15: warning: unused variable 'page' [-Wunused-variable]
     struct page *page = NULL;
                  ^~~~
   mm/vmalloc.c: At top level:
   mm/vmalloc.c:47:13: warning: '__vunmap' used but never defined
    static void __vunmap(const void *, int);
                ^~~~~~~~
   mm/vmalloc.c: In function 'vmalloc_to_page':
   mm/vmalloc.c:303:2: warning: control reaches end of non-void function [-Wreturn-type]
     WARN_ON_ONCE(pmd_bad(*pmd);
     ^~~~~~~~~~~~
   At top level:
   mm/vmalloc.c:240:12: warning: 'vmap_page_range' defined but not used [-Wunused-function]
    static int vmap_page_range(unsigned long start, unsigned long end,
               ^~~~~~~~~~~~~~~
   mm/vmalloc.c:121:13: warning: 'vunmap_page_range' defined but not used [-Wunused-function]
    static void vunmap_page_range(unsigned long addr, unsigned long end)
                ^~~~~~~~~~~~~~~~~
   mm/vmalloc.c:49:13: warning: 'free_work' defined but not used [-Wunused-function]
    static void free_work(struct work_struct *w)
                ^~~~~~~~~
   In file included from include/asm-generic/percpu.h:6:0,
                    from arch/x86/include/asm/percpu.h:542,
                    from arch/x86/include/asm/preempt.h:5,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/vmalloc.h:4,
                    from mm/vmalloc.c:11:
   mm/vmalloc.c:45:46: warning: 'vfree_deferred' defined but not used [-Wunused-variable]
    static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
                                                 ^
   include/linux/percpu-defs.h:105:19: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     __typeof__(type) name
                      ^~~~
>> mm/vmalloc.c:45:8: note: in expansion of macro 'DEFINE_PER_CPU'
    static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
           ^~~~~~~~~~~~~~

vim +/DEFINE_PER_CPU +45 mm/vmalloc.c

^1da177e4 Linus Torvalds       2005-04-16   5   *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
^1da177e4 Linus Torvalds       2005-04-16   6   *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian <tigran@veritas.com>, May 2000
^1da177e4 Linus Torvalds       2005-04-16   7   *  Major rework to support vmap/vunmap, Christoph Hellwig, SGI, August 2002
930fc45a4 Christoph Lameter    2005-10-29   8   *  Numa awareness, Christoph Lameter, SGI, June 2005
^1da177e4 Linus Torvalds       2005-04-16   9   */
^1da177e4 Linus Torvalds       2005-04-16  10  
db64fe022 Nick Piggin          2008-10-18 @11  #include <linux/vmalloc.h>
^1da177e4 Linus Torvalds       2005-04-16  12  #include <linux/mm.h>
^1da177e4 Linus Torvalds       2005-04-16  13  #include <linux/module.h>
^1da177e4 Linus Torvalds       2005-04-16  14  #include <linux/highmem.h>
c3edc4010 Ingo Molnar          2017-02-02  15  #include <linux/sched/signal.h>
^1da177e4 Linus Torvalds       2005-04-16  16  #include <linux/slab.h>
^1da177e4 Linus Torvalds       2005-04-16  17  #include <linux/spinlock.h>
^1da177e4 Linus Torvalds       2005-04-16  18  #include <linux/interrupt.h>
5f6a6a9c4 Alexey Dobriyan      2008-10-06  19  #include <linux/proc_fs.h>
a10aa5798 Christoph Lameter    2008-04-28  20  #include <linux/seq_file.h>
3ac7fe5a4 Thomas Gleixner      2008-04-30  21  #include <linux/debugobjects.h>
230169693 Christoph Lameter    2008-04-28  22  #include <linux/kallsyms.h>
db64fe022 Nick Piggin          2008-10-18  23  #include <linux/list.h>
4da56b99d Chris Wilson         2016-04-04  24  #include <linux/notifier.h>
db64fe022 Nick Piggin          2008-10-18  25  #include <linux/rbtree.h>
db64fe022 Nick Piggin          2008-10-18  26  #include <linux/radix-tree.h>
db64fe022 Nick Piggin          2008-10-18  27  #include <linux/rcupdate.h>
f0aa66179 Tejun Heo            2009-02-20  28  #include <linux/pfn.h>
89219d37a Catalin Marinas      2009-06-11  29  #include <linux/kmemleak.h>
60063497a Arun Sharma          2011-07-26  30  #include <linux/atomic.h>
3b32123d7 Gideon Israel Dsouza 2014-04-07  31  #include <linux/compiler.h>
32fcfd407 Al Viro              2013-03-10  32  #include <linux/llist.h>
0f616be12 Toshi Kani           2015-04-14  33  #include <linux/bitops.h>
3b32123d7 Gideon Israel Dsouza 2014-04-07  34  
7c0f6ba68 Linus Torvalds       2016-12-24  35  #include <linux/uaccess.h>
^1da177e4 Linus Torvalds       2005-04-16  36  #include <asm/tlbflush.h>
2dca6999e David Miller         2009-09-21  37  #include <asm/shmparam.h>
^1da177e4 Linus Torvalds       2005-04-16  38  
dd56b0464 Mel Gorman           2015-11-06  39  #include "internal.h"
dd56b0464 Mel Gorman           2015-11-06  40  
32fcfd407 Al Viro              2013-03-10  41  struct vfree_deferred {
32fcfd407 Al Viro              2013-03-10  42  	struct llist_head list;
32fcfd407 Al Viro              2013-03-10  43  	struct work_struct wq;
32fcfd407 Al Viro              2013-03-10  44  };
32fcfd407 Al Viro              2013-03-10 @45  static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
32fcfd407 Al Viro              2013-03-10  46  
32fcfd407 Al Viro              2013-03-10  47  static void __vunmap(const void *, int);
32fcfd407 Al Viro              2013-03-10  48  

:::::: The code at line 45 was first introduced by commit
:::::: 32fcfd40715ed13f7a80cbde49d097ddae20c8e2 make vfree() safe to call from interrupt contexts

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26719 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/de1f4dfc/attachment-0001.gz>
