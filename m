From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Wed, 18 Nov 2015 21:09:01 +0800
Subject: [PATCH v3 01/62] Revert "xen/arm: vgic-v2: Drop cbase from
 arch_domain"
In-Reply-To: <564C63E6.2080104@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-2-git-send-email-shannon.zhao@linaro.org>
 <564B0F1E.9040804@citrix.com> <564B1E62.8080208@huawei.com>
 <564B3255.6040108@citrix.com> <564BE23C.6020808@huawei.com>
 <564C63E6.2080104@citrix.com>
Message-ID: <564C786D.5050108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/18 19:41, Julien Grall wrote:
> Hi Shannon,
>
> On 18/11/15 02:28, Shannon Zhao wrote:
>
>> On 2015/11/17 21:57, Julien Grall wrote:
>>> On 17/11/15 12:32, Shannon Zhao wrote:
>>>>> Hi Julien,
>>>>>
>>>>> On 2015/11/17 19:27, Julien Grall wrote:
>>>>>>> Hi Shannon,
>>>>>>>
>>>>>>> Why do you want to revert this patch?
>>>>>>>
>>>>> Because d->arch.vgic.cbase will be used by creating Dom0 MADT table
>>>>> later. See [PATCH v3 43/62].
>>>>> +            gicc.base_address = d->arch.vgic.cbase;
>>>>>
>>>>> My previous way is get this from ACPI table but someone suggest get it
>>>>> from struct domain and I think this way is better too since it uses the
>>>>> value after being parsed.
>>> It's pointless to store the value in arch_domain for something that it's
>>> only use during building...
>>>
>>> We have struct kernel_info which store any information related to the
>>> DOM0 during the building.
>>>
>>
>> Yeah, that would be better if it could use kernel_info. But the problem
>> is that kernel_info is firstly used in construct_dom0(), while it needs
>> to store the cbase in domain_create() which is called before
>> construct_dom0(). And if we pass kernel_info as parameter to
>> domain_create(), this would introduce more changes to common codes.
>>
>> Do you have any better idea to handle this?
>
> Yes, introducing callback to create the ACPI table in the GIC driver.
> See what we did for make_hwdom_dt_node.
>
> We are trying to make the domain_build domain as agnostic as possible
> from the GIC version. However in patch #43, you implement specific
> version in the domain builder.
>
> It will also not scale very well when we will introduce GICv2m and ITS.
>
> The version of the GIC (ACPI_MADT_GIC_*) could be introduced in the
> vgic_ops.
>
> The re-distributor could be moved in gic-v3.c and the generic interrupt
> controller in gic-v2.c.
>
> Note it's a mandatory to emulate the same version as the hardware for
> the virtual GIC.
>
So it doesn't support vGICv2 on GICv3 hardware for Xen?

Thanks,
-- 
Shannon
