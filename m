From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 10:46:52 -0600
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <1375866749.8111.57.camel@jlo-ubuntu-64.nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
 <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
 <51FC1751.9010401@wwwdotorg.org>
 <1375689749.1731.36.camel@jlo-ubuntu-64.nvidia.com>
 <51FFDA20.6050403@wwwdotorg.org> <51FFE363.4080603@wwwdotorg.org>
 <1375780249.2261.63.camel@jlo-ubuntu-64.nvidia.com>
 <52014258.9070602@wwwdotorg.org>
 <1375866749.8111.57.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <520279FC.1000006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 03:12 AM, Joseph Lo wrote:
> On Wed, 2013-08-07 at 02:37 +0800, Stephen Warren wrote:
>> On 08/06/2013 03:10 AM, Joseph Lo wrote:
>>> On Tue, 2013-08-06 at 01:39 +0800, Stephen Warren wrote:
>>>> On 08/05/2013 11:00 AM, Stephen Warren wrote:
>>>>> On 08/05/2013 02:02 AM, Joseph Lo wrote:
>>>>>> On Sat, 2013-08-03 at 04:32 +0800, Stephen Warren wrote:
>>>>>>> On 08/02/2013 02:09 AM, Joseph Lo wrote:
>>>>>>>> On Tue, 2013-07-30 at 06:51 +0800, Stephen Warren wrote:
>>>>>>>>> On 07/26/2013 03:15 AM, Joseph Lo wrote:
> [snip]
>>> OK. It's a little difference we do in clock driver side and low level
>>> code side.
>>>
>>> As you knew, we have two CPU clusters (CCLKG & CCLKLP) in Tegra chips.
>>> And they have exactly the same clock source for Tegra20/30, but
>>> Tegra114. From the low level side, it should be supported when the
>>> system going to suspend with CPU_G or CPU_LP. So we switched the clock
>>> source of CPU to CLK_M by CCLK_BURST_POLICY. This register can support
>>> the running CPU switch to the clock source they want.
>>>
>>> On the clock driver side, because the clock source of CCLKG and CCLKLP
>>> is not exactly the same for the Tegra114. The CCLKG supports DFLL clock
>>> but CCLKLP. We need to restore it separately to avoid the CPU restore to
>>> the wrong clock source.
>>>
>>> The CPU clock suspend/resume function in the tegra_cpu_car_ops of
>>> Tegra20/30 is also using CCLK_BURST_POLICY register, because the
>>> definition of the clock source of CCLKG and CCLKLP is the same. We can
>>> simply the code for just using CCLK_BURST_POLICY.
>>>
>>> I think the code should OK when CPU_G or CPU_LP running with it.
>>
>> OK, so just to paraphrase what you've said, to make sure I understand it:
>>
>> On Tegra114, there are 3 registers:
> It's on Tegra30 too.
>>
>> 1) Controls just the clock source of the G cluster.
> CCLKG_BURST_POLICY at offset 0x368.
>> 2) Controls just the clock source of the LP cluster.
> CCLKLP_BURST_POLICY at offset 0x370.
>> 3) Controls both at the same time, simulating a write to both (1) and (2)
> CCLK_BURST_POLICY at offset 0x20.
> Yes, exactly. And I double confirm the item 3 again with a downstream
> kernel that support cluster switch today. It's true.
>>
>> In tegra30_switch_cpu_to_clk32k(), we use register (3) above to switch
>> to clk_m then clk_s. This is possible, because in both registers (1) and
>> (2), the values for clk_m and clk_s are identical.
> Yes.
>>
>> In tegra30_lp1_reset(), we can't use the same technique (a write to
>> register 3) to restore the clock source for both G and LP clusters,
>> since the values we need to write to those registers to re-select their
>> clock source is different.
>>
>> however, on Tegra30, there really is only one register, so we can use
>> that to both switch to clk_m/clk_s, /and/ to switch back.
>>
>> That all explains the following part of patch 7/8, which disables the
>> clock register restore path except on Tegra30 where it will work:
>>
>>> -	mov32	r4, ((1 << 28) | (0x8))	@ burst policy is PLLX
>>> -	str	r4, [r0, #CLK_RESET_CCLK_BURST]
>>> +	cmp	r10, #TEGRA30
>>> +	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
>>> +	movteq	r4, #:upper16:((1 << 28) | (0x8))
>>> +	streq	r4, [r0, #CLK_RESET_CCLK_BURST]
>
> OK. The burst policy of CPU clock has 5 different states (STDBY, IDLE,
> RUN, IRQ and FIQ). The SW only can set up the clock source of each
> state. The switching to different state was controlled by HW.
> 
> So the Tegra30 code here was set up the clock source of IDLE state only
> (the CPU runs in this state after resume) to make the performance
> better. But It had no idea about the clock sources of the other states.
> It still needs clock driver to take care of that.
> 
> The clock source id (0x8) means PLLX_OUT0 in Tegra30. In Tegra114, it
> means PLLX_OUT0_LJ (low jitter). It's not available at this moment. I
> can switch it to PLLX_OUT0 (0xe) for Tegra114 too. The code may like
> below.
> 
>> -     mov32   r4, ((1 << 28) | (0x8)) @ burst policy is PLLX
>> -     str     r4, [r0, #CLK_RESET_CCLK_BURST]
>> +     cmp     r10, #TEGRA30
>> +     movweq  r4, #:lower16:((1 << 28) | (0x8))
>> +     movteq  r4, #:upper16:((1 << 28) | (0x8))
>> +	movwne  r4, #:lower16:((1 << 28) | (0xe))
>> +	movteq  r4, #:upper16:((1 << 28) | (0xe))

I assume that should be movtne.

>> +     str	r4, [r0, #CLK_RESET_CCLK_BURST]
> 
> I had tested this code before I sent this series. It didn't impact or
> improve the resuming performance. So I removed them.
> Do you want me to add them back?

I think adding that code back would make sense. It would mean the code
works fundamentally the same way for all SoCs.

BTW, you mentioned that LP1 resume takes 10-15 seconds on Dalmore. Are
you sure this isn't because the above code is missing, and hence the CPU
keeps running at 32KHz or the crystal speed, since nothing restores the
CPU clock source until much later, when the syscore op runs?

>> However, none of this explains why the CPU clock restore logic on
>> Tegra114 needs to be a syscore_op, rather than simply having
>> tegra30_lp1_reset() execute some Tegra114-specific code.
>>
>> Re-writing the part of the patch I quoted above in C, it looks like:
>>
>> if (soc is tegra30)
>>     write to CLK_RESET_CCLK_BURST to select pllx
>>
>> Instead of making that code do nothing on Tegra114, why can't that code be:
>>
>> if (soc is tegra30)
>>     write to CLK_RESET_CCLK_BURST to re-select pllx
>> else
>>     write to G-cluster-specific register to restore saved value
>>     write to LP-cluster-specific register to restore saved value
>>
>> or:
>>
>> if (soc is tegra30)
>>     write to CLK_RESET_CCLK_BURST to re-select pllx
>> else
>>     write to G-cluster-specific register to re-select pllx/dfll/...
>>     write to LP-cluster-specific register to restore ...
>>
> Hope the explanation above is enough for you. The low level code had no
> idea of clock source of each CPU state in BURST_POLICY register. It
> needs to be done by clk driver itself.

I still have absolutely no idea why Tegra30 and Tegra114 are different.

You mentioned something about this low-level code only manipulating the
IDLE state, and the clock driver needing to restore the other 4 states.
This raises yet more questions:

1) Do we not need to restore the other 4 states on Tegra30? If not, why
not? If we do, presumably Tegra30 (and Tegra20?) need to the syscore_op
this patch series adds to Tegra114 only? If we don't, then why does
Tegra114 have to restore them?

2) What triggers the HW to switch from IDLE to RUN state? In other
words, I think you're saying that the existing Tegra30 code:

	mov32	r4, ((1 << 28) | (0x8))	@ burst policy is PLLX
	str	r4, [r0, #CLK_RESET_CCLK_BURST]

doesn't change the clock rate right away. When does it change?

Related, when tegra30_switch_cpu_to_clk32k() sets the CPU clock source
for the IDLE state to clk_s, when does that switch actually take place?
That function appears to assume it happens immediately, since it
immediately disables the PLLs that might have been the previous CPU
clock source. Perhaps this is what the MSELECT register writes do?  I
guess not since there's only 1 MSELECT write in tegra_lp1_reset() and
two changes of CPU clock source.
