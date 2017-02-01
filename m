From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Feb 2017 12:19:53 +0100
Subject: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
Message-ID: <17693846.Edk12xXofc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 28, 2017 9:48:36 PM CET Linus Walleij wrote:
> +       interrupt-map-mask = <0xff00 0 0 7>;
> +       interrupt-map = <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> +                       <0x4900 0 0 2 &pci_intc 1>,
> +                       <0x4a00 0 0 3 &pci_intc 2>,
> +                       <0x4b00 0 0 4 &pci_intc 3>,
> +                       <0x5000 0 0 1 &pci_intc 0>, /* Slot 10 */
> +                       <0x5100 0 0 2 &pci_intc 1>,
> +                       <0x5200 0 0 3 &pci_intc 2>,
> +                       <0x5300 0 0 4 &pci_intc 3>,
> +                       <0x5800 0 0 1 &pci_intc 0>, /* Slot 11 */
> +                       <0x5900 0 0 2 &pci_intc 1>,
> +                       <0x5a00 0 0 3 &pci_intc 2>,
> +                       <0x5b00 0 0 4 &pci_intc 3>,
> +                       <0x6000 0 0 1 &pci_intc 0>, /* Slot 12 */
> +                       <0x6100 0 0 2 &pci_intc 1>,
> +                       <0x6200 0 0 3 &pci_intc 2>,
> +                       <0x6300 0 0 4 &pci_intc 3>;
> 

The mapping looks wrong here, we normally don't list interrupts per function
so the mask should be 0xf800.

Note that the interrupt map is board specific, so this should probably
go in the board.dts file rather than platform.dtsi.

For this particular board, the interrupt lines appear to have been badly
configured so all slots use the same interrupt 0 for IntA. IIRC This also
means you can probably use <0 0 0 7> as the mask and just specify each of
the four interrupts once. A properly wired board would swizzle the
interrupts so that each slot has a different IRQ for its IntA line.

	Arnd
