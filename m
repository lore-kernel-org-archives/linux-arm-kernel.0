From: lkp@intel.com (kbuild test robot)
Date: Thu, 18 Oct 2018 10:28:07 +0800
Subject: [PATCH V2 3/4] arm64: mm: Define arch_get_mmap_end,
 arch_get_mmap_base
In-Reply-To: <20181017163459.20175-4-steve.capper@arm.com>
References: <20181017163459.20175-4-steve.capper@arm.com>
Message-ID: <201810181001.S8feTq0v%fengguang.wu@intel.com>
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

   In file included from include/asm-generic/qrwlock.h:23:0,
                    from ./arch/arm64/include/generated/asm/qrwlock.h:1,
                    from arch/arm64/include/asm/spinlock.h:19,
                    from include/linux/spinlock.h:88,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from mm/mmap.c:12:
   mm/mmap.c: In function 'arch_get_unmapped_area':
   arch/arm64/include/asm/processor.h:63:50: error: 'tsk' undeclared (first use in this function)
    #define DEFAULT_MAP_WINDOW (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
                                                     ^
   arch/arm64/include/asm/processor.h:81:42: note: in expansion of macro 'DEFAULT_MAP_WINDOW'
    #define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
                                             ^~~~~~~~~~~~~~~~~~
>> mm/mmap.c:2073:33: note: in expansion of macro 'arch_get_mmap_end'
     const unsigned long mmap_end = arch_get_mmap_end(addr);
                                    ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/processor.h:63:50: note: each undeclared identifier is reported only once for each function it appears in
    #define DEFAULT_MAP_WINDOW (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
                                                     ^
   arch/arm64/include/asm/processor.h:81:42: note: in expansion of macro 'DEFAULT_MAP_WINDOW'
    #define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
                                             ^~~~~~~~~~~~~~~~~~
>> mm/mmap.c:2073:33: note: in expansion of macro 'arch_get_mmap_end'
     const unsigned long mmap_end = arch_get_mmap_end(addr);
                                    ^~~~~~~~~~~~~~~~~
   mm/mmap.c: In function 'arch_get_unmapped_area_topdown':
   arch/arm64/include/asm/processor.h:63:50: error: 'tsk' undeclared (first use in this function)
    #define DEFAULT_MAP_WINDOW (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
                                                     ^
   arch/arm64/include/asm/processor.h:81:42: note: in expansion of macro 'DEFAULT_MAP_WINDOW'
    #define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
                                             ^~~~~~~~~~~~~~~~~~
   mm/mmap.c:2113:33: note: in expansion of macro 'arch_get_mmap_end'
     const unsigned long mmap_end = arch_get_mmap_end(addr);
                                    ^~~~~~~~~~~~~~~~~

vim +/arch_get_mmap_end +2073 mm/mmap.c

d5d60952 Steve Capper           2018-10-17  2053  
^1da177e Linus Torvalds         2005-04-16  2054  /* Get an address range which is currently unmapped.
^1da177e Linus Torvalds         2005-04-16  2055   * For shmat() with addr=0.
^1da177e Linus Torvalds         2005-04-16  2056   *
^1da177e Linus Torvalds         2005-04-16  2057   * Ugly calling convention alert:
^1da177e Linus Torvalds         2005-04-16  2058   * Return value with the low bits set means error value,
^1da177e Linus Torvalds         2005-04-16  2059   * ie
^1da177e Linus Torvalds         2005-04-16  2060   *	if (ret & ~PAGE_MASK)
^1da177e Linus Torvalds         2005-04-16  2061   *		error = ret;
^1da177e Linus Torvalds         2005-04-16  2062   *
^1da177e Linus Torvalds         2005-04-16  2063   * This function "knows" that -ENOMEM has the bits set.
^1da177e Linus Torvalds         2005-04-16  2064   */
^1da177e Linus Torvalds         2005-04-16  2065  #ifndef HAVE_ARCH_UNMAPPED_AREA
^1da177e Linus Torvalds         2005-04-16  2066  unsigned long
^1da177e Linus Torvalds         2005-04-16  2067  arch_get_unmapped_area(struct file *filp, unsigned long addr,
^1da177e Linus Torvalds         2005-04-16  2068  		unsigned long len, unsigned long pgoff, unsigned long flags)
^1da177e Linus Torvalds         2005-04-16  2069  {
^1da177e Linus Torvalds         2005-04-16  2070  	struct mm_struct *mm = current->mm;
1be7107f Hugh Dickins           2017-06-19  2071  	struct vm_area_struct *vma, *prev;
db4fbfb9 Michel Lespinasse      2012-12-11  2072  	struct vm_unmapped_area_info info;
d5d60952 Steve Capper           2018-10-17 @2073  	const unsigned long mmap_end = arch_get_mmap_end(addr);
^1da177e Linus Torvalds         2005-04-16  2074  
d5d60952 Steve Capper           2018-10-17  2075  	if (len > mmap_end - mmap_min_addr)
^1da177e Linus Torvalds         2005-04-16  2076  		return -ENOMEM;
^1da177e Linus Torvalds         2005-04-16  2077  
06abdfb4 Benjamin Herrenschmidt 2007-05-06  2078  	if (flags & MAP_FIXED)
06abdfb4 Benjamin Herrenschmidt 2007-05-06  2079  		return addr;
06abdfb4 Benjamin Herrenschmidt 2007-05-06  2080  
^1da177e Linus Torvalds         2005-04-16  2081  	if (addr) {
^1da177e Linus Torvalds         2005-04-16  2082  		addr = PAGE_ALIGN(addr);
1be7107f Hugh Dickins           2017-06-19  2083  		vma = find_vma_prev(mm, addr, &prev);
d5d60952 Steve Capper           2018-10-17  2084  		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
1be7107f Hugh Dickins           2017-06-19  2085  		    (!vma || addr + len <= vm_start_gap(vma)) &&
1be7107f Hugh Dickins           2017-06-19  2086  		    (!prev || addr >= vm_end_gap(prev)))
^1da177e Linus Torvalds         2005-04-16  2087  			return addr;
^1da177e Linus Torvalds         2005-04-16  2088  	}
^1da177e Linus Torvalds         2005-04-16  2089  
db4fbfb9 Michel Lespinasse      2012-12-11  2090  	info.flags = 0;
db4fbfb9 Michel Lespinasse      2012-12-11  2091  	info.length = len;
4e99b021 Heiko Carstens         2013-11-12  2092  	info.low_limit = mm->mmap_base;
d5d60952 Steve Capper           2018-10-17  2093  	info.high_limit = mmap_end;
db4fbfb9 Michel Lespinasse      2012-12-11  2094  	info.align_mask = 0;
db4fbfb9 Michel Lespinasse      2012-12-11  2095  	return vm_unmapped_area(&info);
^1da177e Linus Torvalds         2005-04-16  2096  }
^1da177e Linus Torvalds         2005-04-16  2097  #endif
^1da177e Linus Torvalds         2005-04-16  2098  

:::::: The code at line 2073 was first introduced by commit
:::::: d5d60952691e93644f4e7692baffbef33c93f91a mm: mmap: Allow for "high" userspace addresses

:::::: TO: Steve Capper <steve.capper@arm.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40225 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/3b851d8b/attachment-0001.gz>
