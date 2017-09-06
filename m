From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 6 Sep 2017 14:31:18 +0100
Subject: [PATCH v2 09/18] firmware: arm_scmi: probe and initialise all the
 supported protocols
In-Reply-To: <bc52d57a-156b-cef0-7560-63a9ed7e78b5@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-10-git-send-email-sudeep.holla@arm.com>
 <bc52d57a-156b-cef0-7560-63a9ed7e78b5@arm.com>
Message-ID: <7c82503d-229f-08e7-6605-18d778b6f525@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/09/17 10:41, Julien Thierry wrote:
> 
> 
> On 04/08/17 15:31, Sudeep Holla wrote:
>> Now that we have basic support for all the protocols in the
>> specification, let's probe them individually and initialise them.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/firmware/arm_scmi/common.h |  5 +++
>>   drivers/firmware/arm_scmi/driver.c | 80
>> +++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/common.h
>> b/drivers/firmware/arm_scmi/common.h
>> index 7473dfcad4ee..d7c73a8d260b 100644
>> --- a/drivers/firmware/arm_scmi/common.h
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -118,4 +118,9 @@ int scmi_version_get(const struct scmi_handle *h,
>> u8 protocol, u32 *version);
>>   void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>>                        u8 *prot_imp);
>>   +typedef int (*scmi_init_fn_t)(struct scmi_handle *);
>>   int scmi_base_protocol_init(struct scmi_handle *h);
>> +int scmi_perf_protocol_init(struct scmi_handle *h);
>> +int scmi_sensors_protocol_init(struct scmi_handle *h);
>> +int scmi_power_protocol_init(struct scmi_handle *h);
>> +int scmi_clock_protocol_init(struct scmi_handle *h);
>> diff --git a/drivers/firmware/arm_scmi/driver.c
>> b/drivers/firmware/arm_scmi/driver.c
>> index 601d0d7210d9..6f31761043e2 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -157,6 +157,12 @@ struct scmi_shared_mem {
>>       u8 msg_payload[0];
>>   };
>>   +struct scmi_protocol_match {
>> +    u8 protocol_id;
>> +    scmi_init_fn_t fn;
> 
> Could we call this "init" or "prot_init"?
> 

Done

>> +    char name[32];
>> +};
>> +
>>   static int scmi_linux_errmap[] = {
>>       /* better than switch case as long as return value is continuous */
>>       0,            /* SCMI_SUCCESS */
>> @@ -687,6 +693,41 @@ static int scmi_xfer_info_init(struct scmi_info
>> *sinfo)
>>       return 0;
>>   }
>>   +static const struct scmi_protocol_match scmi_protocols[] = {
>> +    {
>> +        .protocol_id = SCMI_PROTOCOL_PERF,
>> +        .fn = scmi_perf_protocol_init,
>> +        .name = "scmi-cpufreq",
>> +    }, {
>> +        .protocol_id = SCMI_PROTOCOL_CLOCK,
>> +        .fn = scmi_clock_protocol_init,
>> +        .name = "scmi-clocks",
>> +    }, {
>> +        .protocol_id = SCMI_PROTOCOL_POWER,
>> +        .fn = scmi_power_protocol_init,
>> +        .name = "scmi-power-domain",
>> +    }, {
>> +        .protocol_id = SCMI_PROTOCOL_SENSOR,
>> +        .fn = scmi_sensors_protocol_init,
>> +        .name = "scmi-hwmon",
>> +    },
>> +    {}
>> +};
>> +
>> +static const struct scmi_protocol_match *scmi_protocol_match_get(u8
>> protocol_id)
>> +{
>> +    int i;
>> +    const struct scmi_protocol_match *match = NULL, *loop =
>> scmi_protocols;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(scmi_protocols); i++, loop++)
>> +        if (loop->protocol_id == protocol_id) {
>> +            match = loop;
>> +            break;
>> +        }
>> +
>> +    return match;
>> +}
>> +
> 
> The "match" variable is not needed. We can just return "loop" in the if
> branch and return NULL at the end of the function. Unless we are
> following some coding standard that advises against that?
>

Agreed and fixed locally.

>>   static int scmi_mailbox_check(struct device_node *np)
>>   {
>>       struct of_phandle_args arg;
>> @@ -778,7 +819,7 @@ static int scmi_probe(struct platform_device *pdev)
>>       const struct scmi_desc *desc;
>>       struct scmi_info *info;
>>       struct device *dev = &pdev->dev;
>> -    struct device_node *np = dev->of_node;
>> +    struct device_node *child, *np = dev->of_node;
>>         /* Only mailbox method supported, check for the presence of
>> one */
>>       if (scmi_mailbox_check(np)) {
>> @@ -817,6 +858,43 @@ static int scmi_probe(struct platform_device *pdev)
>>           return ret;
>>       }
>>   +    for_each_available_child_of_node(np, child) {
>> +        int init_ret;
>> +        u32 prot_id;
>> +        const struct scmi_protocol_match *match;
>> +
>> +        if (of_property_read_u32(child, "reg", &prot_id))
>> +            continue;
>> +
>> +        prot_id &= MSG_PROTOCOL_ID_MASK;
>> +
>> +        if (!scmi_is_protocol_implemented(handle, prot_id)) {
>> +            dev_err(dev, "SCMI protocol %d not implemented\n",
>> +                prot_id);
>> +            continue;
>> +        }
>> +
>> +        match = scmi_protocol_match_get(prot_id);
>> +        if (match) {
>> +            struct platform_device *cdev;
>> +
>> +            cdev = of_platform_device_create(child, match->name,
>> +                             dev);
>> +            if (!cdev) {
>> +                dev_err(dev, "failed to create %s device\n",
>> +                    match->name);
>> +                continue;
>> +            }
>> +
>> +            init_ret = match->fn(handle);
>> +            if (init_ret) {
>> +                dev_err(dev, "SCMI protocol %d init error %d\n",
>> +                    prot_id, init_ret);
>> +                of_platform_device_destroy(&cdev->dev, NULL);
>> +            }
>> +        }
>> +    }
>> +
> 
> For the code in the "if (match)" branch, would it be better to have an
> inline function "scmi_create_protocol_device" or something with a name
> that fits?
> 

Done

> Also I was wondering, what is the difference between the protocol being
> implemented and finding the matching structure? Feels like there is a
> bit of redundancy. If the protocol is implemented but doesn't have a
> match structure does it just mean it doesn't need any specific
> initialization?
> 

Yes, that's the idea. One reason to have both check is backward
compatibility. Suppose new protocols are implemented in the f/w but DT
doesn't have them or know how to use it or there are no users of that
feature, then skip initializing it. Similarly if DT is updated but not
the firmware.

-- 
Regards,
Sudeep
