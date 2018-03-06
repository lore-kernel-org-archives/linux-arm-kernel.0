From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 6 Mar 2018 10:24:29 +0000
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <b2a3d2a7-7042-aef3-0def-05e64e39d046@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <b2a3d2a7-7042-aef3-0def-05e64e39d046@codeaurora.org>
Message-ID: <4d3d9bbf-a1a7-82ff-9b8d-5634121d83ad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 21:44, Sinan Kaya wrote:
> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>> +static int iommu_queue_fault(struct iommu_domain *domain, struct device *dev,
>> +			     struct iommu_fault_event *evt)
>> +{
>> +	struct iommu_fault_group *group;
>> +	struct iommu_fault_context *fault, *next;
>> +
>> +	if (!iommu_fault_queue)
>> +		return -ENOSYS;
>> +
>> +	if (!evt->last_req) {
>> +		fault = kzalloc(sizeof(*fault), GFP_KERNEL);
>> +		if (!fault)
>> +			return -ENOMEM;
>> +
>> +		fault->evt = *evt;
>> +		fault->dev = dev;
>> +
>> +		/* Non-last request of a group. Postpone until the last one */
>> +		spin_lock(&iommu_partial_faults_lock);
>> +		list_add_tail(&fault->head, &iommu_partial_faults);
>> +		spin_unlock(&iommu_partial_faults_lock);
>> +
>> +		return IOMMU_PAGE_RESP_HANDLED;
>> +	}
>> +
>> +	group = kzalloc(sizeof(*group), GFP_KERNEL);
>> +	if (!group)
>> +		return -ENOMEM;
> 
> Release the requests in iommu_partial_faults here.

We move these requests to the group->faults list (which btw should use
list_move instead of the current list_del+list_add) and we release them in
iommu_fault_handle_group()

Thanks,
Jean
