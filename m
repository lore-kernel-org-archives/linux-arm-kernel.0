From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 24 May 2018 12:44:25 +0100
Subject: [PATCH v2 03/40] iommu/sva: Manage process address spaces
In-Reply-To: <20180522094334.71f0e36b@jacob-builder>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <20180516163117.622693ea@jacob-builder>
 <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
 <20180522094334.71f0e36b@jacob-builder>
Message-ID: <f73b4a0e-669e-8483-88d7-1b2c8a2b9934@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/18 17:43, Jacob Pan wrote:
> On Thu, 17 May 2018 11:02:42 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 17/05/18 00:31, Jacob Pan wrote:
>>> On Fri, 11 May 2018 20:06:04 +0100
>>> I am a little confused about domain vs. pasid relationship. If
>>> each domain represents a address space, should there be a domain for
>>> each pasid?  
>>
>> I don't think there is a formal definition, but from previous
>> discussion the consensus seems to be: domains are a collection of
>> devices that have the same virtual address spaces (one or many).
>>
>> Keeping that definition makes things easier, in my opinion. Some time
>> ago, I did try to represent PASIDs using "subdomains" (introducing a
>> hierarchy of struct iommu_domain), but it required invasive changes in
>> the IOMMU subsystem and probably all over the tree.
>>
>> You do need some kind of "root domain" for each device, so that
>> "iommu_get_domain_for_dev()" still makes sense. That root domain
>> doesn't have a single address space but a collection of subdomains.
>> If you need this anyway, representing a PASID with an iommu_domain
>> doesn't seem preferable than using a different structure (io_mm),
>> because they don't have anything in common.
>>
> My main concern is the PASID table storage. If PASID table storage
> is tied to domain, it is ok to scale up, i.e. multiple devices in a
> domain share a single PASID table. But to scale down, e.g. further
> partition device with VFIO mdev for assignment, each mdev may get its
> own domain via vfio. But there is no IOMMU storage for PASID table at
> mdev device level. Perhaps we do need root domain or some parent-child
> relationship to locate PASID table.

Interesting, I hadn't thought about this use-case before. At first I
thought you were talking about mdev devices assigned to VMs, but I think
you're referring to mdevs assigned to userspace drivers instead? Out of
curiosity, is it only theoretical or does someone actually need this?

I don't think mdev for VM assignment are compatible with PASID, at least
not when the IOMMU is involved. I usually ignore mdev in my reasoning
because, as far as I know, currently they only affect devices that have
their own MMU, and IOMMU domains don't come into play. However, if a
device was backed by the IOMMU, and the device driver wanted to
partition it into mdevs, then users would be tempted to assign mdev1 to
VM1 and mdev2 to VM2.

It doesn't work with PASID, because the PASID spaces of VM1 and VM2 will
conflict. If both VM1 and VM2 allocate PASID #1, then the host has to
somehow arbitrate device accesses, for example scheduling first mdev1
then mdev2. That's possible if the device driver is in charge of the
MMU, but not really compatible with the IOMMU.

So in the IOMMU subsystem, for assigning devices to VMs the only
model that makes sense is SR-IOV, where each VF/mdev has its own RID and
its own PASID table. In that case you'd get one IOMMU domain per VF.


But considering userspace drivers in the host alone, it might make sense
to partition a device into mdevs and assign them to multiple processes.
Interestingly this scheme still doesn't work with the classic MAP/UNMAP
ioctl: since there is a single device context entry for all mdevs, the
mediating driver would have to catch all MAP/UNMAP ioctls and reject
those with IOVAs that overlap those of another mdev. It's doesn't seem
viable. But when using PASID then each mdev has its own address space,
and since PASIDs are allocated by the kernel there is no such conflict.

Anyway, I think this use-case can work with the current structures, if
mediating driver does the bind() instead of VFIO. That's necessary
because you can't let userspace program the PASID into the device, or
they would be able to access address spaces owned by other mdevs. Then
the mediating driver does the bind(), and keeps internal structures to
associate the process to the given mdev.

Thanks,
Jean
