From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Aug 2013 12:37:12 -0600
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <1375780249.2261.63.camel@jlo-ubuntu-64.nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
 <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
 <51FC1751.9010401@wwwdotorg.org>
 <1375689749.1731.36.camel@jlo-ubuntu-64.nvidia.com>
 <51FFDA20.6050403@wwwdotorg.org> <51FFE363.4080603@wwwdotorg.org>
 <1375780249.2261.63.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <52014258.9070602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2013 03:10 AM, Joseph Lo wrote:
> On Tue, 2013-08-06 at 01:39 +0800, Stephen Warren wrote:
>> On 08/05/2013 11:00 AM, Stephen Warren wrote:
>>> On 08/05/2013 02:02 AM, Joseph Lo wrote:
>>>> On Sat, 2013-08-03 at 04:32 +0800, Stephen Warren wrote:
>>>>> On 08/02/2013 02:09 AM, Joseph Lo wrote:
>>>>>> On Tue, 2013-07-30 at 06:51 +0800, Stephen Warren wrote:
>>>>>>> On 07/26/2013 03:15 AM, Joseph Lo wrote:
>>>>>>>> When the system suspends to LP1, the clock of the CPU would be switched to
>>>>>>>> CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
>>>>>>>> needs to restore the clock of CPU after LP1 resume.
>>>>>>>
>>>>>>> It's unclear to me how the code change implements "restore the clock of
>>>>>>> the CPU". A register name of CCLKG_BURST_POLICY doesn't sound like it's
>>>>>>> anything to do with enabled/disabling the CPU clock, nor configuring its
>>>>>>> rate. What exactly does this register do, and hence what does this new
>>>>>>> code actually restore?
>>>>>>>
>>>>>> When system suspend to LP1, most of the PLLs was clock gated. Because we
>>>>>> didn't cut off the core power, the settings of PLL still keep there. But
>>>>>> we switch the clock source of CPU to CLK_M before shut off PLLs by
>>>>>> CCLKG_BURSY_POLICY register. So we need to resume it back to original
>>>>>> clock source by CCLKG_BURST_POLICY register. Or it would be keep in low
>>>>>> rate (CLK_M) after resume.
>>>>>
>>>>> OK, I guess the register name was badly chosen by HW. I'd like to see
>>>>> part of your description above in the patch description. How about
>>>>> replacing the patch description with:
>>>>>
>>>>> ----------
>>>>> When the system suspends to LP1, the CPU clock source is switched to
>>>>> CLK_M (12MHz Oscillator) during suspend/resume flow[1]. The CPU clock
>>>>> source is controlled by the CCLKG_BURST_POLICY register, and hence this
>>>>> register must be restored during LP1 resume.
>>>>> ----------
>>>>>
>>>>> [1] Question: where does this happen? This patch doesn't make that
>>>>> change. I wonder why the suspend path can't save this register, rather
>>>>> than implementing a separate suspend syscore op in the clock driver.
>>>>> Does the HW auto-switch the value in the register itself?
>>>>
>>>> If we switch CPU to CLK_M in clock driver, the system will become slowly
>>>> during the middle of suspending flow. We do this at the very end of the
>>>> LP1 suspending flow before the CPU disable all the PLL clocks.
>>>
>>> I think you answered "why is the switch to CLK_M performed very late",
>>> whereas I asked "where is the code that performs the switch to CLK_M".
> You can find to code in the function tegraXX_switch_cpu_to_clk32k of the
> patch 5/8 and 6/8. It switches the SCLK and CCLK to CLKM before
> disabling the PLLs.
>>
>> To expand on this a bit more, I can't find any reference to register
>> CCLKG_BURST_POLICY in arch/arm/mach-tegra/ or drivers/clk/tegra/ except
>> for the definition of clock cclk_g, nor any reference to that clock in
>> those two directories. And that CCLKG_BURST_POLICY register is what this
>> patch saves/restores.
>>
>> I do see function tegra30_switch_cpu_to_clk32k in patch 5/8 appears to
>> do something related to switching to clk_m and touches some other
>> burst-related registers, but not CCLKG_BURST_POLICY...
>>
> OK. It's a little difference we do in clock driver side and low level
> code side.
> 
> As you knew, we have two CPU clusters (CCLKG & CCLKLP) in Tegra chips.
> And they have exactly the same clock source for Tegra20/30, but
> Tegra114. From the low level side, it should be supported when the
> system going to suspend with CPU_G or CPU_LP. So we switched the clock
> source of CPU to CLK_M by CCLK_BURST_POLICY. This register can support
> the running CPU switch to the clock source they want.
> 
> On the clock driver side, because the clock source of CCLKG and CCLKLP
> is not exactly the same for the Tegra114. The CCLKG supports DFLL clock
> but CCLKLP. We need to restore it separately to avoid the CPU restore to
> the wrong clock source.
> 
> The CPU clock suspend/resume function in the tegra_cpu_car_ops of
> Tegra20/30 is also using CCLK_BURST_POLICY register, because the
> definition of the clock source of CCLKG and CCLKLP is the same. We can
> simply the code for just using CCLK_BURST_POLICY.
> 
> I think the code should OK when CPU_G or CPU_LP running with it.

OK, so just to paraphrase what you've said, to make sure I understand it:

On Tegra114, there are 3 registers:

1) Controls just the clock source of the G cluster.
2) Controls just the clock source of the LP cluster.
3) Controls both at the same time, simulating a write to both (1) and (2)

In tegra30_switch_cpu_to_clk32k(), we use register (3) above to switch
to clk_m then clk_s. This is possible, because in both registers (1) and
(2), the values for clk_m and clk_s are identical.

In tegra30_lp1_reset(), we can't use the same technique (a write to
register 3) to restore the clock source for both G and LP clusters,
since the values we need to write to those registers to re-select their
clock source is different.

however, on Tegra30, there really is only one register, so we can use
that to both switch to clk_m/clk_s, /and/ to switch back.

That all explains the following part of patch 7/8, which disables the
clock register restore path except on Tegra30 where it will work:

> -	mov32	r4, ((1 << 28) | (0x8))	@ burst policy is PLLX
> -	str	r4, [r0, #CLK_RESET_CCLK_BURST]
> +	cmp	r10, #TEGRA30
> +	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
> +	movteq	r4, #:upper16:((1 << 28) | (0x8))
> +	streq	r4, [r0, #CLK_RESET_CCLK_BURST]

However, none of this explains why the CPU clock restore logic on
Tegra114 needs to be a syscore_op, rather than simply having
tegra30_lp1_reset() execute some Tegra114-specific code.

Re-writing the part of the patch I quoted above in C, it looks like:

if (soc is tegra30)
    write to CLK_RESET_CCLK_BURST to select pllx

Instead of making that code do nothing on Tegra114, why can't that code be:

if (soc is tegra30)
    write to CLK_RESET_CCLK_BURST to re-select pllx
else
    write to G-cluster-specific register to restore saved value
    write to LP-cluster-specific register to restore saved value

or:

if (soc is tegra30)
    write to CLK_RESET_CCLK_BURST to re-select pllx
else
    write to G-cluster-specific register to re-select pllx/dfll/...
    write to LP-cluster-specific register to restore ...

Plenty of other registers are saved/restored by tegra30_lp1_reset(), so
surely you just need to have save two more registers in the suspend
path, and restore them as I showed above.

That way, we don't have to have some special-case syscore_op to do this;
all chips will restore the clock sources at the exact same place in the
code, and everything will be consistent.
