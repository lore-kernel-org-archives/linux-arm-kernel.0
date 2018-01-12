From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Jan 2018 10:19:38 -0800
Subject: [PATCH] soc: brcmstb: Only register SoC device on STB platforms
In-Reply-To: <419d5b97-9d8e-dcbe-3984-006f1e261161@arm.com>
References: <20180109145409.11612-1-thierry.reding@gmail.com>
 <cc470686-374e-0c71-d797-62cffd76bb82@arm.com>
 <973b2445-48ca-87a9-b4c2-21d8bfec76dd@arm.com>
 <20180112125828.GB19999@ulmo> <419d5b97-9d8e-dcbe-3984-006f1e261161@arm.com>
Message-ID: <CAOesGMgtUcWhn+PqCnCKBmSm-tihP31GmfFHO7+hL9HWkwk2JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 7:27 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 12/01/18 12:58, Thierry Reding wrote:
>> On Fri, Jan 12, 2018 at 12:12:11PM +0000, Sudeep Holla wrote:
>>>
>>>
>>> On 12/01/18 11:39, Sudeep Holla wrote:
>>>>
>>>>
>>>> On 09/01/18 14:54, Thierry Reding wrote:
>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>
>>>>> After moving the SoC device initialization to an early initcall in
>>>>> commit f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall"),
>>>>> the Broadcom STB SoC device is registered on all platforms if support
>>>>> for the device is enabled in the kernel configuration.
>>>>>
>>>>> This causes an additional SoC device to appear on platforms that already
>>>>> register a native one. In case of Tegra the STB SoC device is registered
>>>>> as soc0 (with totally meaningless content in the sysfs attributes) and
>>>>> causes various scripts and programs to fail because they don't know how
>>>>> to parse that data.
>>>>>
>>>>> To fix this, duplicate the check from brcmstb_soc_device_early_init()
>>>>> that already prevents the code from doing anything nonsensical on non-
>>>>> STB platforms.
>>>>>
>>>>> Fixes: f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall")
>>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>>> ---
>>>>>  drivers/soc/bcm/brcmstb/common.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
>>>>> index 781ada62d0a3..4fe1cb73b39a 100644
>>>>> --- a/drivers/soc/bcm/brcmstb/common.c
>>>>> +++ b/drivers/soc/bcm/brcmstb/common.c
>>>>> @@ -89,8 +89,13 @@ early_initcall(brcmstb_soc_device_early_init);
>>>>>  static int __init brcmstb_soc_device_init(void)
>>>>>  {
>>>>>    struct soc_device_attribute *soc_dev_attr;
>>>>> +  struct device_node *sun_top_ctrl;
>>>>>    struct soc_device *soc_dev;
>>>>>
>>>>> +  sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
>>>>> +  if (!sun_top_ctrl)
>>>>> +          return -ENODEV;
>>>>> +
>>>>
>>>> missing of_node_put(sun_top_ctrl) ? or am I missing to see that elsewhere ?
>>>>
>>>
>>> Further, I still the error messags on my Juno with this patch applied. I
>>> fail to see how this patch prevents brcmstb_biuctrl_init which is
>>> early_initcall in drivers/soc/bcm/brcmstb/biuctrl.c getting called ?
>>
>> I'm not sure I understand. There's no way we can prevent the early
>> initcall from running. The point here is to prevent it from running code
>> that shouldn't be run on a platform.
>>
>
> Sorry for missing the context, I was referring [1]
>
> --
> Regards,
> Sudeep
>
> [1] [1] https://marc.info/?l=linux-kernel&m=151568158127806&w=2


Do we have an incremental patch coming, or should I revert this?


-Olof
