From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 8 Jan 2016 11:06:16 +0800
Subject: [PATCH v8 20/20] KVM: ARM64: Add a new kvm ARM PMU device
In-Reply-To: <CAFEAcA-Qcda7TSFLSeykLHqZYdP6tYdEjPe2uHN6f_+omqWFZg@mail.gmail.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-21-git-send-email-zhaoshenglong@huawei.com>
 <CAFEAcA_MDiOphseZ7RGNE3G=4ZDF5SFV5krOjanPbVuhgg9gnQ@mail.gmail.com>
 <568E7AF1.9040103@huawei.com>
 <CAFEAcA-Qcda7TSFLSeykLHqZYdP6tYdEjPe2uHN6f_+omqWFZg@mail.gmail.com>
Message-ID: <568F27A8.80808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/7 22:56, Peter Maydell wrote:
>>>> +  Errors:
>>>> >>> +    -ENXIO: Unsupported attribute group
>>>> >>> +    -EBUSY: The PMU overflow interrupt is already set
>>>> >>> +    -ENODEV: Getting the PMU overflow interrupt number while it's not set
>>>> >>> +    -EINVAL: Invalid vcpu_index or PMU overflow interrupt number supplied
>>> >>
>>> >> What happens if you create a PMU but then never set the IRQ number?
>>> >> Is there a default or does the VM refuse to run or something?
>>> >>
>> > If userspace doesn't specify the irq number, the guest will not receive
>> > the PMU interrupt because we check if the irq is initialized when we
>> > inject the interrupt. But guest could still use the vPMU if QEMU
>> > generates a proper DTB or ACPI.
> So is it a valid use case to create a PMU with the interrupt not wired
> up to anything? (If it's never valid it would be nice to diagnose it
> rather than just silently letting the guest run but not work right.)
So how about adding a helper to check if the PMU is completely
initialized and if not, return trap_raz_wi when guest access PMU registers?

Thanks,
-- 
Shannon
