From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 12 Mar 2015 08:40:20 +0800
Subject: [PATCH] soc/tegra: move soc_device_register call out of arch/arm
In-Reply-To: <20150311083424.GA19391@ulmo.nvidia.com>
References: <1425868301-22767-1-git-send-email-josephl@nvidia.com>
 <20150311083424.GA19391@ulmo.nvidia.com>
Message-ID: <5500E074.8050007@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 04:34 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Mon, Mar 09, 2015 at 10:31:41AM +0800, Joseph Lo wrote:
>> Expending the usage for both Tegra & Tegra64 SoCs.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   arch/arm/mach-tegra/tegra.c | 31 +------------------------------
>>   drivers/soc/tegra/common.c  | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>> index 914341bcef25..95df6a97b956 100644
>> --- a/arch/arm/mach-tegra/tegra.c
>> +++ b/arch/arm/mach-tegra/tegra.c
>> @@ -87,36 +87,7 @@ static void __init tegra_dt_init_irq(void)
>>
>>   static void __init tegra_dt_init(void)
>>   {
>> -	struct soc_device_attribute *soc_dev_attr;
>> -	struct soc_device *soc_dev;
>> -	struct device *parent = NULL;
>> -
>> -	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> -	if (!soc_dev_attr)
>> -		goto out;
>> -
>> -	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
>> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d",
>> -					   tegra_sku_info.revision);
>> -	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
>> -
>> -	soc_dev = soc_device_register(soc_dev_attr);
>> -	if (IS_ERR(soc_dev)) {
>> -		kfree(soc_dev_attr->family);
>> -		kfree(soc_dev_attr->revision);
>> -		kfree(soc_dev_attr->soc_id);
>> -		kfree(soc_dev_attr);
>> -		goto out;
>> -	}
>> -
>> -	parent = soc_device_to_device(soc_dev);
>> -
>> -	/*
>> -	 * Finished with the static registrations now; fill in the missing
>> -	 * devices
>> -	 */
>> -out:
>> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>
> One of the reasons for adding the soc_device in the first place was so
> that it would be possible to use it as the parent for all devices that
> are instantiated from device tree. You remove that here, and break the
> ABI in the process. Arguably no userspace should be relying on the exact
> path in sysfs, but I'd still like to keep the top-level parent.
>
That would be a problem if you want to keep the same "ABI" in ARM64 kernel.

> Which reminds me of a discussion a while back about introducing a top-
> level driver for the SoC. I'm not sure if anything came of that.
>
> Stephen, do you know if there was a conclusion on that discussion? As
> far as I remember this sparked around the time when we moved drivers to
> drivers/soc and started splitting things up into initcalls. I'm thinking
> that if nothing like that was created yet, perhaps soc_device and
> soc_bus_type would be good candidates to implement this on top of.
>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
>
