From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Apr 2017 11:03:40 +0100
Subject: [PATCH v4 18/22] KVM: arm64: ITS: Collection table save/restore
In-Reply-To: <3d5f7230-e55b-44b8-bc37-021d1784ee0e@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-19-git-send-email-eric.auger@redhat.com>
 <95a88e33-3cbc-9c4d-b76c-3cec5c4cc310@arm.com>
 <3d5f7230-e55b-44b8-bc37-021d1784ee0e@redhat.com>
Message-ID: <02981ae1-5138-45fa-b1be-6fc96194d0d7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/17 10:57, Auger Eric wrote:
> Hi Marc,
> 
> On 10/04/2017 11:55, Marc Zyngier wrote:
>> On 27/03/17 10:31, Eric Auger wrote:
>>> The flush path copies the collection entries into guest RAM
>>> at the GPA specified in the BASER register. This obviously
>>> requires the BASER to be set. The last written element
>>> is a dummy collection table entry.
>>>
>>> We do not index by collection ID as the collection entry
>>> can fit into 8 bytes while containing the collection ID.
>>>
>>> On restore path we re-allocate the collection objects.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> v3 -> v4:
>>> - replaced u64 *ptr by gpa_t gpa
>>> - check the collection does not exist before allocating it
>>>
>>> v1 -> v2:
>>> - reword commit message and directly use 8 as entry size
>>> - no kvm parameter anymore
>>> - add helper for flush/restore cte
>>> - table size computed here
>>> - add le64/cpu conversions
>>> ---
>>>  virt/kvm/arm/vgic/vgic-its.c | 99 +++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 97 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>>> index 8eaeba4..df984b6 100644
>>> --- a/virt/kvm/arm/vgic/vgic-its.c
>>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>>> @@ -1828,13 +1828,89 @@ static int vgic_its_restore_device_tables(struct vgic_its *its)
>>>  	return -ENXIO;
>>>  }
>>>  
>>> +static int vgic_its_flush_cte(struct vgic_its *its,
>>> +			      struct its_collection *collection, gpa_t gpa)
>>
>> Given that the pendent of this function is name ..._restore_..., should
>> this be called ..._save_... ?
>>
>>> +{
>>> +	u64 val;
>>> +	int ret;
>>> +
>>> +	val = ((u64)1 << 63 | ((u64)collection->target_addr << 16) |
>>> +	       collection->collection_id);
>>
>> Please provide some #defines that describe the encoding. This will be
>> specially useful if we need to export this to userspace (KVM/TCG
>> interoperability?).
>>
>>> +	val = cpu_to_le64(val);
>>> +	ret = kvm_write_guest(its->dev->kvm, gpa, &val, 8);
>>> +	return ret;
>>> +}
>>> +
>>> +static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, bool *valid)
>>> +{
>>> +	struct its_collection *collection;
>>> +	u32 target_addr;
>>> +	u32 coll_id;
>>> +	u64 val;
>>> +	int ret;
>>> +
>>> +	*valid = false;
>>> +
>>> +	ret = kvm_read_guest(its->dev->kvm, gpa, &val, 8);
>>> +	if (ret)
>>> +		return ret;
>>> +	val = le64_to_cpu(val);
>>> +	*valid = val & BIT_ULL(63);
>>> +
>>> +	if (!*valid)
>>> +		return 0;
>>> +
>>> +	target_addr = (u32)(val >> 16);
>>
>> u32?
> At the moment its_collection.target_addr is u32 and corresponds to the
> PE number. Only GITS_TYPER.PTA = 0 is supported.
> 
> Or do I miss something?

No, you're right. I'm getting confused between the model I'm working
with and the ITS emulation... Ignore me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
