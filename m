From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 10:24:21 -0600
Subject: [PATCH V2] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <1375177568.1239.16.camel@jlo-ubuntu-64.nvidia.com>
References: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
 <51F292D4.9030208@wwwdotorg.org>
 <1375177568.1239.16.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51F7E8B5.6030009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 03:46 AM, Joseph Lo wrote:
> On Fri, 2013-07-26 at 23:16 +0800, Stephen Warren wrote:
>> On 07/24/2013 04:54 AM, Joseph Lo wrote:
>>> The IRQ trigger type of Palmas MFD device (tps65913) is edge trigger. The
>>> wrong configuration would cause an interrupt storm when booting the
>>> system. Fixing it in DT with appropriate interrupt type.
>>
>>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
>>
>>>  		palmas: tps65913 {
>>>  			compatible = "ti,palmas";
>>>  			reg = <0x58>;
>>> -			interrupts = <0 86 0x4>;
>>> +			interrupts = <0 86 0x0>;
>>
>> The legal values for that final cell are:
>>
>>     - bits[3:0] trigger type and level flags
>>         1 = low-to-high edge triggered
>>         2 = high-to-low edge triggered
>>         4 = active high level-sensitive
>>         8 = active low level-sensitive
>>
>> 0 isn't one of those values. This patch can't be correct.
>>
>> BTW, this cell should use the constants from
>> <dt-bindings/interrupt-controller/irq.h>.
> 
> Oops. I made a wrong description in the commit message.
> 
> Update my test result again.
> 
>> 1 = low-to-high edge triggered
> No IRQ storm, but the system always auto wake up by Palmas RTC.
>> 2 = high-to-low edge triggered
> No IRQ storm, but the GIC didn't support this trigger type. The flag
> would be re-configured as 0x0.
>> 4 = active high level-sensitive
> There is a IRQ storm when system booting.
>> 8 = active low level-sensitive
> No IRQ strom, but the GIC didn't support this trigger type. The flag
> would be re-configured as 0x0.
> 
>> nvidia, invert-interrupt
> Removing this can fix IRQ storm too, but the system always auto wake up
> by Palmas RTC.
> 
> So we can only three trigger type here.
> IRQ_TYPE_NONE 0

That's not a valid value; it just means that the GIC driver doesn't
explicitly set the type, and the HW probably defaults to active high?

> IRQ_TYPE_EDGE_FALLING 2
> IRQ_TYPE_LEVEL_LOW 8
> 
> But using IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_LEVEL_LOW, it would
> configure to IRQ_TYPE_NONE. Because the PMIC is low level trigger to PMC
> on Dalmore, I would prefer to use IRQ_TYPE_LEVEL_LOW just like the v1.
> Any comments?

Comments no, I just have confusion!

We should simply set this flag to the correct value. Does the PMIC
output an edge-sensitive or level-sensitive signal? Is the signal
active-high/rising or active-low/falling? Those are the only things that
should be considered when selecting the correct value for the IRQ flags.
This information can be determined by reading the data sheet for the
PMIC; while the test results you mention above are interesting, the HW
documentation should drive the value we select here, unless the
documentation has a known bug.

If there is an IRQ storm, then that sounds like a bug in the code. That
needs to be fixed too, not worked around by setting an incorrect IRQ
flags value.

To be clear, here is what I would expect depending on what kind of IRQ
signal the PMIC outputs:

active-low:
GIC: active-high, PMC: nvidia,invert-interrupt

active-high:
GIC: active-high, PMC: NO nvidia,invert-interrupt

falling-edge:
GIC: rising-edge-triggered, PMC: nvidia,invert-interrupt

rising-edge:
GIC: rising-edge-triggered, PMC: NO nvidia,invert-interrupt
