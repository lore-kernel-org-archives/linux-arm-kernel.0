From: lkp@intel.com (kbuild test robot)
Date: Sat, 16 Sep 2017 02:27:21 +0800
Subject: [PATCH 1/2] clocksource: stm32: rework driver to use only one
 timer
In-Reply-To: <1505375812-19037-2-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <201709160224.qv6Npq2c%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

[auto build test WARNING on tip/timers/core]
[also build test WARNING on next-20170915]
[cannot apply to robh/for-next v4.13]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Gaignard/stm32-clocksource-driver-rework/20170915-220617
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-stm32.c: In function 'stm32_timer_init':
>> drivers/clocksource/timer-stm32.c:180:11: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     int irq, err;
              ^~~

vim +/err +180 drivers/clocksource/timer-stm32.c

   173	
   174	static int __init stm32_timer_init(struct device_node *node)
   175	{
   176		struct reset_control *rstc;
   177		void __iomem *timer_base;
   178		unsigned long max_arr;
   179		struct clk *clk;
 > 180		int irq, err;
   181	
   182		timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
   183		if (IS_ERR(timer_base)) {
   184			pr_err("Can't map registers\n");
   185			goto out;
   186		}
   187	
   188		irq = irq_of_parse_and_map(node, 0);
   189		if (irq <= 0) {
   190			pr_err("Can't parse IRQ\n");
   191			goto out_unmap;
   192		}
   193	
   194		clk = of_clk_get(node, 0);
   195		if (IS_ERR(clk)) {
   196			pr_err("Can't get timer clock\n");
   197			goto out_unmap;
   198		}
   199	
   200		rstc = of_reset_control_get(node, NULL);
   201		if (!IS_ERR(rstc)) {
   202			reset_control_assert(rstc);
   203			reset_control_deassert(rstc);
   204		}
   205	
   206		err = clk_prepare_enable(clk);
   207		if (err) {
   208			pr_err("Couldn't enable parent clock\n");
   209			goto out_clk;
   210		}
   211	
   212		/* Detect whether the timer is 16 or 32 bits */
   213		writel_relaxed(~0U, timer_base + TIM_ARR);
   214		max_arr = readl_relaxed(timer_base + TIM_ARR);
   215		if (max_arr != ~0U) {
   216			err = -EINVAL;
   217			pr_err("32 bits timer is needed\n");
   218			goto out_unprepare;
   219		}
   220	
   221		err = stm32_clocksource_init(node, timer_base, clk);
   222		if (err)
   223			goto out_unprepare;
   224	
   225		err = stm32_clockevent_init(node, timer_base, clk, irq);
   226		if (err)
   227			goto out_unprepare;
   228	
   229		return 0;
   230	
   231	out_unprepare:
   232		clk_disable_unprepare(clk);
   233	out_clk:
   234		clk_put(clk);
   235	out_unmap:
   236		iounmap(timer_base);
   237	out:
   238		return err;
   239	}
   240	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62854 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170916/fb7d9a6c/attachment-0001.gz>
