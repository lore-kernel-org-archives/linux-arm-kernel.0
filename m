From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Fri, 24 Mar 2017 11:41:26 +0300
Subject: [PATCH v7 5/7] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <201703241631.5BKa33uG%fengguang.wu@intel.com>
References: <201703241631.5BKa33uG%fengguang.wu@intel.com>
Message-ID: <B771814D-541A-4D89-AC8A-5FFF84DE2E66@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series should be applied after the patches [1] and [2] haven?t merged yet into the kernel.
That mention in the cover letter.

[1] https://lkml.org/lkml/2017/3/22/420
[2] https://lkml.org/lkml/2017/3/22/426

> 24 ????? 2017 ?., ? 11:29, kbuild test robot <lkp@intel.com> ???????(?):
> 
> Hi Alexander,
> 
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on v4.11-rc3 next-20170323]
> [cannot apply to rockchip/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Alexander-Kochetkov/Implement-clocksource-for-rockchip-SoC-using-rockchip-timer/20170324-113008
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # save the attached .config to linux build tree
>        make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>   In file included from include/linux/tick.h:7:0,
>                    from drivers//acpi/processor_idle.c:32:
>>> include/linux/clockchips.h:232:2: error: invalid preprocessing directive #els
>    #els
>     ^~~
>>> include/linux/clockchips.h:233:19: error: static declaration of 'clockevent_probe' follows non-static declaration
>    static inline int clockevent_probe(void) { return 0; }
>                      ^~~~~~~~~~~~~~~~
>   include/linux/clockchips.h:231:12: note: previous declaration of 'clockevent_probe' was here
>    extern int clockevent_probe(void);
>               ^~~~~~~~~~~~~~~~
> --
>>> drivers//clocksource/clkevt-probe.c:20:29: fatal error: linux/clockchip.h: No such file or directory
>    #include <linux/clockchip.h>
>                                ^
>   compilation terminated.
> 
> vim +232 include/linux/clockchips.h
> 
> d316c57f Thomas Gleixner 2007-02-16  226  
> 376bc271 Daniel Lezcano  2016-04-19  227  #define CLOCKEVENT_OF_DECLARE(name, compat, fn) \
> 376bc271 Daniel Lezcano  2016-04-19  228  	OF_DECLARE_1_RET(clkevt, name, compat, fn)
> 376bc271 Daniel Lezcano  2016-04-19  229  
> 376bc271 Daniel Lezcano  2016-04-19  230  #ifdef CONFIG_CLKEVT_PROBE
> 376bc271 Daniel Lezcano  2016-04-19  231  extern int clockevent_probe(void);
> 376bc271 Daniel Lezcano  2016-04-19 @232  #els
> 376bc271 Daniel Lezcano  2016-04-19 @233  static inline int clockevent_probe(void) { return 0; }
> 376bc271 Daniel Lezcano  2016-04-19  234  #endif
> 376bc271 Daniel Lezcano  2016-04-19  235  
> 9eed56e8 Ingo Molnar     2015-04-02  236  #endif /* _LINUX_CLOCKCHIPS_H */
> 
> :::::: The code at line 232 was first introduced by commit
> :::::: 376bc27150f180d9f5eddec6a14117780177589d clockevents: Add a clkevt-of mechanism like clksrc-of
> 
> :::::: TO: Daniel Lezcano <daniel.lezcano@linaro.org>
> :::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> <.config.gz>
