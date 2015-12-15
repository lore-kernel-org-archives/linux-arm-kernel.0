From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 15 Dec 2015 00:43:51 -0500
Subject: [PATCH V9 2/5] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20151214120339.GA21356@leverpostej>
References: <1449850623-32214-1-git-send-email-okaya@codeaurora.org>
 <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
 <20151211164137.GA23638@leverpostej> <566B1F64.9010500@codeaurora.org>
 <20151211193742.GD23638@leverpostej> <566B4ACC.3070005@codeaurora.org>
 <20151214120339.GA21356@leverpostej>
Message-ID: <566FA897.4060407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 12/14/2015 7:05 AM, Mark Rutland wrote:
>>>>>> +Required properties:
>>>>>> +- compatible: "qcom,hidma-mgmt-1.0";
>>>>>> +- reg: Address range for DMA device
>>>>>
>>>>> Does this cover just the management registers, or those for channels as
>>>>> well?
>>>>
>>>> just management.
>>>>
>>>>>
>>>>>> +- dma-channels: Number of channels supported by this DMA controller.
>>>>>
>>>>> Surely this is discoverable, or can be derived from the set of channels
>>>>> described in the DT?
>>>>
>>>> No, this is a HW configuration. Each hardware instance supports certain
>>>> number of channels based on the HW build. The number of active channels
>>>> on the running operating system does not necessarily represent the
>>>> maximum possible.
>>>
>>> I don't follow.
>>>
>>> If you aren't using some channels, why do you need to know about them?
>>>
>>
>> I mean the hypervisor OS may not be using the channels. It could be the
>> guest machines that are using it. I need the number of the channels not
>> the memory addresses where each channel is.
> 
> I still don't follow. Knowing the number of channels alone is clearly
> insufficient.
>
> The hypervisor is in charge of handing these out to guests. So it needs
> to know the set of of channels (i.e. the address of each channel, and
> which index the channel has in the control interface). Otherwise it
> cannot possibly allocate them to guests, and cannot possibly control
> those channels at runtime.

For clarification, let me reiterate.

Hypervisor operating system certainly knows which channels and
management interfaces there are in the system. However, the information
feeds into the OS from two different drivers.

The HW ownership has been partitioned among two drivers as management
driver and channel driver. Both of them serve the hypervisor but the
management driver doesn't need to know about the channel addresses where
the transfer descriptors are set up. Similarly, the channel driver
doesn't need to know anything about the management interface where the
priority and weight assignment is done.

> 
> Given the hypervisor is in chage of allocating channels to guests, it
> knows which channels are in use, and can decide whether or not to use
> channels for its own purposes.

Agreed

> 
>>> The driver seems to assume it can access registers for all (linearly
>>> indexed) channels up to the value it read from dt for dma-channels. That
>>> doesn't seem right if the driver is not dealing with all of those
>>> channels.
>>
>> I assume you are talking about this. Feel free to be specific if not
>> this one.
>>
>> 	for (i = 0; i < mgmtdev->dma_channels; i++) {
>> 		u32 weight = mgmtdev->weight[i];
>> 		u32 priority = mgmtdev->priority[i];
>>
>> 		val = readl(mgmtdev->virtaddr + HIDMA_QOS_N_OFFSET + (4 * i));
>> 		val &= ~(1 << HIDMA_PRIORITY_BIT_POS);
>> 		val |= (priority & 0x1) << HIDMA_PRIORITY_BIT_POS;
>> 		val &= ~(HIDMA_WEIGHT_MASK << HIDMA_WRR_BIT_POS);
>> 		val |= (weight & HIDMA_WEIGHT_MASK) << HIDMA_WRR_BIT_POS;
>> 		writel(val, mgmtdev->virtaddr + HIDMA_QOS_N_OFFSET + (4 * i));
>> 	}
>>
>> The management driver is configuring the priority and weight registers
>> inside the management address space. It is not accessing the channel
>> address space where data transfer descriptors are set up. There is one
>> register for priority & weight of the each channel inside the management
>> address space.
> 
> My point was that this implies that the driver has no idea as to the
> relationship between these configuration registers and the actual
> channel address spaces. It has no idea which channel address spaces are
> being configured here. That does not seem right.

My intention was to use the ACPI _UID to associate the channel index.
The _UID would tell me the index of the channel. I was encoding UID as
follows in the ACPI table.

<deviceid><channelid>

this would tell me which HIDMA this channel belongs to as well as which
channel it is.

Since this solution is very much ACPI specific and doesn't scale to
device-tree, I'm thinking of adding a sysfs "index" file into each
channel so that I don't need to search through the firmware_node in ACPI
and of_node directory in device-tree mode.

I'm also thinking of creating symbolic links from the channel object
into the management object.

>>>>> hidma {
>>>>> 	compatible - "qcom,hidma-1.0";
>>>>>
>>>>> 	/* OPTIONAL management interface registers */
>>>>> 	reg = < ... ... >;
>>>>>
>>>>> 	...
>>>>>
>>>>> 	channel0 {
>>>>> 		compatible = "qcom,
>>>>> 		reg = < ... ... >;
>>>>>
>>>>> 		...
>>>>> 	};
>>>>>
>>>>> 	...
>>>>> };
>>
>> This seems to have worked without requiring any work from me.
>>

Here is something I don't understand why and I could get some help from
DT experts.

When I have ACPI as follows

device(mgmt)
{
	device(channel0)
	{
	}
}

The channel0 driver gets automatically probed by the OS.

When I have device tree based structure as follows, hidma_00 doesn't get
probed.

hidmam_00: hidma-mgmt at 0x58000000 {
		compatible = "qcom,hidma_mgmt-1.0";
		hidma_00: hidma at 0x58010000 {
			compatible = "qcom,hidma-1.0";

		}
}

If I put them seperately, it works

hidma_00: hidma at 0x58010000 {
	compatible = "qcom,hidma-1.0";
}

hidmam_00: hidma-mgmt at 0x58000000 {
	compatible = "qcom,hidma_mgmt-1.0";
}

Wondering If there is any mechanism in DT, I could have the same probing
behavior as ACPI? I hate calling the of_find_matching_node functions and
locate the child object. Then, create a platform device. This seems a
lot of hand-crafting to me. I don't have any OF/ACPI specific code in my
driver. I want to avoid it if there is a way.


>> I need to associate sysfs next.
> 
> Ok. I look forward to seeing those patches.
> 

OK. I'll post it as soon as I figure out DT/ACPI behavior differences.

> Thanks,
> Mark.
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
