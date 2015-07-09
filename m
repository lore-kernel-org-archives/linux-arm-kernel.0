From: thunder.leizhen@huawei.com (leizhen)
Date: Thu, 9 Jul 2015 09:30:44 +0800
Subject: [PATCH v2 5/9] iommu/arm-smmu: skip the execution of
 CMD_PREFETCH_CONFIG
In-Reply-To: <20150708171107.GC6348@arm.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
 <1436239822-14132-6-git-send-email-thunder.leizhen@huawei.com>
 <559D1F91.6000508@arm.com> <20150708171107.GC6348@arm.com>
Message-ID: <559DCEC4.7030104@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/7/9 1:11, Will Deacon wrote:
> Hi Robin,
> 
> FWIW, I already queued this ;)
> 
> On Wed, Jul 08, 2015 at 02:03:13PM +0100, Robin Murphy wrote:
>> On 07/07/15 04:30, Zhen Lei wrote:
>>> Hisilicon SMMUv3 devices treat CMD_PREFETCH_CONFIG as a illegal command,
>>> execute it will trigger GERROR interrupt. Although the gerror code manage
>>> to turn the prefetch into a SYNC, and the system can continue to run
>>> normally, but it's ugly to print error information.
>>
>> No mention of the DT binding change, and no corresponding documentation 
>> update either.
> 
> I've added that.

Thank you very much. You are a real gentleman.

> 
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>> [...]
>>> +static struct arm_smmu_option_prop arm_smmu_options[] = {
>>> +	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>>> +	{ 0, NULL},
>>> +};
>> [...]
>>> +static void parse_driver_options(struct arm_smmu_device *smmu)
>>> +{
>>> +	int i = 0;
>>> +
>>> +	do {
>>> +		if (of_property_read_bool(smmu->dev->of_node,
>>> +						arm_smmu_options[i].prop)) {
>>> +			smmu->options |= arm_smmu_options[i].opt;
>>> +			dev_notice(smmu->dev, "option %s\n",
>>> +				arm_smmu_options[i].prop);
>>> +		}
>>> +	} while (arm_smmu_options[++i].opt);
>>> +}
>>> +
>>
>> Nitpicking for sure, but I'm still waiting for a good excuse to rewrite 
>> this overcomplicated loop logic in the SMMUv2 driver - can't we just 
>> treat a static array as a static array and iterate over the thing in the 
>> obvious way?
>>
>> 	for (i = 0; i < ARRAY_SIZE(arm_smmu_options); i++)
> 
> I'd rather have consistency with the other driver and I really have no
> personal preference about how we iterate over an array. If you have a
> technical reason to change both the drivers, please send a patch.
> 
> Will
> 
> .
> 
