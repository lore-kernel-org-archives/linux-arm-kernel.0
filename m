From: zhengqiang10@huawei.com (Zhengqiang)
Date: Fri, 18 May 2018 15:13:40 +0800
Subject: [PATCH] ghes_edac: enable HIP08 platform edac driver
In-Reply-To: <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
 <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
 <20180516182958.GB17092@pd.tnic>
 <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
Message-ID: <5AFE7D24.3090408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/5/18 2:02, James Morse wrote:
> Hi guys,
> 
> Tyler, Zhengqiang, I assume all your shipped platforms with HEST->GHES entries
> also have DMI tables.
> 

Sure, Our ARM64 platform have DMI tables. thanks.

> 
> On 16/05/18 19:29, Borislav Petkov wrote:
>> On Wed, May 16, 2018 at 02:38:38PM +0100, James Morse wrote:
>>> XGene has its own edac driver, but it doesn't probe when booted via ACPI so
>>> won't conflict with ghes_edac.
>>
>> Actually it will. EDAC core can have only one EDAC driver loaded. Don't
>> ask me why - it has been that way since forever.
> 
> By won't probe I mean it only works on DT systems:
> 
> | static const struct of_device_id xgene_edac_of_match[] = {
> |	{ .compatible = "apm,xgene-edac" },
> |	{},
> | };
> 
> |	.driver = {
> |		.name = "xgene-edac",
> |		.of_match_table = xgene_edac_of_match,
> |	},
> 
> To work on a system with GHES it would need an 'struct acpi_device_id' to
> describe the HID (?) and populate driver's acpi_match_table.
> 
> 
>> We can change it some
>> day but frankly, I don't see reasoning for it. One driver can easily
>> manage *all* error sources on a system, I'd say.
> 
> I agree, there is no reason to support two at the same time, if this happens
> then there is probably something wrong with the platform (e.g. races with
> firmware reading the same hardware registers), so we should make some noise.
> 
> Xgene's edac driver would be a good example of this, it looks like it reads data
> from some mmio region, if something else is doing the same we're going to make a
> mess.
> 
> 
>>> So I think we're good to make the whitelist x86 only.
>>> Your diff-hunk makes 'idx=-1', so we always get the 'Unfortunately' warning. I'd
>>> like to suppress this unless force_load has been used.
>>
>> Yeah, we should handle that differently for ARM. Toshi added the idx
>> thing in
>>
>>   5deed6b6a479 ("EDAC, ghes: Add platform check")
>>
>> to dump this when the platform is not whitelisted. So let's do that:
>>
>> ---
>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>> index 863fbf3db29f..473aeec4b1da 100644
>> --- a/drivers/edac/ghes_edac.c
>> +++ b/drivers/edac/ghes_edac.c
>> @@ -440,12 +440,16 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>>  	struct mem_ctl_info *mci;
>>  	struct edac_mc_layer layers[1];
>>  	struct ghes_edac_dimm_fill dimm_fill;
>> -	int idx;
>> +	int idx = -1;
>>  
>> -	/* Check if safe to enable on this system */
>> -	idx = acpi_match_platform_list(plat_list);
>> -	if (!force_load && idx < 0)
>> -		return -ENODEV;
> 
> v4.17-rc5 has 'return 0' here. Wouldn't this change means no ghes can be
> registered unless ghes_edac is also supported by the platform?
> Shouldn't this be '0' for a silent failure?
> 
> 
>> +	if (IS_ENABLED(CONFIG_X86)) {
>> +		/* Check if safe to enable on this system */
>> +		idx = acpi_match_platform_list(plat_list);
>> +		if (!force_load && idx < 0)
>> +			return -ENODEV;
>> +	} else {
>> +		idx = 0;
>> +	}
>>  
>>  	/*
>>  	 * We have only one logical memory controller to which all DIMMs belong.
> 
> Tested on Seattle and some cranky homebrew-no-DMI firmware:
> Tested-by: James Morse <james.morse@arm.com>
> 
> With the ENODEV/0 thing above:
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
>>> It looks like even the oldest Arm64 ACPI systems have dmi tables, so we can
>>> probably require DMI or the 'force' flag.
>>
>> Well, with the hunk above it would still do ghes_edac_count_dimms() on
>> ARM and if it fails to find something, it will set fake, which is a good
>> sanity-check as it screams loudly. :)
> 
> 
> Thanks,
> 
> James
> 
> .
> 
