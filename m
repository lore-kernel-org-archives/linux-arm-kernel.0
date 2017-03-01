From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 1 Mar 2017 14:24:00 -0500
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Message-ID: <5a7822f2-3991-aa51-169f-78ef49567feb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
> /* Initialise command lazily */
> +		if (!cmd.opcode)
> +			arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
> +
> +		spin_lock(&smmu_group->devices_lock);
> +
> +		list_for_each_entry(master, &smmu_group->devices, group_head)
> +			arm_smmu_atc_invalidate_master(master, &cmd);
> +
> +		/*
> +		 * TODO: ensure we do a sync whenever we have sent ats_queue_depth
> +		 * invalidations to the same device.
> +		 */
> +		arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
> +

It is possible to observe ATS invalidation timeout up to 90 seconds according to PCIe
spec. How does the current code deal with this?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
