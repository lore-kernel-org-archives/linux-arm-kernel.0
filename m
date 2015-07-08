From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 08 Jul 2015 14:03:13 +0100
Subject: [PATCH v2 5/9] iommu/arm-smmu: skip the execution of
 CMD_PREFETCH_CONFIG
In-Reply-To: <1436239822-14132-6-git-send-email-thunder.leizhen@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
 <1436239822-14132-6-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <559D1F91.6000508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the respin. I still have a few comments on the series, 
starting here;

On 07/07/15 04:30, Zhen Lei wrote:
> Hisilicon SMMUv3 devices treat CMD_PREFETCH_CONFIG as a illegal command,
> execute it will trigger GERROR interrupt. Although the gerror code manage
> to turn the prefetch into a SYNC, and the system can continue to run
> normally, but it's ugly to print error information.

No mention of the DT binding change, and no corresponding documentation 
update either.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
[...]
> +static struct arm_smmu_option_prop arm_smmu_options[] = {
> +	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> +	{ 0, NULL},
> +};
[...]
> +static void parse_driver_options(struct arm_smmu_device *smmu)
> +{
> +	int i = 0;
> +
> +	do {
> +		if (of_property_read_bool(smmu->dev->of_node,
> +						arm_smmu_options[i].prop)) {
> +			smmu->options |= arm_smmu_options[i].opt;
> +			dev_notice(smmu->dev, "option %s\n",
> +				arm_smmu_options[i].prop);
> +		}
> +	} while (arm_smmu_options[++i].opt);
> +}
> +

Nitpicking for sure, but I'm still waiting for a good excuse to rewrite 
this overcomplicated loop logic in the SMMUv2 driver - can't we just 
treat a static array as a static array and iterate over the thing in the 
obvious way?

	for (i = 0; i < ARRAY_SIZE(arm_smmu_options); i++)

Robin.
