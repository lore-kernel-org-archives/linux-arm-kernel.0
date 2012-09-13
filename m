From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 19:12:32 -0600
Subject: [PATCH V3 2/5] ARM: bcm2708: add interrupt controller driver
In-Reply-To: <201209121037.43897.arnd@arndb.de>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <1347423509-30647-2-git-send-email-swarren@wwwdotorg.org>
 <201209121037.43897.arnd@arndb.de>
Message-ID: <50513300.6080403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 04:37 AM, Arnd Bergmann wrote:
> On Wednesday 12 September 2012, Stephen Warren wrote:
>> From: Simon Arlott <simon@fire.lp0.eu>
>>
>> The BCM2708 contains a custom interrupt controller, which supports 72
>> interrupt sources using a 2-level register scheme. The interrupt
>> controller, or the HW block containing it, is referred to occasionally
>> as "armctrl" in the SoC documentation, hence the symbol naming in the
>> code.
>>
>> This patch was extracted from git://github.com/lp0/linux.git branch
>> rpi-split as of 2012/09/08, and modified as follows:
>>
>> * Added devicetree documentation, and hence removed list of IRQs from
>>   bcm2835.dtsi.
>> * Changed shift in MAKE_HWIRQ() and HWIRQ_BANK() from 8 to 5 to reduce
>>   the size of the hwirq space, and pass the total size of the hwirq space
>>   to irq_domain_add_linear(), rather than just the number of valid hwirqs;
>>   the two are different due to the hwirq space being sparse.
> 
> If the IRQ space is very sparse, isn't it better to use a tree domain
> rather than a linear one?

It's not very sparse. There are 3 banks, each containing up to 32
interrupts. However, the first bank actually only has 8 interrupts plus
2 cascade inputs (which are hidden inside the interrupt controller
driver and so not exposed). So, it's more like there's one gap in the
middle. I don't know much about the tree domain, but I figure it's
probably not worth it.

>> * Added the interrupt controller DT node to the top-level of the DT,
>>   rather than nesting it inside a /axi node. Hence, changed the reg value
>>   since /axi had a ranges property. This seems simpler to me, but I'm not
>>   sure if everyone will like this change or not.
> 
> The layout should follow what the hardware looks like. If the interrupt
> controller is connected through axi, then I'd suggest describing it there
> unless there is a strong reason not to. The interrupt-parent property
> of the root node can easily point anywhere.

The problem is that there's no documentation of the actual bus
structure. Simon's original patch placed all peripherals under a single
top-level /axi bus/node, but the documentation mentions all of AXI, APB,
and AHB in passing, but doesn't explicitly describe which peripherals
are on which bus etc. I think I'd rather not represent the bus structure
in the .dtsi file at all, rather than represent just part of the
structure and hence be misleading.

>> @@ -0,0 +1,110 @@
>> +BCM2708 Top-Level ("ARMCTRL") Interrupt Controller
>> +
>> +The BCM2708 contains a custom top-level interrupt controller, which supports
>> +72 interrupt sources using a 2-level register scheme. The interrupt
>> +controller, or the HW block containing it, is referred to occasionally
>> +as "armctrl" in the SoC documentation, hence naming of this binding.
> 
> Do we actually know that BCM2708 has the same one, or could it be present
> just on bcm2835? It seem hard to find any information about bcm2708,
> so I don't feel too good about using that name in bindings.

I don't know anything at all about the BCM2708 really. Perhaps Dom at
Broadcom can fill in some details?

A similar discussion was apparently held downstream, and IIRC the
reported decision there was that BCM2708 was the "parent" of a family of
SoCs, so they made all the DT stuff compatible with both 2708 and 2835.
Given the lack of documentation, I'd be quite happy to rework all of
this to say just BCM2835 instead, and drop any reference to BCM2708 at
all. Should I just go ahead and do that?

>> +asmlinkage void __exception_irq_entry bcm2708_armctrl_handle_irq(
>> +	struct pt_regs *regs)
>> +{
>> +	u32 stat, irq;
>> +
>> +	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
>> +		if (stat & BANK0_HWIRQ_MASK) {
>> +			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
>> +			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
>> +		} else if (stat & SHORTCUT1_MASK) {
>> +			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
>> +		} else if (stat & SHORTCUT2_MASK) {
>> +			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
>> +		} else if (stat & BANK1_HWIRQ) {
>> +			armctrl_handle_bank(1, regs);
>> +		} else if (stat & BANK2_HWIRQ) {
>> +			armctrl_handle_bank(2, regs);
>> +		} else {
>> +			BUG();
>> +		}
>> +	}
>> +}
> 
> I'm not sure if readl_relaxed() is appropriate here, or if you need readl().
> If you have an MSI type interrupt signaling the completion of a DMA, you
> need to ensure ordering between the data transfer and the interrupt
> notification.

I did wonder about this. I suppose it would be safe to globally replace
all readl/writel_relaxed with plain readl/writel, and fix this up later
if we can justify it. Should I go ahead and do that?
