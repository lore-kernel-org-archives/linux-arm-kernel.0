From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 16:55:37 +0200
Subject: [PATCH 07/13] scpi: ignore init_versions failure if reported not
 supported
In-Reply-To: <5e627a97-88f6-c7cf-1d64-6439cb708aff@arm.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-8-git-send-email-narmstrong@baylibre.com>
 <74d35f80-8499-cadf-798c-9b296218305c@arm.com>
 <86c4042a-a892-b5c4-cc75-c2139e80e226@baylibre.com>
 <5e627a97-88f6-c7cf-1d64-6439cb708aff@arm.com>
Message-ID: <895da5b6-baec-daf8-814b-76bd9ebcbbbc@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2016 04:54 PM, Sudeep Holla wrote:
> 
> 
> On 23/08/16 09:23, Neil Armstrong wrote:
>> On 08/19/2016 06:46 PM, Sudeep Holla wrote:
>>>
>>>
>>> On 18/08/16 11:11, Neil Armstrong wrote:
>>>> In Amlogic GXBB Legacy SCPI, the LEGACY_SCPI_CMD_SCPI_CAPABILITIES report
>>>> as SCPI_ERR_SUPPORT, so do not fail if this command is not supported.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>  drivers/firmware/arm_scpi.c | 12 +++++++-----
>>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>>>> index 3fe39fe..d3be4c5 100644
>>>> --- a/drivers/firmware/arm_scpi.c
>>>> +++ b/drivers/firmware/arm_scpi.c
>>>> @@ -1111,12 +1111,13 @@ err:
>>>>          ret = scpi_info->ops->init_versions(scpi_info);
>>>>      else
>>>>      ret = scpi_init_versions(scpi_info);
>>>> -    if (ret) {
>>>> +    if (ret && ret != -EOPNOTSUPP) {
>>>>          dev_err(dev, "incorrect or no SCP firmware found\n");
>>>>          scpi_remove(pdev);
>>>>          return ret;
>>>>      }
>>>>
>>>
>>> Why not deal it in init_versions itself.
>>>
>>>> +    if (ret != -EOPNOTSUPP) {
>>>>      _dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
>>>>            PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
>>>>            PROTOCOL_REV_MINOR(scpi_info->protocol_version),
>>>
>>> Why not have default value like 0.0 ? Just add a comment. Since get
>>> version is exported out, IMO having default value makes more sense. What
>>> do you think ?
>>>
>>>> @@ -1124,15 +1125,16 @@ err:
>>>>            FW_REV_MINOR(scpi_info->firmware_version),
>>>>            FW_REV_PATCH(scpi_info->firmware_version));
>>>>
>>>> +        ret = sysfs_create_groups(&dev->kobj, versions_groups);
>>>> +        if (ret)
>>>> +            dev_err(dev, "unable to create sysfs version group\n");
>>>> +    }
>>>> +
>>>
>>> Again this can stay as is if we have default.
>>>
>>
>> Printing version 0.0 firmware 0.0.0 is a nonsense for me...
>>
> 
> OK 0.0 was a wrong example. May be 0.1 ?
> 
> Since the driver has already exposed, hypothetically user-space can use
> that information, so IMO, we need to expose some static version for pre-v1.0
> 
> I am surprised that capability is not supported as this was present even
> in that legacy SCPI. Do you know what happens if you send that command ?
> Have you done some experiments on that ?
> 

I've experimented and returns EOPNOTSUPP, Amlogic confirmed to us the command was not implemented.

This a clearly a corner-case.

Neil
