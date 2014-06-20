From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jun 2014 22:51:45 +0200
Subject: [PATCH v4 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <201406210036.59693.sergei.shtylyov@cogentembedded.com>
References: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
 <201406210036.59693.sergei.shtylyov@cogentembedded.com>
Message-ID: <4637423.jWRbL1GbCK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 June 2014 00:36:58 Sergei Shtylyov wrote:
> +       pci0: pci at ee090000 {
> +               compatible = "renesas,pci-r8a7790";
> +               clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
> +               reg = <0x0 0xee090000 0x0 0xc00>,
> +                     <0x0 0xee080000 0x0 0x1100>;
> +               interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
> +               status = "disabled";
> +
> +               bus-range = <0 0>;
> +               #address-cells = >;
> +               #size-cells = <2>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0xff00 0 0 0x7>;
> +               interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> +                                0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> +                                0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
> +       };

Hmm, this device node is not actually compliant to the PCI binding,
it needs a "ranges" property that can be used to look up the memory
and I/O space windows. It also needs a device_type property.

I realize that the driver doesn't currently use them, but you should
adhere to the binding anyway, so we can fix the driver at some point.

	Arnd
