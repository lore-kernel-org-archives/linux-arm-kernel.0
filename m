From: lkp@intel.com (kbuild test robot)
Date: Thu, 18 Oct 2018 10:44:55 +0800
Subject: [PATCH V2 4/4] arm64: mm: introduce 52-bit userspace support
In-Reply-To: <20181017163459.20175-5-steve.capper@arm.com>
References: <20181017163459.20175-5-steve.capper@arm.com>
Message-ID: <201810181050.dj7G9iVO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.19-rc8]
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

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:7,
                    from arch/arm64/mm/init.c:20:
   arch/arm64/mm/init.c: In function 'mem_init':
>> include/linux/compiler.h:358:38: error: call to '__compiletime_assert_613' declared with attribute error: BUILD_BUG_ON failed: TASK_SIZE_32 > TASK_SIZE_64
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:338:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:358:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> arch/arm64/mm/init.c:613:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(TASK_SIZE_32   > TASK_SIZE_64);
     ^~~~~~~~~~~~

vim +/__compiletime_assert_613 +358 include/linux/compiler.h

9a8ab1c3 Daniel Santos 2013-02-21  344  
9a8ab1c3 Daniel Santos 2013-02-21  345  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c3 Daniel Santos 2013-02-21  346  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c3 Daniel Santos 2013-02-21  347  
9a8ab1c3 Daniel Santos 2013-02-21  348  /**
9a8ab1c3 Daniel Santos 2013-02-21  349   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  350   * @condition: a compile-time constant condition to check
9a8ab1c3 Daniel Santos 2013-02-21  351   * @msg:       a message to emit if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  352   *
9a8ab1c3 Daniel Santos 2013-02-21  353   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos 2013-02-21  354   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos 2013-02-21  355   * compiler has support to do so.
9a8ab1c3 Daniel Santos 2013-02-21  356   */
9a8ab1c3 Daniel Santos 2013-02-21  357  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos 2013-02-21 @358  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos 2013-02-21  359  

:::::: The code at line 358 was first introduced by commit
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
Size: 40225 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/4ba01138/attachment-0001.gz>
