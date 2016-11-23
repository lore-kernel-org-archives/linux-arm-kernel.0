From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 Nov 2016 12:07:27 +0000
Subject: [PATCH 1/3] of: base: add support to get machine compatible string
In-Reply-To: <ff1ea88a-87c6-6721-8e63-ddb05900cc58@ti.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
 <1479811311-3080-2-git-send-email-bgolaszewski@baylibre.com>
 <5ce9fb9f-459a-562b-2e9f-85d35f9ec035@arm.com>
 <67a3c2c7-0cb9-9764-2710-6ee66fc4dde4@ti.com>
 <fdb93150-9089-c7bb-2b0a-21ded241a647@arm.com>
 <ae92e013-b41b-6caa-b32f-284ffb6f5aa0@ti.com>
 <2a644b8c-d91e-5ab1-200b-00f749a36307@arm.com>
 <ff1ea88a-87c6-6721-8e63-ddb05900cc58@ti.com>
Message-ID: <f0ba1a7a-8948-21c3-8a96-d46bf105bb7e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/11/16 11:47, Sekhar Nori wrote:
> On Wednesday 23 November 2016 03:35 PM, Sudeep Holla wrote:
>>
>>
>> On 23/11/16 07:49, Sekhar Nori wrote:
>>> On Tuesday 22 November 2016 09:16 PM, Sudeep Holla wrote:
>>>> Hi Sekhar,
>>>>
>>>> On 22/11/16 15:06, Sekhar Nori wrote:
>>>>> Hi Sudeep,
>>>>>
>>>>> On Tuesday 22 November 2016 04:23 PM, Sudeep Holla wrote:
>>>>>>
>>>>>>
>>>>>> On 22/11/16 10:41, Bartosz Golaszewski wrote:
>>>>>>> Add a function allowing to retrieve the compatible string of the root
>>>>>>> node of the device tree.
>>>>>>>
>>>>>>
>>>>>> Rob has queued [1] and it's in -next today. You can reuse that if you
>>>>>> are planning to target this for v4.11 or just use open coding in your
>>>>>> driver for v4.10 and target this move for v4.11 to avoid cross tree
>>>>>> dependencies as I already mentioned in your previous thread.
>>>>>
>>>>> I dont have your original patch in my mailbox, but I wonder if
>>>>> returning a pointer to property string for a node whose reference has
>>>>> already been released is safe to do? Probably not an issue for the root
>>>>> node, but still feels counter-intuitive.
>>>>>
>>>>
>>>> I am not sure if I understand the issue here. Are you referring a case
>>>> where of_root is freed ?
>>>
>>> Yes, right, thats what I was hinting at. Since you are giving up the
>>> reference to the device node before the function returns, the user can
>>> be left with a dangling reference.
>>>
>>
>> Yes I agree.
>
> So, the if(!of_node_get()) is just an expensive NULL pointer check. I think
> it is better to be explicit about it by not using of_node_get/put() at all.
> How about:
>

Are we planning to use this in any time sensitive paths? Anyways I am
fine removing them.

> +int of_machine_get_model_name(const char **model)
> +{
> +       int error;
> +
> +       if (!of_root)
> +               return -EINVAL;
> +
> +       error = of_property_read_string(of_root, "model", model);
> +       if (error)
> +               error = of_property_read_string_index(of_root, "compatible",
> +                                                     0, model);
> +       return error;
> +}
> +EXPORT_SYMBOL(of_machine_get_model_name);
>
> I know the patch is already in -next so I guess it depends on how strongly
> Rob feels about this.

Frank expressed his concerns and it may be reverted.

-- 
Regards,
Sudeep
