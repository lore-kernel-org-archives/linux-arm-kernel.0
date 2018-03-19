From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 19 Mar 2018 19:03:41 +0800
Subject: [PATCH 27/37] iommu/arm-smmu-v3: Register fault workqueue
In-Reply-To: <1519280641-30258-27-git-send-email-xieyisheng1@huawei.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-27-git-send-email-xieyisheng1@huawei.com>
Message-ID: <f2841aac-4c5e-4ac2-fa4d-81d6b2857503@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

[...]
> @@ -3168,6 +3260,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
> +		smmu->faultq_nb.notifier_call = arm_smmu_flush_queues;
> +		ret = iommu_fault_queue_register(&smmu->faultq_nb);
> +		if (ret)
> +			return ret;

I find a case here: CONFIG_IOMMU_FAULT=n, and smmu support feature STALLS or PRI,
the device probe will failed here, is this what we want?

Thanks
Yisheng

> +	}
> +
>  	/* And we're up. Go go go! */
>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>  				     "smmu3.%pa", &ioaddr);
