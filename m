From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 17 Nov 2017 11:15:26 +0800
Subject: [arm:drm-armada-devel 8/30] include/linux/compiler.h:577:38: error:
 call to '__compiletime_assert_85' declared with attribute error: pointer
 type mismatch in container_of()
Message-ID: <201711171120.BmAh6LGI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-devel
head:   6e1b66d093d9dccecc5e3932d4ce72f90a55ce25
commit: 2ef98e6a2c04e6757c5e7a2ae006ca2961b3f598 [8/30] drm/armada: store plane in armada_plane_work
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2ef98e6a2c04e6757c5e7a2ae006ca2961b3f598
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm/drm-armada-devel HEAD 6e1b66d093d9dccecc5e3932d4ce72f90a55ce25 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:2:0,
                    from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/list.h:5,
                    from include/linux/agp_backend.h:33,
                    from include/drm/drmP.h:35,
                    from drivers/gpu//drm/armada/armada_overlay.c:9:
   drivers/gpu//drm/armada/armada_overlay.c: In function 'armada_ovl_plane_work':
>> include/linux/compiler.h:577:38: error: call to '__compiletime_assert_85' declared with attribute error: pointer type mismatch in container_of()
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:557:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:577:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:47:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
>> drivers/gpu//drm/armada/armada_overlay.c:85:36: note: in expansion of macro 'container_of'
     struct armada_ovl_plane *dplane = container_of(work->plane, struct armada_ovl_plane, base);
                                       ^~~~~~~~~~~~
--
   In file included from include/uapi/linux/stddef.h:2:0,
                    from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/list.h:5,
                    from include/linux/agp_backend.h:33,
                    from include/drm/drmP.h:35,
                    from drivers/gpu/drm/armada/armada_overlay.c:9:
   drivers/gpu/drm/armada/armada_overlay.c: In function 'armada_ovl_plane_work':
>> include/linux/compiler.h:577:38: error: call to '__compiletime_assert_85' declared with attribute error: pointer type mismatch in container_of()
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:557:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:577:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:47:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/armada/armada_overlay.c:85:36: note: in expansion of macro 'container_of'
     struct armada_ovl_plane *dplane = container_of(work->plane, struct armada_ovl_plane, base);
                                       ^~~~~~~~~~~~

vim +/__compiletime_assert_85 +577 include/linux/compiler.h

9a8ab1c3 Daniel Santos 2013-02-21  563  
9a8ab1c3 Daniel Santos 2013-02-21  564  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c3 Daniel Santos 2013-02-21  565  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c3 Daniel Santos 2013-02-21  566  
9a8ab1c3 Daniel Santos 2013-02-21  567  /**
9a8ab1c3 Daniel Santos 2013-02-21  568   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  569   * @condition: a compile-time constant condition to check
9a8ab1c3 Daniel Santos 2013-02-21  570   * @msg:       a message to emit if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  571   *
9a8ab1c3 Daniel Santos 2013-02-21  572   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos 2013-02-21  573   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos 2013-02-21  574   * compiler has support to do so.
9a8ab1c3 Daniel Santos 2013-02-21  575   */
9a8ab1c3 Daniel Santos 2013-02-21  576  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos 2013-02-21 @577  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos 2013-02-21  578  

:::::: The code at line 577 was first introduced by commit
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
Size: 63995 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171117/0413a0c1/attachment-0001.gz>
