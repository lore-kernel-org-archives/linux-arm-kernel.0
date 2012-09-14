From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 20:21:14 -0600
Subject: [PATCH V3 2/5] ARM: bcm2708: add interrupt controller driver
In-Reply-To: <201209131045.20730.arnd@arndb.de>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <201209121037.43897.arnd@arndb.de> <50513300.6080403@wwwdotorg.org>
 <201209131045.20730.arnd@arndb.de>
Message-ID: <5052949A.1020909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 04:45 AM, Arnd Bergmann wrote:
> On Thursday 13 September 2012, Stephen Warren wrote:
>> On 09/12/2012 04:37 AM, Arnd Bergmann wrote:

>>>> @@ -0,0 +1,110 @@
>>>> +BCM2708 Top-Level ("ARMCTRL") Interrupt Controller
>>>> +
>>>> +The BCM2708 contains a custom top-level interrupt controller, which supports
>>>> +72 interrupt sources using a 2-level register scheme. The interrupt
>>>> +controller, or the HW block containing it, is referred to occasionally
>>>> +as "armctrl" in the SoC documentation, hence naming of this binding.
>>>
>>> Do we actually know that BCM2708 has the same one, or could it be present
>>> just on bcm2835? It seem hard to find any information about bcm2708,
>>> so I don't feel too good about using that name in bindings.
>>
>> I don't know anything at all about the BCM2708 really. Perhaps Dom at
>> Broadcom can fill in some details?
>>
>> A similar discussion was apparently held downstream, and IIRC the
>> reported decision there was that BCM2708 was the "parent" of a family of
>> SoCs, so they made all the DT stuff compatible with both 2708 and 2835.
>> Given the lack of documentation, I'd be quite happy to rework all of
>> this to say just BCM2835 instead, and drop any reference to BCM2708 at
>> all. Should I just go ahead and do that?
> 
> That's probably safer, yes.

Sounds good. For reference, I found:

https://github.com/raspberrypi/linux/issues/22

... where it sounds like BCM2708 isn't actually a chip at all, but a
family name, so that supports this change.

>>>> +asmlinkage void __exception_irq_entry bcm2708_armctrl_handle_irq(
>>>> +	struct pt_regs *regs)
>>>> +{
>>>> +	u32 stat, irq;
>>>> +
>>>> +	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
>>>> +		if (stat & BANK0_HWIRQ_MASK) {
>>>> +			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
>>>> +			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
>>>> +		} else if (stat & SHORTCUT1_MASK) {
>>>> +			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
>>>> +		} else if (stat & SHORTCUT2_MASK) {
>>>> +			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
>>>> +		} else if (stat & BANK1_HWIRQ) {
>>>> +			armctrl_handle_bank(1, regs);
>>>> +		} else if (stat & BANK2_HWIRQ) {
>>>> +			armctrl_handle_bank(2, regs);
>>>> +		} else {
>>>> +			BUG();
>>>> +		}
>>>> +	}
>>>> +}
>>>
>>> I'm not sure if readl_relaxed() is appropriate here, or if you need readl().
>>> If you have an MSI type interrupt signaling the completion of a DMA, you
>>> need to ensure ordering between the data transfer and the interrupt
>>> notification.
>>
>> I did wonder about this. I suppose it would be safe to globally replace
>> all readl/writel_relaxed with plain readl/writel, and fix this up later
>> if we can justify it. Should I go ahead and do that?
> 
> The synchronizations can be a bit expensive, so in the interrupt controller
> driver it makes sense to use at least writel_relaxed, which should always
> be fine because you don't have to worry about outgoing DMAs.

Thinking some more about this - I doubt there are any MSI-style
interrupts; there's certainly no PCI/PCIe on the Raspberry Pi board, and
none documented in the SoC itself (although admittedly only a small
subset of the SoC is publicly documented). I guess it's easiest just to
leave that code as-is, and fix it up if the hardware ever turns out to
be more complex, and actually have MSI.
