From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 18:28 +0200
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on designware
 core driver
In-Reply-To: <1400169692-9677-6-git-send-email-m-karicheri2@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <1400169692-9677-6-git-send-email-m-karicheri2@ti.com>
Message-ID: <4195791.GS9XG8RaXW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 12:01:32 Murali Karicheri wrote:
> +Sample bindings shown below:-
> +
> + - Remove ti,enable-linktrain if boot loader already does Link training and do EP
> +   configuration.
> + - Remove ti,init-phy if boot loader already initialize the phy and sets up pcie
> +   link

You actually have to document all the properties. Have a look at the
other bindings for what this means.

> +
> +               pcie at 21800000 {
> +                       compatible = "ti,keystone-pcie";
> +                       device_type = "pci";
> +                       clocks = <&clkpcie>;
> +                       clock-names = "pcie";

The dw-pcie binding lists two clocks.

> +                       #address-cells = >;
> +                       #size-cells = <2>;
> +                       reg =  <0x21800000 0x1000>, <0x0262014c 4>;
> +                       reg-names = "reg_rc_app", "reg_devcfg";

There should be standard names that are documented in the binding.

> +                       interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>; /* Error IRQ */

What are all these interrupts?

> +                       ranges = <0x00000800 0 0x21801000 0x21801000 0 0x0002000    /* Configuration space */
> +                                 0x81000000 0 0          0x24000000 0 0x4000       /* downstream I/O */
> +                                 0x82000000 0 0x50000000 0x50000000 0 0x10000000>; /* non-prefetchable memory */

Please move the config space into 'reg' now instead of 'ranges'.
This was a mistake earlier, and there are already other front-ends
doing the same thing.

> +                       num-lanes = <2>;
> +                       ti,enable-linktrain;
> +                       ti,init-phy;
> +
> +                       /* PCIE phy */
> +                       phys = <&pcie0_phy>;
> +                       phy-names = "pcie-phy";
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 1 &pcie_intc 1>, // INT A
> +                                       <0 0 0 2 &pcie_intc 2>, // INT B
> +                                       <0 0 0 3 &pcie_intc 3>, // INT C
> +                                       <0 0 0 4 &pcie_intc 4>; // INT D

I think this is the wrong map-mask.

	Arnd
