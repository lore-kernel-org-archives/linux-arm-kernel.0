From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 5 Mar 2018 16:44:48 -0500
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <20180212183352.22730-8-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
Message-ID: <b2a3d2a7-7042-aef3-0def-05e64e39d046@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static int iommu_queue_fault(struct iommu_domain *domain, struct device *dev,
> +			     struct iommu_fault_event *evt)
> +{
> +	struct iommu_fault_group *group;
> +	struct iommu_fault_context *fault, *next;
> +
> +	if (!iommu_fault_queue)
> +		return -ENOSYS;
> +
> +	if (!evt->last_req) {
> +		fault = kzalloc(sizeof(*fault), GFP_KERNEL);
> +		if (!fault)
> +			return -ENOMEM;
> +
> +		fault->evt = *evt;
> +		fault->dev = dev;
> +
> +		/* Non-last request of a group. Postpone until the last one */
> +		spin_lock(&iommu_partial_faults_lock);
> +		list_add_tail(&fault->head, &iommu_partial_faults);
> +		spin_unlock(&iommu_partial_faults_lock);
> +
> +		return IOMMU_PAGE_RESP_HANDLED;
> +	}
> +
> +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> +	if (!group)
> +		return -ENOMEM;

Release the requests in iommu_partial_faults here.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
