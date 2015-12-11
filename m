From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Dec 2015 17:14:36 -0500
Subject: [PATCH V9 2/5] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20151211193742.GD23638@leverpostej>
References: <1449850623-32214-1-git-send-email-okaya@codeaurora.org>
 <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
 <20151211164137.GA23638@leverpostej> <566B1F64.9010500@codeaurora.org>
 <20151211193742.GD23638@leverpostej>
Message-ID: <566B4ACC.3070005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 2:37 PM, Mark Rutland wrote:
>>
>> Another reviewer requested guidance on how to set these parameters.
>> That's why, I tried to provide as much data as possible.
> 
> It's perfectly fine to have some other document for the driver, but the
> binding doc should stick to HW description.
> 

OK, I'll reword and put some more HW description.

>>>> +Required properties:
>>>> +- compatible: "qcom,hidma-mgmt-1.0";
>>>> +- reg: Address range for DMA device
>>>
>>> Does this cover just the management registers, or those for channels as
>>> well?
>>
>> just management.
>>
>>>
>>>> +- dma-channels: Number of channels supported by this DMA controller.
>>>
>>> Surely this is discoverable, or can be derived from the set of channels
>>> described in the DT?
>>
>> No, this is a HW configuration. Each hardware instance supports certain
>> number of channels based on the HW build. The number of active channels
>> on the running operating system does not necessarily represent the
>> maximum possible.
> 
> I don't follow.
> 
> If you aren't using some channels, why do you need to know about them?
> 

I mean the hypervisor OS may not be using the channels. It could be the
guest machines that are using it. I need the number of the channels not
the memory addresses where each channel is.

> The driver seems to assume it can access registers for all (linearly
> indexed) channels up to the value it read from dt for dma-channels. That
> doesn't seem right if the driver is not dealing with all of those
> channels.

I assume you are talking about this. Feel free to be specific if not
this one.

	for (i = 0; i < mgmtdev->dma_channels; i++) {
		u32 weight = mgmtdev->weight[i];
		u32 priority = mgmtdev->priority[i];

		val = readl(mgmtdev->virtaddr + HIDMA_QOS_N_OFFSET + (4 * i));
		val &= ~(1 << HIDMA_PRIORITY_BIT_POS);
		val |= (priority & 0x1) << HIDMA_PRIORITY_BIT_POS;
		val &= ~(HIDMA_WEIGHT_MASK << HIDMA_WRR_BIT_POS);
		val |= (weight & HIDMA_WEIGHT_MASK) << HIDMA_WRR_BIT_POS;
		writel(val, mgmtdev->virtaddr + HIDMA_QOS_N_OFFSET + (4 * i));
	}

The management driver is configuring the priority and weight registers
inside the management address space. It is not accessing the channel
address space where data transfer descriptors are set up. There is one
register for priority & weight of the each channel inside the management
address space.

> 
>>>
>>> Why can this information not be associated with the channel directly?
>>>
>> Two reasons:
>> 1. The channel doesn't have the capability to change the priority and
>> weight. HW design. Management HW can do this only.
> 
> You can describe the channels directly to the hypervisor which talks to
> the management HW.

Not a use case, I don't want to allow guest machine to change their
priority and weight. Guest machine runs the channel driver.

> 
>> 2. We are building SW to change the channel priority and weight at
>> runtime from the hypervisor through sysfs. The system administrator of
>> the server will reallocate resources based on the guest machine
>> requirements.
> 
> Ok, so these properties are not necessary at all.
> 
> They can go, and you can default to a reasonable fair QoS configuration
> that the user can override at runtime depending on use-case.

Partially agreed, some values are "the fair QoS configuration defaults"
per platform like maximum-read-request etc. The firmware writes the
default values in their device tree/ ACPI table for HW description and
the HIDMA driver will configure the defaults.

I'll remove the weight and priority though.

> 
>>> How does one choose the right priority and/or weight? These seem like
>>> runtime details given that channels are indned to be allocated by
>>> software.
>>
>> priority = 0..1
>> weight = 0...15 (adding max value to the documentation)
> 
> My point was more that the value you want depends on your use-case,
> which is _not_ a static hardware property, but rather a dynamic run-time
> property.
> 
> You stated this can be modified at run time. It should not be in the DT.
> Please drop it from the binding.
> 

I'll get rid of weight and priority only.

>> +  Valid values are 1..15.
>>
>>>
>>> There's no relationship to channels defined here. What happens if/when
>>> you have a system with multiple instances?
>>>
>>
>> I do support multiple instances. I tested with 4 instances (6 channels
>> each). This driver is only responsible for management which it can do
>> through its own dedicated HW interface. It doesn't need access to the
>> channel address space. There will be 4 HIDMA management instances in
>> this case.
> 
> I don't follow.
> 
> How do you know which channels are associated with which management
> interface?

