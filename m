From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Sep 2015 19:09:15 +0100
Subject: [PATCH v4 2/2] dt-binding:Documents of the mbigen bindings
In-Reply-To: <1439952920-2296-3-git-send-email-majun258@huawei.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-3-git-send-email-majun258@huawei.com>
Message-ID: <20150921190915.1a551e16@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Aug 2015 03:55:20 +0100
MaJun <majun258@huawei.com> wrote:

> From: Ma Jun <majun258@huawei.com>
> 
> Add the mbigen msi interrupt controller bindings document.
> 
> Change since v3:
> --- Change the interrupt cells definition.
> --- Change the mbigen node definition.
> --- Add mbigen device node as sub node of mbigen.
> 
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/mbigen.txt |   97 ++++++++++++++++++++++
>  1 files changed, 97 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
> new file mode 100644
> index 0000000..8e1203b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mbigen.txt
> @@ -0,0 +1,97 @@
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
> +- interrupt controller: Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value is 4 now.
> +
> +  The 1st cell is the device id.
> +  The 2nd cell is the mbigen node number. This value should refer to the
> +  vendor Soc specification.
> +  The 3rd cell is the hardware pin number of the interrupt.
> +  This value depends on the Soc design.
> +  The 4th cell is the interrupt trigger type, encoded as follows:
> +		1 = edge triggered
> +		4 = level triggered
> +
> +- #mbigen-node-cells :Specifies the number of cells needed to encode an
> +  mbigen node information. The value is 3 now.
> +
> +  The 1st cell is the mbigen node number.
> +  The 2nd cell is the interrupt numbers connected to.
> +  The 3rd cell is the start value of pin offset.
> +
> +- reg: Specifies the base physical address and size of the Mbigen
> +  registers.
> +
> +Sub-nodes:
> +
> +Mbigen has one or more mbigen device nodes which represents the devices
> +connected to this mbigen chip.
> +
> +These nodes must have the following properties:
> +- msi-parent: This property has two cells.
> +	The 1st cell specifies the ITS this device connected.
> +	The 2nd cell specifies the device id.
> +- nr-interrupts:Specifies the total number of interrupt this device has.
> +- mbigen_node: Specifies the information of mbigen nodes this device
> +  connected.Some devices with many interrupts maybe connects with several
> +  mbigen nodes.
> +
> +Examples:
> +
> +		mbigen_dsa: interrupt-controller at c0080000 {
> +			compatible = "hisilicon,mbigen-v2";
> +			interrupt-controller;
> +			#interrupt-cells = <5>;
> +			#mbigen-node-cells = <3>;
> +			reg = <0xc0080000 0x10000>;
> +
> +			mbigen_device_01 {
> +				msi-parent = <&its 0x40b1c>;
> +				nr-interrupts = <9>;
> +				mbigen_node = <1 2 0>,
> +							<3 2 4>,
> +							<4 5 0>;
> +			}
> +
> +			mbigen_device_02 {
> +				msi-parent = <&its 0x40b1d>;
> +				nr-interrupts = <3>;
> +				mbigen_node = <6 3 0>;
> +				interrupt-controller;
> +			}
> +		};
> +
> +Device connect to mbigen required properties:
> +----------------------------------------------------
> +-interrupt-parent: Specifies the mbigen node which device connected.
> +-interrupts:specifies the interrupt source.The first cell is hwirq num, the
> +  second number is trigger type.
> +
> +Examples:
> +	smmu_dsa {
> +		compatible = "arm,smmu-v3";
> +		reg = <0x0 0xc0040000 0x0 0x20000>;
> +		interrupt-parent  = <&mbigen_dsa>;
> +		interrupts = <0x40b20 6 78 1>,
> +				<0x40b20 6 79 1>,
> +				<0x40b20 6 80 1>;
> +	};
> +

I find the current split very confusing. In your example, the interrupt
controller is the mbigen block, which forces you to encode the DevID as
part of the interrupt specifier. This doesn't feel like an ideal
design, because you end up duplicating the DevID information at both
the "client" device and the mbi_device.

I'd be more inclined to have the mbi_device itself be the interrupt
controller for the client device. This would eliminate information
duplication, and reflect the hardware (or what I understand of the
hardware) a bit more.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
