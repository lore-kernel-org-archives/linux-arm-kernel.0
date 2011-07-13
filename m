From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2011 08:55:52 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1C7650.6010700@codeaurora.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<1310476090-9807-2-git-send-email-lee.jones@linaro.org>
	<4E1C7650.6010700@codeaurora.org>
Message-ID: <4E1D4F88.3070501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/11 17:29, Saravana Kannan wrote:
>> +struct soc_callback_functions soc_callbacks = {
>> +    .get_machine_fn  = ux500_get_machine,
>> +    .get_family_fn   = ux500_get_family,
>> +    .get_soc_id_fn   = ux500_get_soc_id,
>> +    .get_revision_fn = ux500_get_revision,
>> +};
>> +
>> +struct device_attribute ux500_soc_attrs[] = {
>> +    __ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
>> +    __ATTR_NULL,
>> +};
>> +
>> +static int __init ux500_soc_sysfs_init(void)
>> +{
>> +    int ret;
>> +    int i = 0;
>> +    ret = soc_device_register(&soc_parent,
>> +                &soc_callbacks);
>> +    if (ret>= 0) {
>> +        while (ux500_soc_attrs[i].attr.name != NULL) {
>> +            ret = device_create_file(&soc_parent,
>> +                        &ux500_soc_attrs[i++]);
>> +            if (ret)
>> +                goto out;
>> +        }
>> +    }
> 
> Can you please make this code as part of soc_device_register? Otherwise,
> every SoC that wants to add its own set of attributes will have to
> repeat this code.

That's the idea.

I initially had it all as part of soc_device_register, but Arnd told me
to remove it in this patch-set.

See here:

On 17/04/11 19:36, Arnd Bergmann wrote:
> For the nonstandard attributes, I would recommend having the individual
> drivers call device_create_file, in order to discourage the use of 
> device specific attribute names.

Hence all of these are the _standard_ attributes:

>> +    .get_machine_fn  = ux500_get_machine,
>> +    .get_family_fn   = ux500_get_family,
>> +    .get_soc_id_fn   = ux500_get_soc_id,
>> +    .get_revision_fn = ux500_get_revision,

And this is the _non standard_ one:
>> +    __ATTR(process,  S_IRUGO, ux500_get_process,  NULL),

Which is subsequently added by the platform.

Kind regards,
Lee
