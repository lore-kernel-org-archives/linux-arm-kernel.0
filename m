From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Feb 2017 17:42:18 +0000
Subject: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
In-Reply-To: <1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
 <1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170202174218.GO31394@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 02, 2017 at 10:40:18PM +0530, Sricharan R wrote:
> +- clock-names:    Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
> +                  required for smmu's register group access and interface
> +                  clk for the smmu's underlying bus access.
> +
> +- clocks:         Phandles for respective clocks described by clock-names.

Which SMMU implementations are those clock-names valid for?

The SMMU architecture specifications do not architect the clocks, which
are implemementation-specific.

AFAICT, this doesn't match MMU-400 or MMU-500.

> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
> +{
> +	const char *cname;
> +	struct property *prop;
> +	int i = 0;
> +	struct device *dev = smmu->dev;
> +
> +	smmu->num_clocks =
> +		of_property_count_strings(dev->of_node, "clock-names");
> +
> +	if (smmu->num_clocks < 1)
> +		return 0;
> +
> +	smmu->clocks = devm_kzalloc(dev,
> +				    sizeof(*smmu->clocks) * smmu->num_clocks,
> +				    GFP_KERNEL);
> +
> +	if (!smmu->clocks) {
> +		dev_err(dev, "Failed to allocate memory for clocks\n");
> +		return -ENODEV;
> +	}
> +
> +	of_property_for_each_string(dev->of_node, "clock-names", prop, cname) {
> +		struct clk *c = devm_clk_get(dev, cname);
> +
> +		if (IS_ERR(c)) {
> +			dev_err(dev, "Couldn't get clock: %s", cname);
> +			return -EPROBE_DEFER;
> +		}
> +
> +		smmu->clocks[i] = c;
> +		++i;
> +	}
> +
> +	return 0;
> +}

I am very much not a fan of grabbing hold of resources that don't
necessarily match the binding, and we likely don't understand the use
of.

Either we know the names, and can manage them, or we don't, and cannot.

Thanks,
Mark.
