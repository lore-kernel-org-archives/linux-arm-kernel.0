From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Jan 2016 11:22:19 +0000
Subject: [PATCH v2 3/3] iommu/io-pgtable: Avoid redundant TLB syncs
In-Reply-To: <56963297.7090605@arm.com>
References: <cover.1450383740.git.robin.murphy@arm.com>
 <eb7458ed51b800f035976e879530ab1e90d02858.1450383740.git.robin.murphy@arm.com>
 <20160112182754.GC22186@arm.com> <56963297.7090605@arm.com>
Message-ID: <5696336B.6080003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/16 11:18, Robin Murphy wrote:
> On 12/01/16 18:27, Will Deacon wrote:
>> On Thu, Dec 17, 2015 at 08:50:59PM +0000, Robin Murphy wrote:
>>> In certain unmapping situations it is quite possible to end up issuing
>>> back-to-back TLB synchronisations, which at best is a waste of time and
>>> effort, and at worst causes some hardware to get rather confused. Whilst
>>> the pagetable implementations, or the IOMMU drivers, or both, could keep
>>> track of things to avoid this happening, it seems to make the most sense
>>> to prevent code duplication and add some simple state tracking in the
>>> common interface between the two.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/io-pgtable.h | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
>>> index 95c5565..d06219b 100644
>>> --- a/drivers/iommu/io-pgtable.h
>>> +++ b/drivers/iommu/io-pgtable.h
>>> @@ -132,12 +132,14 @@ void free_io_pgtable_ops(struct io_pgtable_ops
>>> *ops);
>>>    * @fmt:    The page table format.
>>>    * @cookie: An opaque token provided by the IOMMU driver and passed
>>> back to
>>>    *          any callback routines.
>>> + * @sync_flag: Private flag for optimising out redundant syncs.
>>
>> It makes sense to factor this out like you're proposing, but maybe we
>> can think of a better name? How about "tlb_sync_pending", to follow
>> "tlb_flush_pending" in the core code?
>
> Ooh, tlb_flush_pending is a much nicer name indeed. It's almost as if I

Or tlb_sync_pending, even. Bah, mornings...

> threw this together in a pre-holiday rush and put very little thought
> into it...
>
> I've fixed it up locally, but I'll save the repost until after -rc1,
> especially in case Yong has any further comments in the meantime.
>
> Thanks,
> Robin.
>
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
