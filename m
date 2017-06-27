From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 05:42:46 +0800
Subject: [PATCH] ARM: small correction to early_ioremap support
In-Reply-To: <20170627005731.7869-1-opendmb@gmail.com>
Message-ID: <201706280532.oWitSrjT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc7 next-20170627]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Doug-Berger/ARM-small-correction-to-early_ioremap-support/20170627-233123
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from arch/arm/mm/mmu.c:10:
   arch/arm/mm/mmu.c: In function 'early_fixmap_init':
>> include/linux/compiler.h:529:38: error: call to '__compiletime_assert_396' declared with attribute error: BUILD_BUG_ON failed: (__fix_to_virt(__end_of_fixed_addresses) >> PMD_SHIFT) != FIXADDR_TOP >> PMD_SHIFT
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:512:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:529:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:54:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:78:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> arch/arm/mm/mmu.c:395:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON((__fix_to_virt(__end_of_fixed_addresses) >> PMD_SHIFT)
     ^~~~~~~~~~~~

vim +/__compiletime_assert_396 +529 include/linux/compiler.h

9a8ab1c3 Daniel Santos  2013-02-21  523   *
9a8ab1c3 Daniel Santos  2013-02-21  524   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos  2013-02-21  525   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos  2013-02-21  526   * compiler has support to do so.
9a8ab1c3 Daniel Santos  2013-02-21  527   */
9a8ab1c3 Daniel Santos  2013-02-21  528  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos  2013-02-21 @529  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos  2013-02-21  530  
47933ad4 Peter Zijlstra 2013-11-06  531  #define compiletime_assert_atomic_type(t)				\
47933ad4 Peter Zijlstra 2013-11-06  532  	compiletime_assert(__native_word(t),				\

:::::: The code at line 529 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos@pobox.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41289 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/df29f012/attachment-0001.gz>
