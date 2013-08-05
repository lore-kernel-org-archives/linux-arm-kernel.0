From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Aug 2013 11:39:47 -0600
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <51FFDA20.6050403@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
 <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
 <51FC1751.9010401@wwwdotorg.org>
 <1375689749.1731.36.camel@jlo-ubuntu-64.nvidia.com>
 <51FFDA20.6050403@wwwdotorg.org>
Message-ID: <51FFE363.4080603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 11:00 AM, Stephen Warren wrote:
> On 08/05/2013 02:02 AM, Joseph Lo wrote:
>> On Sat, 2013-08-03 at 04:32 +0800, Stephen Warren wrote:
>>> On 08/02/2013 02:09 AM, Joseph Lo wrote:
>>>> On Tue, 2013-07-30 at 06:51 +0800, Stephen Warren wrote:
>>>>> On 07/26/2013 03:15 AM, Joseph Lo wrote:
>>>>>> When the system suspends to LP1, the clock of the CPU would be switched to
>>>>>> CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
>>>>>> needs to restore the clock of CPU after LP1 resume.
>>>>>
>>>>> It's unclear to me how the code change implements "restore the clock of
>>>>> the CPU". A register name of CCLKG_BURST_POLICY doesn't sound like it's
>>>>> anything to do with enabled/disabling the CPU clock, nor configuring its
>>>>> rate. What exactly does this register do, and hence what does this new
>>>>> code actually restore?
>>>>>
>>>> When system suspend to LP1, most of the PLLs was clock gated. Because we
>>>> didn't cut off the core power, the settings of PLL still keep there. But
>>>> we switch the clock source of CPU to CLK_M before shut off PLLs by
>>>> CCLKG_BURSY_POLICY register. So we need to resume it back to original
>>>> clock source by CCLKG_BURST_POLICY register. Or it would be keep in low
>>>> rate (CLK_M) after resume.
>>>
>>> OK, I guess the register name was badly chosen by HW. I'd like to see
>>> part of your description above in the patch description. How about
>>> replacing the patch description with:
>>>
>>> ----------
>>> When the system suspends to LP1, the CPU clock source is switched to
>>> CLK_M (12MHz Oscillator) during suspend/resume flow[1]. The CPU clock
>>> source is controlled by the CCLKG_BURST_POLICY register, and hence this
>>> register must be restored during LP1 resume.
>>> ----------
>>>
>>> [1] Question: where does this happen? This patch doesn't make that
>>> change. I wonder why the suspend path can't save this register, rather
>>> than implementing a separate suspend syscore op in the clock driver.
>>> Does the HW auto-switch the value in the register itself?
>>
>> If we switch CPU to CLK_M in clock driver, the system will become slowly
>> during the middle of suspending flow. We do this at the very end of the
>> LP1 suspending flow before the CPU disable all the PLL clocks.
> 
> I think you answered "why is the switch to CLK_M performed very late",
> whereas I asked "where is the code that performs the switch to CLK_M".

To expand on this a bit more, I can't find any reference to register
CCLKG_BURST_POLICY in arch/arm/mach-tegra/ or drivers/clk/tegra/ except
for the definition of clock cclk_g, nor any reference to that clock in
those two directories. And that CCLKG_BURST_POLICY register is what this
patch saves/restores.

I do see function tegra30_switch_cpu_to_clk32k in patch 5/8 appears to
do something related to switching to clk_m and touches some other
burst-related registers, but not CCLKG_BURST_POLICY...

So, if this syscore_op is attempting to undo some change that happens to
CCLKG_BURST_POLICY during suspend, I still can't see what change is
happening to that register during suspemd, nor which piece of code
causes it.

If the issue is that the value in this register is simply lost during
LP1 because the power is turned off, then I wonder what sets up this
register during the original boot path?
