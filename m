From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Jun 2017 12:33:55 +0800
Subject: [PATCH 1/2] clocksource/drivers: Add timer-of common init routine
In-Reply-To: <1496753054-7489-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201706081223.ubF3tvNS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[auto build test WARNING on next-20170605]
[cannot apply to tip/timers/core clk/clk-next linus/master v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.12-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Lezcano/clocksource-drivers-Add-timer-of-common-init-routine/20170607-024801
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:260:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/clocksource/timer-of.c:33:24: sparse: incompatible types in conditional expression (different types)

vim +33 drivers/clocksource/timer-of.c

    17	 */
    18	#include <linux/clk.h>
    19	#include <linux/interrupt.h>
    20	#include <linux/of.h>
    21	#include <linux/of_address.h>
    22	#include <linux/of_irq.h>
    23	#include <linux/slab.h>
    24	
    25	#include "timer-of.h"
    26	
    27	static __init void timer_irq_exit(struct of_timer_irq *of_irq)
    28	{
    29		struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
    30	
    31		struct clock_event_device *clkevt = &to->clkevt;
    32	
  > 33		of_irq->percpu ? free_percpu_irq(of_irq->irq, clkevt) :
    34			free_irq(of_irq->irq, clkevt);
    35	}
    36	
    37	static __init int timer_irq_init(struct device_node *np,
    38					 struct of_timer_irq *of_irq)
    39	{
    40		int ret;
    41		struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
