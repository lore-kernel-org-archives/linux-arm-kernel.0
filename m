From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 23 Aug 2016 15:47:02 +0100
Subject: [PATCH 04/13] scpi: Add legacy SCP functions calling
 legacy_scpi_send_message
In-Reply-To: <53093fb5-22e2-3c17-3345-50c7e9df7089@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-5-git-send-email-narmstrong@baylibre.com>
 <fe6919a2-a1dc-f056-9480-3248dc9315dc@arm.com>
 <53093fb5-22e2-3c17-3345-50c7e9df7089@baylibre.com>
Message-ID: <e31c0b43-a32f-bef9-c341-25783871f74f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/08/16 09:19, Neil Armstrong wrote:
> On 08/19/2016 06:22 PM, Sudeep Holla wrote:
>>
>>
>> On 18/08/16 11:10, Neil Armstrong wrote:
>>> In order to support legacy SCP functions from kernel-wide driver, add legacy
>>> functions using the legacy command enums and calling legacy_scpi_send_message.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/firmware/arm_scpi.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 118 insertions(+)
>>>
>>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>>> index 50b1297..bb9965f 100644
>>> --- a/drivers/firmware/arm_scpi.c
>>> +++ b/drivers/firmware/arm_scpi.c
>>> @@ -578,6 +578,8 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
>>>      return ret;
>>>  }
>>>
>>> +/* scpi_clk_get_range not available for legacy */
>>> +
>>>  static unsigned long scpi_clk_get_val(u16 clk_id)
>>>  {
>>>      int ret;
>>> @@ -589,6 +591,18 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
>>>      return ret ? ret : le32_to_cpu(clk.rate);
>>>  }
>>>
>>> +static unsigned long legacy_scpi_clk_get_val(u16 clk_id)
>>> +{
>>> +    int ret;
>>> +    struct clk_get_value clk;
>>> +    __le16 le_clk_id = cpu_to_le16(clk_id);
>>> +
>>> +    ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_GET_CLOCK_VALUE,
>>> +                       &le_clk_id, sizeof(le_clk_id),
>>> +                       &clk, sizeof(clk));
>>> +    return ret ? ret : le32_to_cpu(clk.rate);
>>> +}
>>> +
>>>  static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
>>>  {
>>>      int stat;
>>> @@ -601,6 +615,19 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
>>>                   &stat, sizeof(stat));
>>>  }
>>>
>>> +static int legacy_scpi_clk_set_val(u16 clk_id, unsigned long rate)
>>> +{
>>> +    int stat;
>>> +    struct legacy_clk_set_value clk = {
>>> +        .id = cpu_to_le16(clk_id),
>>> +        .rate = cpu_to_le32(rate)
>>> +    };
>>> +
>>> +    return legacy_scpi_send_message(LEGACY_SCPI_CMD_SET_CLOCK_VALUE,
>>> +                    &clk, sizeof(clk),
>>> +                    &stat, sizeof(stat));
>>
>> Except this one which has a different structure format, why do we need
>> to define legacy versions of other functions ? Can't we play with
>> function pointer or have a boolean in drvinfo structure and use then in
>> the existing functions as I had shown in one of the earlier emails.
>>
>
> The main problem is that the command indexes deviates starting at
> SCPI_CMD_SET_CSS_PWR_STATE, I'll be pleased to know how to implement it.
>

Yes, I was thinking of some kind of mapping to new index using an array.

-- 
Regards,
Sudeep
