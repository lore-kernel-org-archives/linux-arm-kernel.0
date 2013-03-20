From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Mar 2013 09:51:33 -0600
Subject: [PATCH V2 2/3] ARM: tegra: get PMC clock source from DT
In-Reply-To: <1363773608.5697.8.camel@jlo-ubuntu-64.nvidia.com>
References: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
 <1363594199-10974-3-git-send-email-josephl@nvidia.com>
 <51489513.1020107@wwwdotorg.org>
 <1363773608.5697.8.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <5149DB05.5000906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 04:00 AM, Joseph Lo wrote:
> On Wed, 2013-03-20 at 00:40 +0800, Stephen Warren wrote:
>> On 03/18/2013 02:09 AM, Joseph Lo wrote:
>>> The clock source of PMC should be PCLK and gotten from DT.
>>>
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>> ---
>>> V2:
>>> * new in this change
>>
>> s/change/series/ ???
>>
>>> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
>>
>>>  void __init tegra_dt_init_irq(void)
>>>  {
>>>  	tegra_clocks_init();
>>> +	tegra_pmc_init();
>>>  	tegra_init_irq();
>>>  	irqchip_init();
>>>  }
>>> @@ -100,7 +101,6 @@ void __init tegra_init_early(void)
>>>  	tegra_apb_io_init();
>>>  	tegra_init_fuse();
>>>  	tegra_init_cache();
>>> -	tegra_pmc_init();
>>
>> This change isn't mentioned in the commit description.
>>
>> Why is this change needed? We should minimize the amount of code in
>> tegra_dt_init_irq(), not add more code there.
>
> The clocks only available after tegra_clocks_init(). If I can keep the
> PMC dt node somewhere in PMC driver, then I can get the clock later.

Oh right. For some reason I thought that init_irq was executed before
init_early.

I guess this is OK for now, but I wonder if we shouldn't create a
tegra_init_machine() that tegra.c:tegra_dt_init() can call before
creating all the devices, and have that call both tegra_clocks_init()
and tegra_pmc_init(). But, we can leave that until a later cleanup patch
once we've thought it through a bit more.

>>> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
>>
>>> @@ -151,6 +153,8 @@ static void tegra_pmc_parse_dt(void)
>>>  
>>>  	tegra_pmc_invert_interrupt = of_property_read_bool(np,
>>>  				     "nvidia,invert-interrupt");
>>> +	tegra_pclk = of_clk_get(np, 0);
>>> +	WARN_ON_ONCE(IS_ERR(tegra_pclk));
>>
>> Why WARN_ON_ONCE(); is tegra_pmc_parse_dt() called more than once?
>>
>> Can the code continue if IS_ERR(tegra_pclk), or is that fatal?
> 
> The code is still OK just want to warn people that the PMC DT node
> needs PCLK clock info.

So perhaps s/WARN_ON_ONCE/WARN_ON/? No need to explicitly use a macro
that only emits the warning once if the code path is only executed once.
