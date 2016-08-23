From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 23 Aug 2016 15:50:01 +0100
Subject: [PATCH 06/13] scpi: add priv_scpi_ops and fill legacy structure
In-Reply-To: <a0c9c4bc-cd83-c2e7-bfab-b8d24c886349@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-7-git-send-email-narmstrong@baylibre.com>
 <5c89a4e9-0100-0c67-1d6c-07651649172a@arm.com>
 <a0c9c4bc-cd83-c2e7-bfab-b8d24c886349@baylibre.com>
Message-ID: <cfbb96a6-4a90-01f2-591e-8f0853d7c06e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/08/16 09:22, Neil Armstrong wrote:
> On 08/19/2016 06:39 PM, Sudeep Holla wrote:
>>
>>
>> On 18/08/16 11:10, Neil Armstrong wrote:
>>> In order to use the legacy functions variants, add a new priv_scpi_ops
>>> structure that will contain the internal alterne functions and then use these
>>> alternate call in the probe function.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/firmware/arm_scpi.c | 68 ++++++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 64 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>>> index b0d911b..3fe39fe 100644
>>> --- a/drivers/firmware/arm_scpi.c
>>> +++ b/drivers/firmware/arm_scpi.c
>>> @@ -213,6 +213,7 @@ struct scpi_drvinfo {
>>>      struct scpi_ops *scpi_ops;
>>>      struct scpi_chan *channels;
>>>      struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
>>> +    const struct priv_scpi_ops *ops;
>>>  };
>>>
>>>  /*
>>> @@ -299,6 +300,17 @@ struct dev_pstate_set {
>>>      u8 pstate;
>>>  } __packed;
>>>
>>> +struct priv_scpi_ops {
>>> +    /* Internal Specific Ops */
>>> +    void (*handle_remote_msg)(struct mbox_client *c, void *msg);
>>> +    void (*tx_prepare)(struct mbox_client *c, void *msg);
>>> +    /* Message Specific Ops */
>>> +    int (*init_versions)(struct scpi_drvinfo *info);
>>> +    int (*dvfs_get_info)(u8 domain, struct dvfs_info *buf);
>>> +    /* System wide Ops */
>>> +    struct scpi_ops *scpi_ops;
>>> +};
>>> +
>>
>>
>> I fail to understand the need for this. Can you please explain the issue
>> you would face without this ?
>>
>>>  static struct scpi_drvinfo *scpi_info;
>>>
>>>  static int scpi_linux_errmap[SCPI_ERR_MAX] = {
>>> @@ -695,9 +707,12 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
>>>      if (scpi_info->dvfs[domain])    /* data already populated */
>>>          return scpi_info->dvfs[domain];
>>>
>>> -    ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
>>> +    if (scpi_info->ops && scpi_info->ops->dvfs_get_info)
>>> +        ret = scpi_info->ops->dvfs_get_info(domain, &buf);
>>> +    else
>>> +        ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO,
>>> +                    &domain, sizeof(domain),
>>>                  &buf, sizeof(buf));
>>> -
>>>      if (ret)
>>>          return ERR_PTR(ret);
>>>
>>> @@ -855,6 +870,22 @@ static struct scpi_ops scpi_ops = {
>>>      .vendor_send_message = scpi_ext_send_message,
>>>  };
>>>
>>> +static struct scpi_ops legacy_scpi_ops = {
>>> +    .get_version = scpi_get_version,
>>> +    .clk_get_range = NULL,
>>> +    .clk_get_val = legacy_scpi_clk_get_val,
>>> +    .clk_set_val = legacy_scpi_clk_set_val,
>>> +    .dvfs_get_idx = legacy_scpi_dvfs_get_idx,
>>> +    .dvfs_set_idx = legacy_scpi_dvfs_set_idx,
>>> +    .dvfs_get_info = scpi_dvfs_get_info,
>>> +    .sensor_get_capability = legacy_scpi_sensor_get_capability,
>>> +    .sensor_get_info = legacy_scpi_sensor_get_info,
>>> +    .sensor_get_value = legacy_scpi_sensor_get_value,
>>> +    .device_get_power_state = NULL,
>>> +    .device_set_power_state = NULL,
>>> +    .vendor_send_message = legacy_scpi_send_message,
>>
>> I think we need not have this at all if you follow the suggestion I had
>> in the previous patch. Try and let's see how it would look.
>
> If you confirm you want the if/else as said in patch 4.
>
> But clk_get_range, device_get/set_power_state are not available in legacy,
> I think we should still have this alternate structure.
>

I was thinking of overriding the pointers accordingly at the probe time
as the common list is bigger than the one that differs.

-- 
Regards,
Sudeep
