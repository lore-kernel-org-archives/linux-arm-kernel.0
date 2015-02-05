From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Feb 2015 07:34:50 -0600
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <87h9v1a8k2.fsf@free.fr>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org> <87h9v1a8k2.fsf@free.fr>
Message-ID: <CAL_JsqLiiKvzxQqE=bEx7qoLSZXLZOegt87A=+pR3PJuSBK95w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 11:30 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
> Hi Rob,
>
>> SA1100 and PXA differ only in register offsets which are currently
>> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
>> have this RTC block also.
>>
>> Convert the driver to use ioremap and set the register offsets dynamically.
>> Since we are touching all the register accesses, convert them all to
>> readl/writel.
> A general comment, probably made by Arnd already, why not using the relaxed
> accessors ?

I just default to writel/readl unless they are in a hot path as the
the relaxed variants were not available on all architectures, but I
think that is fixed now. I can switch them.

>
> ... zip ...
>
>> +     iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     base = devm_ioremap_resource(&pdev->dev, iores);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
>> +         of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
>> +             info->rcnr = base + 0x04;
>> +             info->rtsr = base + 0x10;
>> +             info->rtar = base + 0x00;
>> +             info->rttr = base + 0x08;
>> +     } else {
>> +             info->rcnr = base + 0x0;
>> +             info->rtsr = base + 0x8;
>> +             info->rtar = base + 0x4;
>> +             info->rttr = base + 0xc;
>> +     }
>> +
> This is making me feel a bit uncomfortable. What if a single kernel is built for
> both SA1100 and PXA, and used in a PXA platform (as this drivers is also used in
> pxa2xx and pxa3xx) ?

If we ever support both simultaneously, then that implies we will be
using DT. At that time we would need to remove
"IS_ENABLED(CONFIG_ARCH_SA1100)" and the DT compatible strings
determine which register layout.

> And just for your information, both rtc-sa1100 and rtc-pxa can be used at the
> same time in a pxa kernel.

Yes, I know. I find that a bit odd. We'll have a bit of a problem
supporting that with DT BTW.

Rob

>
> Apart from that worry it's quite nice.
>
> Cheers.
>
> --
> Robert
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
