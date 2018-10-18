From: lkp@intel.com (kbuild test robot)
Date: Thu, 18 Oct 2018 10:09:59 +0800
Subject: [PATCH V2 2/4] arm64: mm: Introduce DEFAULT_MAP_WINDOW
In-Reply-To: <20181017163459.20175-3-steve.capper@arm.com>
References: <20181017163459.20175-3-steve.capper@arm.com>
Message-ID: <201810181056.kv4MsksX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.19-rc8]
[cannot apply to next-20181017]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Steve-Capper/52-bit-userspace-VAs/20181018-061652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/cache.h:5:0,
                    from include/linux/printk.h:9,
                    from include/linux/kernel.h:14,
                    from include/asm-generic/bug.h:18,
                    from arch/arm64/include/asm/bug.h:37,
                    from include/linux/bug.h:5,
                    from arch/arm64/include/asm/ptrace.h:90,
                    from arch/arm64/include/asm/elf.h:24,
                    from include/linux/elf.h:5,
                    from arch/arm64/mm/mmap.c:19:
   arch/arm64/mm/mmap.c: In function 'arch_pick_mmap_layout':
   arch/arm64/include/asm/processor.h:63:50: error: 'tsk' undeclared (first use in this function)
    #define DEFAULT_MAP_WINDOW (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
                                                     ^
   include/uapi/linux/kernel.h:11:41: note: in definition of macro '__ALIGN_KERNEL_MASK'
    #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                            ^
   include/linux/kernel.h:58:22: note: in expansion of macro '__ALIGN_KERNEL'
    #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                         ^~~~~~~~~~~~~~
   include/linux/mm.h:144:26: note: in expansion of macro 'ALIGN'
    #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
                             ^~~~~
   arch/arm64/include/asm/processor.h:70:29: note: in expansion of macro 'PAGE_ALIGN'
    #define TASK_UNMAPPED_BASE (PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
                                ^~~~~~~~~~
   arch/arm64/include/asm/processor.h:70:40: note: in expansion of macro 'DEFAULT_MAP_WINDOW'
    #define TASK_UNMAPPED_BASE (PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
                                           ^~~~~~~~~~~~~~~~~~
>> arch/arm64/mm/mmap.c:98:19: note: in expansion of macro 'TASK_UNMAPPED_BASE'
      mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
                      ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/processor.h:63:50: note: each undeclared identifier is reported only once for each function it appears in
    #define DEFAULT_MAP_WINDOW (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
                                                     ^
   include/uapi/linux/kernel.h:11:41: note: in definition of macro '__ALIGN_KERNEL_MASK'
    #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                            ^
   include/linux/kernel.h:58:22: note: in expansion of macro '__ALIGN_KERNEL'
    #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                         ^~~~~~~~~~~~~~
   include/linux/mm.h:144:26: note: in expansion of macro 'ALIGN'
    #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
                             ^~~~~
   arch/arm64/include/asm/processor.h:70:29: note: in expansion of macro 'PAGE_ALIGN'
    #define TASK_UNMAPPED_BASE (PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
                                ^~~~~~~~~~
   arch/arm64/include/asm/processor.h:70:40: note: in expansion of macro 'DEFAULT_MAP_WINDOW'
    #define TASK_UNMAPPED_BASE (PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
                                           ^~~~~~~~~~~~~~~~~~
>> arch/arm64/mm/mmap.c:98:19: note: in expansion of macro 'TASK_UNMAPPED_BASE'
      mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
                      ^~~~~~~~~~~~~~~~~~

vim +/TASK_UNMAPPED_BASE +98 arch/arm64/mm/mmap.c

1d18c47c Catalin Marinas 2012-03-05   81  
1d18c47c Catalin Marinas 2012-03-05   82  /*
1d18c47c Catalin Marinas 2012-03-05   83   * This function, called very early during the creation of a new process VM
1d18c47c Catalin Marinas 2012-03-05   84   * image, sets up which VM layout function to use:
1d18c47c Catalin Marinas 2012-03-05   85   */
8f2af155 Kees Cook       2018-04-10   86  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
1d18c47c Catalin Marinas 2012-03-05   87  {
dd04cff1 Kees Cook       2015-04-14   88  	unsigned long random_factor = 0UL;
dd04cff1 Kees Cook       2015-04-14   89  
dd04cff1 Kees Cook       2015-04-14   90  	if (current->flags & PF_RANDOMIZE)
2b68f6ca Kees Cook       2015-04-14   91  		random_factor = arch_mmap_rnd();
dd04cff1 Kees Cook       2015-04-14   92  
1d18c47c Catalin Marinas 2012-03-05   93  	/*
1d18c47c Catalin Marinas 2012-03-05   94  	 * Fall back to the standard layout if the personality bit is set, or
1d18c47c Catalin Marinas 2012-03-05   95  	 * if the expected stack growth is unlimited:
1d18c47c Catalin Marinas 2012-03-05   96  	 */
8f2af155 Kees Cook       2018-04-10   97  	if (mmap_is_legacy(rlim_stack)) {
dd04cff1 Kees Cook       2015-04-14  @98  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
1d18c47c Catalin Marinas 2012-03-05   99  		mm->get_unmapped_area = arch_get_unmapped_area;
1d18c47c Catalin Marinas 2012-03-05  100  	} else {
8f2af155 Kees Cook       2018-04-10  101  		mm->mmap_base = mmap_base(random_factor, rlim_stack);
1d18c47c Catalin Marinas 2012-03-05  102  		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
1d18c47c Catalin Marinas 2012-03-05  103  	}
1d18c47c Catalin Marinas 2012-03-05  104  }
1d18c47c Catalin Marinas 2012-03-05  105  

:::::: The code at line 98 was first introduced by commit
:::::: dd04cff1dceab18226853b555cf07914648a235f arm64: standardize mmap_rnd() usage

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40225 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/3046b2d8/attachment-0001.gz>