The association is the other way around. User need to know the
management interface for a channel rather than the channel needing to
know the management interface.

I'll think about it.

> 
> How can your sysfs interface work if that relationship is not described?

Here is the sysfs documentation. Each management object has one channel
directory under it. I still don't need to access the channel object in
order to change its weight and priority.

What:           /sys/devices/platform/hidma-mgmt*/chan*/priority
                /sys/devices/platform/QCOM8060:*/chan*/priority
Date:           Nov 2015
KernelVersion:  4.4
Contact:        "Sinan Kaya <okaya@cudeaurora.org>"
Description:
                Contains either 0 or 1 and indicates if the DMA channel is a
                low priority (0) or high priority (1) channel.


> 
>>> I don't understand why you don't have a single binding for both the
>>> management interface and channels, e.g.
>>>
>>> hidma {
>>> 	compatible - "qcom,hidma-1.0";
>>>
>>> 	/* OPTIONAL management interface registers */
>>> 	reg = < ... ... >;
>>>
>>> 	...
>>>
>>> 	channels {
>>> 		channel0 {
>>> 			compatible = "qcom,
>>> 			reg = < ... ... >;
>>>
>>> 			...
>>> 		};
>>>
>>> 		...
>>> 	};
>>> };
>>>
>>> That would be more in keeping with what we do for other componenents
>>> with hyp control elements (e.g. the GIC) and keeps everything
>>> associated.
>>
>> This was discussed before with the previous versions of the patch. This
>> split and loose coupling design is on purpose.
> 
> I understand it was a deliberate choice. I am disagreeing with that
> choice.
> 

In order to be able to use the same channel driver in the guest machine
context with the hierarchy you want, I need to create this.

fake management object {
	fake values;
	channels {
		real DMA channel {
			...
		}
	}
}

This looks really ugly to me. I need to deal with a fake management
driver and object that could be hypervisor specific.

Here is a fact:

QEMU is not capable of generating complex device-tree nodes for platform
devices that are being virtualized. QEMU only generates a very simple
device object with compatible ID and memory and interrupt resources. No
parent, child relationship and no device-specific attributes. Here is an
example:

device {
	compatible-id;
	reg;
	interrupt;
}

This is plain and simple. It works too. No need to create some fake device.

The other issue is the ACPI. I know device-tree has all kinds of nice
gadgets for traversing the parent/child relationship and object
pointers. I can't implement this if the solution does not scale to ACPI.

I'm still leaning towards keep it simple approach.

>> The summary is that for static OS configurations where devices remain
>> active for the rest of the OS execution; it makes perfect sense to
>> create a device bus or child device object relationship.
>>
>> The use case here is virtualization and object lifetime in the
>> hypervisor is dynamic. Channel objects get unbound and bound dynamically
>> for guest OS control. At any time, the hypervisor may not have any
>> channel objects if the administrator decides to give all channels to the
>> guest machines.
> 
> If the administrator tells the host to give a guest ownership of a
> channel, the host knows that it cannot use the channel itself, nor can
> it allocate the channel to another guest. Consider PCIe device
> passthrough; the host knows that there is a device on the PCIe bus, but
> also knows that a guest owns it. The same logic should apply here.

Agreed, the HIDMA channel object gets associated to the VFIO driver
while the guest is owning the HIDMA channel object.


> 
> No guest should care which particular physical channels it's provided
> with.
> 
>> Only the hidma channel driver gets executed in the guest machine. There
>> is no management driver and device entity in the guest. Therefore,
>> child-parent relationship does not exist.
> 
> The management driver needs to know details of the channels it's
> managing, even if it never accesses them directly. Otherwise how can you
> allocate a channel to a guest and manage it through the correct portion
> of the correct management interface?

I'll add support for both. Both having a parent-child relationship while
inside the hypervisor and flat hierarchy while running in the guest
machine for QEMU.

I just created a child object of the management driver and channel
driver got probed properly. So, it just a matter of device-tree
documentation at this point.

It will be like this though.

>>> hidma {
>>> 	compatible - "qcom,hidma-1.0";
>>>
>>> 	/* OPTIONAL management interface registers */
>>> 	reg = < ... ... >;
>>>
>>> 	...
>>>
>>> 	channel0 {
>>> 		compatible = "qcom,
>>> 		reg = < ... ... >;
>>>
>>> 		...
>>> 	};
>>>
>>> 	...
>>> };

This seems to have worked without requiring any work from me.

I need to associate sysfs next.

> 
> I am not arguing for the management driver to run in the guest. For the
> GIC we have a single binding, yet never run the KVM driver in the guest.
> The same split of responsibility can apply to the hidma driver(s).
> 
> Thanks,
> Mark.
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
