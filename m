From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 21 Feb 2018 10:28:04 +0000
Subject: [PATCH 09/37] iommu/fault: Let handler return a fault response
In-Reply-To: <20180220151933.022f1036@jacob-builder>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-10-jean-philippe.brucker@arm.com>
 <20180220151933.022f1036@jacob-builder>
Message-ID: <11811f62-10d8-836c-f184-742d510bbdbc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/18 23:19, Jacob Pan wrote:
> On Mon, 12 Feb 2018 18:33:24 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>>  
>> +/**
>> + * enum page_response_code - Return status of fault handlers,
>> telling the IOMMU
>> + * driver how to proceed with the fault.
>> + *
>> + * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do
>> not send a
>> + *	reply to the device.
>> + * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the
>> next handler,
>> + *	or terminate.
>> + * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the page
>> tables
>> + *	populated, retry the access. This is "Success" in PCI PRI.
>> + * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
>> faults from
>> + *	this device if possible. This is "Response Failure" in PCI
>> PRI.
>> + * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't
>> retry the
>> + *	access. This is "Invalid Request" in PCI PRI.
>> + */
>> +enum page_response_code {
>> +	IOMMU_PAGE_RESP_HANDLED = 0,
>> +	IOMMU_PAGE_RESP_CONTINUE,
>> +	IOMMU_PAGE_RESP_SUCCESS,
>> +	IOMMU_PAGE_RESP_INVALID,
>> +	IOMMU_PAGE_RESP_FAILURE,
>> +};
> it seems to me two things are mixed here:
> 1. driver handler response status (HANDLED, CONTINUE)
> 2. PCI standard page response code (the rest)
> Can we leave them separate? then we don't have to convert this enum
> to/from PCI ATS page response code.

Except when the producer is a platform device instead of PCI :) But I get
your point. I liked combining them into one enum because it may simplify
some device drivers. I can separate HANDLED/CONTINUE and have drivers
always call page_response().

Thanks,
Jean
