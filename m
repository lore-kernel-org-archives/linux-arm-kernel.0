From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 Apr 2016 19:25:40 +0800
Subject: [PATCH v10 06/17] Xen: ARM: Add support for mapping platform
 device mmio
In-Reply-To: <57063752.4020805@arm.com>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-7-git-send-email-shannon.zhao@linaro.org>
 <5704FE2C.5000902@arm.com> <5705B9BD.1020403@huawei.com>
 <57063752.4020805@arm.com>
Message-ID: <570643B4.3070502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/7 18:32, Julien Grall wrote:
> Hi Shannon,
> 
> On 07/04/16 02:37, Shannon Zhao wrote:
>>
>>
>> On 2016/4/6 20:16, Julien Grall wrote:
>>>> +            gpfns[j] = XEN_PFN_DOWN(r->start) + j;
>>>> +            idxs[j] = XEN_PFN_DOWN(r->start) + j;
>>>> +        }
>>>> +
>>>> +        xatp.domid = DOMID_SELF;
>>>> +        xatp.size = nr;
>>>> +        xatp.space = XENMAPSPACE_dev_mmio;
>>>> +
>>>> +        set_xen_guest_handle(xatp.gpfns, gpfns);
>>>> +        set_xen_guest_handle(xatp.idxs, idxs);
>>>> +        set_xen_guest_handle(xatp.errs, errs);
>>>> +
>>>> +        rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
>>>> +        kfree(gpfns);
>>>> +        kfree(idxs);
>>>> +        kfree(errs);
>>>> +        if (rc)
>>>> +            return rc;
>>>
>>> Shouldn't we redo the mapping if the hypercall fails?
>> Hmm, why? If it fails again when we redo the mapping, what should we do
>> then? Redo again?
> 
> Because the device MMIO region is left half mapped in DOM0 address space.
> 
> After having another look to your patch, if an error occurs, the
> notifier will still return NOTIFY_OK. This will lead to random data
> abort when the driver is accessing the MMIO regions as the device will
> be considered fully functional.
> 
> However, even if the notifier return NOTIFY_BAD, the function device_add
> doesn't care about the return value of blocking_notifier_call_chain. I
> think this need to be fixed.
> 
>> I think if it fails at the first time it will always fail no matter how
>> many times we do.
> 
> I was speaking about the mappings that succeeded. They will unlikely
> fail during removal. If they ever fail you can just ignore the error.
Ok, I see. I thought you mean that it needs to map the regions again.
But what you really mean is undoing the mappings.

Thanks,
-- 
Shannon
