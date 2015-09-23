From: majun258@huawei.com (majun (F))
Date: Wed, 23 Sep 2015 15:24:46 +0800
Subject: [PATCH v4 2/2] dt-binding:Documents of the mbigen bindings
In-Reply-To: <20150922154120.18634b41@arm.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-3-git-send-email-majun258@huawei.com>
 <20150921190915.1a551e16@arm.com> <56013D0A.4000403@huawei.com>
 <20150922154120.18634b41@arm.com>
Message-ID: <560253BE.8030505@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/9/22 22:41, Marc Zyngier ??:
> On Tue, 22 Sep 2015 19:35:38 +0800
> "majun (F)" <majun258@huawei.com> wrote:
> 
[...]
>>>> +Examples:
>>>> +	smmu_dsa {
>>>> +		compatible = "arm,smmu-v3";
>>>> +		reg = <0x0 0xc0040000 0x0 0x20000>;
>>>> +		interrupt-parent  = <&mbigen_dsa>;
>>>> +		interrupts = <0x40b20 6 78 1>,
>>>> +				<0x40b20 6 79 1>,
>>>> +				<0x40b20 6 80 1>;
>>>> +	};
>>>> +
>>>
>>> I find the current split very confusing. In your example, the interrupt
>>> controller is the mbigen block, which forces you to encode the DevID as
>>> part of the interrupt specifier. This doesn't feel like an ideal
>>> design, because you end up duplicating the DevID information at both
>>> the "client" device and the mbi_device.
>>>
>>> I'd be more inclined to have the mbi_device itself be the interrupt
>>> controller for the client device. This would eliminate information
>>> duplication, and reflect the hardware (or what I understand of the
>>> hardware) a bit more.
>>
>> Do you mean make the dts likes below?
>>
>>
>> 		mbigen_dsa: interrupt-controller at c0080000 {
>> 			compatible = "hisilicon,mbigen-v2";
>> 			interrupt-controller;
>> 			#interrupt-cells = <5>;
> 
> These two statements shouldn't be here...

According to you suggest that irq chip should be probed with IRQCHIP_DECLARE(),
I think the compatible string also should be moved into mbigen_clinet_device node.

And, changing mbigen driver likes below:

IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbigen-v2", mbigen_of_init);

Thanks!
Ma Jun

> 
>> 			#mbigen-node-cells = <3>;
>> 			reg = <0xc0080000 0x10000>;
>> 			
>> 			mbigen_client_device1 {
>> 				msi-parent = <&its 0x40b1c>;
>> 				nr-interrupts = <9>;
>> 				interrupt-controller;
> 
> This is where #interrupt-cells should be.
> 
>> 			}
>>
>> 			mbigen_client_device2{
>> 				msi-parent = <&its 0x40b1d>;
>> 				nr-interrupts = <3>;
>> 				interrupt-controller;
>> 			}
>> 		};
>>
>>
>> 	client_device1 {
>> 		compatible = "arm,smmu-v3";
>> 		reg = <0x0 0xc0040000 0x0 0x20000>;
>> 		interrupt-parent  = <&mbigen_client_device1>;
>> 		interrupts = <pin_offset 78 1>,
>> 				<pin_offset 79 1>,
>> 				<pin_offset 80 1>;
>> 	};
>>
>>
> 
> But otherwise, this looks better.
> 
> Thanks,
> 
> 	M.
> 
