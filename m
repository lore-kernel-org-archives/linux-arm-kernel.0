From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 12:37:01 +0100
Subject: [PATCH 1/3] PCI: designware: add legacy PCI interrupt mapping
In-Reply-To: <1393586856.5225.6.camel@weser.hi.pengutronix.de>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <000101cf3452$f203ed60$d60bc820$%han@samsung.com>
 <1393586856.5225.6.camel@weser.hi.pengutronix.de>
Message-ID: <5728262.sMhnqxGTXH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 12:27:36 Lucas Stach wrote:
>
> It seems that dw_pcie_map_irq shouldn't even exist and should be
> replaced with of_irq_parse_and_map_pci().

Right.

> As I understand the Exynos hardware is mapping all legacy PCI IRQs to
> one single GIC IRQ. Now I wonder why you have two different IRQs in your
> DT? See this snippet:
> 
> interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> #interrupt-cells = <1>;
> interrupt-map-mask = <0 0 0 0>;
> interrupt-map = <0x0 0 &gic 53>;
> 
> The driver uses the second device IRQ to map all PCI IRQs to, which is
> GIC IRQ 21 in this example. Your interrupt-map property in contrary
> indicates that all PCI IRQs should be mapped to GIC IRQ 53.
> What is the right thing to do here?

The interrupt-map doesn't even look well-formed, since it refers to
a gic that has #interrupt-cells=<3>, but only has one cell with the
value. This clearly cannot work at all. It should probably be

	interrupt-map = <0x0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;

Note that '53' is the IRQ number that is commonly assigned to
SPI interrupt 21, since SPI starts at number 32 on GIC.


	Arnd
