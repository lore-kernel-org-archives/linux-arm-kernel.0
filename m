From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 22 Mar 2017 15:12:54 +0100
Subject: [PATCH v3 15/19] KVM: arm64: ITS: Collection table save/restore
In-Reply-To: <12e8bb9b-75cb-998b-fb7c-c5f96adafd59@arm.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-16-git-send-email-eric.auger@redhat.com>
 <12e8bb9b-75cb-998b-fb7c-c5f96adafd59@arm.com>
Message-ID: <5b5e819e-a462-0737-643b-b6aaac7fe921@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 21/03/2017 19:13, Andre Przywara wrote:
> Hi,
> 
> On 06/03/17 11:34, Eric Auger wrote:
>> The flush path copies the collection entries into guest RAM
>> at the GPA specified in the BASER register. This obviously
>> requires the BASER to be set. The last written element
>> is a dummy collection table entry.
>>
>> We do not index by collection ID as the collection entry
>> can fit into 8 bytes while containing the collection ID.
>>
>> On restore path we re-allocate the collection objects.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - reword commit message and directly use 8 as entry size
>> - no kvm parameter anymore
>> - add helper for flush/restore cte
>> - table size computed here
>> - add le64/cpu conversions
>> ---
>>  virt/kvm/arm/vgic/vgic-its.c | 94 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 92 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index cf04776..ad67759 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -1761,13 +1761,84 @@ static int vgic_its_restore_device_tables(struct vgic_its *its)
>>  	return -ENXIO;
>>  }
>>  
>> +static int vgic_its_flush_cte(struct vgic_its *its,
>> +			      struct its_collection *collection, u64 *ptr)
> 
> I don't think "u64 *ptr" is right here, why not use "gpa_t gpa" and save
> the cast below?
Agreed. changed.
> 
>> +{
>> +	u64 val;
>> +	int ret;
>> +
>> +	val = ((u64)1 << 63 | ((u64)collection->target_addr << 16) |
>> +	       collection->collection_id);
>> +	val = cpu_to_le64(val);
>> +	ret = kvm_write_guest(its->dev->kvm, (gpa_t)ptr, &val, 8);
>> +	return ret;
>> +}
>> +
>> +static int vgic_its_restore_cte(struct vgic_its *its, u64 *ptr, bool *valid)
>> +{
>> +	struct its_collection *collection;
>> +	u32 target_addr;
>> +	u32 coll_id;
>> +	u64 val;
>> +	int ret;
>> +
>> +	*valid = false;
>> +
>> +	ret = kvm_read_guest(its->dev->kvm, (gpa_t)ptr, &val, 8);
>> +	if (ret)
>> +		return ret;
>> +	val = le64_to_cpu(val);
>> +	*valid = val & BIT_ULL(63);
>> +
>> +	if (!*valid)
>> +		return 0;
>> +
>> +	target_addr = (u32)(val >> 16);
>> +	coll_id = val & 0xFFFF;
>> +	ret = vgic_its_alloc_collection(its, &collection, coll_id);
> 
> I think you should do as the other users do and check if there is a
> collection with that ID already. Or refactor vgic_its_alloc_collection()
> to do that for you: allocate or use an existing one.
added a check in this function.
> 
>> +	if (ret)
>> +		return ret;
>> +	collection->target_addr = target_addr;
>> +	return 0;
>> +}
>> +
>>  /**
>>   * vgic_its_flush_collection_table - flush the collection table into
>>   * guest RAM
>>   */
>>  static int vgic_its_flush_collection_table(struct vgic_its *its)
>>  {
>> -	return -ENXIO;
>> +	struct its_collection *collection;
>> +	u64 val, *ptr;
> 
> Please don't use a pointer for that guest address, use gpa_t instead.
done
> 
>> +	size_t max_size, filled = 0;
>> +	int ret;
>> +
>> +	ptr = (u64 *)(BASER_ADDRESS(its->baser_coll_table));
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	max_size = GITS_BASER_NR_PAGES(its->baser_coll_table) * SZ_64K;
>> +
>> +	list_for_each_entry(collection, &its->collection_list, coll_list) {
>> +		if (filled == max_size)
>> +			return -ENOSPC;
>> +		ret = vgic_its_flush_cte(its, collection, ptr);
>> +		if (ret)
>> +			return ret;
>> +		ptr++;
>> +		filled += 8;
>> +	}
>> +
>> +	if (filled == max_size)
>> +		return 0;
>> +
>> +	/*
>> +	 * table is not fully filled, add a last dummy element
>> +	 * with valid bit unset
>> +	 */
>> +	val = 0;
>> +	ret = kvm_write_guest(its->dev->kvm, (gpa_t)ptr, &val, 8);
>> +	return ret;
>>  }
>>  
>>  /**
>> @@ -1777,7 +1848,26 @@ static int vgic_its_flush_collection_table(struct vgic_its *its)
>>   */
>>  static int vgic_its_restore_collection_table(struct vgic_its *its)
>>  {
>> -	return -ENXIO;
>> +	size_t max_size, read = 0;
>> +	u64 *ptr;
> 
> Same comment as above, please use gpa_t.
done

Thanks

Eric
> 
> Cheers,
> Andre.
> 
>> +	int ret;
>> +
>> +	ptr = (u64 *)(BASER_ADDRESS(its->baser_coll_table));
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	max_size = GITS_BASER_NR_PAGES(its->baser_coll_table) * SZ_64K;
>> +
>> +	while (read < max_size) {
>> +		bool valid;
>> +
>> +		ret = vgic_its_restore_cte(its, ptr, &valid);
>> +		if (!valid || ret)
>> +			break;
>> +		ptr++;
>> +		read += 8;
>> +	}
>> +	return ret;
>>  }
>>  
>>  /**
>>
