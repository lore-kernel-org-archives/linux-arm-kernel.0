From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 02 Aug 2013 14:40:06 -0600
Subject: [PATCH 4/8] ARM: tegra: add common LP1 suspend support
In-Reply-To: <1375435620.6761.120.camel@jlo-ubuntu-64.nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-5-git-send-email-josephl@nvidia.com>
 <51F6F725.6000106@wwwdotorg.org>
 <1375435620.6761.120.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51FC1926.9030103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 03:27 AM, Joseph Lo wrote:
> On Tue, 2013-07-30 at 07:13 +0800, Stephen Warren wrote:
>> On 07/26/2013 03:15 AM, Joseph Lo wrote:
>>> The LP1 suspending mode on Tegra means CPU rail off, devices and PLLs are
>>> clock gated and SDRAM in self-refresh mode. That means the low level LP1
>>> suspending and resuming code couldn't be run on DRAM and the CPU must
>>> switch to the always on clock domain (a.k.a. CLK_M 12MHz oscillator). And
>>> the system clock (SCLK) would be switched to CLK_S, a 32KHz oscillator.
>>> The LP1 low level handling code need to be moved to IRAM area first. And
>>> marking the LP1 mask for indicating the Tegra device is in LP1. The CPU
>>> power timer needs to be re-calculated based on 32KHz that was originally
>>> based on PCLK.
>>
>>> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
>>
>>>  #ifdef CONFIG_PM_SLEEP
>>>  static DEFINE_SPINLOCK(tegra_lp2_lock);
>>> +static void __iomem *iram_code = IO_ADDRESS(TEGRA_IRAM_CODE_AREA);
>>> +static u32 iram_save_size;
>>> +static void *iram_save_addr;
>>> +struct tegra_lp1_iram *tegra_lp1_iram;
>>>  void (*tegra_tear_down_cpu)(void);
>>> +void (*tegra_sleep_core_finish)(unsigned long v2p);
>>
>> I'm not sure all of those are required to be global variables. For
>> example, iram_code is just a constant, so you could easily just use it
>> directly in code.
>
> All of them does not mean the same thing. The LP1 resume code was built
> in kernel image and store in RAM.
> The tegra_lp1_iram hooks the LP1 resume code for different chips. Before
> LP1 suspend, the original stuffs that in the area of IRAM would be store
> in the iram_save_addr (RAM). Then copy the LP1 resume code to iram_code
> area (IRAM).

Sure, some of those variable may differ based on the SoC at runtime etc.

But at least the value of iram_code never changes, right?

>>> +static bool tegra_sleep_core_init(void)
>>> +{
>>> +	if (!tegra_sleep_core_finish)
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>
>> That function seems a little pointless. Why not just check the value of
>> tegra_sleep_core_finish directly in tegra_init_suspend()?
>
> I will add some code that wraps to different SoC later. We add some
> common code for LP1 support here, but it didn't support by the chip yet.
> Does that OK or should I move it to the next patch?

OK, I see this is enhanced immediately in the next patch, so it's fine.

>>> +static void tegra_suspend_enter_lp1(void)
>>> +{
>>> +	tegra_pmc_suspend();
>>> +
>>> +	/* copy the reset vector & SDRAM shutdown code into IRAM */
>>> +	memcpy(iram_save_addr, iram_code, iram_save_size);
>>> +	memcpy(iram_code, tegra_lp1_iram->start_addr, iram_save_size);
>>> +
>>> +	*((u32 *)tegra_cpu_lp1_mask) = 1;
>>> +}
>>> +
>>> +static void tegra_suspend_exit_lp1(void)
>>> +{
>>> +	tegra_pmc_resume();
>>> +
>>> +	/* restore IRAM */
>>> +	memcpy(iram_code, iram_save_addr, iram_save_size);
>>> +
>>> +	*(u32 *)tegra_cpu_lp1_mask = 0;
>>> +}
>>
>> I'm not really sure I like that, but I suppose it's OK. It sure seems
>> like a performance limiter, but I suppose LP1 is so slow it doesn't
>> matter, due to the need to ramp power rails, PLLs, SDRAM controller, etc.
>
> That's why we only back up the code size that exactly same with the LP1
> resume code of the SoC.
>
>> It'd be nice to simply reserve more IRAM for the kernel's use. Right
>> now, only 1K is reserved, and presumably the code running on the AVP
>> can't use the rest of that page anyway, or can it?
>
> The LP1 resume code still running on the CPU (The LP0 would resume from
> AVP).

Sure. However, if the AVP never touched the IRAM region where the LP1
resume code is placed, we would only need to copy the LP1 resume code to
IRAM once at kernel boot time, rather than every time we enter/leave LP1.

I guess the idea is that once we have an AVP driver, we will force the
AVP to suspend first, save the IRAM that it might have been using, do
the system suspend/resume, then restore the IRAM. And that changing that
sequence so that the AVP never ever touched the LP1 IRAM area would
require AVP firmware changes that we can't make?
