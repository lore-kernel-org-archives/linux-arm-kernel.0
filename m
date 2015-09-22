From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 15:41:20 +0100
Subject: [PATCH v4 2/2] dt-binding:Documents of the mbigen bindings
In-Reply-To: <56013D0A.4000403@huawei.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-3-git-send-email-majun258@huawei.com>
 <20150921190915.1a551e16@arm.com> <56013D0A.4000403@huawei.com>
Message-ID: <20150922154120.18634b41@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Sep 2015 19:35:38 +0800
"majun (F)" <majun258@huawei.com> wrote:

> Hi Marc:
> 
> ? 2015/9/22 2:09, Marc Zyngier ??:
> > On Wed, 19 Aug 2015 03:55:20 +0100
> > MaJun <majun258@huawei.com> wrote:
> > 
> [...]
> >> +These nodes must have the following properties:
> >> +- msi-parent: This property has two cells.
> >> +	The 1st cell specifies the ITS this device connected.
> >> +	The 2nd cell specifies the device id.
> >> +- nr-interrupts:Specifies the total number of interrupt this device has.
> >> +- mbigen_node: Specifies the information of mbigen nodes this device
> >> +  connected.Some devices with many interrupts maybe connects with several
> >> +  mbigen nodes.
> >> +
> >> +Examples:
> >> +
> >> +		mbigen_dsa: interrupt-controller at c0080000 {
> >> +			compatible = "hisilicon,mbigen-v2";
> >> +			interrupt-controller;
> >> +			#interrupt-cells = <5>;
> >> +			#mbigen-node-cells = <3>;
> >> +			reg = <0xc0080000 0x10000>;
> >> +
> >> +			mbigen_device_01 {
> >> +				msi-parent = <&its 0x40b1c>;
> >> +				nr-interrupts = <9>;
> >> +				mbigen_node = <1 2 0>,
> >> +							<3 2 4>,
> >> +							<4 5 0>;
> >> +			}
> >> +
> >> +			mbigen_device_02 {
> >> +				msi-parent = <&its 0x40b1d>;
> >> +				nr-interrupts = <3>;
> >> +				mbigen_node = <6 3 0>;
> >> +				interrupt-controller;
> >> +			}
> >> +		};
> >> +
> >> +Device connect to mbigen required properties:
> >> +----------------------------------------------------
> >> +-interrupt-parent: Specifies the mbigen node which device connected.
> >> +-interrupts:specifies the interrupt source.The first cell is hwirq num, the
> >> +  second number is trigger type.
> >> +
> >> +Examples:
> >> +	smmu_dsa {
> >> +		compatible = "arm,smmu-v3";
> >> +		reg = <0x0 0xc0040000 0x0 0x20000>;
> >> +		interrupt-parent  = <&mbigen_dsa>;
> >> +		interrupts = <0x40b20 6 78 1>,
> >> +				<0x40b20 6 79 1>,
> >> +				<0x40b20 6 80 1>;
> >> +	};
> >> +
> > 
> > I find the current split very confusing. In your example, the interrupt
> > controller is the mbigen block, which forces you to encode the DevID as
> > part of the interrupt specifier. This doesn't feel like an ideal
> > design, because you end up duplicating the DevID information at both
> > the "client" device and the mbi_device.
> > 
> > I'd be more inclined to have the mbi_device itself be the interrupt
> > controller for the client device. This would eliminate information
> > duplication, and reflect the hardware (or what I understand of the
> > hardware) a bit more.
> 
> Do you mean make the dts likes below?
> 
> 
> 		mbigen_dsa: interrupt-controller at c0080000 {
> 			compatible = "hisilicon,mbigen-v2";
> 			interrupt-controller;
> 			#interrupt-cells = <5>;

These two statements shouldn't be here...

> 			#mbigen-node-cells = <3>;
> 			reg = <0xc0080000 0x10000>;
> 			
> 			mbigen_client_device1 {
> 				msi-parent = <&its 0x40b1c>;
> 				nr-interrupts = <9>;
> 				interrupt-controller;

This is where #interrupt-cells should be.

> 			}
> 
> 			mbigen_client_device2{
> 				msi-parent = <&its 0x40b1d>;
> 				nr-interrupts = <3>;
> 				interrupt-controller;
> 			}
> 		};
> 
> 
> 	client_device1 {
> 		compatible = "arm,smmu-v3";
> 		reg = <0x0 0xc0040000 0x0 0x20000>;
> 		interrupt-parent  = <&mbigen_client_device1>;
> 		interrupts = <pin_offset 78 1>,
> 				<pin_offset 79 1>,
> 				<pin_offset 80 1>;
> 	};
> 
> 

But otherwise, this looks better.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
