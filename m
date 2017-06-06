From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Jun 2017 05:55:40 +0800
Subject: [PATCH 1/2] clocksource/drivers: Add timer-of common init routine
In-Reply-To: <1496753054-7489-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201706070526.P6vwTUt3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[auto build test ERROR on next-20170605]
[cannot apply to tip/timers/core clk/clk-next linus/master v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.12-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Lezcano/clocksource-drivers-Add-timer-of-common-init-routine/20170607-024801
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/clocksource/timer-of.c:25:0:
>> drivers/clocksource/timer-of.h:34:28: error: field 'clkevt' has incomplete type
     struct clock_event_device clkevt;
                               ^~~~~~
   In file included from include/linux/err.h:4:0,
                    from include/linux/clk.h:15,
                    from drivers/clocksource/timer-of.c:18:
   drivers/clocksource/timer-of.h: In function 'to_timer_of':
   include/linux/kernel.h:859:32: error: dereferencing pointer to incomplete type 'struct clock_event_device'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                   ^~~~~~
   include/linux/compiler.h:517:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:537:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:46:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:859:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:859:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> drivers/clocksource/timer-of.h:42:9: note: in expansion of macro 'container_of'
     return container_of(clkevt, struct timer_of, clkevt);
            ^~~~~~~~~~~~

vim +/clkevt +34 drivers/clocksource/timer-of.h

    28		unsigned long rate;
    29		unsigned long period;
    30	};
    31	
    32	struct timer_of {
    33		unsigned int flags;
  > 34		struct clock_event_device clkevt;
    35		struct of_timer_base of_base;
    36		struct of_timer_irq  of_irq;
    37		struct of_timer_clk  of_clk;
    38	};
    39	
    40	static inline struct timer_of *to_timer_of(struct clock_event_device *clkevt)
    41	{
  > 42		return container_of(clkevt, struct timer_of, clkevt);
    43	}
    44	
    45	static inline void __iomem *timer_of_base(struct timer_of *to)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47902 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/0c037873/attachment-0001.gz>
