From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Aug 2017 23:10:01 +0800
Subject: [PATCH v2] module: use relative references for __ksymtab entries
In-Reply-To: <20170806124624.22915-1-ard.biesheuvel@linaro.org>
Message-ID: <201708062357.YqRmu8ag%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc3 next-20170804]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/module-use-relative-references-for-__ksymtab-entries/20170806-205309
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:6:0,
                    from arch/x86/include/asm/percpu.h:542,
                    from arch/x86/include/asm/preempt.h:5,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from kernel/fork.c:14:
>> include/linux/percpu-defs.h:92:26: error: __pcpu_unique_cached_stacks causes a section type conflict with __discard_lockdep_tasklist_lock_is_held
     __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;   \
                             ^
   include/linux/percpu-defs.h:116:2: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     DEFINE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:181:8: note: in expansion of macro 'DEFINE_PER_CPU'
    static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
           ^~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/asm-generic/bug.h:15,
                    from arch/x86/include/asm/bug.h:81,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from kernel/fork.c:14:
   include/linux/export.h:71:4: note: '__discard_lockdep_tasklist_lock_is_held' was declared here
       __discard_##sym(void) { return (void *)&sym; } \
       ^
   include/linux/export.h:104:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:111:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   kernel/fork.c:131:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(lockdep_tasklist_lock_is_held);
    ^~~~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/percpu.h:6:0,
                    from arch/x86/include/asm/percpu.h:542,
                    from arch/x86/include/asm/preempt.h:5,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from mm/slab.c:89:
>> include/linux/percpu-defs.h:92:26: error: __pcpu_unique_slab_reap_node causes a section type conflict with __discard_kmem_cache_alloc
     __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;   \
                             ^
   include/linux/percpu-defs.h:116:2: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     DEFINE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~
>> mm/slab.c:524:8: note: in expansion of macro 'DEFINE_PER_CPU'
    static DEFINE_PER_CPU(unsigned long, slab_reap_node);
           ^~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/asm-generic/bug.h:15,
                    from arch/x86/include/asm/bug.h:81,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from mm/slab.c:89:
   include/linux/export.h:71:4: note: '__discard_kmem_cache_alloc' was declared here
       __discard_##sym(void) { return (void *)&sym; } \
       ^
   include/linux/export.h:104:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   mm/slab.c:3567:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(kmem_cache_alloc);
    ^~~~~~~~~~~~~

vim +92 include/linux/percpu-defs.h

