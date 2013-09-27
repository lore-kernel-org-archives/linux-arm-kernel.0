From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 10:51:57 +0100
Subject: [PATCH 2/9] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu
 register values
In-Reply-To: <1380234982-1677-3-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-3-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20130927095157.GA9057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Thu, Sep 26, 2013 at 11:36:14PM +0100, Andreas Herrmann wrote:
> Currently it is derived from smmu resource size.  In case of a
> mismatchin between the two calculations trust DT more than register
> values and overwrite cb_base.

I thought the driver already favoured the DT?

> @@ -1702,12 +1704,23 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  
>  	/* Check that we ioremapped enough */
>  	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
> -	size *= (smmu->pagesize << 1);
> +	size *= smmu->pagesize;
> +	smmu->cb_base = smmu->base + size;
> +	size *= 2;
> +
>  	if (smmu->size < size)
>  		dev_warn(smmu->dev,
>  			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
>  			 size, smmu->size);
>  
> +	t = (unsigned long) smmu->base + (smmu->size >> 1);
> +	if ((unsigned long)smmu->cb_base != t) {
> +		dev_warn(smmu->dev, "address space mismatch, "
> +			"overwriting cb_base (old: 0x%lx, new: 0x%lx)\n",
> +			(unsigned long) smmu->cb_base, t);
> +		smmu->cb_base = (void *) t;
> +	}
> +

I expect I'm just being slow here (only one coffee in), but I can't see what
this gets us over the current use of resource_size (which goes and uses the
DT).

Will
