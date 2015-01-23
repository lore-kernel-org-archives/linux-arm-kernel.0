From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 23 Jan 2015 17:38:26 +0800
Subject: [PATCH v7 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <54C10D31.1090203@arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-14-git-send-email-hanjun.guo@linaro.org>
 <54B8F2E3.80306@arm.com>
 <CACxGe6tBb8L8upS3zenZbrOc_c0E=MA=DqLjkSezEbregaAaaA@mail.gmail.com>
 <54B92245.6080306@arm.com> <54C0F133.8060901@linaro.org>
 <54C10D31.1090203@arm.com>
Message-ID: <54C21692.8040703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?22? 22:46, Marc Zyngier wrote:
> Hi Hanjun,
>
> On 22/01/15 12:46, Hanjun Guo wrote:
>> Hi Marc,
>>
>> We (Tomasz, Suravee and me) are working on supporting stacked domain on
>> ACPI, and rework GIC ACPI related patch, before we going further, we
>> need your guidance to see if we are going the right direction.
>>
>>     - You said that we spread GIC related code every where, so how
>>       about put all the ACPI related GIC init code in one file under
>>       drivers/irqchip/ with name irq-gic-acpi.c?
>
> That would certainly be an improvement.
>
>>     - ACPI only support one GICD for now, so we assume that there
>>      only one gicv2/v3 core domain and every device not using MSI
>>       will refer to that irqdomain in default.
>
> That's good enough, provided that nobody comes up with any form of
> chained interrupt controller (in whatever way that's implemented). ACPI
> doesn't seem to cater for that anyway.
>
> But default domains are only a quick optimization (it is only there to
> cope with code that didn't know about irq domains at all). What we need
> is a proper integration of the ACPI namespace in the irq domain code.
> Being able to lookup a domain by ACPI table, for example (just like
> irq_find_host returns the domain associated to a DT node).

I totally agree, so we have different ways to handle devices using
MSI and devices not using MSI.

   - Devices using MSI, there is a IORT table to map the dev id to ITS,
     then every device can easily lookup a domain;

   - Devices not using MSI, we only present the GSI (hwirq num) used
     in DSDT by this device to OS, no property to indicate its interrupt
     parent, since we have only one domain for now, we can just let
     those devices refer to the gic core domain, and it will work.

For x86, devices using GSI have no such problem, because every
IOAPIC have the GSI base reported and how many GSI is supported,
so with a GSI num, we can easily find a IOAPIC then pointing to
its irqdomain, can we do something similar to x86 here?

>
> This would ensure that we can reuse most of the existing code (stacked
> domains, per-device MSI domains [WIP]) without too much effort.

I agree.

Thanks
Hanjun
