From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 12 Jan 2018 10:34:24 -0800
Subject: [PATCH] soc: brcmstb: Only register SoC device on STB platforms
In-Reply-To: <973b2445-48ca-87a9-b4c2-21d8bfec76dd@arm.com>
References: <20180109145409.11612-1-thierry.reding@gmail.com>
 <cc470686-374e-0c71-d797-62cffd76bb82@arm.com>
 <973b2445-48ca-87a9-b4c2-21d8bfec76dd@arm.com>
Message-ID: <89ce7223-8ae5-061b-911c-d10f12b9517b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2018 04:12 AM, Sudeep Holla wrote:
> 
> 
> On 12/01/18 11:39, Sudeep Holla wrote:
>>
>>
>> On 09/01/18 14:54, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> After moving the SoC device initialization to an early initcall in
>>> commit f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall"),
>>> the Broadcom STB SoC device is registered on all platforms if support
>>> for the device is enabled in the kernel configuration.
>>>
>>> This causes an additional SoC device to appear on platforms that already
>>> register a native one. In case of Tegra the STB SoC device is registered
>>> as soc0 (with totally meaningless content in the sysfs attributes) and
>>> causes various scripts and programs to fail because they don't know how
>>> to parse that data.
>>>
>>> To fix this, duplicate the check from brcmstb_soc_device_early_init()
>>> that already prevents the code from doing anything nonsensical on non-
>>> STB platforms.
>>>
>>> Fixes: f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall")
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  drivers/soc/bcm/brcmstb/common.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
>>> index 781ada62d0a3..4fe1cb73b39a 100644
>>> --- a/drivers/soc/bcm/brcmstb/common.c
>>> +++ b/drivers/soc/bcm/brcmstb/common.c
>>> @@ -89,8 +89,13 @@ early_initcall(brcmstb_soc_device_early_init);
>>>  static int __init brcmstb_soc_device_init(void)
>>>  {
>>>  	struct soc_device_attribute *soc_dev_attr;
>>> +	struct device_node *sun_top_ctrl;
>>>  	struct soc_device *soc_dev;
>>>  
>>> +	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
>>> +	if (!sun_top_ctrl)
>>> +		return -ENODEV;
>>> +
>>
>> missing of_node_put(sun_top_ctrl) ? or am I missing to see that elsewhere ?
>>
> 
> Further, I still the error messags on my Juno with this patch applied. I
> fail to see how this patch prevents brcmstb_biuctrl_init which is
> early_initcall in drivers/soc/bcm/brcmstb/biuctrl.c getting called ?

I read your patch too quickly, yours is needed, and so is Thierry's, I
will send an incremental fix to Olof shortly, sorry about the mess.
-- 
Florian
