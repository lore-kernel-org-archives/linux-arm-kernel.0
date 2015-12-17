From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Dec 2015 13:52:47 +0000
Subject: [PATCH v10 1/4] dt-binding:Documents of the mbigen bindings
In-Reply-To: <1450353397-47668-2-git-send-email-majun258@huawei.com>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
 <1450353397-47668-2-git-send-email-majun258@huawei.com>
Message-ID: <20151217135247.GD13389@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 07:56:34PM +0800, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> Add the mbigen msi interrupt controller bindings document.
> 
> This patch based on Mark Rutland's patch
> https://lkml.org/lkml/2015/7/23/558
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/mbigen.txt |   74 ++++++++++++++++++++++
>  1 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
> new file mode 100644
> index 0000000..3eaa678
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mbigen.txt
> @@ -0,0 +1,74 @@
> +Hisilicon mbigen device tree bindings.
> +=======================================
> +
> +Mbigen means: message based interrupt generator.
> +
> +MBI is kind of msi interrupt only used on Non-PCI devices.
> +
> +To reduce the wired interrupt number connected to GIC,
> +Hisilicon designed mbigen to collect and generate interrupt.
> +
> +
> +Non-pci devices can connect to mbigen and generate the
> +interrupt by writing ITS register.
> +
> +The mbigen chip and devices connect to mbigen have the following properties:
> +
> +Mbigen main node required properties:
> +-------------------------------------------
> +- compatible: Should be "hisilicon,mbigen-v2"
> +
> +- reg: Specifies the base physical address and size of the Mbigen
> +  registers.
> +
> +- interrupt controller: Identifies the node as an interrupt controller
> +
> +- msi-parent: Specifies the MSI controller this mbigen use.
> +  For more detail information,please refer to the generic msi-parent binding in
> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +- num-msis:Specifies the total number of interrupt this device has.

Is this the number of pins implemented? Or the number of pins that are
in use?

The latter feels like something we can derive.

> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value must be 2.
> +
> +  The 1st cell is hardware pin number of the interrupt.This number is local to
> +  each mbigen chip and in the range from 0 to the maximum interrupts number
> +  of the mbigen.

Just to check: 0 - 63 represent the "reserved" pins, yes?

Other than those questions, this looks good to me.

Thanks,
Mark.

> +
> +  The 2nd cell is the interrupt trigger type.
> +	The value of this cell should be:
> +	1: rising edge triggered
> +	or
> +	4: high level triggered
> +
> +Examples:
> +
> + 	mbigen_device_gmac:intc {
> +			compatible = "hisilicon,mbigen-v2";
> +			reg = <0x0 0xc0080000 0x0 0x10000>;
> +			interrupt-controller;
> +			msi-parent = <&its_dsa 0x40b1c>;
> +			num-msis = <9>;
> +			#interrupt-cells = <2>;
> + 	};
> +
> +Devices connect to mbigen required properties:
> +----------------------------------------------------
> +-interrupt-parent: Specifies the mbigen device node which device connected.
> +
> +-interrupts:Specifies the interrupt source.
> + For the specific information of each cell in this property,please refer to
> + the "interrupt-cells" description mentioned above.
> +
> +Examples:
> +	gmac0: ethernet at c2080000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0 0xc2080000 0 0x20000>,
> +		      <0 0xc0000000 0 0x1000>;
> +		interrupt-parent  = <&mbigen_device_gmac>;
> +		interrupts =	<656 1>,
> +				<657 1>;
> +	};
> +
> -- 
> 1.7.1
> 
> 
