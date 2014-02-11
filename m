From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 11 Feb 2014 21:47:39 +0100
Subject: [PATCH] ARM: tegra: dalmore: fix irq trigger type
In-Reply-To: <4fcfcfdbc86c37c6d47ec32cdbd987f3b406e9b5.1392147256.git.stefan@agner.ch>
References: <4fcfcfdbc86c37c6d47ec32cdbd987f3b406e9b5.1392147256.git.stefan@agner.ch>
Message-ID: <20140211204737.GA1895@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:11:32PM +0100, Stefan Agner wrote:
> Trigger type needs to be IRQ_TYPE_LEVEL_HIGH since the interrupt
> signal gets inverted by the PMC (configured by the invert-interrupt
> property).

Isn't the reason the other way around? The PMIC generates a low-level
interrupt, but the GIC can only be configured to accept high-level (or
rising edge) and therefore the nvidia,invert-interrupt property needs to
be set in the PMC node?

One nitpick below.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
[...]
> @@ -888,8 +888,9 @@
>  		palmas: tps65913 at 58 {
>  			compatible = "ti,palmas";
>  			reg = <0x58>;
> -			interrupts = <0 86 IRQ_TYPE_LEVEL_LOW>;
>  
> +			/* active-low configured by PMC invert-interrupt */
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;

I'd prefer to keep the properties grouped as before. interrupts is a
"client" property, whereas #interrupt-cells and interrupt-controller
are "provider" properties.

And I think the comment would be more appropriate in the pmc node, for
the same reason that I think the commit description isn't entirely
accurate.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/92fcdf86/attachment-0001.sig>