62fde541 Tejun Heo     2014-06-17   37  
5028eaa9 David Howells 2009-04-21   38  /*
5028eaa9 David Howells 2009-04-21   39   * Base implementations of per-CPU variable declarations and definitions, where
5028eaa9 David Howells 2009-04-21   40   * the section in which the variable is to be placed is provided by the
7c756e6e Tejun Heo     2009-06-24   41   * 'sec' argument.  This may be used to affect the parameters governing the
5028eaa9 David Howells 2009-04-21   42   * variable's storage.
5028eaa9 David Howells 2009-04-21   43   *
5028eaa9 David Howells 2009-04-21   44   * NOTE!  The sections for the DECLARE and for the DEFINE must match, lest
5028eaa9 David Howells 2009-04-21   45   * linkage errors occur due the compiler generating the wrong code to access
5028eaa9 David Howells 2009-04-21   46   * that section.
5028eaa9 David Howells 2009-04-21   47   */
7c756e6e Tejun Heo     2009-06-24   48  #define __PCPU_ATTRS(sec)						\
e0fdb0e0 Rusty Russell 2009-10-29   49  	__percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))	\
7c756e6e Tejun Heo     2009-06-24   50  	PER_CPU_ATTRIBUTES
7c756e6e Tejun Heo     2009-06-24   51  
7c756e6e Tejun Heo     2009-06-24   52  #define __PCPU_DUMMY_ATTRS						\
7c756e6e Tejun Heo     2009-06-24   53  	__attribute__((section(".discard"), unused))
7c756e6e Tejun Heo     2009-06-24   54  
7c756e6e Tejun Heo     2009-06-24   55  /*
7c756e6e Tejun Heo     2009-06-24   56   * s390 and alpha modules require percpu variables to be defined as
7c756e6e Tejun Heo     2009-06-24   57   * weak to force the compiler to generate GOT based external
7c756e6e Tejun Heo     2009-06-24   58   * references for them.  This is necessary because percpu sections
7c756e6e Tejun Heo     2009-06-24   59   * will be located outside of the usually addressable area.
7c756e6e Tejun Heo     2009-06-24   60   *
7c756e6e Tejun Heo     2009-06-24   61   * This definition puts the following two extra restrictions when
7c756e6e Tejun Heo     2009-06-24   62   * defining percpu variables.
7c756e6e Tejun Heo     2009-06-24   63   *
7c756e6e Tejun Heo     2009-06-24   64   * 1. The symbol must be globally unique, even the static ones.
7c756e6e Tejun Heo     2009-06-24   65   * 2. Static percpu variables cannot be defined inside a function.
7c756e6e Tejun Heo     2009-06-24   66   *
7c756e6e Tejun Heo     2009-06-24   67   * Archs which need weak percpu definitions should define
7c756e6e Tejun Heo     2009-06-24   68   * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
7c756e6e Tejun Heo     2009-06-24   69   *
7c756e6e Tejun Heo     2009-06-24   70   * To ensure that the generic code observes the above two
7c756e6e Tejun Heo     2009-06-24   71   * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
7c756e6e Tejun Heo     2009-06-24   72   * definition is used for all cases.
7c756e6e Tejun Heo     2009-06-24   73   */
7c756e6e Tejun Heo     2009-06-24   74  #if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
7c756e6e Tejun Heo     2009-06-24   75  /*
7c756e6e Tejun Heo     2009-06-24   76   * __pcpu_scope_* dummy variable is used to enforce scope.  It
7c756e6e Tejun Heo     2009-06-24   77   * receives the static modifier when it's used in front of
7c756e6e Tejun Heo     2009-06-24   78   * DEFINE_PER_CPU() and will trigger build failure if
7c756e6e Tejun Heo     2009-06-24   79   * DECLARE_PER_CPU() is used for the same variable.
7c756e6e Tejun Heo     2009-06-24   80   *
7c756e6e Tejun Heo     2009-06-24   81   * __pcpu_unique_* dummy variable is used to enforce symbol uniqueness
7c756e6e Tejun Heo     2009-06-24   82   * such that hidden weak symbol collision, which will cause unrelated
7c756e6e Tejun Heo     2009-06-24   83   * variables to share the same address, can be detected during build.
7c756e6e Tejun Heo     2009-06-24   84   */
7c756e6e Tejun Heo     2009-06-24   85  #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
7c756e6e Tejun Heo     2009-06-24   86  	extern __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;		\
dd17c8f7 Rusty Russell 2009-10-29   87  	extern __PCPU_ATTRS(sec) __typeof__(type) name
7c756e6e Tejun Heo     2009-06-24   88  
7c756e6e Tejun Heo     2009-06-24   89  #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
7c756e6e Tejun Heo     2009-06-24   90  	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
0f5e4816 Tejun Heo     2009-10-29   91  	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
7c756e6e Tejun Heo     2009-06-24  @92  	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
b1a0fbfd Tejun Heo     2013-12-04   93  	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
c43768cb Tejun Heo     2009-07-04   94  	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
dd17c8f7 Rusty Russell 2009-10-29   95  	__typeof__(type) name
7c756e6e Tejun Heo     2009-06-24   96  #else
7c756e6e Tejun Heo     2009-06-24   97  /*
7c756e6e Tejun Heo     2009-06-24   98   * Normal declaration and definition macros.
7c756e6e Tejun Heo     2009-06-24   99   */
7c756e6e Tejun Heo     2009-06-24  100  #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
dd17c8f7 Rusty Russell 2009-10-29  101  	extern __PCPU_ATTRS(sec) __typeof__(type) name
7c756e6e Tejun Heo     2009-06-24  102  

:::::: The code at line 92 was first introduced by commit
:::::: 7c756e6e19e71f0327760d8955f7077118ebb2b1 percpu: implement optional weak percpu definitions

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39269 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170806/9e64aae7/attachment-0001.gz>
