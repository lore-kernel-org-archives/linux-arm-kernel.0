From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 30 Apr 2018 16:24:16 +0200
Subject: [PATCH 14/17] dt-bindings/interrupt-controller: add description
 for Marvell SEI node
In-Reply-To: <20180421135537.24716-15-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-15-miquel.raynal@bootlin.com>
Message-ID: <20180430162416.7b8f2e9c@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Miqu?l,

Title should rather be: "add DT binding documentation for the Marvell
SEI controller" or something like that. Talking about "node" is a bit
weird here.

On Sat, 21 Apr 2018 15:55:34 +0200, Miquel Raynal wrote:
> Describe the SEI (System Error Interrupt) controller driver.

As soon as you say "driver" in a DT binding documentation, you're on
the wrong track. A binding documentation never describes a driver, but
a piece of hardware.

> The controller is part of the GIC.

I don't think we should state that, especially since it's not part of
the GIC shipped by ARM as far as I know, and we represent it as a
separate Device Tree nodes.

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> new file mode 100644
> index 000000000000..a246d59552b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> @@ -0,0 +1,54 @@
> +Marvell SEI (System Error Interrupt) Controller
> +-----------------------------------------------
> +
> +Marvell SEI (System Error Interrupt) controller is an interrupt aggregator.
> +It receives interrupts from several sources and aggregates them to a single
> +interrupt line (an SPI) on the primary interrupt controller.

Rather than primary, I would use "parent" here.

> +The IRQ chip can handle up to 64 SEIs, a set comes from the AP and is

"IRQ chip" is a Linux concept, I would stick to "This interrupt
controller can handle up ..."

> +wired while a second set comes from the CPs by the mean of MSIs. Each
> +'domain' is represented as a subnode.
> +
> +Required properties:
> +
> +- compatible: should be "marvell,armada-8k-sei".
> +- reg: SEI registers location and length.
> +- interrupts: identifies the parent IRQ that will be triggered.
> +- #address-cells: should be '1', represents the position of the first
> +                  IRQ of a given type in the SEI range.
> +- #size-cells: should be '1', represents the number of a given type of
> +               IRQs.

What is the "given type" ?

> +Child node 'sei-wired-controller' required properties:
> +
> +- reg: the range of wired interrupts.
> +- #interrupt-cells: number of cells to define an SEI wired interrupt
> +                    coming from the AP, should be 1. The cell is the IRQ
> +                    number.
> +- interrupt-controller: identifies the node as an interrupt controller.
> +
> +Child node 'sei-msi-controller' required properties:
> +
> +- reg: the range of non-wired interrupts triggered by way of MSIs.
> +- msi-controller: identifies the node as an MSI controller.
> +
> +Example:
> +
> +        sei: sei at 3f0200 {
> +               compatible = "marvell,armada-8k-sei";
> +               reg = <0x3f0200 0x40>;
> +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               sei_wired_controller: sei-wired-controller at 0 {
> +                       reg = <0 21>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-controller;
> +               };
> +
> +               sei_msi_controller: sei-msi-controller at 21 {
> +                       reg = <21 43>;
> +                       msi-controller;
> +               };

As Rob asked, I'm not sure we need subnodes here. Did you check if it
is was doable to have a single node which is both an
interrupt-controller and a msi-controller ?

And indeed, as Rob said, using reg to encode interrupt ranges doesn't
look good.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
