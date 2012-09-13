From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2012 10:45:20 +0000
Subject: [PATCH V3 2/5] ARM: bcm2708: add interrupt controller driver
In-Reply-To: <50513300.6080403@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <201209121037.43897.arnd@arndb.de> <50513300.6080403@wwwdotorg.org>
Message-ID: <201209131045.20730.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, Stephen Warren wrote:
> On 09/12/2012 04:37 AM, Arnd Bergmann wrote:
> > If the IRQ space is very sparse, isn't it better to use a tree domain
> > rather than a linear one?
> 
> It's not very sparse. There are 3 banks, each containing up to 32
> interrupts. However, the first bank actually only has 8 interrupts plus
> 2 cascade inputs (which are hidden inside the interrupt controller
> driver and so not exposed). So, it's more like there's one gap in the
> middle. I don't know much about the tree domain, but I figure it's
> probably not worth it.

Ok, makes sense.

> >> * Added the interrupt controller DT node to the top-level of the DT,
> >>   rather than nesting it inside a /axi node. Hence, changed the reg value
> >>   since /axi had a ranges property. This seems simpler to me, but I'm not
> >>   sure if everyone will like this change or not.
> > 
> > The layout should follow what the hardware looks like. If the interrupt
> > controller is connected through axi, then I'd suggest describing it there
> > unless there is a strong reason not to. The interrupt-parent property
> > of the root node can easily point anywhere.
> 
> The problem is that there's no documentation of the actual bus
> structure. Simon's original patch placed all peripherals under a single
> top-level /axi bus/node, but the documentation mentions all of AXI, APB,
> and AHB in passing, but doesn't explicitly describe which peripherals
> are on which bus etc. I think I'd rather not represent the bus structure
> in the .dtsi file at all, rather than represent just part of the
> structure and hence be misleading.

Ok.

> >> @@ -0,0 +1,110 @@
> >> +BCM2708 Top-Level ("ARMCTRL") Interrupt Controller
> >> +
> >> +The BCM2708 contains a custom top-level interrupt controller, which supports
> >> +72 interrupt sources using a 2-level register scheme. The interrupt
> >> +controller, or the HW block containing it, is referred to occasionally
> >> +as "armctrl" in the SoC documentation, hence naming of this binding.
> > 
> > Do we actually know that BCM2708 has the same one, or could it be present
> > just on bcm2835? It seem hard to find any information about bcm2708,
> > so I don't feel too good about using that name in bindings.
> 
> I don't know anything at all about the BCM2708 really. Perhaps Dom at
> Broadcom can fill in some details?
> 
> A similar discussion was apparently held downstream, and IIRC the
> reported decision there was that BCM2708 was the "parent" of a family of
> SoCs, so they made all the DT stuff compatible with both 2708 and 2835.
> Given the lack of documentation, I'd be quite happy to rework all of
> this to say just BCM2835 instead, and drop any reference to BCM2708 at
> all. Should I just go ahead and do that?

That's probably safer, yes.

> >> +asmlinkage void __exception_irq_entry bcm2708_armctrl_handle_irq(
> >> +	struct pt_regs *regs)
> >> +{
> >> +	u32 stat, irq;
> >> +
> >> +	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
> >> +		if (stat & BANK0_HWIRQ_MASK) {
> >> +			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
> >> +			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
> >> +		} else if (stat & SHORTCUT1_MASK) {
> >> +			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
> >> +		} else if (stat & SHORTCUT2_MASK) {
> >> +			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
> >> +		} else if (stat & BANK1_HWIRQ) {
> >> +			armctrl_handle_bank(1, regs);
> >> +		} else if (stat & BANK2_HWIRQ) {
> >> +			armctrl_handle_bank(2, regs);
> >> +		} else {
> >> +			BUG();
> >> +		}
> >> +	}
> >> +}
> > 
> > I'm not sure if readl_relaxed() is appropriate here, or if you need readl().
> > If you have an MSI type interrupt signaling the completion of a DMA, you
> > need to ensure ordering between the data transfer and the interrupt
> > notification.
> 
> I did wonder about this. I suppose it would be safe to globally replace
> all readl/writel_relaxed with plain readl/writel, and fix this up later
> if we can justify it. Should I go ahead and do that?

The synchronizations can be a bit expensive, so in the interrupt controller
driver it makes sense to use at least writel_relaxed, which should always
be fine because you don't have to worry about outgoing DMAs.

Even for incoming DMA, I think there is only a need for the non-relaxed
version if we're actually dealing with MSI interrupts, because regular
level and edge triggered interrupts have no form of synchronization between
DMA completion and interrupt delivery anyway.

	Arnd
