From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 24 Oct 2015 10:36:24 +0800
Subject: [PATCH v2] EDAC: Add ARM64 EDAC
In-Reply-To: <562A7545.2050306@amd.com>
References: <1445460097-10260-1-git-send-email-brijeshkumar.singh@amd.com>
 <56282550.4000201@arm.com> <5628F6B5.5080701@amd.com>
 <56299042.5090109@huawei.com> <562A033A.5050105@arm.com>
 <562A7545.2050306@amd.com>
Message-ID: <562AEEA8.5090000@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/24 1:58, Brijesh Singh wrote:
>> So I checked the x86 code: the driver is always loaded as soon as the
>> hardware is there (looking at PCI device IDs from the on-chip
>> northbridge, for instance). The trick here is to have the Kconfig option
>> defaulting to "=n", so a kernel builder would have to explicitly enable
>> this. Android or embedded kernels wouldn't do this, for instance, while
>> a server distribution would do.
>> If a user doesn't want to be bothered with the driver, there is always
>> the possibility of blacklisting the module.
>> Setting a system policy is IMHO out of scope for a DT binding.
>>
> Will update Kconfig to make it n by default.
>
>>>> * Its possible that other SoC's might handle single-bit and double-bit errors differently compare to 
>>>>   Seattle platform. In Seattle platform both errors are handled by firmware but if other SoC 
>>>>   wants OS to handle these errors then they might need DT binding to provide the irq numbers etc.
>> What do you mean exactly with "firmware handles these errors"?
>> What would the firmware do? I guess just logging the error and then
>> possibly reset the register? How would this change the driver?
>>
> On Seattle platform SoC generates a interrupt on both single bit and double bit error
> and that interrupt is handled by firmware, so we don't need to do anything in the driver.
> Driver just need to poll registers to log correctable errors (because they do not generate interrupt).
> This very driver is doing exactly what we want. DT binding is not required.
>
> But Hanjun's comment on very first patch hinted me that there is possibility that
> SoC generate a interrupt on single bit and double bit but firmware does not handle it.
> In those cases driver will need be extended to handle interrupt.

yes, exactly.

>
> I will submit v3 for review with DT binding removed. We can revisit DT binding need in future.
>
>>> I totally agree with you here,  thanks for putting them together.
>>> Different SoCs may handle the error in different ways, we need
>>> bindings to specialize them, irq number is a good example :)
>> But how does this affect this very driver, polling just those two registers?
>> Where would the interrupt come into the game here? Where is the proposed
>> DT binding for that interrupt?
>>
>> AFAICT EL3 firmware handling errors would just hide this information
>> from the driver, so if the f/w decides to "handle" uncorrectable ECC
>> errors in a fatal way, there is nothing the driver could do anyway, right?

Yes, if EL3 firmware is involved, the driver don't need to handle such interrupt.

>>
>> Can you sketch a concrete example where we would actually need the
>> driver to know about the firmware capabilities?

So if firmware don't handle it, just like the APM xgene did in xgene_edac.c, we
need handle it in the driver, then DT bindings with irq number are needed.
You know, I'm working on ACPI and will enthusiastically encourage people using
APEI with firmware handle error first :) , but I think we can't rule out such
cases (driver handle the errors).

Thanks
Hanjun
