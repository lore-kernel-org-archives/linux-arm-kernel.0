From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 13 Jan 2014 16:54:42 +0100
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <52D292DA.8010709@gmail.com>
References: <Pine.LNX.4.44L0.1401111728150.16586-100000@netrider.rowland.org>
 <52D2064B.3010103@prisktech.co.nz> <52D292DA.8010709@gmail.com>
Message-ID: <52D40C42.2050408@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/12/2014 02:04 PM, Tomasz Figa wrote:
> Hi,
>
> [Cc'ing DT maintainers directly]
>

<snip>

>>> Alan Stern Wrote:
>> I prefer the -generic option, although generic- is equally fine - Having
>> said that, I don't really care if it's called mmio either (although this
>> does seem less 'descriptive').

I can do a v5 changing the compatible string to generix-Xhci, if that will
put an end to all this discussion, then again, there may be a better way, see
below.

>
> Grepping over existing dts files, I can find several occurrences of "usb-ehci" compatible string:
>
> at91sam9g45.dtsi:                       compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> at91sam9x5.dtsi:                        compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> omap3.dtsi:                             compatible = "ti,ehci-omap", "usb-ehci";
> omap4.dtsi:                             compatible = "ti,ehci-omap", "usb-ehci";
> omap5.dtsi:                             compatible = "ti,ehci-omap", "usb-ehci";
> sama5d3.dtsi:                   compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> spear13xx.dtsi:                 compatible = "st,spear600-ehci", "usb-ehci";
> spear13xx.dtsi:                 compatible = "st,spear600-ehci", "usb-ehci";
> spear3xx.dtsi:                  compatible = "st,spear600-ehci", "usb-ehci";
> spear600.dtsi:                  compatible = "st,spear600-ehci", "usb-ehci";
> spear600.dtsi:                  compatible = "st,spear600-ehci", "usb-ehci";
> tegra114.dtsi:          compatible = "nvidia,tegra30-ehci", "usb-ehci";
> tegra114.dtsi:          compatible = "nvidia,tegra30-ehci", "usb-ehci";
> tegra20.dtsi:           compatible = "nvidia,tegra20-ehci", "usb-ehci";
> tegra20.dtsi:           compatible = "nvidia,tegra20-ehci", "usb-ehci";
> tegra20.dtsi:           compatible = "nvidia,tegra20-ehci", "usb-ehci";
> tegra30.dtsi:           compatible = "nvidia,tegra30-ehci", "usb-ehci";
> tegra30.dtsi:           compatible = "nvidia,tegra30-ehci", "usb-ehci";
> tegra30.dtsi:           compatible = "nvidia,tegra30-ehci", "usb-ehci";
>
> Same for "usb-ohci":
>
> arch/arm/boot/dts/at91rm9200.dtsi:                      compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/at91sam9260.dtsi:                     compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/at91sam9263.dtsi:                     compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/at91sam9g45.dtsi:                     compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/at91sam9n12.dtsi:                     compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/at91sam9x5.dtsi:                      compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/lpc32xx.dtsi:                 compatible = "nxp,ohci-nxp", "usb-ohci";
> arch/arm/boot/dts/omap3.dtsi:                           compatible = "ti,ohci-omap3", "usb-ohci";
> arch/arm/boot/dts/omap4.dtsi:                           compatible = "ti,ohci-omap3", "usb-ohci";
> arch/arm/boot/dts/omap5.dtsi:                           compatible = "ti,ohci-omap3", "usb-ohci";
> arch/arm/boot/dts/sama5d3.dtsi:                 compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> arch/arm/boot/dts/spear13xx.dtsi:                       compatible = "st,spear600-ohci", "usb-ohci";
> arch/arm/boot/dts/spear13xx.dtsi:                       compatible = "st,spear600-ohci", "usb-ohci";
> arch/arm/boot/dts/spear3xx.dtsi:                        compatible = "st,spear600-ohci", "usb-ohci";
> arch/arm/boot/dts/spear3xx.dtsi:                        compatible = "st,spear600-ohci", "usb-ohci";
> arch/arm/boot/dts/spear600.dtsi:                        compatible = "st,spear600-ohci", "usb-ohci";
> arch/arm/boot/dts/spear600.dtsi:                        compatible = "st,spear600-ohci", "usb-ohci";
>
> For "usb-ehci" there is even a documentation file [1], while "usb-ohci" seems to be undocumented.
>
> [1] Documentation/devicetree/bindings/usb/usb-ehci.txt
>
> Aren't they both something that should be accounted for in this series?

I agree that usb-Xhci would be the best compatible strings to use.

The problem with usb-ehci is that there already is a ppc specific driver binding to that
compatible string, doing various ppc specific controller initialization.

Thinking more about this, there is one possible solution though, the ehci-ppc-of.c is
guarded in Kconfig with:

         depends on PPC_OF

If we add an inverted check to the Kconfig option for platform-ehci.c, ie:

config USB_EHCI_HCD_PLATFORM
         tristate "Generic EHCI driver for a platform device"
	depends on !PPC_OF

Then we can be certain that we don't end up with 2 drivers claiming the
usb-ehci compatible on ppc platforms. I've done some quick research
and it seems that ehci-platform.c is only used on arm and mips devices, so
excluding its use on ppc should not be an issue.

Then later on someone, who has the actual hardware to test, can merge the
ppc specific quirk handling into ehci-platform,c and ehci-ppc-of.c can go
away entirely.

Alan, if you agree this is the best way forward, I'll do a v5 with the proposed
changes.

Regards,

Hans
