From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Jul 2013 11:08:10 -0600
Subject: [PATCH V2] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <1375261841.1231.166.camel@jlo-ubuntu-64.nvidia.com>
References: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
 <51F292D4.9030208@wwwdotorg.org>
 <1375177568.1239.16.camel@jlo-ubuntu-64.nvidia.com>
 <51F7E8B5.6030009@wwwdotorg.org>
 <1375261841.1231.166.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51F9447A.3090008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 03:10 AM, Joseph Lo wrote:
> On Wed, 2013-07-31 at 00:24 +0800, Stephen Warren wrote:
>> On 07/30/2013 03:46 AM, Joseph Lo wrote:
>>> On Fri, 2013-07-26 at 23:16 +0800, Stephen Warren wrote:
>>>> On 07/24/2013 04:54 AM, Joseph Lo wrote:
>>>>> The IRQ trigger type of Palmas MFD device (tps65913) is edge trigger. The
>>>>> wrong configuration would cause an interrupt storm when booting the
>>>>> system. Fixing it in DT with appropriate interrupt type.
>>>>
>>>>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
>>>>
>>>>>  		palmas: tps65913 {
>>>>>  			compatible = "ti,palmas";
>>>>>  			reg = <0x58>;
>>>>> -			interrupts = <0 86 0x4>;
>>>>> +			interrupts = <0 86 0x0>;
>>>>
>>>> The legal values for that final cell are:
>>>>
>>>>     - bits[3:0] trigger type and level flags
>>>>         1 = low-to-high edge triggered
>>>>         2 = high-to-low edge triggered
>>>>         4 = active high level-sensitive
>>>>         8 = active low level-sensitive
>>>>
>>>> 0 isn't one of those values. This patch can't be correct.
>>>>
>>>> BTW, this cell should use the constants from
>>>> <dt-bindings/interrupt-controller/irq.h>.
>>>
>>> Oops. I made a wrong description in the commit message.
>>>
>>> Update my test result again.
>>>
>>>> 1 = low-to-high edge triggered
>>> No IRQ storm, but the system always auto wake up by Palmas RTC.
>>>> 2 = high-to-low edge triggered
>>> No IRQ storm, but the GIC didn't support this trigger type. The flag
>>> would be re-configured as 0x0.
>>>> 4 = active high level-sensitive
>>> There is a IRQ storm when system booting.
>>>> 8 = active low level-sensitive
>>> No IRQ strom, but the GIC didn't support this trigger type. The flag
>>> would be re-configured as 0x0.
>>>
>>>> nvidia, invert-interrupt
>>> Removing this can fix IRQ storm too, but the system always auto wake up
>>> by Palmas RTC.
>>>
>>> So we can only three trigger type here.
>>> IRQ_TYPE_NONE 0
>>
>> That's not a valid value; it just means that the GIC driver doesn't
>> explicitly set the type, and the HW probably defaults to active high?
>>
> oh,yes. May be.
> 
>>> IRQ_TYPE_EDGE_FALLING 2
>>> IRQ_TYPE_LEVEL_LOW 8
>>>
>>> But using IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_LEVEL_LOW, it would
>>> configure to IRQ_TYPE_NONE. Because the PMIC is low level trigger to PMC
>>> on Dalmore, I would prefer to use IRQ_TYPE_LEVEL_LOW just like the v1.
>>> Any comments?
>>
>> Comments no, I just have confusion!
>>
>> We should simply set this flag to the correct value. Does the PMIC
>> output an edge-sensitive or level-sensitive signal? Is the signal
>> active-high/rising or active-low/falling? Those are the only things that
>> should be considered when selecting the correct value for the IRQ flags.
>> This information can be determined by reading the data sheet for the
>> PMIC; while the test results you mention above are interesting, the HW
>> documentation should drive the value we select here, unless the
>> documentation has a known bug.
>>
> OK, the PMIC(Palmas here) only support level-sensitive and default is
> active low.
> 
> But it was being configured as active high in the Dalmore's DT. And yes,
> it can work fine with the configuration you mentioned below. The suspend
> mode of LP1/LP2 that could be woken up by IRQ is OK in this case.
> 
> But if checking the PMU_INT signal in the schematic of Dalmore, it only
> supports active low. It was connected to !PWR_INT of Tegra114 that will
> cause the system wake up automatically when syspended to LP0 if active
> high.
> 
> That's why my change is setting the IRQ type of PMIC to active low and
> keep the "nvidia,invert-interrupt". And it can make the LP0/1/2 work
> proper.

OK, the explanation all basically makes sense. We do clearly need to fix
the DT so that the Palmas IRQ signal polarity matches what we've
configured the Tegra PMC/GIC to expect.

However, your patch was:

		palmas:?tps65913?{
			compatible?=?"ti,palmas";
			reg?=?<0x58>;
-			interrupts?=?<0?86?0x4>;
+			interrupts?=?<0?86?0x0>;

0 isn't valid. The replacement shouldn't be 0, but instead should be
IRQ_TYPE_LEVEL_LOW.

Alternatively, it sounds fine to leave that interrupts property as-is,
and remove the pmc's nvidia,invert-interrupt. Either sound like they
should work fine, although perhaps one polarity might cause glitches
before the inversion/... is programmed in the PMIC and/or based on
whatever pull-ups/downs are on the board?

>> If there is an IRQ storm, then that sounds like a bug in the code. That
>> needs to be fixed too, not worked around by setting an incorrect IRQ
>> flags value.
>>
> By the way, don't you see IRQ storm like below(You use "if" here)?
> 
> [   87.054085] irq 118: nobody cared (try booting with the "irqpoll" option)
> [   87.060862] CPU: 0 PID: 41 Comm: irq/118-palmas Not tainted 3.11.0-rc2-next-20130722-00011-gadb202a-dirty #11
> [   87.070811] [<c0012161>] (unwind_backtrace+0x1/0x98) from [<c000f07b>] (show_stack+0xb/0xc)
> [   87.079134] [<c000f07b>] (show_stack+0xb/0xc) from [<c038af89>] (dump_stack+0x59/0x8c)
> [   87.087035] [<c038af89>] (dump_stack+0x59/0x8c) from [<c005eef9>] (__report_bad_irq+0x15/0x80)
> [   87.095676] [<c005eef9>] (__report_bad_irq+0x15/0x80) from [<c005f22d>] (note_interrupt+0x139/0x17c)
> [   87.104782] [<c005f22d>] (note_interrupt+0x139/0x17c) from [<c005e4d7>] (irq_thread+0xc3/0xd4)
> [   87.113424] [<c005e4d7>] (irq_thread+0xc3/0xd4) from [<c002f87b>] (kthread+0x6b/0x74)
> [   87.121237] [<c002f87b>] (kthread+0x6b/0x74) from [<c000ccfd>] (ret_from_fork+0x11/0x34)
> [   87.121325] vdd-sensor-2v85: disabling
> [   87.133064] handlers:
> [   87.135335] [<c005dd85>] irq_default_primary_handler threaded [<c01dbd99>] regmap_irq_thread
> [   87.143762] Disabling IRQ #118

I don't recall seeing that.

>            CPU0       CPU1       CPU2       CPU3       
> ...
>  85:     804308          0          0          0       GIC  85  i2c
> 118:     100001          0          0          0       GIC 118  palmas
> 122:        152          0          0          0       GIC 122  serial
> ...

I didn't check that.
