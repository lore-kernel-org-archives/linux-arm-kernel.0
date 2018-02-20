From: jacob.jun.pan@linux.intel.com (Jacob Pan)
Date: Tue, 20 Feb 2018 15:19:33 -0800
Subject: [PATCH 09/37] iommu/fault: Let handler return a fault response
In-Reply-To: <20180212183352.22730-10-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-10-jean-philippe.brucker@arm.com>
Message-ID: <20180220151933.022f1036@jacob-builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Feb 2018 18:33:24 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

>  
> +/**
> + * enum page_response_code - Return status of fault handlers,
> telling the IOMMU
> + * driver how to proceed with the fault.
> + *
> + * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do
> not send a
> + *	reply to the device.
> + * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the
> next handler,
> + *	or terminate.
> + * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the page
> tables
> + *	populated, retry the access. This is "Success" in PCI PRI.
> + * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
> faults from
> + *	this device if possible. This is "Response Failure" in PCI
> PRI.
> + * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't
> retry the
> + *	access. This is "Invalid Request" in PCI PRI.
> + */
> +enum page_response_code {
> +	IOMMU_PAGE_RESP_HANDLED = 0,
> +	IOMMU_PAGE_RESP_CONTINUE,
> +	IOMMU_PAGE_RESP_SUCCESS,
> +	IOMMU_PAGE_RESP_INVALID,
> +	IOMMU_PAGE_RESP_FAILURE,
> +};
it seems to me two things are mixed here:
1. driver handler response status (HANDLED, CONTINUE)
2. PCI standard page response code (the rest)
Can we leave them separate? then we don't have to convert this enum
to/from PCI ATS page response code.

> +
>  /**
>   * Generic page response information based on PCI ATS and PASID spec.
>   * @addr: servicing page address
> @@ -202,12 +225,7 @@ enum page_response_type {
>  struct page_response_msg {
>  	u64 addr;
>  	u32 pasid;
> -	u32 resp_code:4;
> -#define IOMMU_PAGE_RESP_SUCCESS	0
> -#define IOMMU_PAGE_RESP_INVALID	1
> -#define IOMMU_PAGE_RESP_HANDLED	2
> -#define IOMMU_PAGE_RESP_FAILURE	0xF
> -
[Jacob Pan]
