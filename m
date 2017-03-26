From: lkp@intel.com (kbuild test robot)
Date: Sun, 26 Mar 2017 15:44:42 +0800
Subject: [PATCH v3 3/7] x86: Implement memset16, memset32 & memset64
In-Reply-To: <20170324161318.18718-4-willy@infradead.org>
Message-ID: <201703261513.GU5jiBgq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/Add-memsetN-functions/20170326-140108
config: i386-randconfig-x077-201713 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> lib/string.c:733:7: error: redefinition of 'memset32'
    void *memset32(uint32_t *s, uint32_t v, size_t count)
          ^~~~~~~~
   In file included from arch/x86/include/asm/string.h:2:0,
                    from include/linux/string.h:18,
                    from lib/string.c:23:
   arch/x86/include/asm/string_32.h:347:21: note: previous definition of 'memset32' was here
    static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
                        ^~~~~~~~

vim +/memset32 +733 lib/string.c

9114f9de Matthew Wilcox 2017-03-24  717  	return s;
9114f9de Matthew Wilcox 2017-03-24  718  }
9114f9de Matthew Wilcox 2017-03-24  719  EXPORT_SYMBOL(memset16);
9114f9de Matthew Wilcox 2017-03-24  720  #endif
9114f9de Matthew Wilcox 2017-03-24  721  
9114f9de Matthew Wilcox 2017-03-24  722  #ifndef __HAVE_ARCH_MEMSET32
9114f9de Matthew Wilcox 2017-03-24  723  /**
9114f9de Matthew Wilcox 2017-03-24  724   * memset32() - Fill a memory area with a uint32_t
9114f9de Matthew Wilcox 2017-03-24  725   * @s: Pointer to the start of the area.
9114f9de Matthew Wilcox 2017-03-24  726   * @v: The value to fill the area with
9114f9de Matthew Wilcox 2017-03-24  727   * @count: The number of values to store
9114f9de Matthew Wilcox 2017-03-24  728   *
9114f9de Matthew Wilcox 2017-03-24  729   * Differs from memset() in that it fills with a uint32_t instead
9114f9de Matthew Wilcox 2017-03-24  730   * of a byte.  Remember that @count is the number of uint32_ts to
9114f9de Matthew Wilcox 2017-03-24  731   * store, not the number of bytes.
9114f9de Matthew Wilcox 2017-03-24  732   */
9114f9de Matthew Wilcox 2017-03-24 @733  void *memset32(uint32_t *s, uint32_t v, size_t count)
9114f9de Matthew Wilcox 2017-03-24  734  {
9114f9de Matthew Wilcox 2017-03-24  735  	uint32_t *xs = s;
9114f9de Matthew Wilcox 2017-03-24  736  
9114f9de Matthew Wilcox 2017-03-24  737  	while (count--)
9114f9de Matthew Wilcox 2017-03-24  738  		*xs++ = v;
9114f9de Matthew Wilcox 2017-03-24  739  	return s;
9114f9de Matthew Wilcox 2017-03-24  740  }
9114f9de Matthew Wilcox 2017-03-24  741  EXPORT_SYMBOL(memset32);

:::::: The code at line 733 was first introduced by commit
:::::: 9114f9de5005f9468370ed1cb1b5b841b10d3bad Add multibyte memset functions

:::::: TO: Matthew Wilcox <mawilcox@microsoft.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25827 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/cd155bfd/attachment-0001.gz>
