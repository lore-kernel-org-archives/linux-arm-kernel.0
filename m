From: arnab.basu@freescale.com (Arnab Basu)
Date: Fri, 7 Feb 2014 05:41:08 +0000 (UTC)
Subject: [PATCH 02/18] arm64: GICv3 device tree binding documentation
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <loom.20140207T062553-254@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

Marc Zyngier <marc.zyngier <at> arm.com> writes:

> +
> +AArch64 SMP cores are often associated with a GICv3, providing private
> +peripheral interrupts (PPI), shared peripheral interrupts (SPI),
> +software generated interrupts (SGI), and locality-specific peripheral
> +Interrupts (LPI).
> +
> +Main node required properties:
> +
> +- compatible : should at least contain  "arm,gic-v3".
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. Must be a single cell with a value of at least 3.
> +
> +  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
> +  interrupts. Other values are reserved for future use.

These values are defined in
"include/dt-bindings/interrupt-controller/arm-gic.h" maybe we should start
mentioning that here and encourage future device treese to use those defines
to improve readability.

> +
> +  The 2nd cell contains the interrupt number for the interrupt type.
> +  SPI interrupts are in the range [0-987]. PPI interrupts are in the
> +  range [0-15].
> +
> +  The 3rd cell is the flags, encoded as follows:
> +	bits[3:0] trigger type and level flags.
> +		1 = edge triggered
> +		2 = edge triggered (deprecated, for compatibility with GICv2)
> +		4 = level triggered
> +		8 = level triggered (deprecated, for compatibility with GICv2)

Similar to the above comment
"include/dt-bindings/interrupt-controller/irq.h" defines the trigger type
and level flags. Although this file currently contains the GICv2 bindings,
we could update them.

Thanks
Arnab

> +
> +  Cells 4 and beyond are reserved for future use. Where the 1st cell
> +  has a value of 0 or 1, cells 4 and beyond act as padding, and may be
> +  ignored. It is recommended that padding cells have a value of 0.
> +
> +- reg : Specifies base physical address(s) and size of the GIC
> +  registers, in the following order:
> +  - GIC Distributor interface (GICD)
> +  - GIC Redistributors (GICR), one range per redistributor region
> +  - GIC CPU interface (GICC)
> +  - GIC Hypervisor interface (GICH)
> +  - GIC Virtual CPU interface (GICV)
> +
> +  GICC, GICH and GICV are optional.
> +
> +- interrupts : Interrupt source of the VGIC maintenance interrupt.
> +
