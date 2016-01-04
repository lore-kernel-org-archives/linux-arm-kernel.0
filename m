From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 4 Jan 2016 10:05:57 +0000
Subject: [PATCH 4.4-rc5 v22 4/4] ARM: Allow IPI_CPU_BACKTRACE to exploit
 FIQ
In-Reply-To: <201512210611.VZD43TTL%fengguang.wu@intel.com>
References: <201512210611.VZD43TTL%fengguang.wu@intel.com>
Message-ID: <568A4405.50807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/15 22:52, kbuild test robot wrote:
> Hi Daniel,
>
> [auto build test ERROR on v4.4-rc5]
> [also build test ERROR on next-20151218]
> [cannot apply to tip/irq/core]
>
> url:    https://github.com/0day-ci/linux/commits/Daniel-Thompson/irq-arm-Use-FIQ-for-NMI-backtrace-when-possible/20151221-045854
> config: arm-socfpga_defconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All error/warnings (new ones prefixed by >>):
>
>     In file included from include/uapi/linux/stddef.h:1:0,
>                      from include/linux/stddef.h:4,
>                      from include/uapi/linux/posix_types.h:4,
>                      from include/uapi/linux/types.h:13,
>                      from include/linux/types.h:5,
>                      from include/linux/list.h:4,
>                      from include/linux/module.h:9,
>                      from arch/arm/kernel/smp.c:10:
>     arch/arm/kernel/smp.c: In function 'raise_nmi':
>>> include/linux/compiler.h:484:38: error: call to '__compiletime_assert_766' declared with attribute error: BUILD_BUG_ON failed: SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE)
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:467:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^
>     include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^
>     include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^
>     include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>       ^
>>> arch/arm/kernel/smp.c:766:2: note: in expansion of macro 'BUILD_BUG_ON'
>       BUILD_BUG_ON(SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE));

This should be a false alarm or at least, the BUILD_BUG_ON() is doing 
exactly what it was intended to.

I forgot to mention it in the covering letter (and will fix next time) 
but my patchset requires a fix from Marc Zyngier which changes the 
numeric value of IPI_CPU_BACKTRACE[1].


Daniel.

1: http://thread.gmane.org/gmane.linux.ports.arm.kernel/464985
