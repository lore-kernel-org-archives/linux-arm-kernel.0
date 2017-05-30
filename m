From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 May 2017 11:37:10 +0100
Subject: [PATCH 2/6] dt-bindings: interrupt-controller: add DT binding for
 the Marvell ICU
In-Reply-To: <1496135772-20694-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <97989700-2c97-892e-b470-a84af6dfd77b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 10:16, Thomas Petazzoni wrote:
> This commit adds the Device Tree binding documentation for the Marvell
> ICU interrupt controller, which collects wired interrupts from the
> devices located into the CP110 hardware block of Marvell Armada 7K/8K,
> and converts them into SPI interrupts in the GIC located in the AP
> hardware block, using the GICP extension.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../bindings/interrupt-controller/marvell,icu.txt  | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> new file mode 100644
> index 0000000..e0b4068
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> @@ -0,0 +1,57 @@
> +Marvell ICU Interrupt Controller
> +--------------------------------
> +
> +The Marvell ICU (Interrupt Consolidation Unit) controller is
> +responsible for collecting all wired-interrupt sources in the CP and
> +communicating them to the GIC in the AP, the unit translates interrupt
> +requests on input wires to MSG memory mapped transactions to the GIC.
> +
> +The interrupts from the ICU to the GIC can be mapped to one of the following groups:
> +
> +- Shared Peripheral Interrupt - Non-Secured (SPI_NSR)
> +- Shared Peripheral Interrupt - Secured (SPI_SR)
> +- System Error Interrupt (SEI)
> +- RAM Error Interrupt (REI)
> +
> +Required properties:
> +
> +- compatible: Should be "marvell,icu"
> +
> +- reg: Should contain ICU registers location and length.
> +
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. The type shall be a <u32> and the value shall be
> +  3.

Yup...

> +
> +  The 1st cell is the group type of the ICU interrupt (SPI_NSR,
> +  SPI_SR, SEI, and REI).

Is it worth documenting what these are?

> +
> +  The 2nd cell is the index of the interrupt in the ICU unit.
> +
> +  The 3rd cell is the type of the interrupt. See arm,gic.txt for
> +  details.
> +
> +- interrupt-controller: Identifies the node as an interrupt
> +  controller.
> +
> +- interrupt-parent: Indicates the node of the parent interrupt
> +  controller. Should be pointer to the GIC.
> +
> +- gicp: Should point to the GICP controller, the GIC extension that
> +  allows to trigger interrupts using MSG memory mapped transactions.
> +
> +Example:
> +
> +icu: interrupt-controller at 1e0000 {
> +	compatible = "marvell,icu";
> +	reg = <0x1e0000 0x10>;
> +	#interrupt-cells = <2>;

Oh wait...

> +	interrupt-controller;
> +	interrupt-parent = <&gic>;
> +	gicp = <&gicp>;

Should this be prefixed with a vendor specific identifier, just in case?

> +};
> +
> +usb3h0: usb3 at 500000 {
> +	interrupt-parent = <&icu>;
> +	interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
> +};
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
