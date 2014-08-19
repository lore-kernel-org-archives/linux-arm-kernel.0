From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 19 Aug 2014 14:03:00 +0300
Subject: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <a0244b6befa9407fb6c2c35cc29f92f7@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
 <87a9774lf5.fsf@nvidia.com>
 <cfb1d2ff66004685b7ead3f5e6321681@BL2PR03MB468.namprd03.prod.outlook.com>
 <87y4ur2h23.fsf@nvidia.com>
 <d9fb045d54244f26a773ba45ad3caa2d@BL2PR03MB468.namprd03.prod.outlook.com>
 <87zjf0hk3b.fsf@nvidia.com>
 <a0244b6befa9407fb6c2c35cc29f92f7@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <87wqa4hhcr.fsf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Varun Sethi <Varun.Sethi@freescale.com> writes:

>> >> > Also, for dynamic stream ID allocation we would need to represent
>> >> > the specific master register (to store the stream ID) in the device tree.
>> >>
>> >> I assmue that the above means that iMX has such configuration
>> >> register to map steramID and a device dynamically.
>> >
>> > We have per master registers for setting the stream ID on the
>> > Layerscape platforms. My point was that we would need the iommu master
>> > node to include a reference to the master id register.
>> >
>> > master at 1 {
>> >                /* device has master ID 42 in the IOMMU */
>> >              iommus = <&{/iommu} 42>;
>> >              master-id-reg = <phandle offset> };
>> 
>> In the above, for "iommus=" bindings, you wouldn't need to break
>> ARM,SMMU compatibility at all if you set "streamID" exactly as below.
>> 
>>   master at 1 {
>>                  /* device has master ID 42 in the IOMMU */
>>                iommus = <&{/iommu} 'any given streamID'>;
>>                master-id-reg = <phandle offset>
>>   };
>> 
>> And your SoC needs to register bus_notifier and ADD_DEVICE should configure
>> to map 'any given streamID' to a device via the above register. This wouldn't
>> need any modification from ARM,SMMU driver and keep the iommus bindings
>> as it is.
>> 
>> IOW, SoC only needs to register ADD_DEVICE in bus_notifier to map StreamID
>> to a device. This needs to be executed earlier than IOMMU bus's ADD_DEVICE,
>> though.
>> 
>> Is my understanding right?
>
> I don't think that SOC specific code needs a bus notifier for setting
> the stream ID. It can be done as a part of SOC specific
> initialization. The device tree can be updated to reflect the correct
> stream ID (SMMU driver can get the updated stream ID from device
> tree). 

That's possible.

> I was thinking more on the lines of updating the device stream id
> while attaching a device to the domain.

I thought the same but this would break the ARM,SMMU /compatibility/
since the 1st param of "iommus=" is always expected as "streamID".

If streamID can be assigned dynamically like PCIe, not like streamID
statically set in DT, how should we describe this dynmaic steramID
shifting/assignment in DT?
