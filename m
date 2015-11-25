From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 25 Nov 2015 20:12:29 +0300
Subject: [question] kernel build fails with O0 gcc optimization flag
Message-ID: <20151125171229.GA8415@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all.

I changed optimization from O2 to O0 in Makefile:
        609 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
        610 KBUILD_CFLAGS   += -Os $(call cc-disable-warning,maybe-uninitialized,)
        611 else
        612 KBUILD_CFLAGS   += -O2 <-- here
        613 endif

And broke the build. O1 looks fine.

I tried Ubuntu and Cavium GCC:
        gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu1) 
        gcc version 5.2.0 (Cavium Development Version) 

Kernel is v4.3, defconfig, ARCH=arm64.

What am I doing wrong?

BR,
Yury.

[...]
  CC      arch/arm64/kernel/debug-monitors.o
In file included from include/linux/ioport.h:12:0,
                 from include/linux/device.h:16,
                 from include/linux/node.h:17,
                 from include/linux/cpu.h:16,
                 from arch/arm64/kernel/debug-monitors.c:21:
In function ?__percpu_add?,
    inlined from ?enable_debug_monitors? at arch/arm64/kernel/debug-monitors.c:91:6:
include/linux/compiler.h:492:38: error: call to ?__compiletime_assert_97? declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:475:4: note: in definition of macro ?__compiletime_assert? prefix ## suffix();    \
    ^
include/linux/compiler.h:492:2: note: in expansion of macro ?_compiletime_assert?
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
include/linux/bug.h:50:37: note: in expansion of macro ?compiletime_assert?
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
include/linux/bug.h:84:21: note: in expansion of macro ?BUILD_BUG_ON_MSG?
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^
./arch/arm64/include/asm/percpu.h:91:3: note: in expansion of macro ?BUILD_BUG?
   BUILD_BUG();      \
   ^
./arch/arm64/include/asm/percpu.h:97:1: note: in expansion of macro ?PERCPU_OP?
 PERCPU_OP(add, add)
 ^
In function ?__percpu_add?,
    inlined from ?enable_debug_monitors? at arch/arm64/kernel/debug-monitors.c:95:6:
include/linux/compiler.h:492:38: error: call to ?__compiletime_assert_97? declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:475:4: note: in definition of macro ?__compiletime_assert?
    prefix ## suffix();    \
    ^
include/linux/compiler.h:492:2: note: in expansion of macro ?_compiletime_assert?
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
include/linux/bug.h:50:37: note: in expansion of macro ?compiletime_assert?
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
include/linux/bug.h:84:21: note: in expansion of macro ?BUILD_BUG_ON_MSG?
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^
./arch/arm64/include/asm/percpu.h:91:3: note: in expansion of macro ?BUILD_BUG?
   BUILD_BUG();      \
   ^
./arch/arm64/include/asm/percpu.h:97:1: note: in expansion of macro ?PERCPU_OP?
 PERCPU_OP(add, add)
 ^
In function ?__percpu_add?,
    inlined from ?disable_debug_monitors? at arch/arm64/kernel/debug-monitors.c:111:6:
include/linux/compiler.h:492:38: error: call to ?__compiletime_assert_97? declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:475:4: note: in definition of macro ?__compiletime_assert?
    prefix ## suffix();    \
    ^
include/linux/compiler.h:492:2: note: in expansion of macro ?_compiletime_assert?
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
include/linux/bug.h:50:37: note: in expansion of macro ?compiletime_assert?
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
include/linux/bug.h:84:21: note: in expansion of macro ?BUILD_BUG_ON_MSG?
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^
./arch/arm64/include/asm/percpu.h:91:3: note: in expansion of macro ?BUILD_BUG?
   BUILD_BUG();      \
   ^
./arch/arm64/include/asm/percpu.h:97:1: note: in expansion of macro ?PERCPU_OP?
 PERCPU_OP(add, add)
 ^
In function ?__percpu_add?,
    inlined from ?disable_debug_monitors? at arch/arm64/kernel/debug-monitors.c:115:6:
include/linux/compiler.h:492:38: error: call to ?__compiletime_assert_97? declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:475:4: note: in definition of macro ?__compiletime_assert?
    prefix ## suffix();    \
    ^
include/linux/compiler.h:492:2: note: in expansion of macro ?_compiletime_assert?
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
include/linux/bug.h:50:37: note: in expansion of macro ?compiletime_assert?
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
include/linux/bug.h:84:21: note: in expansion of macro ?BUILD_BUG_ON_MSG?
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^
./arch/arm64/include/asm/percpu.h:91:3: note: in expansion of macro ?BUILD_BUG?
   BUILD_BUG();      \
   ^
./arch/arm64/include/asm/percpu.h:97:1: note: in expansion of macro ?PERCPU_OP?
 PERCPU_OP(add, add)
 ^
In function ?__list_add_rcu?,
    inlined from ?list_add_rcu? at include/linux/rculist.h:80:2,
    inlined from ?register_break_hook?@arch/arm64/kernel/debug-monitors.c:279:2:
include/linux/compiler.h:492:38: error: call to ?__compiletime_assert_54? declared with attribute error: Need native word sized stores/loads for atomicity.
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:475:4: note: in definition of macro ?__compiletime_assert?
    prefix ## suffix();    \
    ^
include/linux/compiler.h:492:2: note: in expansion of macro ?_compiletime_assert?
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
include/linux/compiler.h:495:2: note: in expansion of macro ?compiletime_assert?
  compiletime_assert(__native_word(t),    \
  ^
./arch/arm64/include/asm/barrier.h:44:2: note: in expansion of macro ?compiletime_assert_atomic_type?
  compiletime_assert_atomic_type(*p);    \
  ^
include/linux/rcupdate.h:677:34: note: in expansion of macro ?smp_store_release?
 #define rcu_assign_pointer(p, v) smp_store_release(&p, RCU_INITIALIZER(v))
                                  ^
include/linux/rculist.h:54:2: note: in expansion of macro ?rcu_assign_pointer?
  rcu_assign_pointer(list_next_rcu(prev), new);
  ^
scripts/Makefile.build:258: recipe for target 'arch/arm64/kernel/debug-monitors.o' failed
make[1]: *** [arch/arm64/kernel/debug-monitors.o] Error 1
Makefile:941: recipe for target 'arch/arm64/kernel' failed
make: *** [arch/arm64/kernel] Error 2
