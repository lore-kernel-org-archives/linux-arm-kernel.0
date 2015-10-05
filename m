From: s-anna@ti.com (Suman Anna)
Date: Mon, 5 Oct 2015 13:33:12 -0500
Subject: [PATCH 1/4] ARM: OMAP: dmtimer: check for fixed timers during
 config
In-Reply-To: <20151005165806.GE23801@atomide.com>
References: <201510040126.SfMisWv2%fengguang.wu@intel.com>
 <5612A88E.1040809@ti.com> <20151005165806.GE23801@atomide.com>
Message-ID: <5612C268.7000502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2015 11:58 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [151005 09:47]:
>> Tony,
>>
>> On 10/03/2015 12:29 PM, kbuild test robot wrote:
>>> Hi Suman,
>>>
>>> [auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]
>>>
>>> config: arm-omap1_defconfig (attached as .config)
>>> reproduce:
>>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         make.cross ARCH=arm 
>>>
>>> All error/warnings (new ones prefixed by >>):
>>>
>>>    arch/arm/plat-omap/dmtimer.c: In function 'omap_dm_timer_set_source':
>>>>> arch/arm/plat-omap/dmtimer.c:509:2: error: implicit declaration of function 'clk_hw_get_num_parents' [-Werror=implicit-function-declaration]
>>>      if (!clk_hw_get_num_parents(__clk_get_hw(timer->fclk)))
>>>      ^
>>>>> arch/arm/plat-omap/dmtimer.c:509:2: error: implicit declaration of function '__clk_get_hw' [-Werror=implicit-function-declaration]
>>>    cc1: some warnings being treated as errors
>>>
>>> vim +/clk_hw_get_num_parents +509 arch/arm/plat-omap/dmtimer.c
>>>
>>>    503			return pdata->set_timer_src(timer->pdev, source);
>>>    504	
>>>    505		if (IS_ERR(timer->fclk))
>>>    506			return -EINVAL;
>>>    507	
>>>    508		/* Check if the clock has parents if not no point checking */
>>>  > 509		if (!clk_hw_get_num_parents(__clk_get_hw(timer->fclk)))
>>>    510			return 0;
>>
>> CONFIG_COMMON_CLK is not defined for OMAP1. So, are you ok if I enclose
>> this within #ifdef CONFIG_COMMON_CLK?
> 
> Yes, or maybe you can just clk_get_rate() on the 32k oscillator?
> 
> Boards with no 32k oscillator should set the rate for that 0 zero.

Well, this API is about setting the timer clk's mux source, and not
really dealing with the clk rate or just setting it to the 32k
oscillator. A 32k is usually one of the mux parents (if the timer has
them). If there is a way to find if the clk is a mux clock, then that
check would be ideal. But since no such thing exists, so I will go ahead
and fix this by adding the #ifdef check.

regards
Suman
