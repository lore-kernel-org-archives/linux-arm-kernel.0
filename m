From: eric.auger@redhat.com (Auger Eric)
Date: Fri, 24 Mar 2017 12:28:08 +0100
Subject: [PATCH v3 18/19] KVM: arm64: ITS: Device table save/restore
In-Reply-To: <ddd8369a-364d-3c6c-679d-3ede9a857888@arm.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-19-git-send-email-eric.auger@redhat.com>
 <2c4841df-f7b3-ee03-16d3-7e32c9cbd936@arm.com>
 <728905ad-61a2-f510-b04f-5af178dfaade@redhat.com>
 <ddd8369a-364d-3c6c-679d-3ede9a857888@arm.com>
Message-ID: <4dd0f346-b2ba-5832-66a1-abb0b7fd2340@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/03/2017 12:14, Andre Przywara wrote:
> Hi,
> 
> thanks for addressing the comments and for the fixes!
> 
> On 24/03/17 10:38, Auger Eric wrote:
>> Hi Andre,
>>
>> On 22/03/2017 15:39, Andre Przywara wrote:
>>> Hi,
>>>
>>> On 06/03/17 11:34, Eric Auger wrote:
>>>> This patch flushes the device table entries into guest RAM.
>>>> Both flat table and 2 stage tables are supported.  DeviceId
>>>> indexing is used.
>>>>
>>>> For each device listed in the device table, we also flush
>>>> the translation table using the vgic_its_flush/restore_itt
>>>> routines.
>>>>
>>>> On restore, devices are re-allocated and their itte are
>>>> re-built.
>>>
>>> Some minor things below.
>>> In general I had quite some trouble to understand what's going on here,
>>> though I convinced myself that this is correct. So could you add a bit
>>> more comments here? For instance to explain that we have to explicitly
>>> handle the L1 table on restore, but not on flush.
>>
>> On flush vgic_its_check_id does the 2 stage handling and computes the
>> entry address from the devid:
>>
>> 		if (!vgic_its_check_id(its, baser,
>> 				       dev->device_id, &eaddr))
>>
>> Then you simply flush the entry at that address
>>
>> On restore, you need to scan the level1 and level2 tables for valid entries.
> 
> That is exactly what I read from it, eventually - but only after staring
> at the code for quite a while. So can you put these explanations in some
> comments? An occasional reader would probably be puzzled to find the L1
> handling only in the restore, but not in the save path. It could be even
> shorter like: "Indirect table handling is covered by vgic_its_check_id()".
Yep sure I am going to comment that.

Thanks

Eric
> 
> Cheers,
> Andre.
> 
