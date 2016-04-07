From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 Apr 2016 09:37:01 +0800
Subject: [PATCH v10 06/17] Xen: ARM: Add support for mapping platform
 device mmio
In-Reply-To: <5704FE2C.5000902@arm.com>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-7-git-send-email-shannon.zhao@linaro.org>
 <5704FE2C.5000902@arm.com>
Message-ID: <5705B9BD.1020403@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/6 20:16, Julien Grall wrote:
>> +            gpfns[j] = XEN_PFN_DOWN(r->start) + j;
>> +            idxs[j] = XEN_PFN_DOWN(r->start) + j;
>> +        }
>> +
>> +        xatp.domid = DOMID_SELF;
>> +        xatp.size = nr;
>> +        xatp.space = XENMAPSPACE_dev_mmio;
>> +
>> +        set_xen_guest_handle(xatp.gpfns, gpfns);
>> +        set_xen_guest_handle(xatp.idxs, idxs);
>> +        set_xen_guest_handle(xatp.errs, errs);
>> +
>> +        rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
>> +        kfree(gpfns);
>> +        kfree(idxs);
>> +        kfree(errs);
>> +        if (rc)
>> +            return rc;
> 
> Shouldn't we redo the mapping if the hypercall fails?
Hmm, why? If it fails again when we redo the mapping, what should we do
then? Redo again?
I think if it fails at the first time it will always fail no matter how
many times we do.

Thanks,
-- 
Shannon
