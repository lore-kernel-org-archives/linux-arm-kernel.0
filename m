From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 15 Feb 2018 13:51:34 +0000
Subject: [PATCH 08/37] iommu/fault: Handle mm faults
In-Reply-To: <20180214104621.7675579c@jacob-builder>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-9-jean-philippe.brucker@arm.com>
 <20180214104621.7675579c@jacob-builder>
Message-ID: <800c2efe-10d7-5711-37d6-fb45df9b6e5c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/18 18:46, Jacob Pan wrote:
> On Mon, 12 Feb 2018 18:33:23 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
[...]
>> +	if (!evt->pasid_valid)
>> +		return ret;
> I guess for not we don't handle PRQ without PASID, right?

No. I'm not sure how to implement it, though there have been some requests
(see discussion on 1/37)

>> +	/*
>> +	 * Special case: PASID Stop Marker (LRW = 0b100) doesn't
>> expect a
>> +	 * response. A Stop Marker may be generated when disabling a
>> PASID
>> +	 * (issuing a PASID stop request) in some PCI devices.
>> +	 *
>> +	 * When the mm_exit() callback returns from the device
>> driver, no page
>> +	 * request is generated for this PASID anymore and
>> outstanding ones have
>> +	 * been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
>> and 10.4.1.2 -
>> +	 * Managing PASID TLP Prefix Usage). Some PCI devices will
>> wait for all
>> +	 * outstanding page requests to come back with a response
>> before
>> +	 * completing the PASID stop request. Others do not wait for
>> page
>> +	 * responses, and instead issue this Stop Marker that tells
>> us when the
>> +	 * PASID can be reallocated.
>> +	 *
>> +	 * We ignore the Stop Marker because:
>> +	 * a. Page requests, which are posted requests, have been
>> flushed to the
>> +	 *    IOMMU when mm_exit() returns,
>> +	 * b. We flush all fault queues after mm_exit() returns and
>> before
>> +	 *    freeing the PASID.
>> +	 *
>> +	 * So even though the Stop Marker might be issued by the
>> device *after*
>> +	 * the stop request completes, outstanding faults will have
>> been dealt
>> +	 * with by the time we free the PASID.
>> +	 */
>> +	if (evt->last_req &&
>> +	    !(evt->prot & (IOMMU_FAULT_READ | IOMMU_FAULT_WRITE)))
>> +		return IOMMU_PAGE_RESP_HANDLED;
>> +
> If we don't expect a page response, shouldn't it be filtered by the
> IOMMU vendor driver in the first place? i.e. in the vendor IOMMU driver
> PRQ handler, it will sanitize the request anyway, for anything that
> does not need response, it will not call iommu_report_device_fault().

Right, we're not doing anything with the stop marker anyway. This encoding
is also specific to PCI PRI, and maybe in future architectures, LRW =
0b100 will mean something else and will require a response. So filtering
it in the IOMMU driver makes more sense.

Thanks,
Jean
