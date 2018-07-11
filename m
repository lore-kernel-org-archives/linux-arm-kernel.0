From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 11 Jul 2018 10:11:38 -0700
Subject: [PATCH -next] pinctrl: nsp: fix potential NULL dereference in
 nsp_pinmux_probe()
In-Reply-To: <6c133df2-7dc7-d58b-297a-c27b87e7edd3@arm.com>
References: <1531312461-134547-1-git-send-email-weiyongjun1@huawei.com>
 <7b4361a5-f757-179c-57b6-44359801baad@broadcom.com>
 <6c133df2-7dc7-d58b-297a-c27b87e7edd3@arm.com>
Message-ID: <c0163341-1445-76e2-644f-22cab0735f82@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/11/2018 10:01 AM, Sudeep Holla wrote:
> 
> 
> On 11/07/18 17:48, Ray Jui wrote:
>>
>>
>> On 7/11/2018 5:34 AM, Wei Yongjun wrote:
>>> platform_get_resource() may fail and return NULL, so we should
>>> better check it's return value to avoid a NULL pointer dereference
>>> a bit later in the code.
>>>
>>> This is detected by Coccinelle semantic patch.
>>>
>>> @@
>>> expression pdev, res, n, t, e, e1, e2;
>>> @@
>>>
>>> res = platform_get_resource(pdev, t, n);
>>> + if (!res)
>>> +?? return -EINVAL;
>>> ... when != res == NULL
>>> e = devm_ioremap_nocache(e1, res->start, e2);
>>>
>>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>>> ---
>>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>
>> Change looks good to me, although the check could have been avoided if
>> 'devm_ioremap_resource' is used on the next line instead of
>> 'devm_ioremap_nocache', where validation of resource pointer is done.
>>
>> But there's probably a reason why 'devm_ioremap_nocache' was used in
>> this code here.
>>
> 
> I am not sure about that. Both ARM and ARM64 has same definition as
> ioremp. However, arch/arm/include/asm/io.h do mention:
> "ioremap_nocache() is the same as ioremap() as there are too many device
> 
>   drivers using this for device registers, and documentation which tells
> 
>   people to use it for such for this to be any different."
> 
> You could technically use devm_ioremap_resource if you want.
> 

I did not mean the difference on _nocache, which I'm aware it's the same 
on ARM/ARM64 based platforms.

I meant there's a reason why xxx_resource was not used, which is most 
likely due to some resource conflict with another driver on NSP.

Ray
