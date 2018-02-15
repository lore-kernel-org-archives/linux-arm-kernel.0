From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 15 Feb 2018 13:49:41 +0000
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <20180213231821.5863ef99@jacob-builder>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <20180213231821.5863ef99@jacob-builder>
Message-ID: <2be857f1-cde2-a448-2bca-045f068396e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/18 07:18, Jacob Pan wrote:
[...]
>> +/* Used to store incomplete fault groups */
>> +static LIST_HEAD(iommu_partial_faults);
>> +static DEFINE_SPINLOCK(iommu_partial_faults_lock);
>> +
> should partial fault list be per iommu?

That would be good, but I don't see an easy way to retrieve the iommu
instance in report_device_fault(). Maybe the driver should pass it to
report_device_fault(), and we can then store partial faults in struct
iommu_device.

[...]
>> +/**
>> + * iommu_report_device_fault() - Handle fault in device driver or mm
>> + *
>> + * If the device driver expressed interest in handling fault, report
>> it through
>> + * the callback. If the fault is recoverable, try to page in the
>> address.
>> + */
>> +int iommu_report_device_fault(struct device *dev, struct
>> iommu_fault_event *evt) +{
>> +	int ret = -ENOSYS;
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * if upper layers showed interest and installed a fault
>> handler,
>> +	 * invoke it.
>> +	 */
>> +	if (iommu_has_device_fault_handler(dev)) {
> I think Alex pointed out this is racy, so adding a mutex to the
> iommu_fault_param and acquire it would help. Do we really
> atomic handler?

Yes I think a few IOMMU drivers will call this function from IRQ context,
so a spinlock might be better for acquiring iommu_fault_param.

>> +		struct iommu_fault_param *param =
>> dev->iommu_param->fault_param; +
>> +		return param->handler(evt, param->data);
> Even upper layer (VFIO) registered handler to propagate PRQ to a guest
> to fault in the pages, we may still need to keep track of the page
> requests that need page response later, i.e. last page in group or
> stream request in vt-d. This will allow us sanitize the page response
> come back from the guest/VFIO.
> In my next round, I am adding a per device list under iommu_fault_param
> for pending page request. This will also address the situation where
> guest failed to send response. We can enforce time or credit limit of
> pending requests based on this list.

Sounds good

Thanks,
Jean
