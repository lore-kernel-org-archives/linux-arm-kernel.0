From: lkp@intel.com (kbuild test robot)
Date: Wed, 11 Jul 2018 03:12:19 +0800
Subject: [PATCH net-next 08/13] ARM: net: bpf: use immediate forms of
 instructions where possible
In-Reply-To: <E1fcrsq-0005V7-Pp@rmk-PC.armlinux.org.uk>
References: <E1fcrsq-0005V7-Pp@rmk-PC.armlinux.org.uk>
Message-ID: <201807110203.DNO4LfBk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I love your patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Russell-King/ARM-net-bpf-enumerate-the-JIT-scratch-stack-layout/20180710-203859
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from arch/arm/net/bpf_jit_32.c:12:
   In function 'emit_bpf_tail_call',
       inlined from 'build_insn' at arch/arm/net/bpf_jit_32.c:1601:7:
>> include/linux/compiler.h:339:38: error: call to '__compiletime_assert_1045' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct bpf_array, ptrs) > ARM_ALU_IMM
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> arch/arm/net/bpf_jit_32.c:1045:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > ARM_ALU_IMM);
     ^~~~~~~~~~~~

vim +/__compiletime_assert_1045 +339 include/linux/compiler.h

9a8ab1c3 Daniel Santos 2013-02-21  325  
9a8ab1c3 Daniel Santos 2013-02-21  326  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c3 Daniel Santos 2013-02-21  327  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c3 Daniel Santos 2013-02-21  328  
9a8ab1c3 Daniel Santos 2013-02-21  329  /**
9a8ab1c3 Daniel Santos 2013-02-21  330   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  331   * @condition: a compile-time constant condition to check
9a8ab1c3 Daniel Santos 2013-02-21  332   * @msg:       a message to emit if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  333   *
9a8ab1c3 Daniel Santos 2013-02-21  334   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos 2013-02-21  335   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos 2013-02-21  336   * compiler has support to do so.
9a8ab1c3 Daniel Santos 2013-02-21  337   */
9a8ab1c3 Daniel Santos 2013-02-21  338  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos 2013-02-21 @339  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos 2013-02-21  340  

:::::: The code at line 339 was first introduced by commit
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
Size: 66073 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/bb9daefc/attachment-0001.gz>
