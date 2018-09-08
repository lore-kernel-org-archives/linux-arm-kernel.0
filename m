From: christian.koenig@amd.com (=?UTF-8?Q?Christian_K=c3=b6nig?=)
Date: Sat, 8 Sep 2018 09:29:13 +0200
Subject: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <20180907142504.5034351e@jacob-builder>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
 <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
 <2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
 <65e7accd-4446-19f5-c667-c6407e89cfa6@arm.com>
 <5bbc0332-b94b-75cc-ca42-a9b196811daf@amd.com>
 <20180907142504.5034351e@jacob-builder>
Message-ID: <3e3a6797-a233-911b-3a7d-d9b549160960@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.09.2018 um 23:25 schrieb Jacob Pan:
> On Fri, 7 Sep 2018 20:02:54 +0200
> Christian K?nig <christian.koenig@amd.com> wrote:
>> [SNIP]
>>> iommu-sva expects everywhere that the device has an iommu_domain,
>>> it's the first thing we check on entry. Bypassing all of this would
>>> call idr_alloc() directly, and wouldn't have any code in common
>>> with the current iommu-sva. So it seems like you need a layer on
>>> top of iommu-sva calling idr_alloc() when an IOMMU isn't present,
>>> but I don't think it should be in drivers/iommu/
>> In this case I question if the PASID handling should be under
>> drivers/iommu at all.
>>
>> See I can have a mix of VM context which are bound to processes (some
>> few) and VM contexts which are standalone and doesn't care for a
>> process address space. But for each VM context I need a distinct
>> PASID for the hardware to work.
>>
>> I can live if we say if IOMMU is completely disabled we use a simple
>> ida to allocate them, but when IOMMU is enabled I certainly need a
>> way to reserve a PASID without an associated process.
>>
> VT-d would also have such requirement. There is a virtual command
> register for allocate and free PASID for VM use. When that PASID
> allocation request gets propagated to the host IOMMU driver, we need to
> allocate PASID w/o mm.
>
> If the PASID allocation is done via VFIO, can we have FD to track PASID
> life cycle instead of mm_exit()? i.e. all FDs get closed before
> mm_exit, I assume?

Yes, exactly. I just need a PASID which is never used by the OS for a 
process and we can easily give that back when the last FD reference is 
closed.

>>>> 3. Even after destruction of a process address space we need some
>>>> grace period before a PASID is reused because it can be that the
>>>> specific PASID is still in some hardware queues etc...
>>>>    ??? ??? At bare minimum all device drivers using process binding
>>>> need to explicitly note to the core when they are done with a
>>>> PASID.
>>> Right, much of the horribleness in iommu-sva deals with this:
>>>
>>> The process dies, iommu-sva is notified and calls the mm_exit()
>>> function passed by the device driver to iommu_sva_device_init(). In
>>> mm_exit() the device driver needs to clear any reference to the
>>> PASID in hardware and in its own structures. When the device driver
>>> returns from mm_exit(), it effectively tells the core that it has
>>> finished using the PASID, and iommu-sva can reuse the PASID for
>>> another process. mm_exit() is allowed to block, so the device
>>> driver has time to clean up and flush the queues.
>>>
>>> If the device driver finishes using the PASID before the process
>>> exits, it just calls unbind().
>> Exactly that's what Michal Hocko is probably going to not like at all.
>>
>> Can we have a different approach where each driver is informed by the
>> mm_exit(), but needs to explicitly call unbind() before a PASID is
>> reused?
>>
>> During that teardown transition it would be ideal if that PASID only
>> points to a dummy root page directory with only invalid entries.
>>
> I guess this can be vendor specific, In VT-d I plan to mark PASID
> entry not present and disable fault reporting while draining remaining
> activities.

Sounds good to me.

Point is at least in the case where the process was killed by the OOM 
killer we should not block in mm_exit().

Instead operations issued by the process to a device driver which uses 
SVA needs to be terminated as soon as possible to make sure that the OOM 
killer can advance.

Thanks,
Christian.
