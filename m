From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 13:15:06 +0800
Subject: [v4 09/15] sparc64: optimized struct page zeroing
In-Reply-To: <1501706304-869240-10-git-send-email-pasha.tatashin@oracle.com>
Message-ID: <201708031323.GMW6Kw7G%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.13-rc3 next-20170802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/complete-deferred-page-initialization/20170803-081025
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from mm/page_alloc.c:17:
   mm/page_alloc.c: In function '__init_single_page':
>> include/linux/compiler.h:542:38: error: call to '__compiletime_assert_1171' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct page) != 64
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:525:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:542:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:46:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:70:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> arch/sparc/include/asm/pgtable_64.h:240:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(sizeof(struct page) != 64); \
      ^~~~~~~~~~~~
>> mm/page_alloc.c:1171:2: note: in expansion of macro 'mm_zero_struct_page'
     mm_zero_struct_page(page);
     ^~~~~~~~~~~~~~~~~~~

vim +/__compiletime_assert_1171 +542 include/linux/compiler.h

c361d3e5 Daniel Santos 2013-02-21  519  
9a8ab1c3 Daniel Santos 2013-02-21  520  #define __compiletime_assert(condition, msg, prefix, suffix)		\
9a8ab1c3 Daniel Santos 2013-02-21  521  	do {								\
9a8ab1c3 Daniel Santos 2013-02-21  522  		bool __cond = !(condition);				\
9a8ab1c3 Daniel Santos 2013-02-21  523  		extern void prefix ## suffix(void) __compiletime_error(msg); \
9a8ab1c3 Daniel Santos 2013-02-21  524  		if (__cond)						\
9a8ab1c3 Daniel Santos 2013-02-21  525  			prefix ## suffix();				\
9a8ab1c3 Daniel Santos 2013-02-21  526  		__compiletime_error_fallback(__cond);			\
9a8ab1c3 Daniel Santos 2013-02-21  527  	} while (0)
9a8ab1c3 Daniel Santos 2013-02-21  528  
9a8ab1c3 Daniel Santos 2013-02-21  529  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c3 Daniel Santos 2013-02-21  530  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c3 Daniel Santos 2013-02-21  531  
9a8ab1c3 Daniel Santos 2013-02-21  532  /**
9a8ab1c3 Daniel Santos 2013-02-21  533   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  534   * @condition: a compile-time constant condition to check
9a8ab1c3 Daniel Santos 2013-02-21  535   * @msg:       a message to emit if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  536   *
9a8ab1c3 Daniel Santos 2013-02-21  537   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos 2013-02-21  538   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos 2013-02-21  539   * compiler has support to do so.
9a8ab1c3 Daniel Santos 2013-02-21  540   */
9a8ab1c3 Daniel Santos 2013-02-21  541  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos 2013-02-21 @542  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos 2013-02-21  543  

:::::: The code at line 542 was first introduced by commit
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
Size: 51272 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/ad2e99cb/attachment-0001.gz>
