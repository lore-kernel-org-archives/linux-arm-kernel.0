From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Nov 2013 11:40:28 -0700
Subject: Report from 2013 ARM kernel summit
In-Reply-To: <20131121110024.GA8395@mudshark.cambridge.arm.com>
References: <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120.083955.1386179068365424976.hdoyu@nvidia.com>
 <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ@mail.gmail.com>
 <20131121110024.GA8395@mudshark.cambridge.arm.com>
Message-ID: <528E539C.8080603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2013 04:00 AM, Will Deacon wrote:
> On Wed, Nov 20, 2013 at 08:02:10PM +0000, Rob Herring wrote:
>> On Wed, Nov 20, 2013 at 12:39 AM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
>>>   smmu_a: iommu at xxxxxxxx {
>>>         #iommu-cells = <2>;
>>>         ....
>>>   };
>>>
>>>   smmu_b: iommu at xxxxxxxx {
>>>         #iommu-cells = <3>;
>>>         ....
>>>   };
>>>
>>>   device_a {
>>>          iommus = <&smmu_a param1 param2>,
>>>                   <&smmu_b param1 param2 param3>;
>>>   };
>>>
>>> This can describe the relation between a device and an iommu
>>> independently. The number of params needed for each IOMMU can be
>>> sepcified by #iommu-cells in its iommu entry.
>>>
>>>   device_a <-> smmu_a, needs 2 params for a device
>>>   device_a <-> smmu_b, needs 3 params for a device
>>>
>>> For example, "smmu_a" can be an bus level global IOMMU where all child
>>> devices can be an master of "smmu_a", and "smmu_b" is a local IOMMU
>>> only for "device_a".
>>>
>>> "memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
>>>                                       |
>>>                                       |
>>>                                       +--"device_b"
>>
>> I think the above binding would be the correct way to describe things
>> if you have 1 device connected to 2 IOMMUs (directly rather than
>> chained). IIUC, that is something you have on tegra?
>>
>> For the topology above where you are chaining iommu's, I think
>> something like this is more accurately describing the hierarchy:
>>
>>   smmu_b: iommu at xxxxxxxx {
>>         #iommu-cells = <3>;
>>          iommus = <&smmu_a param1 param2>;
>>        ....
>>   };
>>   device_a {
>>          iommus = <&smmu_b param1 param2 param3>;
>>   };
>>
>> I remember discussing this with Will and seem to recall some issue
>> with describing things this way. But looking at it now, I don't see
>> what that was.
> 
> I think it was the usual issue with StreamID remastering. For example, if
             ^^^ s/was/had/ I assume
> you had a device going into two chained IOMMUs, you need a way to relate the
> StreamIDs of the device to the remastered IDs coming out of the first SMMU.

That seems pretty easy to deal with. Am I missing something. Here's how
I assume that would work:

1)

If the mapping is static in HW, then you simply have a table that
describes the remapping. A table representation could be in the DT or
the driver itself. Either way, any static mapping is a property of the
HW itself, so shouldn't need to leak into the client DT nodes at all, right?

That might look like:

smmu_a: iommu at xxxxxxxx {
	#iommu-cells = <1>;
};
smmu_b: iommu at xxxxxxxx {
	#iommu-cells = <1>;

	// a) All stream IDs squashed down to 1 ID
	iommus = <&smmu_a SMMU_B's_STREAM_ID_IN_SMMU_A>;

	// OR b) stream IDs translated:
	iommus = <&smmu_a 0>,
		 <&smmu_a 1>,
		 <&smmu_a 2> ...;
	// this table could be in the driver instead
	iommu-stream-id-map =
		<DEV_A's_STREAM_ID_IN_SMMU_B 0>,
		<DEV_B's_STREAM_ID_IN_SMMU_B 1>,
		<DEV_C's_STREAM_ID_IN_SMMU_B 2>,
};
device_a {
	iommus = <&smmu_b DEV_A's_STREAM_ID_IN_SMMU_B>;
};

or 2)

If the remapping is entirely dynamic, then you'd either need a table in
the DT to describe how to set it up for the particular use-case (similar
to the above), or a function in the driver to manage the mapping at
run-time, probably hooked into the of_xlate() of the parent IOMMU, which
would call into some function of the source IOMMU.

In other words, of_xlate for smmu_a would do both:

a) Parse the SMMU specifier in the client's iommus property

b) If the parse specifier represents a "dynamic stream ID device/IOMMU",
call some function in the client driver to find out which stream ID(s)
the parse iommus entry (specifier) represents.
