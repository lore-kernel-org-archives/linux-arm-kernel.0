From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 14 Mar 2018 13:08:07 +0000
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <20180308164035.000065c2@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <20180308164035.000065c2@huawei.com>
Message-ID: <d855e893-0f3d-3106-eb75-ce01ad9ce663@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

Thanks for reviewing

On 08/03/18 15:40, Jonathan Cameron wrote:
>> +/**
>> + * iommu_fault_queue_unregister() - Unregister an IOMMU driver from the fault
>> + * queue.
>> + * @flush_notifier: same parameter as iommu_fault_queue_register
>> + */
>> +void iommu_fault_queue_unregister(struct notifier_block *flush_notifier)
>> +{
>> +	down_write(&iommu_fault_queue_sem);
>> +	if (refcount_dec_and_test(&iommu_fault_queue_refs)) {
>> +		destroy_workqueue(iommu_fault_queue);
>> +		iommu_fault_queue = NULL;
>> +	}
>> +	up_write(&iommu_fault_queue_sem);
>> +
>> +	if (flush_notifier)
>> +		blocking_notifier_chain_unregister(&iommu_fault_queue_flush_notifiers,
>> +						   flush_notifier);
> I would expect the ordering in queue_unregister to be the reverse of queue
> register (to make it obvious there are no races).
> 
> That would put this last block at the start before potentially destroying
> the work queue.  If I'm missing something then perhaps a comment to
> explain why the ordering is not the obvious one?

Sure, I'll fix the order, I don't think there was any good reason for it

Thanks,
Jean
