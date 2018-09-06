From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 6 Sep 2018 12:09:42 +0100
Subject: [PATCH v2 02/40] iommu/sva: Bind process address spaces to devices
In-Reply-To: <471873d4-a1a6-1a3a-cf17-1e686b4ade96@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-3-jean-philippe.brucker@arm.com>
 <471873d4-a1a6-1a3a-cf17-1e686b4ade96@redhat.com>
Message-ID: <fbe7615d-2236-8080-c54f-f53da8118f93@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2018 12:29, Auger Eric wrote:
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @pasid: valid address where the PASID will be stored
>> + * @flags: bond properties
>> + * @drvdata: private data passed to the mm exit handler
>> + *
>> + * Create a bond between device and task, allowing the device to access the mm
>> + * using the returned PASID. If unbind() isn't called first, a subsequent bind()
>> + * for the same device and mm fails with -EEXIST.
>> + *
>> + * iommu_sva_device_init() must be called first, to initialize the required SVA
>> + * features. @flags is a subset of these features.
> @flags must be a subset of these features?

Ok

> don't you want to check flags is a subset of
> dev->iommu_param->sva_param->features?

Yes, that will be in next version

>> +/**
>> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
>> + * @dev: the device
>> + * @pasid: the pasid returned by bind()
>> + *
>> + * Remove bond between device and address space identified by @pasid. Users
>> + * should not call unbind() if the corresponding mm exited (as the PASID might
>> + * have been reallocated for another process).
>> + *
>> + * The device must not be issuing any more transaction for this PASID. All
>> + * outstanding page requests for this PASID must have been flushed to the IOMMU.
>> + *
>> + * Returns 0 on success, or an error value
>> + */
>> +int iommu_sva_unbind_device(struct device *dev, int pasid)
> returned value needed?

I'd rather keep this one, since it already pointed out some of my bugs
during regression testing.

Thanks,
Jean
