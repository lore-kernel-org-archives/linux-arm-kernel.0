From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 10:37:43 +0000
Subject: [PATCH V3 2/5] ARM: bcm2708: add interrupt controller driver
In-Reply-To: <1347423509-30647-2-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <1347423509-30647-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209121037.43897.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> The BCM2708 contains a custom interrupt controller, which supports 72
> interrupt sources using a 2-level register scheme. The interrupt
> controller, or the HW block containing it, is referred to occasionally
> as "armctrl" in the SoC documentation, hence the symbol naming in the
> code.
> 
> This patch was extracted from git://github.com/lp0/linux.git branch
> rpi-split as of 2012/09/08, and modified as follows:
> 
> * Added devicetree documentation, and hence removed list of IRQs from
>   bcm2835.dtsi.
> * Changed shift in MAKE_HWIRQ() and HWIRQ_BANK() from 8 to 5 to reduce
>   the size of the hwirq space, and pass the total size of the hwirq space
>   to irq_domain_add_linear(), rather than just the number of valid hwirqs;
>   the two are different due to the hwirq space being sparse.

If the IRQ space is very sparse, isn't it better to use a tree domain
rather than a linear one?

> * Added the interrupt controller DT node to the top-level of the DT,
>   rather than nesting it inside a /axi node. Hence, changed the reg value
>   since /axi had a ranges property. This seems simpler to me, but I'm not
>   sure if everyone will like this change or not.

The layout should follow what the hardware looks like. If the interrupt
controller is connected through axi, then I'd suggest describing it there
unless there is a strong reason not to. The interrupt-parent property
of the root node can easily point anywhere.

> TODO: Should of_address_to_resource(), ioremap(), request_mem_region()
> in armctrl_of_init() be collapsed into of_iomap(). This wouldn't request
> the region, but a quick grep implies that's quite common with DT.

Yes, that sounds reasonable.

> diff --git a/Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-armctrl-ic.txt b/Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-armctrl-ic.txt
> new file mode 100644
> index 0000000..d7f7887
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm2708/broadcom,bcm2708-armctrl-ic.txt

The bindings are normally grouped by subsystem, not by manufacturer or soc,
because a lot of components end up getting reused by other people. For
some reason, we have put a lot of interrupt controller bindings into the
arm subdirectory, so you can keep doing this, but I would not create a hierarchy
below that.

I think it would be even better if we could put them all into
bindings/interrupt-controller or similar.

> @@ -0,0 +1,110 @@
> +BCM2708 Top-Level ("ARMCTRL") Interrupt Controller
> +
> +The BCM2708 contains a custom top-level interrupt controller, which supports
> +72 interrupt sources using a 2-level register scheme. The interrupt
> +controller, or the HW block containing it, is referred to occasionally
> +as "armctrl" in the SoC documentation, hence naming of this binding.

Do we actually know that BCM2708 has the same one, or could it be present
just on bcm2835? It seem hard to find any information about bcm2708,
so I don't feel too good about using that name in bindings.


> diff --git a/arch/arm/mach-bcm2708/irq.c b/arch/arm/mach-bcm2708/irq.c
> new file mode 100644
> index 0000000..81dba4e
> --- /dev/null
> +++ b/arch/arm/mach-bcm2708/irq.c

We're starting to put interrupt controller drivers into drivers/irqchip
in v3.7, so maybe you can put this one there too. We will get a trivial
merge conflict with the Makefile, but that's ok IMHO.

> +asmlinkage void __exception_irq_entry bcm2708_armctrl_handle_irq(
> +	struct pt_regs *regs)
> +{
> +	u32 stat, irq;
> +
> +	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
> +		if (stat & BANK0_HWIRQ_MASK) {
> +			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
> +			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
> +		} else if (stat & SHORTCUT1_MASK) {
> +			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
> +		} else if (stat & SHORTCUT2_MASK) {
> +			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
> +		} else if (stat & BANK1_HWIRQ) {
> +			armctrl_handle_bank(1, regs);
> +		} else if (stat & BANK2_HWIRQ) {
> +			armctrl_handle_bank(2, regs);
> +		} else {
> +			BUG();
> +		}
> +	}
> +}


I'm not sure if readl_relaxed() is appropriate here, or if you need readl().
If you have an MSI type interrupt signaling the completion of a DMA, you
need to ensure ordering between the data transfer and the interrupt
notification.

	Arnd
