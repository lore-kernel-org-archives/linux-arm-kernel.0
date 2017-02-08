From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 8 Feb 2017 16:23:17 +0530
Subject: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
In-Reply-To: <20170202174218.GO31394@leverpostej>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
 <1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
 <20170202174218.GO31394@leverpostej>
Message-ID: <017701d281f9$927c5fb0$b7751f10$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

>
>On Thu, Feb 02, 2017 at 10:40:18PM +0530, Sricharan R wrote:
>> +- clock-names:    Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
>> +                  required for smmu's register group access and interface
>> +                  clk for the smmu's underlying bus access.
>> +
>> +- clocks:         Phandles for respective clocks described by clock-names.
>
>Which SMMU implementations are those clock-names valid for?
>
>The SMMU architecture specifications do not architect the clocks, which
>are implemementation-specific.
>
>AFAICT, this doesn't match MMU-400 or MMU-500.

Ok, should be more specific. Infact QCOM has MMU-500 and also
a smmu v2 implementation which is fully compatible with
"arm,smmu-v2", with the clocks being controlled by the soc's
clock controller. i was trying to define these clock bindings
so that its works across socs. So there are one or more interface
clocks which are required for the smmu's interface or the configuration
access and one or more clocks required for smmu's downstream
bus access. That was the reason i was trying to iterate over the
list of clocks down below.  But agree that the bindings should define
each of the clocks required separately.

So one way here is, define a separate compatible for QCOM's SMMU
implementation and define all the clock bindings as a part of it
and handle it in the same way in the driver. But just thinking if
it would scale well for any other soc that is compatible with
arm,smmu-v2 driver and wants to handle clocks in the future ?
 
Regards,
 Sricharan


>
>> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
>> +{
>> +	const char *cname;
>> +	struct property *prop;
>> +	int i = 0;
>> +	struct device *dev = smmu->dev;
>> +
>> +	smmu->num_clocks =
>> +		of_property_count_strings(dev->of_node, "clock-names");
>> +
>> +	if (smmu->num_clocks < 1)
>> +		return 0;
>> +
>> +	smmu->clocks = devm_kzalloc(dev,
>> +				    sizeof(*smmu->clocks) * smmu->num_clocks,
>> +				    GFP_KERNEL);
>> +
>> +	if (!smmu->clocks) {
>> +		dev_err(dev, "Failed to allocate memory for clocks\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	of_property_for_each_string(dev->of_node, "clock-names", prop, cname) {
>> +		struct clk *c = devm_clk_get(dev, cname);
>> +
>> +		if (IS_ERR(c)) {
>> +			dev_err(dev, "Couldn't get clock: %s", cname);
>> +			return -EPROBE_DEFER;
>> +		}
>> +
>> +		smmu->clocks[i] = c;
>> +		++i;
>> +	}
>> +
>> +	return 0;
>> +}
>
>I am very much not a fan of grabbing hold of resources that don't
>necessarily match the binding, and we likely don't understand the use
>of.
>
>Either we know the names, and can manage them, or we don't, and cannot.
