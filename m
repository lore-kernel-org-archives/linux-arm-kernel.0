From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 Dec 2015 06:52:19 +0800
Subject: [PATCH 4.4-rc5 v22 4/4] ARM: Allow IPI_CPU_BACKTRACE to exploit
 FIQ
In-Reply-To: <1450644757-18734-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <201512210611.VZD43TTL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[auto build test ERROR on v4.4-rc5]
[also build test ERROR on next-20151218]
[cannot apply to tip/irq/core]

url:    https://github.com/0day-ci/linux/commits/Daniel-Thompson/irq-arm-Use-FIQ-for-NMI-backtrace-when-possible/20151221-045854
config: arm-socfpga_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
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
                    from arch/arm/kernel/smp.c:10:
   arch/arm/kernel/smp.c: In function 'raise_nmi':
>> include/linux/compiler.h:484:38: error: call to '__compiletime_assert_766' declared with attribute error: BUILD_BUG_ON failed: SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE)
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:467:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/arm/kernel/smp.c:766:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE));
     ^

vim +/__compiletime_assert_766 +484 include/linux/compiler.h

9a8ab1c3 Daniel Santos  2013-02-21  478   *
9a8ab1c3 Daniel Santos  2013-02-21  479   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos  2013-02-21  480   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos  2013-02-21  481   * compiler has support to do so.
9a8ab1c3 Daniel Santos  2013-02-21  482   */
9a8ab1c3 Daniel Santos  2013-02-21  483  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos  2013-02-21 @484  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos  2013-02-21  485  
47933ad4 Peter Zijlstra 2013-11-06  486  #define compiletime_assert_atomic_type(t)				\
47933ad4 Peter Zijlstra 2013-11-06  487  	compiletime_assert(__native_word(t),				\

:::::: The code at line 484 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos@pobox.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 15515 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/a9e75d33/attachment-0001.obj>
